# Script para corrigir todas as variacoes de rodape (SVG raw, Base64, Links de texto)

$basePath = "c:\Meus Sites\LP\LP S3\wp-content\uploads\2025\Lp"
$refFile = Join-Path $basePath "(0) - Portfolio-Projeto-66-CAPA.htm"
$refContent = Get-Content $refFile -Raw -Encoding UTF8

# Extrair a logo nova (Bloco completo do link+img)
$extractRegex = @'
(<a href="https://s3midiadigital\.com\.br"[^>]*>\s*<img [^>]*alt="Logo"[^>]*>\s*</a>)
'@

if ($refContent -match $extractRegex) {
    $newLogoBlock = $matches[1]
    Write-Host "Logo de referencia extraida."
}
else {
    Write-Error "ERRO: Nao foi possivel extrair a logo de referencia do arquivo (0)."
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

# Regex para Link Antigo (Azogu) - cobre http e https, com ou sem www
$azoguLinkRegex = 'https?://(www\.)?azogu\.com/?'
$newLink = "https://s3midiadigital.com.br"

# Regex para SVG Raw da Azogu (identificado em (44))
# Procura um link para azogu que contem um SVG dentro
$rawSvgPattern = @'
<a href="https?://(www\.)?azogu\.com/?"[^>]*>\s*<svg[^>]*>.*?</svg>\s*</a>
'@

# Regex para Base64 da Azogu (identificado em outros arquivos se houver)
$base64Sig = "PHN2ZyB3aWR0aD0iMTQiIGhlaWdodD0iMjEi"
$base64Pattern = @'
(<a href=[^>]+>\s*)?<img[^>]+src=["'][^"']*PHN2ZyB3aWR0aD0iMTQiIGhlaWdodD0iMjEi[^"']*["'][^>]*>(\s*</a>)?
'@

foreach ($filename in $targetFiles) {
    Write-Host "`nProcessando: $filename"
    $path = Join-Path $basePath $filename
    if (-not (Test-Path $path)) { continue }
    
    $content = Get-Content $path -Raw -Encoding UTF8
    $modified = $false

    # 1. Substituir bloco SVG Raw da Logo (Link + SVG) pela Nova Logo
    if ($content -match $rawSvgPattern) {
        # Precisamos de Singleline option para o . no regex casar newlines, pois o SVG pode ser multilinha
        # PowerShell -replace usa regex options inline (?s)
        $content = $content -replace "(?s)$rawSvgPattern", $newLogoBlock
        $modified = $true
        Write-Host "  [Fix] Logo SVG Raw substituida."
    }

    # 2. Substituir bloco Base64 da Logo
    if ($content -match $base64Pattern) {
        $content = $content -replace $base64Pattern, $newLogoBlock
        $modified = $true
        Write-Host "  [Fix] Logo Base64 substituida."
    }

    # 3. Atualizar Links de Texto (Desenvolvido por -> Azogu)
    # Procura por links para azogu que sobraram (provavelmente no texto "Desenvolvido por")
    if ($content -match $azoguLinkRegex) {
        $content = $content -replace $azoguLinkRegex, $newLink
        $modified = $true
        Write-Host "  [Fix] Link de texto 'azogu.com' atualizado."
    }

    # 4. Inserir "Desenvolvido por" se estiver faltando (Logica do script anterior, fallback)
    if ($content -notmatch "Desenvolvido por") {
        # ... Logica de inserção se necessário, mas foco primeiro em substituir o existente ...
        # Se substituimos a logo, o container ja tem o link s3midia.
        # Padrao: Container Heading (possivelmente vazio) ... Container Imagem (com link s3midia)
        $h2Tag = '<h2 class="elementor-heading-title elementor-size-default">Desenvolvido por</h2>'
        $gapPattern = @'
(<div class="elementor-element[^"]+elementor-widget-heading"[^>]*>\s*<div class="elementor-widget-container">\s*)(\s*</div>\s*</div>\s*<div class="elementor-element[^"]+elementor-widget-image"[^>]*>\s*<div class="elementor-widget-container">\s*<a href="https://s3midiadigital\.com\.br")
'@
        if ($content -match $gapPattern) {
            $content = $content -replace "(?s)$gapPattern", "`$1$h2Tag`$2"
            $modified = $true
            Write-Host "  [Fix] Texto 'Desenvolvido por' inserido em container vazio."
        }
    }

    if ($modified) {
        Set-Content -Path $path -Value $content -Encoding UTF8 -NoNewline
        Write-Host "  Arquivo salvo."
    }
    else {
        Write-Host "  Nenhuma alteracao necessaria."
    }
}
