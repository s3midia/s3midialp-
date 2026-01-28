$path = "c:\Meus Sites\LP\LP S3\wp-content\uploads\2025\Lp\(44) - Portfolio-Projeto-66-CAPA.html"
$content = Get-Content $path
$logoSig = "PHN2ZyB3aWR0aD0iMTQiIGhlaWdodD0iMjEi"

Write-Host "File: $path"
Write-Host "Total Lines: $($content.Count)"

$foundLogo = $false
for ($i = 0; $i -lt $content.Count; $i++) {
    if ($content[$i] -match $logoSig) {
        Write-Host "Logo found at line $($i+1):"
        $foundLogo = $true
    }
    if ($content[$i] -match "Desenvolvido por") {
        Write-Host "Text found at line $($i+1):"
        Write-Host $content[$i].Trim()
    }
}

if (-not $foundLogo) { Write-Host "Logo NOT FOUND." }
