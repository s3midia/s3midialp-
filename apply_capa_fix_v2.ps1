$files = Get-ChildItem -Path "c:\Meus Sites\LP\LP S3\wp-content\uploads\2025\Lp" -Filter "*CAPA.html" -Recurse

foreach ($file in $files) {
    Write-Host "Processing $($file.FullName)..."
    $content = Get-Content -Path $file.FullName -Raw

    # We need to target the PREVIOUS fix which used 'sticky'
    $search = "padding:20px;position:sticky;top:0;left:0;right:0;z-index:999999;"
    $replace = "padding:20px;position:fixed;top:0;left:0;right:0;z-index:999999;"

    # Add body padding logic if not present
    $paddingLogic = "document.body.style.paddingTop = '100px';"
    
    if ($content.Contains($search)) {
        # Replace sticky with fixed
        $content = $content.Replace($search, $replace)
        
        # Check if we already added the body padding logic (to avoid duplicate)
        if (-not $content.Contains($paddingLogic)) {
            # Insert the padding logic inside the script
            # We look for the end of the script block we injected or modified
            $content = $content.Replace("document.body.insertBefore(d,document.body.firstChild);", "document.body.insertBefore(d,document.body.firstChild); $paddingLogic")
        }
        
        Set-Content -Path $file.FullName -Value $content -Encoding UTF8
        Write-Host "Updated $($file.Name) to FIXED + PADDING"
    }
    else {
        Write-Host "Pattern not found in $($file.Name) (Already fixed or original?)"
    }
}
