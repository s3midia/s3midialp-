$sourceCss = @"
<style>
    /* ============================================
       MENU STICKY STYLES (Injected)
       ============================================ */
    .sticky-menu {
        position: fixed; /* Forced Fixed */
        top: 0;
        left: 0;
        width: 100%;
        background: rgba(10, 10, 10, 0.95);
        backdrop-filter: blur(16px);
        -webkit-backdrop-filter: blur(16px);
        padding: 0.8rem 2rem;
        z-index: 99999 !important;
        border-bottom: 1px solid rgba(255, 255, 255, 0.08);
        box-shadow: 0 4px 20px 0 rgba(0, 0, 0, 0.3);
        transform: translateZ(0); /* Force GPU */
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
    .footer-links { display: flex; gap: 20px; font-size: 13px; color: rgba(255, 255, 255, 0.4); }

    /* Responsive */
    @media (min-width: 769px) {
        .nav-menu { display: flex !important; }
        .menu-toggle { display: none !important; }
    }
    @media (max-width: 768px) {
        .sticky-menu { padding: 1rem 1.5rem; }
        .logo { font-size: 1.5rem; }
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
            display: flex; /* Initially hidden by right: -100% */
        }
        .nav-menu.active { right: 0; }
        .menu-toggle { display: flex; }
        .cta-button { padding: 0.65rem 1.25rem; font-size: 0.85rem; }
        .cta-section { display: none; } /* Optional: Hide CTA on mobile if needed, or keep it */
    }
    
    /* Padding for Body to Compensate Fixed Header */
    body {
        padding-top: 100px !important;
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
                    <li><a href="index.html" class="nav-item">Início</a></li>
                    <li><a href="#" class="nav-item active">Portfólio</a></li>
                    <li><a href="index.html#servicos" class="nav-item">Serviços</a></li>
                    <li><a href="https://api.whatsapp.com/send/?phone=5577999238273&text=Ol%C3%A1%2C+gostaria+de+fazer+um+or%C3%A7amento..." class="nav-item">Contato</a></li>
                </ul>
                <!-- Menu Toggle -->
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
    <!-- Injected Scripts -->
    <script>
        document.addEventListener('DOMContentLoaded', () => {
            const menuToggle = document.getElementById('menuToggleInjected');
            const navMenu = document.getElementById('navMenuInjected');
            
            if (menuToggle && navMenu) {
                menuToggle.addEventListener('click', () => {
                    navMenu.classList.toggle('active');
                    menuToggle.classList.toggle('active');
                });
                
                // Close when clicking outside
                document.addEventListener('click', (e) => {
                    if (navMenu.classList.contains('active') && 
                        !navMenu.contains(e.target) && 
                        !menuToggle.contains(e.target)) {
                        navMenu.classList.remove('active');
                        menuToggle.classList.remove('active');
                    }
                });
            }
        });
    </script>
"@

# Pasta dos arquivos (Recursivo)
$directory = "c:\Meus Sites\LP\LP S3"

# Obter todos os arquivos CAPA.html recursivamente
$files = Get-ChildItem -Path $directory -Filter "*CAPA.html" -Recurse

foreach ($file in $files) {
    Write-Host "Processando: $($file.FullName)"
    # Read with explicit encoding
    $content = Get-Content -Path $file.FullName -Raw -Encoding UTF8

    $modified = $false

    # 0. CLEANUP OLD JS INJECTION (s and s2)
    if ($content -match "(?s)<script>var s=document\.createElement\('style'\);.*?back-header.*?</script>") {
        Write-Host "  Limpando injecao JS antiga (s)..."
        $content = $content -replace "(?s)<script>var s=document\.createElement\('style'\);.*?back-header.*?</script>", ""
        $modified = $true
    }
    if ($content -match "(?s)<script>var s2=document\.createElement\('style'\);.*?</script>") {
        Write-Host "  Limpando injecao JS antiga (s2)..."
        $content = $content -replace "(?s)<script>var s2=document\.createElement\('style'\);.*?</script>", ""
        $modified = $true
    }

    # 1. Injetar CSS
    # If css exists but needs update (checking menu-toggle class existence in CSS area)
    if ($content -match "(?i)</head>") {
        # Check if we need to inject or replace
        if ($content -notmatch "MENU STICKY STYLES") {
            Write-Host "  Injetando CSS..."
            $content = $content -replace "(?i)</head>", "$sourceCss`n</head>"
            $modified = $true
        }
        elseif ($content -notmatch "\.menu-toggle") {
            # If logic is too complex to regex replace ONLY the css, we might append? 
            # No, better to assume if "MENU STICKY STYLES" is there, we assume it's the old one and we might need to Update it?
            # For safety, let's Append the new CSS style block again if it's missing the mobile toggle part. 
            # Or better: Replace the existing CSS block.
            # Regex for existing block: <style>.*?MENU STICKY STYLES.*?</style>
            Write-Host "  Atualizando CSS (faltava suporte mobile)..."
            $content = $content -replace "(?s)<style>\s*/\* =+.*?MENU STICKY STYLES.*?<\/style>", "$sourceCss"
            $modified = $true
        }
        else {
            Write-Host "  CSS ja atualizado."
        }
    }

    # 2. Injetar Header
    if ($content -match "(?i)(<body[^>]*>)") {
        if ($content -notmatch "Injected Header") {
            Write-Host "  Injetando Header..."
            $content = $content -replace "(?i)(<body[^>]*>)", "`$1`n$sourceHeader"
            $modified = $true
        }
        elseif ($content -notmatch "menuToggleInjected") {
            # Replace old header with new one
            Write-Host "  Substituindo Header antigo (sem toggle)..."
            # Regex to capture the old injected nav
            $content = $content -replace "(?s)<nav class=""sticky-menu"" id=""stickyMenuInjected"">.*?</nav>", "$sourceHeader"
            # Also clean up duplicate newlines if any
            $modified = $true
        }
        else {
            Write-Host "  Header ja atualizado."
        }
    }

    # 3. Injetar Footer (com Scripts)
    if ($content -match "(?i)</body>") {
        if ($content -notmatch "Injected Footer") {
            Write-Host "  Injetando Footer..."
            $content = $content -replace "(?i)</body>", "$sourceFooter`n</body>"
            $modified = $true
        }
        elseif ($content -notmatch "menuToggleInjected") {
            # Check if footer scripts are present (using unique ID from script)
            # Actually, just appending the script part ?
            # If "Injected Footer" is there, but "menuToggleInjected" (in script) is not?
            # Replace footer block + script
            Write-Host "  Atualizando Footer e Scripts..."
            $content = $content -replace "(?s)<!-- Injected Footer -->.*?</footer>", ""
            # Remove old script if any? (hard to identify without ID)
            # Just append new footer
            $content = $content -replace "(?i)</body>", "$sourceFooter`n</body>"
            $modified = $true
        }
        else {
            Write-Host "  Footer ja atualizado."
        }
    }

    if ($modified) {
        Set-Content -Path $file.FullName -Value $content -Encoding UTF8
        Write-Host "  Arquivo salvo."
    }
    else {
        Write-Host "  Nada a alterar."
    }
}
