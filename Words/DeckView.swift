import SwiftUI

struct DeckView: View {
    @ObservedObject var vocabularyManager: VocabularyManager
    
    @State private var translation: CGSize = .zero
    
    var body: some View {
        ZStack {
            if vocabularyManager.currentSessionWords.isEmpty {
                VStack {
                    Text("All caught up!")
                    .font(.title)
                    .padding()
                    Text("Come back later for more reviews.")
                    .foregroundColor(.gray)
                }
            } else {
                ForEach(vocabularyManager.currentSessionWords.reversed()) { word in
                    FlashcardView(word: word)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(translation.width < 0 ? Color.green : Color.red)
                                .opacity(word.id == vocabularyManager.currentSessionWords.first?.id ? abs(Double(translation.width / 300)) : 0)
                        )
                        .offset(x: getOffset(for: word))
                        .rotationEffect(.degrees(getRotation(for: word)))
                        .gesture(
                        DragGesture()
                        .onChanged { gesture in
                            // Only allow dragging the top card
                            if word.id == vocabularyManager.currentSessionWords.first?.id {
                                self.translation = gesture.translation
                            }
                        }
                        .onEnded { gesture in
                            if word.id == vocabularyManager.currentSessionWords.first?.id {
                                let width = gesture.translation.width
                                if width > 100 {
                                    // Swipe Right (Forgotten)
                                    // Animate off screen
                                    withAnimation {
                                        self.translation.width = 500
                                    }
                                    // Perform action after animation
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                        vocabularyManager.markAsForgotten(wordId: word.id)
                                        self.translation = .zero
                                    }
                                } else if width < -100 {
                                    // Swipe Left (Remembered)
                                    withAnimation {
                                        self.translation.width = -500
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                        vocabularyManager.markAsRemembered(wordId: word.id)
                                        self.translation = .zero
                                    }
                                } else {
                                    // Reset
                                    withAnimation(.spring()) {
                                        self.translation = .zero
                                    }
                                }
                            }
                        }
                    )
                }
            }
        }
    }
    
    func getOffset(for word: Word) -> CGFloat {
        if word.id == vocabularyManager.currentSessionWords.first?.id {
            return translation.width
        }
        return 0
    }
    
    func getRotation(for word: Word) -> Double {
        if word.id == vocabularyManager.currentSessionWords.first?.id {
            return Double(translation.width / 20)
        }
        return 0
    }
}
