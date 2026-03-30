$dir = "d:\Morla\frontend"
$files = Get-ChildItem "$dir\*.html"

foreach ($file in $files) {
    if ($file.Name -eq 'contact.html') { continue }
    $content = Get-Content $file.FullName -Raw
    
    # 1. Update horizontal padding for mobile (px-8 -> px-6 md:px-8)
    $content = $content -replace '(?<!md:)px-8', 'px-6 md:px-8'
    
    # 2. Refine large typography scaling (text-5xl md:text-7xl -> text-4xl md:text-7xl)
    $content = $content -replace 'text-5xl md:text-7xl', 'text-4xl md:text-7xl'
    $content = $content -replace 'text-5xl md:text-8xl', 'text-4xl md:text-8xl'
    $content = $content -replace 'text-4xl md:text-6xl', 'text-3xl md:text-6xl'
    
    # 3. Fix About page hero height for mobile
    if ($file.Name -eq 'about.html') {
        $content = $content -replace 'h-\[870px\]', 'h-[70vh] md:h-[870px]'
    }
    
    # 4. Fix Footer Encoding Site-wide (Direct replacement with clean characters)
    $footerSearch = '(?si)<footer\b[^>]*>.*?</footer>'
    $footerClean = @"
<footer class="bg-[#f4f3f1] dark:bg-slate-900 w-full py-12 px-6">
    <div class="max-w-7xl mx-auto flex flex-col items-center">
        <!-- Subtle Brand Background -->
        <span class="text-3xl md:text-5xl font-serif font-black text-[#1E2235]/10 dark:text-white/5 uppercase tracking-[0.2em] mb-10 block text-center select-none">MORLA</span>
        
        <!-- Social Icons -->
        <div class="flex items-center gap-10 mb-10 text-[#1E2235]/60">
            <a href="#" class="hover:text-[#1E2235] transition-colors" title="Instagram">
                <svg class="w-5 h-5 fill-current" viewBox="0 0 24 24"><path d="M12 2.163c3.204 0 3.584.012 4.85.07 3.252.148 4.771 1.691 4.919 4.919.058 1.265.069 1.645.069 4.849 0 3.205-.012 3.584-.069 4.849-.149 3.225-1.664 4.771-4.919 4.919-1.266.058-1.644.07-4.85.07-3.204 0-3.584-.012-4.849-.07-3.26-.149-4.771-1.699-4.919-4.92-.058-1.265-.07-1.644-.07-4.849 0-3.204.013-3.583.07-4.849.149-3.227 1.664-4.771 4.919-4.919 1.266-.057 1.645-.069 4.849-.069zm0-2.163c-3.259 0-3.667.014-4.947.072-4.358.2-6.78 2.618-6.98 6.98-.059 1.281-.073 1.689-.073 4.948 0 3.259.014 3.668.072 4.948.2 4.358 2.618 6.78 6.98 6.98 1.281.058 1.689.072 4.948.072 3.259 0 3.668-.014 4.948-.072 4.354-.2 6.782-2.618 6.979-6.98.059-1.28.073-1.689.073-4.948 0-3.259-.014-3.667-.072-4.947-.196-4.354-2.617-6.78-6.979-6.98-1.281-.059-1.69-.073-4.949-.073zm0 5.838c-3.403 0-6.162 2.759-6.162 6.162s2.759 6.163 6.162 6.163 6.162-2.759 6.162-6.163c0-3.403-2.759-6.162-6.162-6.162zm0 10.162c-2.209 0-4-1.79-4-4 0-2.209 1.791-4 4-4s4 1.791 4 4c0 2.21-1.791 4-4 4zm6.406-11.845c-.796 0-1.441.645-1.441 1.44s.645 1.44 1.441 1.44c.795 0 1.439-.645 1.439-1.44s-.644-1.44-1.439-1.44z"/></svg>
            </a>
            <a href="#" class="hover:text-[#1E2235] transition-colors" title="TikTok">
                <svg class="w-4 h-4 fill-current" viewBox="0 0 24 24"><path d="M19.589 6.686a4.793 4.793 0 0 1-3.77-4.245V2h-3.445v13.672a2.896 2.896 0 0 1-5.201 1.743l-.002-.001.002.001a2.895 2.895 0 0 1 3.183-4.51v-3.5a6.329 6.329 0 0 0-5.394 10.692 6.33 6.33 0 0 0 10.857-4.424V8.617a8.171 8.171 0 0 0 3.77 1.15V6.326a4.809 4.809 0 0 1-.001.36z"/></svg>
            </a>
            <a href="mailto:hello@morla-cafe.com" class="hover:text-[#1E2235] transition-colors" title="Email">
                <svg class="w-5 h-5 fill-none stroke-current stroke-2" viewBox="0 0 24 24"><path d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"/></svg>
            </a>
        </div>

        <p class="font-serif text-[10px] tracking-[0.25em] uppercase text-[#1E2235]/40 dark:text-slate-500">© 2024 MORLA CAFÉ. ALL RIGHTS RESERVED.</p>
    </div>
</footer>
"@
    $content = $content -replace $footerSearch, $footerClean

    # Write back using UTF8 without BOM
    [System.IO.File]::WriteAllText($file.FullName, $content, (New-Object System.Text.UTF8Encoding($false)))
    Write-Host "Optimized $($file.Name) for mobile."
}
