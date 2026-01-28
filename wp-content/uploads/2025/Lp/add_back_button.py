#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Script para adicionar um botão "voltar" no início da página
"""

import re

# Caminho do arquivo
file_path = r'c:\Meus Sites\LP\LP S3\wp-content\uploads\2025\Lp\(4) - Portfolio-Projeto-66-CAPA.html'

# Ler o conteúdo do arquivo
with open(file_path, 'r', encoding='utf-8') as f:
    content = f.read()

# HTML e CSS do botão "voltar"
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

# Procurar por </head> e adicionar o botão logo após
pattern = r'(</head>)'
replacement = r'\1\n' + back_button_html

# Fazer a substituição
new_content = re.sub(pattern, replacement, content, count=1)

# Verificar se a substituição foi feita
if new_content != content:
    # Salvar o arquivo modificado
    with open(file_path, 'w', encoding='utf-8') as f:
        f.write(new_content)
    print("[OK] Botao 'Voltar' adicionado com sucesso!")
    print(f"[OK] Arquivo atualizado: {file_path}")
else:
    print("[ERRO] Nao foi possivel encontrar a tag </head> no arquivo.")
