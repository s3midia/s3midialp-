$directory = "c:\Meus Sites\LP\LP S3\wp-content\uploads\2025\Lp"
$files = Get-ChildItem -Path $directory -Filter "*CAPA.html" -Recurse

foreach ($file in $files) {
    $content = Get-Content -Path $file.FullName -Raw -Encoding UTF8
    $modified = $false

    # Normal references
    if ($content -match "index - S3midia.html") {
        $content = $content -replace "index - S3midia.html", "index.html"
        $modified = $true
    }
    
    # URL Encoded references
    if ($content -match "index%20-%20S3midia.html") {
        $content = $content -replace "index%20-%20S3midia.html", "index.html"
        $modified = $true
    }
    
    # Script references (no extension) - be careful here to match what we saw in searches
    # Searching for "index - S3midia" without .html might catch the title or other things?
    # Context seen in user prompt: "index - S3midia (Referências sem extensão em scripts)"
    # But checking grep results, we only saw .html or encoded.
    # Let's stick to .html replacement which covers most cases safely.

    if ($modified) {
        Set-Content -Path $file.FullName -Value $content -Encoding UTF8
        Write-Host "Updated: $($file.Name)"
    }
}
Write-Host "Batch update completed."
