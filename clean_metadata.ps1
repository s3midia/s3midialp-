# Script para limpar metadados "Azogu"

$files = @(
    "(0) - Portfolio-Projeto-66-CAPA.htm",
    "(2) - Portfolio-Projeto-66-CAPA.html",
    "(3) - Portfolio-Projeto-66-CAPA.html",
    "(4) - Portfolio-Projeto-66-CAPA.html",
    "(44) - Portfolio-Projeto-66-CAPA.html",
    "(63) - Portfolio-Projeto-66-CAPA.html",
    "(66) - Portfolio-Projeto-66-CAPA.html"
)
$basePath = "c:\Meus Sites\LP\LP S3\wp-content\uploads\2025\Lp"

foreach ($filename in $files) {
    Write-Host "Cleaning metadata in: $filename"
    $path = Join-Path $basePath $filename
    if (-not (Test-Path $path)) { continue }
    
    $content = Get-Content $path -Raw -Encoding UTF8
    $modified = $false
    
    # 1. Replace "Azogu" in meta content
    if ($content -match 'content=["'']Azogu["'']') {
        $content = $content -replace 'content=["'']Azogu["'']', 'content="S3 Mídia Digital"'
        $modified = $true
        Write-Host "  Replaced meta content name."
    }
    
    # 2. Replace "Azogu" in JSON-LD name
    if ($content -match '"name":\s*"Azogu"') {
        $content = $content -replace '"name":\s*"Azogu"', '"name":"S3 Mídia Digital"'
        $modified = $true
        Write-Host "  Replaced JSON name."
    }
    
    # 3. Replace author URL part
    if ($content -match '/author/azogu/') {
        $content = $content -replace '/author/azogu/', '/author/s3midiadigital/'
        $modified = $true
        Write-Host "  Replaced author URL."
    }
    
    # 4. Twitter data
    if ($content -match 'twitter:data1 content=Azogu') {
        $content = $content -replace 'twitter:data1 content=Azogu', 'twitter:data1 content="S3 Mídia Digital"'
        $modified = $true
        Write-Host "  Replaced Twitter data."
    }

    if ($modified) {
        Set-Content -Path $path -Value $content -Encoding UTF8 -NoNewline
        Write-Host "  Saved."
    }
}
