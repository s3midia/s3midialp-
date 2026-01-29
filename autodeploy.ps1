# Script de Auto-Deploy para Windows (PowerShell)
# Salve este arquivo como: autodeploy.ps1

Write-Host "🚀 Iniciando Robô de Auto-Deploy (S3 Mídia)..." -ForegroundColor Cyan
Write-Host "Pressione 'Ctrl + C' para parar." -ForegroundColor DarkGray
Write-Host "------------------------------------------------"

# Tempo em segundos para checar alterações
$intervalo = 10

while ($true) {
    # Verifica se tem arquivos modificados
    $status = git status --porcelain

    if ($status) {
        $hora = Get-Date -Format "HH:mm:ss"
        Write-Host "[$hora] 📝 Alterações encontradas! Trabalhando..." -ForegroundColor Yellow

        # Comandos do Git
        git add .
        git commit -m "Auto-save Windows: $hora" | Out-Null
        
        Write-Host "[$hora] ☁️  Subindo para o GitHub..." -ForegroundColor Cyan
        git push

        if ($?) {
            Write-Host "[$hora] ✅ Sucesso! Tudo sincronizado." -ForegroundColor Green
        } else {
            Write-Host "[$hora] ❌ Erro na conexão. Tentando de novo em breve." -ForegroundColor Red
        }
    } 
    
    # Pausa antes da próxima verificação
    Start-Sleep -Seconds $intervalo
}