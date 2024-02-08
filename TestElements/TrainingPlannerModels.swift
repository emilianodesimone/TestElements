import Foundation
import SwiftUI

class TrainingPlannerData: ObservableObject {
    
    @Published var questions: [TrainingPlannerQuestion] = [multiAnswerQuestionExample, singleAnswerQuestionExample, singleAnswerQuestion2Example, multiAnswerQuestion2Example]
    
    static var multiAnswerQuestionExample = TrainingPlannerQuestion(id: "MQ1", type: .multiAnswer, coachText: "Hi! I am Suunto Coach, Your personal AI Assistant. I will help you to develop a personalized training program for you.",
                                                             question: "What is that you want to achieve?",
                                                             subtitle: "You can choose multiple",
                                                             answers: [
                                                                PlannerAnswer(id: "A1", answer: "I want to keep fit", isSelected: false),
                                                                PlannerAnswer(id: "A2", answer: "Build up my cardio training", isSelected: false),
                                                                PlannerAnswer(id: "A3", answer: "Enhance endurance", isSelected: false),
                                                                PlannerAnswer(id: "A4", answer: "Build more strength", isSelected: false)
                                                             ])
    
    static var singleAnswerQuestionExample = TrainingPlannerQuestion(id: "SQ1", type: .singleAnswer, coachText: "Hi! I am Suunto Coach, Your personal AI Assistant. I will help you to develop a personalized training program for you.",
                                                               question: "Which is the day of your biggest effort?",
                                                               subtitle: "You can choose one (1)",
                                                               answers: [ PlannerAnswer(id: "A5", answer: "Monday", isSelected: false),
                                                                          PlannerAnswer(id: "A6", answer: "Tuesday", isSelected: false),
                                                                          PlannerAnswer(id: "A7", answer: "Wednesday", isSelected: false),
                                                                          PlannerAnswer(id: "A8", answer: "Thursday", isSelected: false),
                                                                          PlannerAnswer(id: "A9", answer: "Friday", isSelected: false),
                                                                          PlannerAnswer(id: "A10", answer: "Saturday", isSelected: false),
                                                                          PlannerAnswer(id: "A11", answer: "Sunday", isSelected: false),
                                                                        ])
    static var singleAnswerQuestion2Example = TrainingPlannerQuestion(id: "SQ2", type: .singleAnswer, coachText: "Hi! I am Suunto Coach, Your personal AI Assistant. I will help you to develop a personalized training program for you.",
                                                             question: "What is that you want to achieve?",
                                                             subtitle: "You can choose one (1)",
                                                             answers: [
                                                                PlannerAnswer(id: "A12", answer: "I want to keep fit", isSelected: false),
                                                                PlannerAnswer(id: "A13", answer: "Build up my cardio training", isSelected: false),
                                                                PlannerAnswer(id: "A14", answer: "Enhance endurance", isSelected: false),
                                                                PlannerAnswer(id: "A15", answer: "Enhance endurance", isSelected: false)
                                                             ])
    
    static var multiAnswerQuestion2Example = TrainingPlannerQuestion(id: "MQ2", type: .multiAnswer, coachText: "Hi! I am Suunto Coach, Your personal AI Assistant. I will help you to develop a personalized training program for you.",
                                                                     question: "Which days you want to train in a week?",
                                                                     subtitle: "You can choose multiple",
                                                                     answers: [ PlannerAnswer(id: "A5", answer: "Monday", isSelected: false),
                                                                                PlannerAnswer(id: "A6", answer: "Tuesday", isSelected: false),
                                                                                PlannerAnswer(id: "A7", answer: "Wednesday", isSelected: false),
                                                                                PlannerAnswer(id: "A8", answer: "Thursday", isSelected: false),
                                                                                PlannerAnswer(id: "A9", answer: "Friday", isSelected: false),
                                                                                PlannerAnswer(id: "A10", answer: "Saturday", isSelected: false),
                                                                                PlannerAnswer(id: "A11", answer: "Sunday", isSelected: false),
                                                                              ])
    
//    static func trainingPlannerQuestionType(from questionType: TrainingPlannerQuestionType) -> any TrainingPlannerQuestion.Type {
//        switch questionType {
//        case .multiAnswer:
//            return MultiAnswerQuestion.self
//        case .singleAnswer:
//            return SingleAnswerQuestion.self
//        case .spinner:
//            return SpinnerQuestion.self
//        }
//    }
}

struct PlannerAnswer: Hashable {
    let id: String
    var answer: String
    var isSelected : Bool
}


enum PlannerQuestionType {
    case multiAnswer
    case singleAnswer
}

struct TrainingPlannerQuestion: Identifiable {
    var id: String
    var type: PlannerQuestionType
    var coachText: String?
    var question: String
    var subtitle: String?
    var answers: [PlannerAnswer]
    var idsSelected: [String] {
        answers.filter({$0.isSelected}).map{ $0.id}
    }
}
