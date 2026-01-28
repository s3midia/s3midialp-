import sys

path = r'c:\Meus Sites\LP\LP S3\index.html'

try:
    with open(path, 'r', encoding='utf-8') as f:
        content = f.read()

    # Repair the Bio line where the URL was accidentally substituted globally
    # The erroneous line: "Sou wp-content/uploads/2025/11/s3_midia_logo.png, engenheiro..."
    content = content.replace('wp-content/uploads/2025/11/s3_midia_logo.png, engenheiro', 'Fernando Andrade, engenheiro')

    # Repair Encoding Artifacts (Double UTF-8 encoding via CP1252)
    # We attempt to reverse the encoding damage.
    try:
        # Try to reverse: UTF-8 string -> CP1252 encoded bytes -> Decode as UTF-8
        # This reverses the "Read UTF-8 as CP1252" error.
        fixed_content = content.encode('cp1252').decode('utf-8')
        
        # Check if it actually improved things. 
        # "MÍDIA" should appear instead of "MÃƒÂ DIA" (or whatever the artifact was)
        if "MÍDIA" in fixed_content:
            content = fixed_content
            print("Encoding fixed via CP1252 reversal.")
    except Exception as e:
        print(f"Heuristic fix failed: {e}")
        # Fallback to manual replacements if the heuristic failed widely
        replacements = {
            'MÃƒÂ DIA': 'MÍDIA',
            'estratÃƒÂ©gia': 'estratégia',
            'trÃƒÂ¡s': 'trás',
            'computaÃƒÂ§ÃƒÂ£o': 'computação',
            'ÃƒÂºltimos': 'últimos',
            'pÃƒÂ¡ginas': 'páginas',
            'agÃƒÂªncia': 'agência',
            'nÃƒÂ£o': 'não',
            'intenÃƒÂ§ÃƒÂ£o': 'intenção',
            'ÃƒÂ©': 'é',
            'ÃƒÂ£': 'ã',
            'ÃƒÂ§': 'ç'
        }
        for k, v in replacements.items():
            content = content.replace(k, v)

    with open(path, 'w', encoding='utf-8') as f:
        f.write(content)

    print("File repaired.")

except Exception as e:
    print(f"Error: {e}")
