$path = "c:\Meus Sites\LP\LP S3\index.html"
$content = [System.IO.File]::ReadAllText($path, [System.Text.Encoding]::UTF8)

# Fix bio URL (simple string match)
$content = $content.Replace('wp-content/uploads/2025/11/s3_midia_logo.png,', 'Fernando Andrade,')

# Fix encoding artifacts (Manual Map - expanded)
$map = @{
    'S3 MÃƒÂ DIA'         = 'S3 MÍDIA';
    'pÃƒÂ¡gina'           = 'página';
    'transformaÃƒÂ§ÃƒÂ£o' = 'transformação';
    'lanÃƒÂ§ar'           = 'lançar';
    'manhÃƒÂ£'            = 'manhã';
    'nÃƒÂ£o'              = 'não';
    'comeÃƒÂ§o'           = 'começo';
    'ComeÃƒÂ§o'           = 'Começo'
    # Add any other missing ones observed
}

foreach ($key in $map.Keys) {
    $content = $content.Replace($key, $map[$key])
}

[System.IO.File]::WriteAllText($path, $content, [System.Text.Encoding]::UTF8)
Write-Host "Repairs applied round 2."
