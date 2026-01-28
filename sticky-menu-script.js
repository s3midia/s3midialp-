// ============================================
// STICKY MENU COM SCROLL DETECTION
// ============================================

// Seleciona elementos
const stickyMenu = document.getElementById('stickyMenu');
const menuToggle = document.getElementById('menuToggle');
const navMenu = document.getElementById('navMenu');
const navItems = document.querySelectorAll('.nav-item');

// Configurações
const SCROLL_THRESHOLD = 100; // Pixels para ativar o menu
let lastScrollPosition = 0;
let isMenuVisible = false;

// ============================================
// FUNÇÃO DE SCROLL
// ============================================
function handleScroll() {
    const currentScrollPosition = window.pageYOffset || document.documentElement.scrollTop;

    // Mostra o menu quando rolar para baixo mais de 100px
    if (currentScrollPosition > SCROLL_THRESHOLD) {
        if (!isMenuVisible) {
            stickyMenu.classList.add('visible');
            isMenuVisible = true;
        }
    } else {
        // Esconde o menu quando voltar ao topo
        if (isMenuVisible) {
            stickyMenu.classList.remove('visible');
            isMenuVisible = false;
        }
    }

    lastScrollPosition = currentScrollPosition;
}

// ============================================
// TOGGLE MENU MOBILE
// ============================================
function toggleMobileMenu() {
    menuToggle.classList.toggle('active');
    navMenu.classList.toggle('active');

    // Previne scroll quando menu mobile está aberto
    if (navMenu.classList.contains('active')) {
        document.body.style.overflow = 'hidden';
    } else {
        document.body.style.overflow = '';
    }
}

// ============================================
// SMOOTH SCROLL PARA ÂNCORAS
// ============================================
function smoothScrollToSection(e) {
    const href = e.target.getAttribute('href');

    // Verifica se é uma âncora interna
    if (href && href.startsWith('#') && href !== '#') {
        e.preventDefault();

        const targetSection = document.querySelector(href);

        if (targetSection) {
            // Fecha o menu mobile se estiver aberto
            if (navMenu.classList.contains('active')) {
                toggleMobileMenu();
            }

            // Calcula a posição considerando a altura do menu
            const menuHeight = stickyMenu.offsetHeight;
            const targetPosition = targetSection.offsetTop - menuHeight - 20;

            // Faz o scroll suave
            window.scrollTo({
                top: targetPosition,
                behavior: 'smooth'
            });
        }
    }
}

// ============================================
// HIGHLIGHT DO MENU ATIVO
// ============================================
function updateActiveMenuItem() {
    const sections = document.querySelectorAll('section[id]');
    const scrollPosition = window.pageYOffset + 150;

    sections.forEach(section => {
        const sectionTop = section.offsetTop;
        const sectionHeight = section.offsetHeight;
        const sectionId = section.getAttribute('id');

        if (scrollPosition >= sectionTop && scrollPosition < sectionTop + sectionHeight) {
            // Remove active de todos os itens
            navItems.forEach(item => {
                item.classList.remove('active');
            });

            // Adiciona active no item correspondente
            const activeItem = document.querySelector(`.nav-item[href="#${sectionId}"]`);
            if (activeItem) {
                activeItem.classList.add('active');
            }
        }
    });
}

// ============================================
// DEBOUNCE PARA OTIMIZAR PERFORMANCE DO SCROLL
// ============================================
function debounce(func, wait = 10) {
    let timeout;
    return function executedFunction(...args) {
        const later = () => {
            clearTimeout(timeout);
            func(...args);
        };
        clearTimeout(timeout);
        timeout = setTimeout(later, wait);
    };
}

// ============================================
// EVENT LISTENERS
// ============================================

// Scroll event com debounce para melhor performance
window.addEventListener('scroll', debounce(() => {
    handleScroll();
    updateActiveMenuItem();
}, 10));

// Toggle menu mobile
menuToggle.addEventListener('click', toggleMobileMenu);

// Smooth scroll nos links
navItems.forEach(item => {
    item.addEventListener('click', smoothScrollToSection);
});

// Fecha menu mobile ao clicar fora
document.addEventListener('click', (e) => {
    if (navMenu.classList.contains('active') &&
        !navMenu.contains(e.target) &&
        !menuToggle.contains(e.target)) {
        toggleMobileMenu();
    }
});

// Fecha menu mobile ao pressionar ESC
document.addEventListener('keydown', (e) => {
    if (e.key === 'Escape' && navMenu.classList.contains('active')) {
        toggleMobileMenu();
    }
});

// Ajusta menu no resize da janela
let resizeTimer;
window.addEventListener('resize', () => {
    clearTimeout(resizeTimer);
    resizeTimer = setTimeout(() => {
        // Fecha menu mobile se a tela ficar maior que 768px
        if (window.innerWidth > 768 && navMenu.classList.contains('active')) {
            toggleMobileMenu();
        }
    }, 250);
});

// ============================================
// INICIALIZAÇÃO
// ============================================
// Verifica a posição inicial ao carregar a página
document.addEventListener('DOMContentLoaded', () => {
    handleScroll();
    updateActiveMenuItem();
});

console.log('🎯 Sticky Menu carregado com sucesso!');
