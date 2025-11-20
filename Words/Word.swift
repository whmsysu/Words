import Foundation

struct Word: Identifiable, Codable, Equatable {
    let id: UUID
    let english: String
    let chinese: String
    var status: LearningStatus
    var nextReviewDate: Date?
    var interval: Int // Days until next review
    
    enum LearningStatus: String, Codable {
        case new
        case learning
        case mastered
    }
    
    init(id: UUID = UUID(), english: String, chinese: String, status: LearningStatus = .new, nextReviewDate: Date? = nil, interval: Int = 0) {
        self.id = id
        self.english = english
        self.chinese = chinese
        self.status = status
        self.nextReviewDate = nextReviewDate
        self.interval = interval
    }
}
