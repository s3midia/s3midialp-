# Script de verificação final

$targetFiles = @(
    "(0) - Portfolio-Projeto-66-CAPA.htm",
    "(2) - Portfolio-Projeto-66-CAPA.html",
    "(3) - Portfolio-Projeto-66-CAPA.html",
    "(4) - Portfolio-Projeto-66-CAPA.html",
    "(44) - Portfolio-Projeto-66-CAPA.html",
    "(63) - Portfolio-Projeto-66-CAPA.html",
    "(66) - Portfolio-Projeto-66-CAPA.html"
)

$basePath = "c:\Meus Sites\LP\LP S3\wp-content\uploads\2025\Lp"

foreach ($filename in $targetFiles) {
    $path = Join-Path $basePath $filename
    $content = Get-Content $path -Raw -Encoding UTF8
    
    $hasAzogu = $content -match "azogu"
    $hasS3 = $content -match "s3midiadigital"
    $hasDev = $content -match "Desenvolvido por"
    
    Write-Host "File: $filename"
    if ($hasAzogu) { Write-Warning "  [FAIL] Still contains 'azogu'!" }
    else { Write-Host "  [PASS] No 'azogu'." }
    
    if ($hasS3) { Write-Host "  [PASS] Contains 's3midiadigital'." }
    else { Write-Warning "  [FAIL] Missing 's3midiadigital' (New branding)." }
    
    if ($hasDev) { Write-Host "  [PASS] Contains 'Desenvolvido por'." }
    else { Write-Warning "  [FAIL] Missing 'Desenvolvido por'." }
    Write-Host ""
}
