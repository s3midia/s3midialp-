# Script v3 para padronizar rodapes

$basePath = "c:\Meus Sites\LP\LP S3\wp-content\uploads\2025\Lp"
$refFile = Join-Path $basePath "(0) - Portfolio-Projeto-66-CAPA.htm"
$refContent = Get-Content $refFile -Raw -Encoding UTF8

# Regex para extrair do (0)
$extractRegex = @'
(<a href="https://s3midiadigital\.com\.br"[^>]*>\s*<img [^>]*alt="Logo"[^>]*>\s*</a>)
'@

if ($refContent -match $extractRegex) {
    $correctLogoBlock = $matches[1]
    Write-Host "Logo ref OK"
}
else {
    Write-Error "Logo ref ERRO"
    exit
}

$targetFiles = @(
    "(2) - Portfolio-Projeto-66-CAPA.html",
    "(3) - Portfolio-Projeto-66-CAPA.html",
    "(4) - Portfolio-Projeto-66-CAPA.html",
    "(44) - Portfolio-Projeto-66-CAPA.html",
    "(63) - Portfolio-Projeto-66-CAPA.html",
    "(66) - Portfolio-Projeto-66-CAPA.html"
)

$h2Tag = '<h2 class="elementor-heading-title elementor-size-default">Desenvolvido por</h2>'

# Regex para logo antiga (HARDCODED SIG)
$oldLogoRegex = @'
(<a href=[^>]+>\s*)?<img[^>]+src=["'][^"']*PHN2ZyB3aWR0aD0iMTQiIGhlaWdodD0iMjEi[^"']*["'][^>]*>(\s*</a>)?
'@

# Regex para footer incompleto (HARDCODED LINK)
$footerPattern = @'
(<div class="elementor-element[^"]+elementor-widget-heading"[^>]*>\s*<div class="elementor-widget-container">\s*)(\s*</div>\s*</div>\s*<div class="elementor-element[^"]+elementor-widget-image"[^>]*>\s*<div class="elementor-widget-container">\s*<a href="https://s3midiadigital\.com\.br")
'@

foreach ($filename in $targetFiles) {
    Write-Host "File: $filename"
    $path = Join-Path $basePath $filename
    
    if (-not (Test-Path $path)) { continue }

    $content = Get-Content $path -Raw -Encoding UTF8
    $modified = $false

    if ($content -match $oldLogoRegex) {
        $content = $content -replace $oldLogoRegex, $correctLogoBlock
        $modified = $true
        Write-Host "Logo substituida"
    }

    if ($content -notmatch "Desenvolvido por") {
        if ($content -match $footerPattern) {
            $content = $content -replace $footerPattern, "`$1$h2Tag`$2"
            $modified = $true
            Write-Host "Texto inserido"
        }
        else {
            Write-Warning "Padrao footer nao encontrado"
        }
    }

    if ($modified) {
        Set-Content -Path $path -Value $content -Encoding UTF8 -NoNewline
        Write-Host "Salvo"
    }
}
