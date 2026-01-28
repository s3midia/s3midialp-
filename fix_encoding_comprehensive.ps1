# ========================================
# Fix Double-Encoded UTF-8 Characters
# ========================================

$ErrorActionPreference = "Stop"

$filePath = "c:\Meus Sites\LP\LP S3\index.html"
$backupPath = "c:\Meus Sites\LP\LP S3\index.backup.html"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "   Character Encoding Repair Tool" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Create backup
Write-Host "[1/4] Creating backup..." -ForegroundColor Yellow
Copy-Item -Path $filePath -Destination $backupPath -Force
Write-Host "      Backup saved" -ForegroundColor Green
Write-Host ""

# Read the file
Write-Host "[2/4] Reading file..." -ForegroundColor Yellow
$content = [System.IO.File]::ReadAllText($filePath, [System.Text.Encoding]::UTF8)
Write-Host "      File loaded" -ForegroundColor Green
Write-Host ""

# Apply replacements
Write-Host "[3/4] Applying fixes..." -ForegroundColor Yellow
$fixedContent = $content

# Main replacement patterns
$patterns = @(
    @('ÃƒÂ§ÃƒÂ£o', 'ção'),
    @('ÃƒÂ§ÃƒÂµes', 'ções'),
    @('estratÃƒÂ©gia', 'estratégia'),
    @('ÃƒÂ¡', 'á'),
    @('ÃƒÂ ', 'à'),
    @('ÃƒÂ£', 'ã'),
    @('ÃƒÂ¢', 'â'),
    @('ÃƒÂ©', 'é'),
    @('ÃƒÂª', 'ê'),
    @('ÃƒÂ­', 'í'),
    @('ÃƒÂ³', 'ó'),
    @('ÃƒÂ´', 'ô'),
    @('ÃƒÂµ', 'õ'),
    @('ÃƒÂº', 'ú'),
    @('ÃƒÂ§', 'ç'),
    @('ÃƒÂ', 'Á'),
    @('ÃƒÂ€', 'À'),
    @('ÃƒÂ‰', 'É'),
    @('ÃƒÂ', 'Í'),
    @('ÃƒÂ"', 'Ó'),
    @('ÃƒÂ‡', 'Ç'),
    @('Ãƒâ€°', 'É'),
    @('Ãƒâ€š', 'Â'),
    @('Ãƒæ'', 'Ã'),
    @('ÃƒÅ¡', 'Ê'),
    @('Ãƒâ€\u0022', 'Ô'),
    @('Ãƒâ€¢', 'Õ'),
    @('ÃƒÅ¡', 'Ú')
)

$replacementCount = 0
foreach ($pair in $patterns) {
    $pattern = $pair[0]
    $replacement = $pair[1]
    $before = $fixedContent.Length
    $fixedContent = $fixedContent.Replace($pattern, $replacement)
    $after = $fixedContent.Length
    if ($before -ne $after) {
        $replacementCount++
        Write-Host "      Fixed: $pattern -> $replacement" -ForegroundColor Gray
    }
}

Write-Host ""
Write-Host "      Patterns applied: $replacementCount" -ForegroundColor Green
Write-Host ""

# Save the fixed content
Write-Host "[4/4] Saving fixed file..." -ForegroundColor Yellow
[System.IO.File]::WriteAllText($filePath, $fixedContent, [System.Text.Encoding]::UTF8)
Write-Host "      File saved" -ForegroundColor Green
Write-Host ""

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "   Complete!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Summary:" -ForegroundColor White
Write-Host "  - Backup: index.backup.html" -ForegroundColor White
Write-Host "  - Patterns fixed: $replacementCount" -ForegroundColor White
Write-Host "  - Encoding: UTF-8" -ForegroundColor White
Write-Host ""
