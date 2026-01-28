
try:
    with open(r"c:\Meus Sites\LP\LP S3\wp-content\uploads\2025\Lp\(4) - Portfolio-Projeto-66-CAPA.html", "r", encoding="utf-8") as f:
        for i, line in enumerate(f, 1):
            if "<body" in line.lower():
                print(f"Found <body at line {i}")
                print(line[:200]) # Print start of line
                break
            if "</head>" in line.lower():
                print(f"Found </head> at line {i}")
except Exception as e:
    print(f"Error: {e}")
