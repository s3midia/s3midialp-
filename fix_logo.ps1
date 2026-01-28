$file = "c:\Meus Sites\LP\LP S3\index.html"
$content = Get-Content $file -Raw

# 1. Fix broken uploads path (space in 'upl oads')
$content = $content -replace 'wp-content/upl\s+oads', 'wp-content/uploads'

# 2. Fix broken filename (space in 'freepik...') and replace with new logo
# Regex matches 'freepik_br_' followed by anything until '.png', handling potential spaces
$content = $content -replace 'freepik_br_[^"]+\.png', 's3_midia_logo.png'

# 3. Clear srcset attributes that point to the new logo (or are just leftover junk)
# Note: Since we replaced the filename, the srcset now looks like "s3_midia_logo.png 1024w, ..."
$content = $content -replace 'srcset="[^"]*s3_midia_logo\.png[^"]*"', ''
$content = $content -replace 'data-lazy-srcset="[^"]*s3_midia_logo\.png[^"]*"', ''
$content = $content -replace 'data-lazy-sizes="[^"]*"', ''
$content = $content -replace 'sizes="[^"]*"', ''

[System.IO.File]::WriteAllText($file, $content)
Write-Host "Logo fixed and srcset cleaned."
