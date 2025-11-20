//
//  ContentView.swift
//  Words
//
//  Created by Haomin Wu on 2025/11/20.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var vocabularyManager = VocabularyManager()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(UIColor.systemGroupedBackground)
                    .edgesIgnoringSafeArea(.all)
                
                DeckView(vocabularyManager: vocabularyManager)
            }
            .navigationTitle("GRE Vocabulary")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: VocabularyListView(vocabularyManager: vocabularyManager)) {
                        Image(systemName: "book")
                            .imageScale(.large)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
