#!/usr/bin/env python3
"""
Generate app icon for GRE Vocabulary app
Creates a 1024x1024 icon with a book and letter 'W' design
"""

try:
    from PIL import Image, ImageDraw, ImageFont
    import os
except ImportError:
    print("Installing required packages...")
    import subprocess
    subprocess.check_call(["pip3", "install", "Pillow"])
    from PIL import Image, ImageDraw, ImageFont
    import os

def create_app_icon():
    # Create 1024x1024 image
    size = 1024
    icon = Image.new('RGB', (size, size), color='#4A90E2')  # Blue background
    draw = ImageDraw.Draw(icon)
    
    # Draw rounded rectangle background
    margin = 80
    corner_radius = 120
    draw.rounded_rectangle(
        [(margin, margin), (size - margin, size - margin)],
        radius=corner_radius,
        fill='#FFFFFF'
    )
    
    # Draw book shape
    book_x = size // 2 - 200
    book_y = size // 2 - 100
    book_width = 400
    book_height = 300
    
    # Book cover (left page)
    draw.rounded_rectangle(
        [(book_x, book_y), (book_x + book_width // 2 - 10, book_y + book_height)],
        radius=20,
        fill='#2C5F8D'
    )
    
    # Book pages (right page)
    draw.rounded_rectangle(
        [(book_x + book_width // 2 + 10, book_y), (book_x + book_width, book_y + book_height)],
        radius=20,
        fill='#F5F5F5'
    )
    
    # Book binding
    draw.rectangle(
        [(book_x + book_width // 2 - 10, book_y), (book_x + book_width // 2 + 10, book_y + book_height)],
        fill='#1A3D5C'
    )
    
    # Draw lines on pages (text lines)
    for i in range(3):
        line_y = book_y + 60 + i * 50
        draw.line(
            [(book_x + book_width // 2 + 30, line_y), (book_x + book_width - 30, line_y)],
            fill='#CCCCCC',
            width=3
        )
    
    # Draw letter 'W' on the book
    try:
        # Try to use a system font
        font_size = 200
        try:
            font = ImageFont.truetype("/System/Library/Fonts/Helvetica.ttc", font_size)
        except:
            try:
                font = ImageFont.truetype("/System/Library/Fonts/Arial.ttf", font_size)
            except:
                font = ImageFont.load_default()
    except:
        font = ImageFont.load_default()
    
    # Draw 'W' text
    text = "W"
    # Get text bounding box
    bbox = draw.textbbox((0, 0), text, font=font)
    text_width = bbox[2] - bbox[0]
    text_height = bbox[3] - bbox[1]
    
    # Position text in center of book
    text_x = book_x + book_width // 2 - text_width // 2
    text_y = book_y + book_height // 2 - text_height // 2 - 20
    
    draw.text(
        (text_x, text_y),
        text,
        fill='#4A90E2',
        font=font
    )
    
    # Save icon
    icon_path = "/Users/haominwu/Documents/Words/Words/Words/Assets.xcassets/AppIcon.appiconset/AppIcon.png"
    icon.save(icon_path, 'PNG')
    print(f"✓ Icon generated: {icon_path}")
    
    # Also create dark mode version (darker background, lighter book)
    icon_dark = Image.new('RGB', (size, size), color='#1A1A1A')  # Dark background
    draw_dark = ImageDraw.Draw(icon_dark)
    
    # Draw rounded rectangle background
    draw_dark.rounded_rectangle(
        [(margin, margin), (size - margin, size - margin)],
        radius=corner_radius,
        fill='#2C2C2C'
    )
    
    # Book cover (left page) - lighter for dark mode
    draw_dark.rounded_rectangle(
        [(book_x, book_y), (book_x + book_width // 2 - 10, book_y + book_height)],
        radius=20,
        fill='#4A90E2'
    )
    
    # Book pages (right page)
    draw_dark.rounded_rectangle(
        [(book_x + book_width // 2 + 10, book_y), (book_x + book_width, book_y + book_height)],
        radius=20,
        fill='#3A3A3A'
    )
    
    # Book binding
    draw_dark.rectangle(
        [(book_x + book_width // 2 - 10, book_y), (book_x + book_width // 2 + 10, book_y + book_height)],
        fill='#2C5F8D'
    )
    
    # Draw lines on pages
    for i in range(3):
        line_y = book_y + 60 + i * 50
        draw_dark.line(
            [(book_x + book_width // 2 + 30, line_y), (book_x + book_width - 30, line_y)],
            fill='#666666',
            width=3
        )
    
    # Draw 'W' text (lighter for dark mode)
    draw_dark.text(
        (text_x, text_y),
        text,
        fill='#6BB6FF',
        font=font
    )
    
    icon_dark_path = "/Users/haominwu/Documents/Words/Words/Words/Assets.xcassets/AppIcon.appiconset/AppIcon-Dark.png"
    icon_dark.save(icon_dark_path, 'PNG')
    print(f"✓ Dark mode icon generated: {icon_dark_path}")
    
    return icon_path, icon_dark_path

if __name__ == "__main__":
    print("Generating app icon...")
    create_app_icon()
    print("Done!")

