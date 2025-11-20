import SwiftUI

struct FlashcardView: View {
    let word: Word
    @State private var isFlipped = false
    
    var body: some View {
        // Use a container that ensures background is always covered
        ZStack {
            // Background layer that matches the card color
            RoundedRectangle(cornerRadius: 20)
                .fill(isFlipped ? Color.white : Color.blue)
                .frame(width: 300, height: 400)
                .shadow(radius: 5)
            
            // Card faces
            ZStack {
                // Back (Chinese) - rotated 180 degrees initially
                CardFace(
                    backgroundColor: .white,
                    content: {
                        VStack {
                            Text(word.chinese)
                                .font(.title)
                                .foregroundColor(.black)
                                .padding()
                            Text(word.english)
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                )
                .rotation3DEffect(
                    .degrees(180),
                    axis: (x: 0.0, y: 1.0, z: 0.0)
                )
                .opacity(isFlipped ? 1 : 0)
                
                // Front (English)
                CardFace(
                    backgroundColor: .blue,
                    content: {
                        Text(word.english)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                )
                .opacity(isFlipped ? 0 : 1)
            }
            .frame(width: 300, height: 400)
        }
        .rotation3DEffect(
            .degrees(isFlipped ? 180 : 0),
            axis: (x: 0.0, y: 1.0, z: 0.0),
            perspective: 0.5
        )
        .onTapGesture {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                isFlipped.toggle()
            }
        }
    }
}

struct CardFace<Content: View>: View {
    let backgroundColor: Color
    let content: Content
    
    init(backgroundColor: Color, @ViewBuilder content: () -> Content) {
        self.backgroundColor = backgroundColor
        self.content = content()
    }
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(backgroundColor)
            .overlay(content)
    }
}

struct FlashcardView_Previews: PreviewProvider {
    static var previews: some View {
        FlashcardView(word: Word(english: "Test", chinese: "测试"))
    }
}
