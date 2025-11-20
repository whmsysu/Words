# Words - GRE Vocabulary Learning App

[English](#english) | [中文](#中文)

---

## English

### 📖 Overview

**Words** is a modern iOS flashcard application designed specifically for GRE vocabulary learning. Built with SwiftUI, it provides an intuitive and engaging way to master GRE words through interactive flashcards and comprehensive vocabulary management.

### ✨ Features

- **📚 Comprehensive GRE Vocabulary Database**: Pre-loaded with thousands of GRE words, including definitions, example sentences, and synonyms
- **🎴 Interactive Flashcards**: Flip cards with smooth animations to reveal word definitions and details
- **🗂️ Vocabulary Book**: Browse and search through the complete word list with detailed information
- **🎯 Deck-based Learning**: Organize words into study decks for focused learning sessions
- **💾 Persistent Progress**: Your learning progress is automatically saved
- **🎨 Clean UI**: Modern, intuitive interface built with SwiftUI

### 🛠️ Tech Stack

- **Language**: Swift 5.0
- **Framework**: SwiftUI
- **Platform**: iOS 26.1+
- **IDE**: Xcode 26.1.1
- **Architecture**: MVVM pattern with SwiftUI

### 📋 Requirements

- iOS 26.1 or later
- Xcode 26.1.1 or later
- macOS for development

### 🚀 Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/whmsysu/Words.git
   cd Words
   ```

2. Open the project in Xcode:
   ```bash
   open Words.xcodeproj
   ```

3. Build and run the project:
   - Select your target device or simulator
   - Press `Cmd + R` to build and run

### 📱 Usage

1. **Browse Vocabulary**: Tap the vocabulary book icon to explore all available GRE words
2. **Study with Flashcards**: Select a deck and swipe through flashcards
3. **Flip Cards**: Tap on any card to reveal its definition and details
4. **Track Progress**: Your studied words are automatically tracked

### 📂 Project Structure

```
Words/
├── ContentView.swift          # Main app interface
├── DeckView.swift             # Deck browsing and selection
├── FlashcardView.swift        # Interactive flashcard component
├── VocabularyListView.swift   # Vocabulary browsing interface
├── VocabularyManager.swift    # Data management and persistence
├── Word.swift                 # Word model definition
├── GREWords.json              # GRE vocabulary database
├── GREWordsData.swift         # Generated word data loader
└── Assets.xcassets/           # App icons and images
```

### 🔧 Development Tools

- `convert_gre3000.py` - Convert GRE word lists to JSON format
- `update_gre_words_data.py` - Update vocabulary data from external sources
- `generate_app_icon.py` - Generate app icons

### 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

### 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

### 👤 Author

**whmsysu**
- GitHub: [@whmsysu](https://github.com/whmsysu)

---

## 中文

### 📖 概述

**Words** 是一款专为GRE词汇学习设计的现代iOS闪卡应用。使用SwiftUI构建，通过交互式闪卡和全面的词汇管理，提供直观且引人入胜的GRE单词学习方式。

### ✨ 功能特点

- **📚 全面的GRE词汇库**: 预装数千个GRE单词，包含定义、例句和同义词
- **🎴 交互式闪卡**: 流畅的翻转动画展示单词定义和详细信息
- **🗂️ 词汇手册**: 浏览和搜索完整的词汇列表及详细信息
- **🎯 分组学习**: 将单词组织成学习组，进行专注学习
- **💾 持久化进度**: 学习进度自动保存
- **🎨 简洁UI**: 现代化、直观的SwiftUI界面

### 🛠️ 技术栈

- **语言**: Swift 5.0
- **框架**: SwiftUI
- **平台**: iOS 26.1+
- **开发工具**: Xcode 26.1.1
- **架构**: MVVM模式 + SwiftUI

### 📋 系统要求

- iOS 26.1 或更高版本
- Xcode 26.1.1 或更高版本
- macOS（用于开发）

### 🚀 安装步骤

1. 克隆仓库：
   ```bash
   git clone https://github.com/whmsysu/Words.git
   cd Words
   ```

2. 在Xcode中打开项目：
   ```bash
   open Words.xcodeproj
   ```

3. 构建并运行项目：
   - 选择目标设备或模拟器
   - 按 `Cmd + R` 构建并运行

### 📱 使用方法

1. **浏览词汇**: 点击词汇手册图标探索所有GRE单词
2. **使用闪卡学习**: 选择一个学习组并滑动浏览闪卡
3. **翻转卡片**: 点击任意卡片查看定义和详细信息
4. **跟踪进度**: 已学习的单词会自动跟踪

### 📂 项目结构

```
Words/
├── ContentView.swift          # 主应用界面
├── DeckView.swift             # 学习组浏览和选择
├── FlashcardView.swift        # 交互式闪卡组件
├── VocabularyListView.swift   # 词汇浏览界面
├── VocabularyManager.swift    # 数据管理和持久化
├── Word.swift                 # 单词模型定义
├── GREWords.json              # GRE词汇数据库
├── GREWordsData.swift         # 自动生成的词汇数据加载器
└── Assets.xcassets/           # 应用图标和图像
```

### 🔧 开发工具

- `convert_gre3000.py` - 将GRE词汇列表转换为JSON格式
- `update_gre_words_data.py` - 从外部数据源更新词汇数据
- `generate_app_icon.py` - 生成应用图标

### 🤝 贡献

欢迎贡献！请随时提交Pull Request。

### 📄 许可证

本项目采用MIT许可证 - 详见 [LICENSE](LICENSE) 文件

### 👤 作者

**whmsysu**
- GitHub: [@whmsysu](https://github.com/whmsysu)

---

<p align="center">Made with ❤️ for GRE learners</p>
