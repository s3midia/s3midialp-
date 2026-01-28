$file = "c:\Meus Sites\LP\LP S3\index.html"
$content = Get-Content $file -Raw
$newLogo = "wp-content/uploads/2025/11/s3_midia_logo.png"

# Target URLs to replace 
$targetFull = "https://ferandrade.com.br/wp-content/uploads/2025/11/freepik_br_d6c1eb5f-48be-45fc-aef5-44757fb53ef4-1024x1024.png"
$targetLocal = "wp-content/uploads/2025/11/freepik_br_d6c1eb5f-48be-45fc-aef5-44757fb53ef4-1024x1024.png"

$content = $content.Replace($targetFull, $newLogo)
$content = $content.Replace($targetLocal, $newLogo)

# Remove the specific long queryset string to empty the attributes (or effectively make them invalid/empty)
$srcsetPart = "https://ferandrade.com.br/wp-content/uploads/2025/11/freepik_br_d6c1eb5f-48be-45fc-aef5-44757fb53ef4-1024x1024.png 1024w, https://ferandrade.com.br/wp-content/uploads/2025/11/freepik_br_d6c1eb5f-48be-45fc-aef5-44757fb53ef4-300x300.png 300w, https://ferandrade.com.br/wp-content/uploads/2025/11/freepik_br_d6c1eb5f-48be-45fc-aef5-44757fb53ef4-150x150.png 150w, https://ferandrade.com.br/wp-content/uploads/2025/11/freepik_br_d6c1eb5f-48be-45fc-aef5-44757fb53ef4-768x768.png 768w, https://ferandrade.com.br/wp-content/uploads/2025/11/freepik_br_d6c1eb5f-48be-45fc-aef5-44757fb53ef4-1536x1536.png 1536w, https://ferandrade.com.br/wp-content/uploads/2025/11/freepik_br_d6c1eb5f-48be-45fc-aef5-44757fb53ef4.png 2048w"

$content = $content.Replace($srcsetPart, "")

[System.IO.File]::WriteAllText($file, $content)
Write-Host "Logo updated in index.html"
