//
//  WordsApp.swift
//  Words
//
//  Created by Haomin Wu on 2025/11/20.
//

import SwiftUI
import CoreData

@main
struct WordsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
