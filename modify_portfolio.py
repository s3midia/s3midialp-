import os

# File paths
file_0_path = r"c:\Meus Sites\LP\LP S3\wp-content\uploads\2025\Lp\(0) - Portfolio-Projeto-66-CAPA.htm"
file_2_path = r"c:\Meus Sites\LP\LP S3\wp-content\uploads\2025\Lp\(2) - Portfolio-Projeto-66-CAPA.html"

def read_file(path):
    with open(path, 'r', encoding='utf-8') as f:
        return f.readlines()

def write_file(path, content):
    with open(path, 'w', encoding='utf-8') as f:
        f.writelines(content)

def main():
    print("Starting modification...")

    # 1. Get Footer from File (0)
    print(f"Reading footer from {file_0_path}...")
    try:
        lines_0 = read_file(file_0_path)
        # Lines 8802 to 8841 (1-based in view_file, so 8801 to 8841 in 0-based list)
        # Note: view_file line numbers are 1-based.
        # Adjusted indices: 8801 (start) to 8841 (end, inclusive so slice up to 8842)
        footer_lines = lines_0[8801:8842] 
        print(f"Extracted {len(footer_lines)} lines for footer.")
    except Exception as e:
        print(f"Error reading file (0): {e}")
        return

    # 2. Modify File (2)
    print(f"Processing {file_2_path}...")
    try:
        lines_2 = read_file(file_2_path)
        content_2 = "".join(lines_2)
        
        # Remove comments and injected code
        print("Removing '<!-- Menu Sticky HTML -->'...")
        content_2 = content_2.replace("<!-- Menu Sticky HTML -->", "")
        
        print("Removing '<!-- Menu Sticky Script -->'...")
        content_2 = content_2.replace("<!-- Menu Sticky Script -->", "")

        # Remove Injected Footer and Script
        # Finding the marker
        marker = "<!-- Injected Footer -->"
        if marker in content_2:
            print(f"Found '{marker}'. Truncating/Removing content after it.")
            # We assume everything after this marker (and the marker itself) is the unwanted footer + script
            # because it was appended to the end in the previous turn.
            # However, we must be careful not to delete closing body/html tags if they exist (though minified files often lack them or they are at the very end).
            # Looking at file (2) view, it seems the file ENDS with the script.
            # 11004: <!-- Injected Footer -->
            # ...
            # 11036: (End of file)
            # So splitting at the marker seems safe.
            parts = content_2.split(marker)
            content_2 = parts[0] # Keep everything before the marker
        else:
            print(f"Warning: '{marker}' not found. Cannot remove injected footer/script block by marker.")
            # Fallback: Try removing the script block directly if marker is missing
            script_start = "const menuToggle = document.getElementById('menuToggleInjected');"
            if script_start in content_2:
                 print("Found script content. Attempting manual removal of script block isn't implemented safely, relying on marker.")

        # 3. Append New Footer
        print("Appending new footer...")
        # Check if file ends with a newline
        if not content_2.endswith('\n'):
            content_2 += '\n'
        
        content_2 += "".join(footer_lines)

        # Write back
        print(f"Writing changes to {file_2_path}...")
        with open(file_2_path, 'w', encoding='utf-8') as f:
            f.write(content_2)
        
        print("Done.")

    except Exception as e:
        print(f"Error processing file (2): {e}")

if __name__ == "__main__":
    main()
