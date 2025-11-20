import json

# Read the generated JSON
with open("/Users/haominwu/Documents/Words/Words/Words/GREWords.json", "r") as f:
    json_content = f.read()

# Escape backslashes and double quotes if necessary (though json.dump usually handles this, we are putting it inside a swift multiline string)
# Swift multiline string """ handles most things, but we need to be careful if the json contains """ (unlikely) or backslashes.
# Actually, since it's a raw string in Swift, we just need to make sure we don't break the """ delimiter.

swift_content = f"""import Foundation

struct GREWordsData {{
    static let initialJSON = \"\"\"
{json_content}
\"\"\"
}}
"""

with open("/Users/haominwu/Documents/Words/Words/Words/GREWordsData.swift", "w") as f:
    f.write(swift_content)

print("Updated GREWordsData.swift")
