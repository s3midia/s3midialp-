$files = Get-ChildItem -Path "c:\Meus Sites\LP\LP S3\wp-content\uploads\2025\Lp" -Filter "*CAPA.html" -Recurse

foreach ($file in $files) {
    Write-Host "Processing $($file.FullName)..."
    $content = Get-Content -Path $file.FullName -Raw

    # Targeted string from the injected JS
    $search = "padding:20px;position:fixed;top:0;left:0;right:0;z-index:999999;"
    $replace = "padding:20px;position:sticky;top:0;left:0;right:0;z-index:999999;"

    if ($content.Contains($search)) {
        $content = $content.Replace($search, $replace)
        Set-Content -Path $file.FullName -Value $content -Encoding UTF8
        Write-Host "Updated $($file.Name)"
    }
    else {
        Write-Host "Strict pattern not found in $($file.Name)"
        # Fallback check
        if ($content -match "back-header.*position:fixed") {
            Write-Host "Potential match found with header regex but skipped strict replace."
        }
    }
}
