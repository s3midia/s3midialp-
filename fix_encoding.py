#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Fix Double-Encoded UTF-8 Characters (Mojibake)
This script fixes Portuguese text that has been double-encoded (UTF-8 -> CP1252 -> UTF-8)
"""

import sys
import os
import shutil
from datetime import datetime

def main():
    file_path = r'c:\Meus Sites\LP\LP S3\index.html'
    backup_path = r'c:\Meus Sites\LP\LP S3\index.backup.html'
    
    print("=" * 50)
    print("   Character Encoding Repair Tool")
    print("=" * 50)
    print()
    
    # Create backup
    print("[1/4] Creating backup...")
    try:
        shutil.copy2(file_path, backup_path)
        print(f"      Backup saved to: {backup_path}")
    except Exception as e:
        print(f"      ERROR: Could not create backup: {e}")
        return 1
    print()
    
    # Read the file
    print("[2/4] Reading file...")
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
        print(f"      File loaded ({len(content)} characters)")
    except Exception as e:
        print(f"      ERROR: Could not read file: {e}")
        return 1
    print()
    
    # Apply fixes
    print("[3/4] Applying fixes...")
    
    # Define replacement mappings
    # These patterns represent double-encoded UTF-8 characters
    replacements = {
        # Combined patterns (most specific first)
        'ÃƒÂ§ÃƒÂ£o': 'ção',
        'ÃƒÂ§ÃƒÂµes': 'ções',
        'OtimizaÃƒÂ§ÃƒÂ£o': 'Otimização',
        'ConversÃƒÂ£o': 'Conversão',
        'estratÃƒÂ©gia': 'estratégia',
        'AnÃƒÂ¡lise': 'Análise',
        'MÃƒÂ©todo': 'Método',
        'OrÃƒÂ§amento': 'Orçamento',
        'computaÃƒÂ§ÃƒÂ£o': 'computação',
        'intenÃƒÂ§ÃƒÂ£o': 'intenção',
        'informaÃƒÂ§ÃƒÂ£o': 'informação',
        'informaÃƒÂ§ÃƒÂµes': 'informações',
        'soluÃƒÂ§ÃƒÂ£o': 'solução',
        'soluÃƒÂ§ÃƒÂµes': 'soluções',
        'descriÃƒÂ§ÃƒÂ£o': 'descrição',
        'otimizaÃƒÂ§ÃƒÂ£o': 'otimização',
        'funÃƒÂ§ÃƒÂ£o': 'função',
        'funÃƒÂ§ÃƒÂµes': 'funções',
        'seÃƒÂ§ÃƒÂ£o': 'seção',
        'animaÃƒÂ§ÃƒÂ£o': 'animação',
        'transiÃƒÂ§ÃƒÂ£o': 'transição',
        'condiÃƒÂ§ÃƒÂ£o': 'condição',
        'condiÃƒÂ§ÃƒÂµes': 'condições',
        'posiÃƒÂ§ÃƒÂ£o': 'posição',
        'instÃƒÂ¢ncia': 'instância',
        'experÃƒÂªncia': 'experiência',
        'agÃƒÂªncia': 'agência',
        'BenefÃƒÂ­cios': 'Benefícios',
        'especÃƒÂ­ficas': 'específicas',
        'especÃƒÂ­fico': 'específico',
        'especÃƒÂ­fica': 'específica',
        'crÃƒÂ­ticas': 'críticas',
        'crÃƒÂ­tico': 'crítico',
        'perceptÃƒÂ­vel': 'perceptível',
        'desnecessÃƒÂ¡rio': 'desnecessário',
        'desnecessÃƒÂ¡ria': 'desnecessária',
        'metÃƒÂ¡lica': 'metálica',
        'metÃƒÂ¡lico': 'metálico',
        'comentÃƒÂ¡rios': 'comentários',
        'parÃƒÂ¡grafos': 'parágrafos',
        
        # Individual accented characters
        'ÃƒÂ§': 'ç',
        'ÃƒÂ£': 'ã',
        'ÃƒÂ§': 'ç',
        'ÃƒÂ¡': 'á',
        'ÃƒÂ ': 'à',
        'ÃƒÂ¢': 'â',
        'ÃƒÂ©': 'é',
        'ÃƒÂª': 'ê',
        'ÃƒÂ­': 'í',
        'ÃƒÂ³': 'ó',
        'ÃƒÂ´': 'ô',
        'ÃƒÂµ': 'õ',
        'ÃƒÂº': 'ú',
        
        # Capital letters
        'ÃƒÂ': 'Á',
        'ÃƒÂ€': 'À',
        'ÃƒÂ‰': 'É',
        'ÃƒÂ': 'Í',
        'ÃƒÂ"': 'Ó',
        'ÃƒÂ‡': 'Ç',
        'Ãƒâ€°': 'É',
        'Ãƒâ€š': 'Â',
        'Ãƒæ'': 'Ã',
        'ÃƒÅ¡': 'Ê',
        'Ãƒâ€"': 'Ô',
        'Ãƒâ€¢': 'Õ',
        
        # Common words
        'MÃƒÂDIA': 'MÍDIA',
        'trÃƒÂ¡fego': 'tráfego',
        'pÃƒÂ¡gina': 'página',
        'pÃƒÂ¡ginas': 'páginas',
        'nÃƒÂ£o': 'não',
        'vocÃƒÂª': 'você',
        'quÃƒÂª': 'quê',
        'atÃƒÂ©': 'até',
        'prÃƒÂ©': 'pré',
        'ÃƒÂºltimos': 'últimos',
        'ÃƒÂºltimo': 'último',
        'ÃƒÂºnica': 'única',
        'ÃƒÂºnico': 'único',
        'orÃƒÂ§amento': 'orçamento',
        'prÃƒÂ³prio': 'próprio',
        'anÃƒÂ¡lise': 'análise',
        'cÃƒÂ³digo': 'código',
        'mÃƒÂ­dia': 'mídia',
        'padrÃƒÂ£o': 'padrão',
        'estÃƒÂ£o': 'estão',
        'jÃƒÂ¡': 'já',
        'famÃƒÂ­lia': 'família',
        'vivaÃƒÂ§o': 'vivaço',
    }
    
    fixed_content = content
    replacement_count = 0
    
    for pattern, replacement in replacements.items():
        count = fixed_content.count(pattern)
        if count > 0:
            fixed_content = fixed_content.replace(pattern, replacement)
            replacement_count += count
            print(f"      {pattern:20s} -> {replacement:15s} ({count} times)")
    
    print()
    print(f"      Total replacements: {replacement_count}")
    print()
    
    # Save the fixed content
    print("[4/4] Saving fixed file...")
    try:
        with open(file_path, 'w', encoding='utf-8') as f:
            f.write(fixed_content)
        print("      File saved successfully")
    except Exception as e:
        print(f"      ERROR: Could not save file: {e}")
        return 1
    print()
    
    print("=" * 50)
    print("   ✓ Encoding Fix Complete!")
    print("=" * 50)
    print()
    print("Summary:")
    print(f"  - Backup: {backup_path}")
    print(f"  - Total replacements: {replacement_count}")
    print("  - File encoding: UTF-8")
    print()
    print("Next Steps:")
    print("  1. Open index.html in your browser")
    print("  2. Look for: tráfego, MÍDIA, Conversão, etc.")
    print("  3. Backup available if rollback needed")
    print()
    
    return 0

if __name__ == "__main__":
    sys.exit(main())
