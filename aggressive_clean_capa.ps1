$sourceCss = @"
<style>
    /* ============================================
       MENU STICKY STYLES (Injected)
       ============================================ */
    .sticky-menu {
        position: fixed !important;
        top: 0 !important;
        left: 0 !important;
        width: 100% !important;
        background: rgba(10, 10, 10, 0.95) !important;
        backdrop-filter: blur(16px);
        -webkit-backdrop-filter: blur(16px);
        padding: 0.8rem 2rem;
        z-index: 999999 !important;
        border-bottom: 1px solid rgba(255, 255, 255, 0.08);
        box-shadow: 0 4px 20px 0 rgba(0, 0, 0, 0.3);
        transform: translateZ(0);
    }
    .menu-container {
        max-width: 1400px;
        margin: 0 auto;
        display: flex;
        align-items: center;
        justify-content: space-between;
        gap: 2rem;
    }
    .logo-image {
        height: 40px;
        width: auto;
        object-fit: contain;
    }
    .nav-section {
        flex: 1;
        display: flex;
        align-items: center;
        justify-content: center;
    }
    .nav-menu {
        display: flex;
        list-style: none;
        gap: 2.5rem;
        align-items: center;
        margin: 0; 
        padding: 0;
    }
    .nav-item {
        color: #ffffff !important;
        text-decoration: none;
        font-size: 0.95rem;
        font-weight: 500;
        position: relative;
        padding: 0.5rem 0;
        transition: color 0.3s ease;
    }
    .nav-item:hover {
        color: #fff;
        text-shadow: 0 0 10px rgba(255, 255, 255, 0.3);
    }
    .cta-button {
        background: transparent;
        color: #fff;
        padding: 0.75rem 1.75rem;
        border-radius: 50px;
        text-decoration: none;
        font-weight: 600;
        font-size: 0.9rem;
        transition: all 0.3s ease;
        display: inline-block;
        border: 1px solid rgba(255, 255, 255, 0.3);
    }
    .cta-button:hover {
        background: rgba(255, 255, 255, 0.1);
        border-color: #fff;
    }
    
    /* Mobile Toggle */
    .menu-toggle {
        display: none;
        flex-direction: column;
        gap: 5px;
        background: none;
        border: none;
        cursor: pointer;
        padding: 8px;
        z-index: 1001;
    }
    .hamburger {
        width: 25px;
        height: 3px;
        background: #fff;
        border-radius: 2px;
        transition: all 0.3s ease;
    }
    .menu-toggle.active .hamburger:nth-child(1) { transform: rotate(45deg) translate(7px, 7px); }
    .menu-toggle.active .hamburger:nth-child(2) { opacity: 0; }
    .menu-toggle.active .hamburger:nth-child(3) { transform: rotate(-45deg) translate(7px, -7px); }

    /* Footer Styles */
    .site-footer {
        background: #000;
        padding: 40px 20px;
        border-top: 1px solid rgba(255, 255, 255, 0.1);
        margin-top: 50px;
    }
    .footer-container {
        max-width: 1200px;
        margin: 0 auto;
        display: flex;
        flex-direction: column;
        align-items: center;
        gap: 30px;
    }
    .footer-logo img { height: 32px; width: auto; opacity: 0.9; }
    .footer-copyright { font-size: 13px; color: rgba(255, 255, 255, 0.6); }
    .footer-social { display: flex; gap: 10px; }
    .footer-social a {
        display: flex; align-items: center; justify-content: center;
        width: 32px; height: 32px; border-radius: 50%;
        background: rgba(255, 255, 255, 0.05); color: #fff;
        border: 1px solid rgba(255, 255, 255, 0.1);
    }

    /* Responsive */
    @media (min-width: 769px) {
        .nav-menu { display: flex !important; }
        .menu-toggle { display: none !important; }
    }
    @media (max-width: 768px) {
        .sticky-menu { padding: 1rem 1.5rem !important; }
        .nav-section { position: relative; }
        .nav-menu {
            position: fixed;
            top: 0;
            right: -100%;
            height: 100vh;
            width: 70%;
            max-width: 300px;
            background: rgba(10, 10, 10, 0.98);
            backdrop-filter: blur(20px);
            flex-direction: column;
            justify-content: center;
            gap: 2rem;
            padding: 2rem;
            transition: right 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            border-left: 1px solid rgba(255, 255, 255, 0.1);
            box-shadow: -5px 0 30px rgba(0, 0, 0, 0.5);
            display: flex;
        }
        .nav-menu.active { right: 0; }
        .menu-toggle { display: flex; }
        .cta-section { display: none; }
    }
    
    body {
        padding-top: 80px !important;
    }
</style>
"@

$sourceHeader = @"
    <!-- Injected Header -->
    <nav class="sticky-menu" id="stickyMenuInjected">
        <div class="menu-container">
            <div class="logo-section">
                <a href="#" style="text-decoration: none;">
                    <img src="wp-content/uploads/2025/11/Logo S3 midia.webp" alt="S3 Mídia" class="logo-image">
                </a>
            </div>
            <div class="nav-section">
                <ul class="nav-menu" id="navMenuInjected">
                    <li><a href="../../../index - S3midia.html" class="nav-item">Início</a></li>
                    <li><a href="../../../portfolio.html" class="nav-item active">Portfólio</a></li>
                    <li><a href="../../../index - S3midia.html#servicos" class="nav-item">Serviços</a></li>
                    <li><a href="https://api.whatsapp.com/send/?phone=5577999238273&text=Ol%C3%A1%2C+gostaria+de+fazer+um+or%C3%A7amento..." class="nav-item">Contato</a></li>
                </ul>
                <button class="menu-toggle" id="menuToggleInjected" aria-label="Toggle Menu">
                    <span class="hamburger"></span>
                    <span class="hamburger"></span>
                    <span class="hamburger"></span>
                </button>
            </div>
            <div class="cta-section">
                <a href="https://api.whatsapp.com/send/?phone=5577999238273&text=Ol%C3%A1%2C+gostaria+de+fazer+um+or%C3%A7amento..." class="cta-button">Fale conosco</a>
            </div>
        </div>
    </nav>
"@

$sourceFooter = @"
    <!-- Injected Footer -->
    <footer class="site-footer">
        <div class="footer-container">
            <div class="footer-logo">
                <a href="#"><img src="wp-content/uploads/2025/11/Logo S3 midia.webp" alt="S3 Mídia Digital"></a>
            </div>
            <div class="footer-copyright">Copyright ©2025 | S3MÍDIA DIGITAL</div>
            <div class="footer-social">
                <a href="https://api.whatsapp.com/send/?phone=5577999238273" target="_blank">W</a>
                <a href="https://www.instagram.com/s3midia/" target="_blank">I</a>
            </div>
        </div>
    </footer>
    <script>
        document.addEventListener('DOMContentLoaded', () => {
            const menuToggle = document.getElementById('menuToggleInjected');
            const navMenu = document.getElementById('navMenuInjected');
            if (menuToggle && navMenu) {
                menuToggle.addEventListener('click', () => {
                    navMenu.classList.toggle('active');
                    menuToggle.classList.toggle('active');
                });
                document.addEventListener('click', (e) => {
                    if (navMenu.classList.contains('active') && !navMenu.contains(e.target) && !menuToggle.contains(e.target)) {
                        navMenu.classList.remove('active');
                        menuToggle.classList.remove('active');
                    }
                });
            }
        });
    </script>
"@

$directory = "c:\Meus Sites\LP\LP S3"
$files = Get-ChildItem -Path $directory -Filter "*CAPA.html" -Recurse

foreach ($file in $files) {
    Write-Host "Limpando e Processando: $($file.FullName)"
    $content = Get-Content -Path $file.FullName -Raw -Encoding UTF8
    
    # 1. REMOVER TUDO QUE É CONHECIDO COMO DUPLICADO/ANTIGO
    # Remover injeções anteriores marcadas
    $content = $content -replace "(?s)<!-- Injected Header -->.*?<\/nav>", ""
    $content = $content -replace "(?s)<!-- Injected Footer -->.*?<\/footer>", ""
    $content = $content -replace "(?s)<style>\s*/\* =+ MENU STICKY STYLES.*?<\/style>", ""
    $content = $content -replace "(?s)<script>var (s|s2)=document\.createElement\('style'\);.*?<\/script>", ""
    
    # Remover blocos legados densos de Menu Sticky (tentativa 1 do arquivo original)
    $content = $content -replace "(?s)<!-- =+ MENU STICKY =+ -->.*?<!-- =+ END MENU STICKY =+ -->", ""
    # Se não tiver markers de 'END', tentar pelo pattern do style/nav
    $content = $content -replace "(?s)<style>\s*/\* =+ MENU STICKY STYLES.*?<\/style>", ""
    $content = $content -replace "(?s)<nav class=""sticky-menu"" id=""stickyMenu"">.*?<\/nav>", ""
    $content = $content -replace "(?s)<script>\s*// Seleciona elementos do menu sticky.*?<\/script>", ""
    # Remover possíveis rodapés extras no final
    if ($content -match "(?s)(<footer class=""site-footer"">.*?<\/footer>.*){2,}") {
        Write-Host "  Limpando rodapés múltiplos..."
        $content = $content -replace "(?s)<footer class=""site-footer"">.*?<\/footer>", ""
    }

    # 2. INJEÇÃO LIMPA
    # CSS no <head>
    if ($content -match "(?i)</head>") {
        $content = $content -replace "(?i)</head>", "$sourceCss`n</head>"
    }
    # Header após <body>
    if ($content -match "(?i)(<body[^>]*>)") {
        $content = $content -replace "(?i)(<body[^>]*>)", "$1`n$sourceHeader"
    }
    # Footer antes de </body>
    if ($content -match "(?i)</body>") {
        $content = $content -replace "(?i)</body>", "$sourceFooter`n</body>"
    }

    Set-Content -Path $file.FullName -Value $content -Encoding UTF8
    Write-Host "  Concluído."
}
