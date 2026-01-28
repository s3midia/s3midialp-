
$targetDir = "C:\Meus Sites\LP\LP S3\wp-content\uploads\2025\Lp"
$files = Get-ChildItem -Path $targetDir -Filter "*CAPA.html"

$menuContent = Get-Content -Path "C:\Users\jefer\.gemini\antigravity\brain\6fc16aee-9bd3-4b26-a7d5-263d457b76ee\menu_component.html" -Raw -Encoding UTF8
$footerContent = Get-Content -Path "C:\Users\jefer\.gemini\antigravity\brain\6fc16aee-9bd3-4b26-a7d5-263d457b76ee\footer_component.html" -Raw -Encoding UTF8

foreach ($file in $files) {
    Write-Host "Processing: $($file.Name)"
    
    # Restore from backup if it exists to ensure clean state
    if (Test-Path "$($file.FullName).bak") {
        Copy-Item -Path "$($file.FullName).bak" -Destination $file.FullName -Force
        Write-Host "  - Restored from backup"
    }
    else {
        # Should normally exist from previous run, but just in case
        Copy-Item -Path $file.FullName -Destination "$($file.FullName).bak" -Force
        Write-Host "  - Created backup"
    }
    
    $content = Get-Content -Path $file.FullName -Raw -Encoding UTF8
    
    # 1. Inject Menu
    $bodyMatch = [regex]::Match($content, "<body[^>]*>")
    if ($bodyMatch.Success) {
        $idx = $bodyMatch.Index + $bodyMatch.Length
        # Insert using substring to avoid regex replacement issues with JS content
        $content = $content.Substring(0, $idx) + "`n" + $menuContent + "`n" + $content.Substring($idx)
        Write-Host "  - Menu Injected"
    }
    else {
        Write-Warning "  - <body> tag NOT found."
    }
    
    # 2. Inject Footer
    # Find the last occurrence of </body> to be safe
    $lastIdx = $content.LastIndexOf("</body>")
    if ($lastIdx -ge 0) {
        $content = $content.Substring(0, $lastIdx) + "`n" + $footerContent + "`n" + $content.Substring($lastIdx)
        Write-Host "  - Footer Injected"
    }
    else {
        Write-Warning "  - </body> tag NOT found."
    }
    
    $content | Set-Content -Path $file.FullName -Encoding UTF8
}

Write-Host "Batch update complete."
