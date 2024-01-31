import Foundation
import SwiftUI

class TrainingPlannerData: ObservableObject {
    
    @Published var multiAnswerQuestion = MultiAnswerQuestion(answers: [
        PlannerAnswer(id: "1", answer: "Are you ok?", subtitle: "Based on your recent mood", isSelected: false),
        PlannerAnswer(id: "2", answer: "Do you like pizza?", subtitle: "Based on your recent meals", isSelected: false),
        PlannerAnswer(id: "3", answer: "Is Lazio your favourite team?", subtitle: "Of course it is", isSelected: false)
    ])
    
    @Published var singleAnswerQuestion = SingleAnswerQuestion(answers: [
        PlannerAnswer(id: "4", answer: "Monday", subtitle: "", isSelected: false),
        PlannerAnswer(id: "5", answer: "Tuesday", subtitle: nil, isSelected: false),
        PlannerAnswer(id: "6", answer: "Wednesday", subtitle: nil, isSelected: false),
        PlannerAnswer(id: "7", answer: "Thursday", subtitle: nil, isSelected: false),
        PlannerAnswer(id: "8", answer: "Friday", subtitle: nil, isSelected: false),
        PlannerAnswer(id: "9", answer: "Saturday", subtitle: nil, isSelected: false),
        PlannerAnswer(id: "10", answer: "Sunday", subtitle: nil, isSelected: false),
    ])
}

struct PlannerAnswer: Hashable {
    let id: String
    var answer: String
    var subtitle: String?
    var isSelected : Bool
}

struct MultiAnswerQuestion {
    var answers: [PlannerAnswer]
    var idsSelected: [String] {
        answers.filter({$0.isSelected}).map{ $0.id}
    }
}

struct SingleAnswerQuestion {
    var answers: [PlannerAnswer]
    var idsSelected: String? {
        answers.first(where: {$0.isSelected})?.id
    }
}
