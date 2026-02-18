import base64
import re

svg_path = r'C:\Users\Pearl Organisation\Desktop\desktop\VLM-Academy\assets\images\vlm_logo.svg'
png_path = r'C:\Users\Pearl Organisation\Desktop\desktop\VLM-Academy\assets\images\vlm_logo.png'

with open(svg_path, 'r', encoding='utf-8') as f:
    content = f.read()

# Extract base64 PNG data from xlink:href
match = re.search(r'xlink:href="data:image/png;base64,([^"]+)"', content)
if match:
    b64data = match.group(1)
    png_data = base64.b64decode(b64data)
    with open(png_path, 'wb') as out:
        out.write(png_data)
    print('SUCCESS: vlm_logo.png created, size:', len(png_data), 'bytes')
else:
    print('ERROR: No base64 PNG found in SVG')
