param()
$file = 'c:\Meus Sites\LP\LP S3\index.html'

Write-Host "Reading file..."
$bytes = [System.IO.File]::ReadAllBytes($file)
$content = [System.Text.Encoding]::UTF8.GetString($bytes)

Write-Host "Applying fixes..."
$fixes = @(
    @('Ã.Â§Ã.Â£o', 'ção'),
    @('MÃ.ÂDIA', 'MÍDIA'),
    @('ConversÃ.Â£o', 'Conversão'),
    @('OtimizaÃ.Â§Ã.Â£o', 'Otimização'),
    @('comentÃ.Â¡rios', 'comentários'),
    @('trÃ.Â¡fego', 'tráfego'),
    @('OrÃ.Â§amento', 'Orçamento'),
    @('pÃ.Â¡gina', 'página'),
    @('AnÃ.Â¡lise', 'Análise'),
    @('otimizaÃ.Â§Ã.Â£o', 'otimização'),
    @('MÃ.Â©todo', 'Método'),
    @('estÃ.Â¡', 'está'),
    @('vocÃ.Âª', 'você'),
    @('prÃ.Â©', 'pré'),
    @('instÃ.Â¢ncia', 'instância'),
    @('cÃ.Â³digo', 'código'),
    @('condiÃ.Â§Ã.Âµes', 'condições'),
    @('especÃ.Â­ficas', 'específicas'),
    @('BenefÃ.Â­cios', 'Benefícios'),
    @('perceptÃ.Â­vel', 'perceptível'),
    @('crÃ.Â­ticas', 'críticas'),
    @('mÃ.Â­dia', 'mídia'),
    @('Ã.Â©', 'é'),
    @('Ã.Â£o', 'ão'),
    @('Ã.Â£', 'ã'),
    @('Ã.Â§', 'ç'),
    @('Ã.Â¡', 'á'),
    @('Ã.Âª', 'ê'),
    @('Ã.Â­', 'í'),
    @('Ã.Â³', 'ó'),
    @('Ã.Âº', 'ú')
)

$count = 0
foreach ($fix in $fixes) {
    $pattern = $fix[0] -replace '\.', [char]0xC6
    $before = $content
    $content = $content.Replace($pattern, $fix[1])
    if ($before -ne $content) {
        $count++
        Write-Host "  Fixed: $($fix[0]) -> $($fix[1])"
    }
}

Write-Host "Saving file..."
$bytes = [System.Text.Encoding]::UTF8.GetBytes($content)
[System.IO.File]::WriteAllBytes($file, $bytes)

Write-Host "Done! Applied $count fixes."
