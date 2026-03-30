$dir = "d:\Morla\frontend"
$files = Get-ChildItem "$dir\*.html"

foreach ($file in $files) {
    if ($file.Name -eq 'contact.html') { continue }
    $content = Get-Content $file.FullName -Raw
    
    # Global replacement for "Café" variants (case insensitive)
    # Using a very broad regex to catch the various corruption patterns
    $content = $content -replace 'caf[ãÃ][^ "<\n]*', 'Café'
    $content = $content -replace 'CAF[ãÃ][^ "<\n]*', 'CAFÉ'
    
    # Specific fix for the logo wordmark smaller text
    $content = $content -replace 'CAFÉ</span>', 'CAFÉ</span>'
    
    # Final check for any rogue "Ãƒ" strings
    $content = $content -replace 'ÃƒÆ’Ã†â€™Ãƒâ€ Ã¢â‚¬â„¢ÃƒÆ’Ã‚Â¢ÃƒÂ¢Ã¢â‚¬Å¡Ã‚Â¬Ãƒâ€šÃ‚Â°', 'CAFÉ'

    # Write back using UTF8 without BOM
    [System.IO.File]::WriteAllText($file.FullName, $content, (New-Object System.Text.UTF8Encoding($false)))
}
