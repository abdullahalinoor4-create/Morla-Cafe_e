$file = "d:\Morla\frontend\index.html"
$content = [System.IO.File]::ReadAllText($file)

# Function to replace literal strings safely
function Replace-Literal($orig, $new) {
    param($orig, $new)
    $script:content = $script:content.Replace($orig, $new)
}

# 1. Centering Hero
Replace-Literal '<header class="relative pt-32 pb-24 md:pt-48 md:pb-40 px-6 max-w-7xl mx-auto">' '<header class="relative pt-32 pb-24 md:pt-48 md:pb-40 px-6 max-w-7xl mx-auto flex flex-col items-center text-center md:items-start md:text-left">'
Replace-Literal '<div class="space-y-8">' '<div class="space-y-8 flex flex-col items-center md:items-start">'
Replace-Literal '<div class="inline-block px-3 py-1 border border-outline-variant rounded-full">' '<div class="inline-block px-3 py-1 border border-outline-variant rounded-full mx-auto md:mx-0">'
Replace-Literal '<p class="font-body text-lg text-on-surface-variant max-w-md leading-relaxed">' '<p class="font-body text-lg text-on-surface-variant max-w-md leading-relaxed mx-auto md:mx-0">'
Replace-Literal '<div class="flex flex-wrap gap-4 pt-4">' '<div class="flex flex-wrap items-center justify-center md:justify-start gap-4 pt-4">'

# 2. Centering About (First instance)
Replace-Literal '<div class="max-w-7xl mx-auto px-6 md:px-8 grid md:grid-cols-2 gap-16 items-center">' '<div class="max-w-7xl mx-auto px-6 md:px-8 grid md:grid-cols-2 gap-16 items-center flex flex-col items-center">'

# 3. Fix Characters
# Note: I'll use the exact sequence seen in Step 615 for the Est 2024 badge
$bad1 = 'ÃƒÆ’Ã†â€™Ãƒâ€ Ã¢â‚¬â„¢ÃƒÆ’Ã¢â‚¬Å¡Ãƒâ€šÃ‚Â¢ÃƒÆ’Ã†â€™ÃƒÂ¢Ã¢â€šÂ¬Ã‚Â¦ÃƒÆ’Ã‚Â¢ÃƒÂ¢Ã¢â‚¬Å¡Ã‚Â¬Ãƒâ€¦Ã¢â‚¬Å“ÃƒÆ’Ã†â€™ÃƒÂ¢Ã¢â€šÂ¬Ã…Â¡ÃƒÆ’Ã¢â‚¬Å¡Ãƒâ€šÃ‚Â¨ Established 2024'
Replace-Literal $bad1 '✨ Established 2024'

# Save as UTF-8 without BOM
$utf8NoBOM = New-Object System.Text.UTF8Encoding $false
[System.IO.File]::WriteAllText($file, $content, $utf8NoBOM)
Write-Host "Centering and character fix applied successfully."
