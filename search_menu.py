
path = r"c:\Meus Sites\LP\LP S3\wp-content\uploads\2025\Lp\(2) - Portfolio-Projeto-66-CAPA.html"

try:
    with open(path, 'r', encoding='utf-8') as f:
        lines = f.readlines()
        
    found = False
    for i, line in enumerate(lines):
        if 'navMenuInjected' in line or 'menu-fixo' in line or 'menuInjected' in line:
            print(f"Match at line {i+1}:")
            print(line[:200]) # First 200 chars
            found = True
            
    if not found:
        print("No matches found.")
        
except Exception as e:
    print(f"Error: {e}")
