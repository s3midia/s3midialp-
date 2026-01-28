$path = "c:\Meus Sites\LP\LP S3\index.html"
$content = [System.IO.File]::ReadAllText($path, [System.Text.Encoding]::UTF8)

# Fix bio URL
$content = $content.Replace('wp-content/uploads/2025/11/s3_midia_logo.png, engenheiro', 'Fernando Andrade, engenheiro')

# Fix encoding artifacts (Manual Map)
$map = @{
    'S3 MÃƒÂ DIA'         = 'S3 MÍDIA';
    'estratÃƒÂ©gia'       = 'estratégia';
    'trÃƒÂ¡s'             = 'trás';
    'computaÃƒÂ§ÃƒÂ£o'    = 'computação';
    'ÃƒÂºltimos'          = 'últimos';
    'pÃƒÂ¡ginas'          = 'páginas';
    'agÃƒÂªncia'          = 'agência';
    'nÃƒÂ£o'              = 'não';
    'intenÃƒÂ§ÃƒÂ£o'      = 'intenção';
    'transformaÃƒÂ§ÃƒÂ£o' = 'transformação';
    'divulgaÃƒÂ§ÃƒÂµes'   = 'divulgações';
    'negÃƒÂ³cio'          = 'negócio';
    'vocÃƒÂª'             = 'você';
    'atÃƒÂ©'              = 'até';
    'tambÃƒÂ©m'           = 'também';
    'comeÃƒÂ§o'           = 'começo';
    'concluÃƒÂdo'         = 'concluído'
}
# Removed duplicate key "Come..." (case insensitive)

foreach ($key in $map.Keys) {
    if ($content.Contains($key)) {
        $content = $content.Replace($key, $map[$key])
    }
}

[System.IO.File]::WriteAllText($path, $content, [System.Text.Encoding]::UTF8)
Write-Host "Repairs applied."
