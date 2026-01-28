
file_path = r"c:\Meus Sites\LP\LP S3\wp-content\uploads\2025\Lp\(44) - Portfolio-Projeto-66-CAPA.html"

try:
    with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
        content = f.read()

    body_index = content.lower().find("<body")
    if body_index != -1:
        print(f"Found <body> at index {body_index}")
        # Print context around body
        start = max(0, body_index - 100)
        end = min(len(content), body_index + 2000)
        print("Context around <body>:")
        print(content[start:end])
    else:
        print("Could not find <body> tag")

    # Search for menu keywords
    keywords = ["menu-fixo", "<header", "nav>", "class=\"menu"]
    for kw in keywords:
        kw_index = content.lower().find(kw)
        if kw_index != -1:
            print(f"\nFound '{kw}' at index {kw_index}")
            start = max(0, kw_index - 100)
            end = min(len(content), kw_index + 500)
            print(f"Context around '{kw}':")
            print(content[start:end])
        else:
            print(f"\nCould not find '{kw}'")

except Exception as e:
    print(f"Error: {e}")
