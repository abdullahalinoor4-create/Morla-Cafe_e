import os
import re

def fix_file(file_path):
    print(f"Processing {file_path}...")
    with open(file_path, 'rb') as f:
        bytes_content = f.read()
    
    # Try multiple decodings to get the most accurate text
    for enc in ['utf-8', 'windows-1252', 'latin-1']:
        try:
            content = bytes_content.decode(enc)
            break
        except:
            continue
    
    # 1. FIX CHARACTER CORRUPTION
    # Fix 'Established 2024' badge
    content = re.sub(r'[\s\S]*?Established 2024', '✨ Established 2024', content, count=0)
    # Fix 'Café' variations
    content = re.sub(r'caf[ãÃ][^ "<\n]*', 'Café', content, flags=re.IGNORECASE)
    content = re.sub(r'CAF[ãÃ][^ "<\n]*', 'CAFÉ', content, flags=re.IGNORECASE)
    # Fix specific dash corruption in ritual blurb
    content = re.sub(r'ritual[^<]*?pause', 'ritual—it\'s', content)
    
    # 2. ENFORCE CENTERING (index.html specific)
    if "index.html" in file_path:
        # Hero Header
        content = content.replace('<header class="relative pt-32 pb-24 md:pt-48 md:pb-40 px-6 max-w-7xl mx-auto">', 
                                 '<header class="relative pt-32 pb-24 md:pt-48 md:pb-40 px-6 max-w-7xl mx-auto flex flex-col items-center text-center md:items-start md:text-left">')
        # Containers in Hero and About
        content = content.replace('<div class="space-y-8">', '<div class="space-y-8 flex flex-col items-center md:items-start">')
        content = content.replace('<div class="inline-block px-3 py-1 border border-outline-variant rounded-full">', 
                                 '<div class="inline-block px-3 py-1 border border-outline-variant rounded-full mx-auto md:mx-0">')
        content = content.replace('<p class="font-body text-lg text-on-surface-variant max-w-md leading-relaxed">', 
                                 '<p class="font-body text-lg text-on-surface-variant max-w-md leading-relaxed mx-auto md:mx-0">')
        content = content.replace('<div class="flex flex-wrap gap-4 pt-4">', 
                                 '<div class="flex flex-wrap items-center justify-center md:justify-start gap-4 pt-4">')
        
        # Center Featured Overlay
        content = content.replace('left-8 text-white', 'left-0 right-0 w-full text-center px-8 md:text-left md:left-8 md:right-auto md:w-auto text-white')
        content = content.replace('left-6 text-primary', 'left-0 right-0 w-full text-center px-4 md:text-left md:left-6 md:right-auto md:w-auto text-primary')
        
        # Gallery Header
        content = content.replace('<div class="flex flex-col md:flex-row justify-between items-end mb-16 gap-8">', 
                                 '<div class="flex flex-col md:flex-row justify-between items-center md:items-end mb-16 gap-8 text-center md:text-left">')

    # Save cleanly as UTF-8
    with open(file_path, 'w', encoding='utf-8', newline='') as f:
        f.write(content)

dir_path = r'd:\Morla\frontend'
for filename in os.listdir(dir_path):
    if filename.endswith('.html'):
        fix_file(os.path.join(dir_path, filename))

print("Site-wide fix complete.")
