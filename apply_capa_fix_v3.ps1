$files = Get-ChildItem -Path "c:\Meus Sites\LP\LP S3\wp-content\uploads\2025\Lp" -Filter "*CAPA.html" -Recurse

foreach ($file in $files) {
    Write-Host "Processing $($file.FullName)..."
    $content = Get-Content -Path $file.FullName -Raw

    # We need to target the PREVIOUS fix (Fixed + Padding) or the one before (Sticky)
    # The file currently has "position:fixed" and "document.body.style.paddingTop = '100px';"
    
    # 1. CLEANUP: Remove the padding logic if present
    $paddingParams = "document.body.style.paddingTop = '100px';"
    $content = $content.Replace($paddingParams, "")

    # 2. ENSURE FIXED: Ensure it is position:fixed (it should be, but let's be safe)
    $stickySearch = "position:sticky;"
    $fixedSearch = "position:fixed;"
    $content = $content.Replace($stickySearch, $fixedSearch)

    # 3. INSERT SPACER: Add a spacer div logic
    # We want to insert the spacer BEFORE the content but logically it acts as the first flow element.
    # The header 'd' is inserted. We will add 'sp' (spacer) logic.
    
    $spacerLogic = "var sp=document.createElement('div');sp.style.height='90px';sp.style.width='100%';sp.style.display='block';document.body.insertBefore(sp,document.body.firstChild);"
    
    # Avoid duplicate spacers
    if (-not $content.Contains("var sp=document.createElement('div')")) {
        # Insert spacer logic before the header insertion, or after styles are appended.
        # Current pattern ends with: document.body.insertBefore(d,document.body.firstChild);</script>
        
        # We will append the spacer logic right before the header is inserted, so the header 'd' (fixed) is inserted, 
        # and then 'sp' is inserted at firstChild (pushing 'd' if it was flow, but 'd' is fixed). 
        # Actually proper order:
        # Body starts: [Existing Content]
        # script runs:
        # insertBefore(d, firstChild) -> [d (fixed), Existing Content]
        # insertBefore(sp, firstChild) -> [sp, d(fixed), Existing Content]
        # This order puts spacer at top. PERFECT.
        
        $insertHeader = "document.body.insertBefore(d,document.body.firstChild);"
        $content = $content.Replace($insertHeader, "$insertHeader $spacerLogic")
        
        Set-Content -Path $file.FullName -Value $content -Encoding UTF8
        Write-Host "Updated $($file.Name) to SPACER DIV"
    }
    else {
        Write-Host "Spacer logic already presumably present in $($file.Name)"
        Set-Content -Path $file.FullName -Value $content -Encoding UTF8 # Save cleanup
    }
}
