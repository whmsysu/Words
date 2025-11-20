import SwiftUI

struct VocabularyListView: View {
    @ObservedObject var vocabularyManager: VocabularyManager
    
    var body: some View {
        List {
            Section(header: Text("New")) {
                ForEach(vocabularyManager.words.filter { $0.status == .new }) { word in
                    WordRow(word: word)
                }
            }
            
            Section(header: Text("Learning")) {
                ForEach(vocabularyManager.words.filter { $0.status == .learning }) { word in
                    WordRow(word: word)
                }
            }
            
            Section(header: Text("Mastered")) {
                ForEach(vocabularyManager.words.filter { $0.status == .mastered }) { word in
                    WordRow(word: word)
                }
            }
        }
        .navigationTitle("Vocabulary Book")
    }
}

struct WordRow: View {
    let word: Word
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(word.english)
                .font(.headline)
            Text(word.chinese)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
    }
}

struct VocabularyListView_Previews: PreviewProvider {
    static var previews: some View {
        VocabularyListView(vocabularyManager: VocabularyManager())
    }
}
