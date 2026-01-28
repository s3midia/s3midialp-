// Fix Double-Encoded UTF-8 Characters (Mojibake)
const fs = require('fs');
const path = require('path');

const filePath = 'c:\\Meus Sites\\LP\\LP S3\\index.html';
const backupPath = 'c:\\Meus Sites\\LP\\LP S3\\index.backup.html';

console.log('========================================');
console.log('   Character Encoding Repair Tool');
console.log('========================================');
console.log('');

// Backup already created by PowerShell
console.log('[1/3] Using existing backup...');
console.log('');

// Read the file
console.log('[2/3] Reading and fixing file...');
let content = fs.readFileSync(filePath, 'utf8');

// Define replacement patterns
const replacements = [
    // Combined patterns (most specific first)
    ['ÃƒÂ§ÃƒÂ£o', 'ção'],
    ['ÃƒÂ§ÃƒÂµes', 'ções'],
    ['OtimizaÃƒÂ§ÃƒÂ£o', 'Otimização'],
    ['ConversÃƒÂ£o', 'Conversão'],
    ['estratÃƒÂ©gia', 'estratégia'],
    ['estratÃƒÂ©gias', 'estratégias'],
    ['AnÃƒÂ¡lise', 'Análise'],
    ['MÃƒÂ©todo', 'Método'],
    ['OrÃƒÂ§amento', 'Orçamento'],
    ['orÃƒÂ§amento', 'orçamento'],
    ['computaÃƒÂ§ÃƒÂ£o', 'computação'],
    ['intenÃƒÂ§ÃƒÂ£o', 'intenção'],
    ['informaÃƒÂ§ÃƒÂ£o', 'informação'],
    ['informaÃƒÂ§ÃƒÂµes', 'informações'],
    ['soluÃƒÂ§ÃƒÂ£o', 'solução'],
    ['soluÃƒÂ§ÃƒÂµes', 'soluções'],
    ['descriÃƒÂ§ÃƒÂ£o', 'descrição'],
    ['descriÃƒÂ§ÃƒÂµes', 'descrições'],
    ['otimizaÃƒÂ§ÃƒÂ£o', 'otimização'],
    ['otimizaÃƒÂ§ÃƒÂµes', 'otimizações'],
    ['funÃƒÂ§ÃƒÂ£o', 'função'],
    ['funÃƒÂ§ÃƒÂµes', 'funções'],
    ['seÃƒÂ§ÃƒÂ£o', 'seção'],
    ['seÃƒÂ§ÃƒÂµes', 'seções'],
    ['animaÃƒÂ§ÃƒÂ£o', 'animação'],
    ['animaÃƒÂ§ÃƒÂµes', 'animações'],
    ['transiÃƒÂ§ÃƒÂ£o', 'transição'],
    ['transiÃƒÂ§ÃƒÂµes', 'transições'],
    ['condiÃƒÂ§ÃƒÂ£o', 'condição'],
    ['condiÃƒÂ§ÃƒÂµes', 'condições'],
    ['posiÃƒÂ§ÃƒÂ£o', 'posição'],
    ['instÃƒÂ¢ncia', 'instância'],
    ['instÃƒÂ¢ncias', 'instâncias'],
    ['experÃƒÂªncia', 'experiência'],
    ['experÃƒÂªncias', 'experiências'],
    ['agÃƒÂªncia', 'agência'],
    ['BenefÃƒÂ­cios', 'Benefícios'],
    ['benefÃƒÂ­cios', 'benefícios'],
    ['especÃƒÂ­ficas', 'específicas'],
    ['especÃƒÂ­fico', 'específico'],
    ['especÃƒÂ­fica', 'específica'],
    ['crÃƒÂ­ticas', 'críticas'],
    ['crÃƒÂ­tico', 'crítico'],
    ['perceptÃƒÂ­vel', 'perceptível'],
    ['desnecessÃƒÂ¡rio', 'desnecessário'],
    ['desnecessÃƒÂ¡ria', 'desnecessária'],
    ['metÃƒÂ¡lica', 'metálica'],
    ['metÃƒÂ¡lico', 'metálico'],
    ['comentÃƒÂ¡rios', 'comentários'],
    ['parÃƒÂ¡grafos', 'parágrafos'],

    // Individual characters
    ['ÃƒÂ§', 'ç'],
    ['ÃƒÂ£', 'ã'],
    ['ÃƒÂ¡', 'á'],
    ['ÃƒÂ ', 'à'],
    ['ÃƒÂ¢', 'â'],
    ['ÃƒÂ©', 'é'],
    ['ÃƒÂª', 'ê'],
    ['ÃƒÂ­', 'í'],
    ['ÃƒÂ³', 'ó'],
    ['ÃƒÂ´', 'ô'],
    ['ÃƒÂµ', 'õ'],
    ['ÃƒÂº', 'ú'],

    // Capital letters  
    ['ÃƒÂ', 'Á'],
    ['ÃƒÂ€', 'À'],
    ['ÃƒÂ‰', 'É'],
    ['ÃƒÂ', 'Í'],
    ['ÃƒÂ"', 'Ó'],
    ['ÃƒÂ‡', 'Ç'],
    ['Ãƒâ€°', 'É'],
    ['Ãƒâ€š', 'Â'],
    ['Ãƒæ'', 'Ã'],
    ['ÃƒÅ¡', 'Ê'],
        ['Ãƒâ€"', 'Ô'],
        ['Ãƒâ€¢', 'Õ'],
        ['ÃƒÅ¡', 'Ú'],

        // Specific words
        ['MÃƒÂDIA', 'MÍDIA'],
        ['trÃƒÂ¡fego', 'tráfego'],
        ['pÃƒÂ¡gina', 'página'],
        ['pÃƒÂ¡ginas', 'páginas'],
        ['nÃƒÂ£o', 'não'],
        ['vocÃƒÂª', 'você'],
        ['quÃƒÂª', 'quê'],
        ['atÃƒÂ©', 'até'],
        ['prÃƒÂ©', 'pré'],
        ['ÃƒÂºltimos', 'últimos'],
        ['ÃƒÂºltimo', 'último'],
        ['ÃƒÂºnica', 'única'],
        ['ÃƒÂºnico', 'único'],
        ['prÃƒÂ³prio', 'próprio'],
        ['anÃƒÂ¡lise', 'análise'],
        ['anÃƒÂ¡lises', 'análises'],
        ['cÃƒÂ³digo', 'código'],
        ['mÃƒÂ­dia', 'mídia'],
        ['padrÃƒÂ£o', 'padrão'],
        ['estÃƒÂ£o', 'estão'],
        ['jÃƒÂ¡', 'já'],
        ['famÃƒÂ­lia', 'família'],
        ['vivaÃƒÂ§o', 'vivaço'],
    ];

let replacementCount = 0;
let totalReplacements = 0;

replacements.forEach(([pattern, replacement]) => {
    const before = content;
    content = content.split(pattern).join(replacement);
    if (before !== content) {
        const count = (before.length - content.length) / (pattern.length - replacement.length);
        console.log(`      ${pattern} → ${replacement} (${count} times)`);
        replacementCount++;
        totalReplacements += count;
    }
});

console.log('');
console.log(`      Patterns applied: ${replacementCount}`);
console.log(`      Total replacements: ${totalReplacements}`);
console.log('');

// Save the file
console.log('[3/3] Saving file...');
fs.writeFileSync(filePath, content, 'utf8');
console.log('      File saved successfully');
console.log('');

console.log('========================================');
console.log('   ✓ Encoding Fix Complete!');
console.log('========================================');
console.log('');
console.log('Summary:');
console.log(`  - Backup: ${backupPath}`);
console.log(`  - Total replacements: ${totalReplacements}`);
console.log('  - File encoding: UTF-8');
console.log('');
console.log('Next Steps:');
console.log('  1. Open index.html in your browser');
console.log('  2. Look for: tráfego, MÍDIA, Conversão');
console.log('  3. Backup available if needed');
console.log('');
