# Script para restaurar texto do rodapé e adicionar link na logo

$capaFiles = Get-ChildItem -Path "c:\Meus Sites\LP\LP S3\wp-content\uploads\2025\Lp" -Filter "*CAPA.htm*" -File | Where-Object { $_.Name -notlike "*.bak" }

$linkUrl = "https://s3midiadigital.com.br"
$linkTagStart = "<a href=`"$linkUrl`" target=`"_blank`" rel=`"noopener`">"
$linkTagEnd = "</a>"
$h2Tag = '<h2 class="elementor-heading-title elementor-size-default">Desenvolvido por</h2>'

foreach ($file in $capaFiles) {
    Write-Host "Processando: $($file.Name)"
    
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    
    # 1. Adicionar o link na imagem (se ainda não tiver)
    # Procura pela imagem com o alt="Logo" que inserimos anteriormente
    $imgPattern = '(<img loading=lazy decoding=async width=200 src="data:image/png;base64,[^"]+" alt="Logo">)'
    
    # Verifica se já tem o link para evitar duplicação
    if ($content -notmatch [regex]::Escape($linkUrl)) {
        if ($content -match $imgPattern) {
            $content = $content -replace $imgPattern, "$linkTagStart`$1$linkTagEnd"
            Write-Host "  Link adicionado na imagem."
        }
        else {
            Write-Warning "  Imagem da logo não encontrada em $($file.Name). Verifique se o script anterior rodou."
        }
    }
    else {
        Write-Host "  Link já existe."
    }

    # 2. Restaurar o texto "Desenvolvido por"
    # Procura pelo container vazio antes do widget de imagem
    # O padrão busca: <div class=elementor-widget-container> [espaço/quebra] </div> [espaço/quebra] </div> [espaço/quebra] <div ... elementor-widget-image
    $emptyContainerPattern = '(<div class=elementor-widget-container>\s*)(\r?\n\s*</div>\s*</div>\s*<div[^>]+elementor-widget-image)'
    
    if ($content -notmatch "Desenvolvido por") {
        if ($content -match $emptyContainerPattern) {
            $content = $content -replace $emptyContainerPattern, "`$1$h2Tag`$2"
            Write-Host "  Texto 'Desenvolvido por' restaurado."
        }
        else {
            Write-Warning "  Container vazio para o texto não encontrado em $($file.Name)."
        }
    }
    else {
        Write-Host "  Texto já existe."
    }
    
    # Salvar o arquivo
    Set-Content -Path $file.FullName -Value $content -Encoding UTF8 -NoNewline
}

Write-Host "`nAtualização concluída em todos os arquivos CAPA!"
