# Script para remover cards sem imagens

# Imagens que existem
$existingImages = @('0', '1', '2', '3', '4', '5', '26', '30', '41', '44', '54', '58', '63', '66', '71', '83')

# Ler o arquivo
$content = Get-Content "portfolio.html" -Raw -Encoding UTF8

# Pattern para encontrar cards
$cardPattern = '(?s)(\s*<!-- Card \d+ -->.*?</div>\s*</div>\s*</div>)'

# Encontrar todos os cards
$matches = [regex]::Matches($content, $cardPattern)

Write-Host "Total de cards encontrados: $($matches.Count)"

# Processar cada card
$cardsToRemove = @()
$cardsToKeep = @()

foreach ($match in $matches) {
    $cardContent = $match.Value
    
    # Extrair o número da imagem
    if ($cardContent -match '\((\d+)\) - Portfolio-Projeto-66-CAPA\.webp') {
        $imageNum = $Matches[1]
        
        if ($existingImages -contains $imageNum) {
            $cardsToKeep += $cardContent
            Write-Host "Mantendo card com imagem ($imageNum)" -ForegroundColor Green
        } else {
            $cardsToRemove += $cardContent
            Write-Host "Removendo card com imagem ($imageNum)" -ForegroundColor Red
        }
    }
}

Write-Host "`nResumo:"
Write-Host "Cards mantidos: $($cardsToKeep.Count)" -ForegroundColor Green
Write-Host "Cards removidos: $($cardsToRemove.Count)" -ForegroundColor Red
