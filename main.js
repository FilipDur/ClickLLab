document.addEventListener('DOMContentLoaded', () => {
    // Inicializace Lucide ikon
    lucide.createIcons();

    // Navbar Scroll Effect
    const navbar = document.getElementById('navbar');

    window.addEventListener('scroll', () => {
        if (window.scrollY > 50) {
            navbar.style.background = 'rgba(10, 10, 12, 0.95)';
            navbar.style.backdropFilter = 'blur(10px)';
            navbar.style.borderBottom = '1px solid rgba(255, 255, 255, 0.05)';
            navbar.style.padding = '1rem 0';
        } else {
            navbar.style.background = 'transparent';
            navbar.style.backdropFilter = 'none';
            navbar.style.borderBottom = '1px solid transparent';
            navbar.style.padding = '1.5rem 0';
        }
    });

    // Reveal on Scroll Animations
    const revealElements = document.querySelectorAll('.reveal');

    const revealOptions = {
        threshold: 0.15,
        rootMargin: "0px 0px -50px 0px"
    };

    const revealOnScroll = new IntersectionObserver(function (entries, observer) {
        entries.forEach(entry => {
            if (!entry.isIntersecting) {
                return;
            } else {
                entry.target.classList.add('active');
                observer.unobserve(entry.target);
            }
        });
    }, revealOptions);

    revealElements.forEach(el => {
        revealOnScroll.observe(el);
    });

    // Mobile Menu Toggle (Placeholder, lze dopracovat později)
    const hamburger = document.querySelector('.hamburger');
    const navLinks = document.querySelector('.nav-links');

    if (hamburger) {
        hamburger.addEventListener('click', () => {
            navLinks.style.display = navLinks.style.display === 'flex' ? 'none' : 'flex';
            // Zde bychom ideálně přidávali třídu pro hezčí animaci menu
        });
    }

    // --- Pokročilé efekty ---

    // 1. Parallax na Hero obrázku
    const heroImg = document.querySelector('.hero-img');
    window.addEventListener('scroll', () => {
        const scrolled = window.scrollY;
        // Jen dokud jsme v horní části stránky, kvůli výkonu
        if (heroImg && scrolled < window.innerHeight) {
            heroImg.style.transform = `scale(1.05) translateY(${scrolled * 0.3}px)`;
        }
    });

    // 2. Dynamický "Glow" efekt na kartách (sleduje myš)
    const cards = document.querySelectorAll('.service-card, .glass-panel, .blog-card');

    document.addEventListener('mousemove', (e) => {
        cards.forEach(card => {
            const rect = card.getBoundingClientRect();
            // Spočítat pozici myši relativně k elementu
            const x = e.clientX - rect.left;
            const y = e.clientY - rect.top;

            // Nastavení CSS proměnných na konkrétním elementu
            card.style.setProperty('--mouse-x', `${x}px`);
            card.style.setProperty('--mouse-y', `${y}px`);
        });
    });

    // 3. Kontaktní formulář — EmailJS (Outlook)
    const contactForm = document.getElementById('contactForm');
    if (contactForm) {
        try {
            if (typeof emailjs !== 'undefined') {
                emailjs.init({ publicKey: 'gbdd3SSDhPJS0_ZZH' });

                contactForm.addEventListener('submit', function (event) {
                    event.preventDefault();

                    const submitBtn = this.querySelector('button[type="submit"]');
                    const originalBtnText = submitBtn.innerHTML;
                    submitBtn.innerHTML = 'Odesílám...';
                    submitBtn.disabled = true;

                    // Zachytit hodnoty pro auto-reply
                    const templateParams = {
                        name: this.querySelector('[name="name"]').value,
                        email: this.querySelector('[name="email"]').value,
                        message: this.querySelector('[name="message"]').value
                    };

                    console.log('--- Zahájení odesílání ---');
                    console.log('Data:', templateParams);

                    // Definice požadavků
                    const sendNotification = emailjs.send('service_i6kkbim', 'template_q1x8khn', templateParams);
                    const sendAutoReply = emailjs.send('service_i6kkbim', 'template_wb8wcwl', templateParams);

                    // Odeslat paralelně a počkat na výsledky
                    Promise.allSettled([sendNotification, sendAutoReply])
                        .then((results) => {
                            const [notificationResult, autoReplyResult] = results;

                            // 1. Logika notifikace pro majitele
                            if (notificationResult.status === 'fulfilled') {
                                console.log('✅ Notifikace (ContactUs): Úspěšně odeslána');
                            } else {
                                console.error('❌ Notifikace (ContactUs): CHYBA', notificationResult.reason);
                            }

                            // 2. Logika auto-reply pro zákazníka
                            if (autoReplyResult.status === 'fulfilled') {
                                console.log('✅ Auto-reply: Úspěšně odeslán');
                            } else {
                                console.error('❌ Auto-reply: CHYBA', autoReplyResult.reason);
                                // Pokud víme, že auto-reply selhal, můžeme to logovat, ale uživatel dostane potvrzení o "odeslání poptávky"
                            }

                            // Úspěch (alespoň notifikace by měla projít pro zobrazení úspěchu)
                            if (notificationResult.status === 'fulfilled') {
                                submitBtn.innerHTML = '✓ Odesláno!';
                                contactForm.reset();
                                setTimeout(() => {
                                    submitBtn.innerHTML = originalBtnText;
                                    submitBtn.disabled = false;
                                }, 3000);
                            } else {
                                alert('Odeslání se nezdařilo. Zkuste to prosím znovu nebo nás kontaktujte napřímo.');
                                submitBtn.innerHTML = originalBtnText;
                                submitBtn.disabled = false;
                            }
                        });
                });
            }
        } catch (e) {
            console.warn("EmailJS failed", e);
        }
    }
});
