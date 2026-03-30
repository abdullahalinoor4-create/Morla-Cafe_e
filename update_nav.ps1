$dir = "d:\Morla\frontend"
$files = Get-ChildItem "$dir\*.html"

$navBase = @"
<nav class="fixed top-0 w-full z-50 bg-white border-b border-gray-100">
  <div class="flex justify-between items-center px-6 md:px-10 py-5 max-w-[1400px] mx-auto">
    <!-- Left: Logo & Wordmark -->
    <a href="index.html" class="flex items-center gap-3 md:gap-4 text-[#1a1c29] hover:opacity-80 transition-opacity">
      <div class="flex flex-col items-center justify-center -mt-1 opacity-80 scale-90 md:scale-100">
        <span class="material-symbols-outlined text-[16px] leading-none mb-[1px]">park</span>
        <span class="font-serif text-[6px] font-bold tracking-[0.2em] leading-none">MORLA</span>
        <span class="font-sans text-[4px] font-light tracking-[0.3em] uppercase leading-none mt-[1px] ml-[1px]" style="font-family: 'Inter', sans-serif;">CAFÉ</span>
      </div>
      <span class="font-serif text-xl md:text-2xl font-bold tracking-widest leading-none uppercase">MORLA</span>
    </a>

    <!-- Center Links (Desktop) -->
    <div class="hidden md:flex items-center space-x-10">
      <a href="index.html" class="font-sans text-[11px] font-bold text-slate-500 hover:text-slate-800 tracking-[0.15em] uppercase transition-colors __ACTIVE_HOME__">HOME</a>
      <a href="menu.html" class="font-sans text-[11px] font-bold text-slate-500 hover:text-slate-800 tracking-[0.15em] uppercase transition-colors __ACTIVE_MENU__">MENU</a>
      <a href="about.html" class="font-sans text-[11px] font-bold text-slate-500 hover:text-slate-800 tracking-[0.15em] uppercase transition-colors __ACTIVE_STORY__">THE STORY</a>
      <a href="gallery.html" class="font-sans text-[11px] font-bold text-slate-500 hover:text-slate-800 tracking-[0.15em] uppercase transition-colors __ACTIVE_GALLERY__">GALLERY</a>
    </div>

    <!-- Right Button (Desktop) / Hamburger (Mobile) -->
    <div class="flex items-center gap-4">
      <button onclick="window.location.href='index.html#contact'" class="hidden md:block px-7 py-2.5 rounded-full border border-slate-400 text-slate-700 text-[11px] font-bold tracking-[0.15em] uppercase hover:bg-slate-50 transition-colors">
        CONTACT US
      </button>
      
      <!-- Hamburger Menu Button -->
      <button id="mobile-menu-button" class="md:hidden flex items-center justify-center p-2 text-slate-700 hover:bg-slate-50 rounded-lg transition-colors">
        <span class="material-symbols-outlined text-2xl">menu</span>
      </button>
    </div>
  </div>

  <!-- Mobile Menu Overlay -->
  <div id="mobile-menu" class="hidden fixed inset-0 z-[60] bg-white transform translate-x-full transition-transform duration-300 ease-in-out md:hidden">
    <div class="flex flex-col h-full bg-slate-50 p-8 pt-24 space-y-8">
      <button id="close-menu-button" class="absolute top-6 right-8 p-2 text-slate-700 hover:bg-white rounded-lg">
        <span class="material-symbols-outlined text-3xl">close</span>
      </button>
      
      <a href="index.html" class="font-serif text-4xl font-bold tracking-widest text-[#1a1c29] border-b border-slate-200 pb-4 __ACTIVE_HOME_M__">HOME</a>
      <a href="menu.html" class="font-serif text-4xl font-bold tracking-widest text-[#1a1c29] border-b border-slate-200 pb-4 __ACTIVE_MENU_M__">MENU</a>
      <a href="about.html" class="font-serif text-4xl font-bold tracking-widest text-[#1a1c29] border-b border-slate-200 pb-4 __ACTIVE_STORY_M__">THE STORY</a>
      <a href="gallery.html" class="font-serif text-4xl font-bold tracking-widest text-[#1a1c29] border-b border-slate-200 pb-4 __ACTIVE_GALLERY_M__">GALLERY</a>
      
      <button onclick="toggleMenu(); window.location.href='index.html#contact'" class="mt-8 bg-[#1E2235] text-white py-5 rounded-full text-xs font-bold tracking-[0.2em] uppercase shadow-xl">
        CONTACT US
      </button>
      
      <div class="mt-auto pb-12 flex justify-center gap-8 text-slate-400">
        <span class="material-symbols-outlined">share</span>
        <span class="material-symbols-outlined">mail</span>
      </div>
    </div>
  </div>

  <script>
    const menuBtn = document.getElementById('mobile-menu-button');
    const closeBtn = document.getElementById('close-menu-button');
    const menu = document.getElementById('mobile-menu');

    function toggleMenu() {
      if (menu.classList.contains('hidden')) {
        menu.classList.remove('hidden');
        setTimeout(() => menu.classList.remove('translate-x-full'), 10);
        document.body.style.overflow = 'hidden';
      } else {
        menu.classList.add('translate-x-full');
        setTimeout(() => menu.classList.add('hidden'), 300);
        document.body.style.overflow = '';
      }
    }

    menuBtn.addEventListener('click', toggleMenu);
    closeBtn.addEventListener('click', toggleMenu);
    
    // Close menu on link click
    const menuLinks = menu.querySelectorAll('a');
    menuLinks.forEach(link => {
      link.addEventListener('click', () => {
        menu.classList.add('translate-x-full');
        setTimeout(() => menu.classList.add('hidden'), 300);
        document.body.style.overflow = '';
      });
    });
  </script>
</nav>
"@

$activeClass = "text-slate-800 border-b border-slate-800 pb-1"
$activeClassMobile = "text-slate-900 border-b-4 border-slate-900"

foreach ($file in $files) {
    if ($file.Name -eq 'contact.html') { continue }
    $content = Get-Content $file.FullName -Raw
    
    $nav = $navBase
    if ($file.Name -eq 'index.html') { 
        $nav = $nav.Replace('__ACTIVE_HOME__', $activeClass).Replace('__ACTIVE_HOME_M__', $activeClassMobile)
    } else { 
        $nav = $nav.Replace('__ACTIVE_HOME__', '').Replace('__ACTIVE_HOME_M__', '') 
    }
    
    if ($file.Name -eq 'menu.html') { 
        $nav = $nav.Replace('__ACTIVE_MENU__', $activeClass).Replace('__ACTIVE_MENU_M__', $activeClassMobile)
    } else { 
        $nav = $nav.Replace('__ACTIVE_MENU__', '').Replace('__ACTIVE_MENU_M__', '') 
    }
    
    if ($file.Name -eq 'about.html') { 
        $nav = $nav.Replace('__ACTIVE_STORY__', $activeClass).Replace('__ACTIVE_STORY_M__', $activeClassMobile)
    } else { 
        $nav = $nav.Replace('__ACTIVE_STORY__', '').Replace('__ACTIVE_STORY_M__', '') 
    }
    
    if ($file.Name -eq 'gallery.html') { 
        $nav = $nav.Replace('__ACTIVE_GALLERY__', $activeClass).Replace('__ACTIVE_GALLERY_M__', $activeClassMobile)
    } else { 
        $nav = $nav.Replace('__ACTIVE_GALLERY__', '').Replace('__ACTIVE_GALLERY_M__', '') 
    }
    
    # Replace the existing nav block
    $content = $content -replace '(?si)<nav\b[^>]*>.*?</nav>', $nav
    
    # Ensure UTF8 without BOM
    [System.IO.File]::WriteAllText($file.FullName, $content, (New-Object System.Text.UTF8Encoding($false)))
    Write-Host "Updated responsive nav in $($file.Name)"
}
