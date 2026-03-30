$dir = "d:\Morla\frontend"
$file = "$dir\index.html"
$content = Get-Content $file -Raw

# 1. FIX CHARACTER CORRUPTION Site-Wide in index.html (Broad Fix)
# Removing the insane garbage strings and replacing with clean ones
$content = $content -replace 'ÃƒÆ’Ã†â€™Ãƒâ€ Ã¢â‚¬â„¢ÃƒÆ’Ã¢â‚¬Å¡Ãƒâ€šÃ‚Â¢ÃƒÆ’Ã†â€™ÃƒÂ¢Ã¢â€šÂ¬Ã‚Â¦ÃƒÆ’Ã‚Â¢ÃƒÂ¢Ã¢â‚¬Å¡Ã‚Â¬Ãƒâ€¦Ã¢â‚¬Å“ÃƒÆ’Ã†â€™ÃƒÂ¢Ã¢â€šÂ¬Ã…Â¡ÃƒÆ’Ã¢â‚¬Å¡Ãƒâ€šÃ‚Â¨ Established 2024', '✨ Established 2024'
$content = $content -replace 'ritualÃƒÆ’Ã†â€™Ãƒâ€ Ã¢â‚¬â„¢ÃƒÆ’Ã¢â‚¬Å¡Ãƒâ€šÃ‚Â¢ÃƒÆ’Ã†â€™Ãƒâ€šÃ‚Â¢ÃƒÆ’Ã‚Â¢ÃƒÂ¢Ã¢â‚¬Å¡Ã‚Â¬Ãƒâ€¦Ã‚Â¡ÃƒÆ’Ã¢â‚¬Å¡Ãƒâ€šÃ‚Â¬ÃƒÆ’Ã†â€™Ãƒâ€šÃ‚Â¢ÃƒÆ’Ã‚Â¢ÃƒÂ¢Ã¢â€šÂ¬Ã…Â¡Ãƒâ€šÃ‚Â¬ÃƒÆ’Ã¢â‚¬Å¡Ãƒâ€šÃ‚Â it''s', 'ritual—it''s'
$content = $content -replace '(?i)caf[ãÃ][^ "<\n]*', 'Café'
$content = $content -replace '(?i)CAF[ãÃ][^ "<\n]*', 'CAFÉ'
$content = $content -replace '©', '©'
$content = $content -replace 'Ã‚Â©', '©'

# 2. ENFORCE CENTERING ON MOBILE (index.html)
# Hero Section
$content = $content -replace '(?si)<header class="relative pt-32 pb-24 md:pt-48 md:pb-40[^>]*>', '<header class="relative pt-32 pb-24 md:pt-48 md:pb-40 px-6 max-w-7xl mx-auto flex flex-col items-center text-center md:items-start md:text-left">'
$content = $content -replace '(?si)<div class="space-y-8">', '<div class="space-y-8 flex flex-col items-center md:items-start">'
$content = $content -replace '(?si)<div class="inline-block px-3 py-1 border border-outline-variant rounded-full">', '<div class="inline-block px-3 py-1 border border-outline-variant rounded-full mx-auto md:mx-0">'
$content = $content -replace '(?si)<p class="font-body text-lg text-on-surface-variant max-w-md leading-relaxed">', '<p class="font-body text-lg text-on-surface-variant max-w-md leading-relaxed mx-auto md:mx-0">'
$content = $content -replace '(?si)<div class="flex flex-wrap gap-4 pt-4">', '<div class="flex flex-wrap items-center justify-center md:justify-start gap-4 pt-4">'

# About Section
$content = $content -replace '(?si)<div class="space-y-8">', '<div class="space-y-8 flex flex-col items-center text-center md:items-start md:text-left">'

# Bento Grid Overlays
$content = $content -replace 'left-8 text-white', 'left-0 right-0 w-full text-center px-8 md:text-left md:left-8 md:right-auto md:w-auto text-white'
$content = $content -replace 'left-6 text-primary', 'left-0 right-0 w-full text-center px-4 md:text-left md:left-6 md:right-auto md:w-auto text-primary'

# Gallery Header
$content = $content -replace '(?si)<div class="flex flex-col md:flex-row justify-between items-end mb-16 gap-8">', '<div class="flex flex-col md:flex-row justify-between items-center md:items-end mb-16 gap-8 text-center md:text-left">'
$content = $content -replace '(?si)<div class="font-body text-sm text-on-surface-variant flex items-center gap-2">', '<div class="font-body text-sm text-on-surface-variant flex items-center justify-center md:justify-start gap-2">'

# Save as UTF-8 without BOM
[System.IO.File]::WriteAllText($file, $content, (New-Object System.Text.UTF8Encoding($false)))
Write-Host "Forced centering and clean encoding in index.html"
