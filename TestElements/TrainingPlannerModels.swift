import Foundation
import SwiftUI

class TrainingPlannerData: ObservableObject {
    
    @Published var multiAnswerQuestion = MultiAnswerQuestion(coachText: "Hi! I am Suunto Coach, Your personal AI Assistant. I will help you to develop a personalized training program for you.",
                                                             question: "What is that you want to achieve?", 
                                                             subtitle: "You can choose multiple",
                                                             answers: [
                                                                PlannerAnswer(id: "1", answer: "I want to keep fit", isSelected: false),
                                                                PlannerAnswer(id: "2", answer: "Build up my cardio training", isSelected: false),
                                                                PlannerAnswer(id: "3", answer: "Enhance endurance", isSelected: false),
                                                                PlannerAnswer(id: "4", answer: "Enhance endurance", isSelected: false)
                                                             ])
    
    @Published var singleAnswerQuestion = SingleAnswerQuestion(coachText: "Hi! I am Suunto Coach, Your personal AI Assistant. I will help you to develop a personalized training program for you.",
                                                               question: "Which is the day of your biggest effort?",
                                                               subtitle: "You can choose one (1)",
                                                               answers: [ PlannerAnswer(id: "5", answer: "Monday", isSelected: false),
                                                                          PlannerAnswer(id: "6", answer: "Tuesday", isSelected: false),
                                                                          PlannerAnswer(id: "7", answer: "Wednesday", isSelected: false),
                                                                          PlannerAnswer(id: "8", answer: "Thursday", isSelected: false),
                                                                          PlannerAnswer(id: "9", answer: "Friday", isSelected: false),
                                                                          PlannerAnswer(id: "10", answer: "Saturday", isSelected: false),
                                                                          PlannerAnswer(id: "11", answer: "Sunday", isSelected: false),
                                                                        ])
}

struct PlannerAnswer: Hashable {
    let id: String
    var answer: String
    var isSelected : Bool
}

struct MultiAnswerQuestion {
    var coachText: String?
    var question: String
    var subtitle: String?
    var answers: [PlannerAnswer]
    var idsSelected: [String] {
        answers.filter({$0.isSelected}).map{ $0.id}
    }
}

struct SingleAnswerQuestion {
    var coachText: String?
    var question: String
    var subtitle: String?
    var answers: [PlannerAnswer]
    var idSelected: String? {
        answers.first(where: {$0.isSelected})?.id
    }
    
    
}
