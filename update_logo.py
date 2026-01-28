import re
import os

file_path = r'c:\Meus Sites\LP\LP S3\index.html'
new_logo_rel = "wp-content/uploads/2025/11/s3_midia_logo.png"

try:
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()

    # 1. Replace the specific main image URL (used in src and data-lazy-src)
    # The file currently has: https://ferandrade.com.br/wp-content/uploads/2025/11/freepik_br_d6c1eb5f-48be-45fc-aef5-44757fb53ef4-1024x1024.png
    # And local: wp-content/uploads/2025/11/freepik_br_d6c1eb5f-48be-45fc-aef5-44757fb53ef4-1024x1024.png
    
    # We replace strict strings to avoid replacing other things unintendedly.
    target_url_full = "https://ferandrade.com.br/wp-content/uploads/2025/11/freepik_br_d6c1eb5f-48be-45fc-aef5-44757fb53ef4-1024x1024.png"
    target_url_local = "wp-content/uploads/2025/11/freepik_br_d6c1eb5f-48be-45fc-aef5-44757fb53ef4-1024x1024.png"
    
    content = content.replace(target_url_full, new_logo_rel)
    content = content.replace(target_url_local, new_logo_rel)

    # 2. Clean up attributes in the image tags that now contain the new logo
    def clean_tag(match):
        tag = match.group(0)
        # Remove srcset, data-lazy-srcset, sizes, data-lazy-sizes
        tag = re.sub(r'\s+srcset="[^"]*"', '', tag)
        tag = re.sub(r'\s+data-lazy-srcset="[^"]*"', '', tag)
        tag = re.sub(r'\s+sizes="[^"]*"', '', tag)
        tag = re.sub(r'\s+data-lazy-sizes="[^"]*"', '', tag)
        return tag

    # Regex to match the img tag that contains the new logo path
    # We match <img ... s3_midia_logo.png ... >
    # The src attribute might be anywhere.
    # We allow matching across newlines if needed, though usually on one line or close.
    # re.DOTALL is needed if the tag spans multiple lines.
    
    content = re.sub(r'<img[^>]*s3_midia_logo\.png[^>]*>', clean_tag, content, flags=re.DOTALL)

    with open(file_path, 'w', encoding='utf-8') as f:
        f.write(content)
        
    print("Successfully updated index.html")

except Exception as e:
    print(f"Error: {e}")
