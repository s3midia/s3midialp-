# Script para substituir logo e texto do rodapé nos arquivos CAPA

$capaFiles = Get-ChildItem -Path "c:\Meus Sites\LP\LP S3\wp-content\uploads\2025\Lp" -Filter "*CAPA.htm*" -File | Where-Object { $_.Name -notlike "*.bak" }

# Base64 da nova logo (imagem enviada pelo usuário)
$newLogoBase64 = Get-Content "C:/Users/jefer/.gemini/antigravity/brain/e023393f-4741-419e-a0e5-7cc66556166c/uploaded_image_1768951313311.png" -Raw -Encoding Byte
$newLogoDataUri = "data:image/png;base64," + [System.Convert]::ToBase64String($newLogoBase64)

foreach ($file in $capaFiles) {
    Write-Host "Processando: $($file.Name)"
    
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    
    # Substituir o texto "Desenvolvido por"
    $content = $content -replace '<h2 class="elementor-heading-title elementor-size-default">Desenvolvido por</h2>', ''
    
    # Substituir o link e a imagem antiga
    $oldPattern = '<a href=https://azogu\.com/ target=_blank rel=noopener>[\s\S]*?</a>'
    $newImageTag = "<img loading=lazy decoding=async width=200 src=`"$newLogoDataUri`" alt=`"Logo`">"
    
    $content = $content -replace $oldPattern, $newImageTag
    
    # Salvar o arquivo
    Set-Content -Path $file.FullName -Value $content -Encoding UTF8 -NoNewline
    
    Write-Host "Concluído: $($file.Name)"
}

Write-Host "`nSubstituição concluída em todos os arquivos CAPA!"
