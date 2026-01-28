#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Script para remover menu sticky e outros elementos indesejados
"""

import re

# Caminho do arquivo
file_path = r'c:\Meus Sites\LP\LP S3\wp-content\uploads\2025\Lp\(4) - Portfolio-Projeto-66-CAPA.html'

# Ler o conteúdo do arquivo
with open(file_path, 'r', encoding='utf-8') as f:
    content = f.read()

original_size = len(content)
print(f"[INFO] Tamanho original: {original_size} caracteres")

# PASSO 1: Remover o menu sticky completo (nav + todo o conteúdo até </nav>)
# Procura por <nav class="sticky-menu" até o </nav> correspondente
pattern_nav = r'<nav\s+class="sticky-menu"[^>]*>.*?</nav>'
content_without_nav = re.sub(pattern_nav, '', content, flags=re.DOTALL | re.IGNORECASE)

removed_nav = original_size - len(content_without_nav)
if removed_nav > 0:
    print(f"[OK] Menu sticky removido ({removed_nav} caracteres)")
    content = content_without_nav
else:
    print("[INFO] Menu sticky nao encontrado")

# PASSO 2: Remover estilos relacionados ao sticky-menu
pattern_sticky_style = r'<style[^>]*>.*?\.sticky-menu.*?</style>'
content_without_style = re.sub(pattern_sticky_style, '', content, flags=re.DOTALL | re.IGNORECASE)

removed_style = len(content) - len(content_without_style)
if removed_style > 0:
    print(f"[OK] Estilos do menu removidos ({removed_style} caracteres)")
    content = content_without_style
else:
    print("[INFO] Estilos do menu nao encontrados")

# PASSO 3: Procurar e listar botões com fundo azul
print("\n[INFO] Procurando por botoes azuis...")
blue_patterns = [
    r'background[^;]*blue',
    r'background[^;]*#[0-9a-f]{0,2}[0-9a-f]{0,2}[fF]{2}',  # tons de azul
    r'background[^;]*rgb\([^)]*,\s*[^)]*,\s*2[0-5][0-9]\)',  # RGB com muito azul
]

for i, pattern in enumerate(blue_patterns):
    matches = re.findall(pattern, content, flags=re.IGNORECASE)
    if matches:
        print(f"  Padrão {i+1}: {len(matches)} ocorrências encontradas")
        for match in matches[:3]:
            print(f"    - {match[:80]}")

# PASSO 4: Remover comentários HTML sobre menu injetado
pattern_comment = r'<!--\s*Injected\s*Header\s*-->'
content = re.sub(pattern_comment, '', content, flags=re.IGNORECASE)

# PASSO 5: Limpar espaços em branco extras
content = re.sub(r'\n\s*\n\s*\n', '\n\n', content)

# Salvar o arquivo
with open(file_path, 'w', encoding='utf-8') as f:
    f.write(content)

final_size = len(content)
total_removed = original_size - final_size

print(f"\n[OK] Arquivo atualizado!")
print(f"[OK] Tamanho final: {final_size} caracteres")
print(f"[OK] Total removido: {total_removed} caracteres")
print(f"[OK] Arquivo: {file_path}")
