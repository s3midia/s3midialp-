# Script robusto para padronizar rodapes (Logo e Texto)

$basePath = "c:\Meus Sites\LP\LP S3\wp-content\uploads\2025\Lp"

# Arquivo de referencia que ja esta correto
$refFile = Join-Path $basePath "(0) - Portfolio-Projeto-66-CAPA.htm"
$refContent = Get-Content $refFile -Raw -Encoding UTF8

# Extrair o bloco correto da logo (Link + Imagem) do arquivo (0)
# A regex busca o link com a imagem dentro, usando o alt="Logo" que definimos
if ($refContent -match '(<a href="https://s3midiadigital\.com\.br"[^>]*>\s*<img [^>]*alt="Logo"[^>]*>\s*</a>)') {
    $correctLogoBlock = $matches[1]
    Write-Host "Bloco de logo correto extraido do arquivo (0)."
}
else {
    Write-Error "Nao foi possivel extrair o bloco de logo do arquivo (0). Verifique se ele esta correto."
    exit
}

# Assinatura da logo antiga (SVG Base64 parcial)
$oldLogoSig = "PHN2ZyB3aWR0aD0iMTQiIGhlaWdodD0iMjEi"
$escapedSig = [regex]::Escape($oldLogoSig)

# Lista de arquivos alvo (baseada na busca anterior)
$targetFiles = @(
    "(2) - Portfolio-Projeto-66-CAPA.html",
    "(3) - Portfolio-Projeto-66-CAPA.html",
    "(4) - Portfolio-Projeto-66-CAPA.html",
    "(44) - Portfolio-Projeto-66-CAPA.html",
    "(63) - Portfolio-Projeto-66-CAPA.html",
    "(66) - Portfolio-Projeto-66-CAPA.html"
)

$h2Tag = '<h2 class="elementor-heading-title elementor-size-default">Desenvolvido por</h2>'

foreach ($filename in $targetFiles) {
    Write-Host "`n----------`nProcessando: $filename"
    $path = Join-Path $basePath $filename
    
    if (-not (Test-Path $path)) {
        Write-Warning "Arquivo nao encontrado: $filename"
        continue
    }

    $content = Get-Content $path -Raw -Encoding UTF8
    $modified = $false

    # 1. Substituir Logo Antiga
    # Procura por qualquer tag IMG que contenha a assinatura da logo antiga
    # Regex explicada: <img [qualquer coisa] src="[qualquer coisa]ASSINATURA[qualquer coisa]" [qualquer coisa] >
    # E opcionalmente um <a> em volta dela, para remover o link antigo se houver
    # Usando variavel para o regex para evitar erro de parse
    $oldLogoRegex = '(<a href=[^>]+>\s*)?<img[^>]+src=["''][^"']*' + $escapedSig + '[^"']*["''][^>]*>(\s*</a>)?'
    
    if ($content -match $oldLogoRegex) {
        $content = $content -replace $oldLogoRegex, $correctLogoBlock
        $modified = $true
        Write-Host "  Logo antiga substituida."
    } elseif ($content -match [regex]::Escape($correctLogoBlock)) {
        Write-Host "  Logo ja esta atualizada."
    } else {
        Write-Warning "  Logo antiga nao encontrada."
    }

    # 2. Restaurar/Adicionar Texto "Desenvolvido por"
    if ($content -notmatch "Desenvolvido por") {
        # Achar a logo nova no texto (agora temos o link "s3midiadigital.com.br")
        # Padrao: (Contentor do Heading) ... (Contentor da Imagem com o Link)
        
        $footerPattern = '(<div class="elementor-element[^"]+elementor-widget-heading"[^>]*>\s*<div class="elementor-widget-container">\s*)(\s*</div>\s*</div>\s*<div class="elementor-element[^"]+elementor-widget-image"[^>]*>\s*<div class="elementor-widget-container">\s*<a href="https://s3midiadigital\.com\.br")'
        
        if ($content -match $footerPattern) {
            # $1 e o inicio ate dentro do container do heading
            # $2 e o fechamento do heading ate o inicio do link
            $content = $content -replace $footerPattern, "`$1$h2Tag`$2"
            $modified = $true
            Write-Host "  Texto 'Desenvolvido por' inserido."
        } else {
            # Tentar achar somente a logo nova e inserir o texto antes (fallback)
            # Se nao achar o container do heading, pode ser que a estrutura seja diferente, mas vamos tentar
            # inserir antes do widget da imagem
            
            # Não vamos arriscar quebrar o layout se não acharmos o container exato.
            # Mas podemos tentar procurar o widget de imagem especifico
            Write-Warning "  Estrutura para insercao do texto nao encontrada com precisao."
        }
    } else {
        Write-Host "  Texto 'Desenvolvido por' ja existe."
    }

    if ($modified) {
        Set-Content -Path $path -Value $content -Encoding UTF8 -NoNewline
        Write-Host "  Arquivo salvo."
    }
}
