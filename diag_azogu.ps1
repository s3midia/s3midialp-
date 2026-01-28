$files = @(
    "(0) - Portfolio-Projeto-66-CAPA.htm",
    "(44) - Portfolio-Projeto-66-CAPA.html"
)
$basePath = "c:\Meus Sites\LP\LP S3\wp-content\uploads\2025\Lp"

foreach ($filename in $files) {
    $path = Join-Path $basePath $filename
    $content = Get-Content $path
    Write-Host "`nChecking: $filename"
    for ($i = 0; $i -lt $content.Count; $i++) {
        if ($content[$i] -match "azogu") {
            Write-Host "Line $($i+1): $content[$i]"
        }
    }
}
