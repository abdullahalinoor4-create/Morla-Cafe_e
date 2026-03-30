$dir = "d:\Morla\frontend"
$file = "$dir\index.html"
$content = [System.IO.File]::ReadAllText($file)

# 1. Guarantee Centering with Inline Styles for Mobile (only if hidden on larger screens or using media queries)
# Actually, I'll just use even stronger Tailwind class combinations.

# Fix the navigation broken char first
$content = $content.Replace('CAFÃƒâ€°', 'CAFÉ')
$content = $content.Replace('Â© 2024 MORLA CAFÃ‰', '© 2024 MORLA CAFÉ')

# Also fix the weird ritual dash again
$content = $content.Replace('ritualÃƒÆ’Ã†â€™Ãƒâ€ Ã¢â‚¬â„¢ÃƒÆ’Ã¢â‚¬Å¡Ãƒâ€šÃ‚Â¢ÃƒÆ’Ã†â€™Ãƒâ€šÃ‚Â¢ÃƒÆ’Ã‚Â¢ÃƒÂ¢Ã¢â‚¬Å¡Ã‚Â¬Ãƒâ€¦Ã‚Â¡ÃƒÆ’Ã¢â‚¬Å¡Ãƒâ€šÃ‚Â¬ÃƒÆ’Ã†â€™Ãƒâ€šÃ‚Â¢ÃƒÆ’Ã‚Â¢ÃƒÂ¢Ã¢â€šÂ¬Ã…Â¡Ãƒâ€šÃ‚Â¬ÃƒÆ’Ã¢â‚¬Å¡Ãƒâ€šÃ‚Â it''s', 'ritual—it''s')

# Ensure the Est 2024 has the emoji
$content = [regex]::Replace($content, 'Established 2024', '✨ Established 2024')

# Save as UTF-8 WITHOUT BOM
$utf8NoBOM = New-Object System.Text.UTF8Encoding $false
[System.IO.File]::WriteAllText($file, $content, $utf8NoBOM)

Write-Host "Forced UTF-8 No BOM and fixed navigation/footer characters."
