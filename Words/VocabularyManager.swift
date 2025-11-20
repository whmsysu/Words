import SwiftUI
import Combine

class VocabularyManager: ObservableObject {
    @Published var words: [Word] = []
    @Published var currentSessionWords: [Word] = []
    
    private let fileName = "vocabulary.json"
    
    // Ebbinghaus intervals in days
    private let intervals = [1, 2, 4, 7, 15, 30]
    
    // Extended intervals for words that have mastered the base intervals
    // After 30 days, continue with longer intervals
    private let extendedIntervals = [60, 90, 180, 365]
    
    init() {
        loadWords()
        prepareSession()
    }
    
    func loadWords() {
        let fileURL = getDocumentsDirectory().appendingPathComponent(fileName)
        
        do {
            let data = try Data(contentsOf: fileURL)
            words = try JSONDecoder().decode([Word].self, from: data)
        } catch {
            print("Failed to load words: \(error.localizedDescription)")
        }
        
        // If load fails or results in empty list (e.g. first run or corrupted file), load initial data
        if words.isEmpty {
            loadInitialData()
        }
    }
    
    func saveWords() {
        let fileURL = getDocumentsDirectory().appendingPathComponent(fileName)
        
        do {
            let data = try JSONEncoder().encode(words)
            try data.write(to: fileURL)
        } catch {
            print("Failed to save words: \(error.localizedDescription)")
        }
    }
    
    func loadInitialData() {
        // Use embedded data instead of loading from bundle
        let jsonString = GREWordsData.initialJSON
        guard let data = jsonString.data(using: .utf8) else {
            print("Failed to convert embedded JSON string to data")
            return
        }
        
        do {
            let initialWords = try JSONDecoder().decode([Word].self, from: data)
            self.words = initialWords
            saveWords()
        } catch {
            print("Failed to load initial data: \(error.localizedDescription)")
        }
    }
    
    func prepareSession() {
        let today = Date()
        
        // 1. Find words due for review
        let dueWords = words.filter { word in
            guard let nextDate = word.nextReviewDate else { return false }
            return nextDate <= today && word.status == .learning
        }
        
        // 2. Find new words (limit to 50 per session)
        let newWords = words.filter { $0.status == .new }.prefix(50)
        
        currentSessionWords = dueWords + Array(newWords)
    }
    
    // Add more words to session when running low
    func addMoreWordsIfNeeded() {
        // If we have less than 5 words left, add more
        if currentSessionWords.count < 5 {
            let today = Date()
            
            // Get words already in session
            let sessionWordIds = Set(currentSessionWords.map { $0.id })
            
            // Find more words due for review
            let dueWords = words.filter { word in
                guard let nextDate = word.nextReviewDate else { return false }
                return nextDate <= today && word.status == .learning && !sessionWordIds.contains(word.id)
            }
            
            // Find more new words
            let newWords = words.filter { word in
                word.status == .new && !sessionWordIds.contains(word.id)
            }.prefix(20)
            
            // Add to current session
            currentSessionWords.append(contentsOf: dueWords + Array(newWords))
        }
    }
    
    func markAsRemembered(wordId: UUID) {
        guard let index = words.firstIndex(where: { $0.id == wordId }) else { return }
        var word = words[index]
        
        // Handle new words (interval = 0) or words with interval not in array
        if word.interval == 0 {
            // First time remembering a new word, set to first interval
            word.interval = intervals[0]
            word.status = .learning
            word.nextReviewDate = Calendar.current.date(byAdding: .day, value: intervals[0], to: Date())
        } else if let currentIntervalIndex = intervals.firstIndex(of: word.interval) {
            // Word's interval is in the base array, move to next interval
            if currentIntervalIndex < intervals.count - 1 {
                let newInterval = intervals[currentIntervalIndex + 1]
                word.interval = newInterval
                word.status = .learning
                word.nextReviewDate = Calendar.current.date(byAdding: .day, value: newInterval, to: Date())
            } else {
                // Reached max base interval (30 days), move to extended intervals
                if let firstExtended = extendedIntervals.first {
                    word.interval = firstExtended
                    word.status = .learning
                    word.nextReviewDate = Calendar.current.date(byAdding: .day, value: firstExtended, to: Date())
                } else {
                    // No extended intervals, mark as mastered
                    word.status = .mastered
                    word.nextReviewDate = nil
                }
            }
        } else if let extendedIndex = extendedIntervals.firstIndex(of: word.interval) {
            // Word is in extended intervals, move to next extended interval
            if extendedIndex < extendedIntervals.count - 1 {
                let newInterval = extendedIntervals[extendedIndex + 1]
                word.interval = newInterval
                word.status = .learning
                word.nextReviewDate = Calendar.current.date(byAdding: .day, value: newInterval, to: Date())
            } else {
                // Reached max extended interval (365 days), mark as mastered
                word.status = .mastered
                word.nextReviewDate = nil
            }
        } else {
            // Interval not in any array (shouldn't happen normally, but handle it)
            // Find the next interval that's greater than current
            let allIntervals = intervals + extendedIntervals
            if let nextInterval = allIntervals.first(where: { $0 > word.interval }) {
                word.interval = nextInterval
                word.status = .learning
                word.nextReviewDate = Calendar.current.date(byAdding: .day, value: nextInterval, to: Date())
            } else {
                // Current interval is beyond all intervals, mark as mastered
                word.status = .mastered
                word.nextReviewDate = nil
            }
        }
        
        words[index] = word
        saveWords()
        removeFromSession(wordId: wordId)
    }
    
    func markAsForgotten(wordId: UUID) {
        guard let index = words.firstIndex(where: { $0.id == wordId }) else { return }
        var word = words[index]
        
        // Reset interval
        word.interval = 1
        word.status = .learning
        word.nextReviewDate = Calendar.current.date(byAdding: .day, value: 1, to: Date())
        
        words[index] = word
        saveWords()
        removeFromSession(wordId: wordId)
    }
    
    private func removeFromSession(wordId: UUID) {
        if let index = currentSessionWords.firstIndex(where: { $0.id == wordId }) {
            currentSessionWords.remove(at: index)
        }
        // Add more words if running low
        addMoreWordsIfNeeded()
    }
    
    private func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
