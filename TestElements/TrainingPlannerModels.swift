import Foundation
import SwiftUI

class TrainingPlannerData: ObservableObject {
    
    @Published var questions: [any TrainingPlannerQuestion] = [multiAnswerQuestionExample, singleAnswerQuestionExample, multiAnswerQuestion2Example]
    
    static var multiAnswerQuestionExample = MultiAnswerQuestion(id: "Multi", coachText: "Hi! I am Suunto Coach, Your personal AI Assistant. I will help you to develop a personalized training program for you.",
                                                             question: "What is that you want to achieve?",
                                                             subtitle: "You can choose multiple",
                                                             answers: [
                                                                PlannerAnswer(id: "1", answer: "I want to keep fit", isSelected: false),
                                                                PlannerAnswer(id: "2", answer: "Build up my cardio training", isSelected: false),
                                                                PlannerAnswer(id: "3", answer: "Enhance endurance", isSelected: false),
                                                                PlannerAnswer(id: "4", answer: "Enhance endurance", isSelected: false)
                                                             ])
    
    static var singleAnswerQuestionExample = SingleAnswerQuestion(id: "Single1", coachText: "Hi! I am Suunto Coach, Your personal AI Assistant. I will help you to develop a personalized training program for you.",
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
    static var multiAnswerQuestion2Example = SingleAnswerQuestion(id: "Single2", coachText: "Hi! I am Suunto Coach, Your personal AI Assistant. I will help you to develop a personalized training program for you.",
                                                             question: "What is that you want to achieve?",
                                                             subtitle: "You can choose multiple",
                                                             answers: [
                                                                PlannerAnswer(id: "1", answer: "I want to keep fit", isSelected: false),
                                                                PlannerAnswer(id: "2", answer: "Build up my cardio training", isSelected: false),
                                                                PlannerAnswer(id: "3", answer: "Enhance endurance", isSelected: false),
                                                                PlannerAnswer(id: "4", answer: "Enhance endurance", isSelected: false)
                                                             ])
    
    static func trainingPlannerQuestionType(from questionType: TrainingPlannerQuestionType) -> any TrainingPlannerQuestion.Type {
        switch questionType {
        case .multiAnswer:
            return MultiAnswerQuestion.self
        case .singleAnswer:
            return SingleAnswerQuestion.self
        case .spinner:
            return SpinnerQuestion.self
        }
    }
}

struct PlannerAnswer: Hashable {
    let id: String
    var answer: String
    var isSelected : Bool
}

enum TrainingPlannerQuestionType {
    case singleAnswer
    case multiAnswer
    case spinner
}


protocol TrainingPlannerQuestion: Identifiable {
    static var type: TrainingPlannerQuestionType { get }
    var id: String { get }
}

struct MultiAnswerQuestion: TrainingPlannerQuestion {
    static var type = TrainingPlannerQuestionType.multiAnswer
    var id: String
    var coachText: String?
    var question: String
    var subtitle: String?
    var answers: [PlannerAnswer]
    var idsSelected: [String] {
        answers.filter({$0.isSelected}).map{ $0.id}
    }
}

struct SingleAnswerQuestion: TrainingPlannerQuestion {
    static var type = TrainingPlannerQuestionType.singleAnswer
    var id: String
    var coachText: String?
    var question: String
    var subtitle: String?
    var answers: [PlannerAnswer]
    var idSelected: String? {
        answers.first(where: {$0.isSelected})?.id
    }
}

struct SpinnerQuestion: TrainingPlannerQuestion {
    static var type = TrainingPlannerQuestionType.spinner
    var id: String
}
