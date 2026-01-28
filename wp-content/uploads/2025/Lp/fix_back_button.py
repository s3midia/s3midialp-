#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Script para LIMPAR COMPLETAMENTE e adicionar apenas UM botão voltar
"""

import re

# Caminho do arquivo
file_path = r'c:\Meus Sites\LP\LP S3\wp-content\uploads\2025\Lp\(4) - Portfolio-Projeto-66-CAPA.html'

# Ler o conteúdo do arquivo
with open(file_path, 'r', encoding='utf-8') as f:
    content = f.read()

print(f"[INFO] Tamanho original do arquivo: {len(content)} caracteres")

# PASSO 1: Encontrar a posição de </head>
head_match = re.search(r'</head>', content)
if not head_match:
    print("[ERRO] Nao foi possivel encontrar a tag </head>")
    exit(1)

head_pos = head_match.end()
print(f"[INFO] Tag </head> encontrada na posicao {head_pos}")

# PASSO 2: Extrair tudo ANTES de </head> (incluindo </head>)
before_head = content[:head_pos]

# PASSO 3: Extrair tudo DEPOIS de </head>
after_head = content[head_pos:]

# PASSO 4: REMOVER TUDO relacionado ao back-button que está DEPOIS do </head>
# Remove blocos <style>...</style> que contêm .back-button
after_head_clean = re.sub(
    r'\s*<style>\s*\.back-button\s*\{.*?</style>\s*',
    '',
    after_head,
    flags=re.DOTALL
)

# Remove tags <a> com class="back-button"
after_head_clean = re.sub(
    r'\s*<a\s+[^>]*class="back-button"[^>]*>.*?</a>\s*',
    '',
    after_head_clean,
    flags=re.DOTALL
)

# Remove espaços em branco extras no início
after_head_clean = after_head_clean.lstrip()

print(f"[INFO] Removidos {len(after_head) - len(after_head_clean)} caracteres de codigo antigo")

# PASSO 5: Criar o NOVO botão
back_button_html = '''
<style>
.back-button {
    position: fixed;
    top: 20px;
    left: 20px;
    z-index: 999999;
    background: linear-gradient(135deg, 
        #000000 0%, 
        #1a1a1a 20%, 
        #2d2d2d 40%, 
        #1a1a1a 60%, 
        #0a0a0a 80%, 
        #000000 100%);
    color: #ffffff;
    border: 2px solid rgba(255, 255, 255, 0.3);
    padding: 12px 24px;
    border-radius: 50px;
    font-size: 16px;
    font-weight: 600;
    cursor: pointer;
    text-decoration: none;
    display: inline-flex;
    align-items: center;
    gap: 8px;
    box-shadow: 
        0 0 20px rgba(255, 255, 255, 0.4),
        0 0 40px rgba(255, 255, 255, 0.2),
        inset 0 0 20px rgba(255, 255, 255, 0.1),
        inset 0 0 40px rgba(255, 255, 255, 0.05),
        0 4px 20px rgba(0, 0, 0, 0.5);
    transition: all 0.3s ease;
    text-shadow: 
        0 0 10px rgba(255, 255, 255, 0.8),
        0 0 20px rgba(255, 255, 255, 0.4);
    backdrop-filter: blur(10px);
    -webkit-backdrop-filter: blur(10px);
}

.back-button:hover {
    transform: translateY(-2px);
    background: linear-gradient(135deg, 
        #0a0a0a 0%, 
        #2a2a2a 20%, 
        #3d3d3d 40%, 
        #2a2a2a 60%, 
        #1a1a1a 80%, 
        #0a0a0a 100%);
    box-shadow: 
        0 0 30px rgba(255, 255, 255, 0.6),
        0 0 60px rgba(255, 255, 255, 0.3),
        inset 0 0 30px rgba(255, 255, 255, 0.15),
        inset 0 0 60px rgba(255, 255, 255, 0.08),
        0 6px 25px rgba(0, 0, 0, 0.6);
    border-color: rgba(255, 255, 255, 0.5);
    text-shadow: 
        0 0 15px rgba(255, 255, 255, 1),
        0 0 30px rgba(255, 255, 255, 0.6);
}

.back-button:active {
    transform: translateY(0);
    box-shadow: 
        0 0 15px rgba(255, 255, 255, 0.3),
        0 0 30px rgba(255, 255, 255, 0.15),
        inset 0 0 15px rgba(255, 255, 255, 0.08),
        0 2px 15px rgba(0, 0, 0, 0.4);
}

.back-button svg {
    width: 20px;
    height: 20px;
    fill: currentColor;
    filter: drop-shadow(0 0 5px rgba(255, 255, 255, 0.8));
}

@media (max-width: 768px) {
    .back-button {
        top: 15px;
        left: 15px;
        padding: 10px 20px;
        font-size: 14px;
    }
}
</style>

<a href="../../../../portfolio.html" class="back-button">
    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
        <path d="M20 11H7.83l5.59-5.59L12 4l-8 8 8 8 1.41-1.41L7.83 13H20v-2z"/>
    </svg>
    Voltar
</a>
'''

# PASSO 6: Reconstruir o conteúdo: ANTES do </head> + NOVO BOTÃO + DEPOIS do </head> (limpo)
new_content = before_head + back_button_html + '\n' + after_head_clean

# PASSO 7: Salvar o arquivo
with open(file_path, 'w', encoding='utf-8') as f:
    f.write(new_content)

print("[OK] Arquivo completamente limpo e atualizado!")
print(f"[OK] Tamanho final: {len(new_content)} caracteres")
print("[OK] Diferenca: {0} caracteres".format(len(new_content) - len(content)))

# Verificar quantas ocorrências de back-button existem agora
count = new_content.count('back-button')
print(f"[OK] Ocorrencias de 'back-button' no arquivo: {count}")
print(f"[OK] Arquivo atualizado: {file_path}")
