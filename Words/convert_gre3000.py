import json
import uuid

# 读取 gre3000.json
with open("/Users/haominwu/Documents/Words/Words/Words/gre3000.json", "r", encoding="utf-8") as f:
    gre3000_data = json.load(f)

# 转换为 GREWords.json 格式
converted_data = []

for item in gre3000_data:
    word = item.get("Word", "").strip()
    # 优先使用带词性的释义，如果没有则使用普通释义
    chinese = item.get("Paraphrase (w/ POS)", "")
    if not chinese:
        chinese = item.get("Paraphrase", "")
    
    # 如果还是没有，跳过这个词
    if not word or not chinese:
        continue
    
    converted_data.append({
        "id": str(uuid.uuid4()).upper(),
        "english": word,
        "chinese": chinese,
        "status": "new",
        "interval": 0
    })

# 保存到 GREWords.json
with open("/Users/haominwu/Documents/Words/Words/Words/GREWords.json", "w", encoding="utf-8") as f:
    json.dump(converted_data, f, indent=4, ensure_ascii=False)

print(f"转换完成！共转换了 {len(converted_data)} 个单词")
print(f"已保存到 GREWords.json")

