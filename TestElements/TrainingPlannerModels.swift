import Foundation
import SwiftUI

class TrainingPlannerData: ObservableObject {
    
    @Published var entries: [TrainingPlannerEntry] = [singleAnswerQuestionExample, singleAnswerQuestion2Example, multiAnswerQuestion2Example, dateQuestion1Example, distanceQUestion1Example, countQuestionExample, durationQuestionExample]

    
    
    static var singleAnswerQuestionExample = TrainingQuestionWithAnswers(id: "SQ1", type: .singleAnswer, coachText: "Hi! I am Suunto Coach, Your personal AI Assistant. I will help you to develop a personalized training program for you.", summaryDescription: "Main Effort Day",
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
    static var singleAnswerQuestion2Example = TrainingQuestionWithAnswers(id: "SQ2", type: .singleAnswer, coachText: "Hi! I am Suunto Coach, Your personal AI Assistant. I will help you to develop a personalized training program for you.", summaryDescription: "Program Info",
                                                             question: "What is that you want to achieve?",
                                                             subtitle: "You can choose one (1)",
                                                             answers: [
                                                                PlannerAnswer(id: "A12", answer: "I want to keep fit", isSelected: false),
                                                                PlannerAnswer(id: "A13", answer: "Build up my cardio training", isSelected: false),
                                                                PlannerAnswer(id: "A14", answer: "Enhance endurance", isSelected: false),
                                                                PlannerAnswer(id: "A15", answer: "Build more strength", isSelected: false)
                                                             ])
    
    static var multiAnswerQuestion2Example = TrainingQuestionWithAnswers(id: "MQ1", type: .multiAnswer, coachText: "Hi! I am Suunto Coach, Your personal AI Assistant. I will help you to develop a personalized training program for you.", summaryDescription: "Workout days",
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
    
    static var dateQuestion1Example = PlannerDateQuestion(id: "DQ1", summaryDescription: "Day of the race", question: "Which is the date of the race?", range: Date()...Date().addingTimeInterval(24*3600*100), selectedValue: Date())

    static var distanceQUestion1Example = PlannerDistanceQuestion(id: "DQ2", summaryDescription: "Distance of the run", question: "What is the distance of the race?", subtitle: "Pick a value in km", range: 0...100, selectedValue: 0)
    
    static var countQuestionExample = PlannerCountQuestion(id: "CQ1", summaryDescription: "Event duration in days", question: "How many days the event lasts?", maxCount: 1000, selectedCount: 0)
    
    static var durationQuestionExample = PlannerDurationQuestion(id: "Dur1", summaryDescription: "Duration of your training", question: "How long do you want to train", maxHours: 24, selectedMinutes: 0, selectedHours: 0)
}

protocol TrainingPlannerEntry {
    var id: String { get }
    var summaryDescription: String { get }
    var coachText: String? { get }
    var question: String { get }
    var subtitle: String? { get }
}

struct PlannerAnswer: Hashable{
    let id: String
    var answer: String
    var isSelected : Bool
}


enum TrainingQuestionType {
    case multiAnswer
    case singleAnswer
}

class TrainingQuestionWithAnswers: TrainingPlannerEntry, Identifiable, ObservableObject  {
    @Published var id: String
    @Published var summaryDescription: String
    @Published var type: TrainingQuestionType
    @Published var coachText: String?
    @Published var question: String
    @Published var subtitle: String?
    @Published var answers: [PlannerAnswer]
    
    var idsSelected: [String] {
        answers.filter({$0.isSelected}).map{ $0.id}
    }
    
    init(id: String, type: TrainingQuestionType, coachText: String? = nil, summaryDescription: String, question: String, subtitle: String? = nil, answers: [PlannerAnswer]) {
        self.id = id
        self.type = type
        self.coachText = coachText
        self.summaryDescription = summaryDescription
        self.question = question
        self.subtitle = subtitle
        self.answers = answers
    }
}

class PlannerDateQuestion: TrainingPlannerEntry, Identifiable, ObservableObject {
    @Published var id: String
    @Published var coachText: String?
    @Published var summaryDescription: String
    @Published var question: String
    @Published var subtitle: String?
    @Published var range: ClosedRange<Date>
    @Published var selectedValue: Date
    
    init(id: String, coachText: String? = nil, summaryDescription: String, question: String, subtitle: String? = nil, range: ClosedRange<Date>, selectedValue: Date) {
        self.id = id
        self.coachText = coachText
        self.summaryDescription = summaryDescription
        self.question = question
        self.subtitle = subtitle
        self.range = range
        self.selectedValue = selectedValue
    }
}

class PlannerDurationQuestion: TrainingPlannerEntry, Identifiable, ObservableObject {
    @Published var id: String
    @Published var coachText: String?
    @Published var summaryDescription: String
    @Published var question: String
    @Published var subtitle: String?
    @Published var maxHours: Int
    @Published var selectedMinutes: Int
    @Published var selectedHours: Int
    
    init(id: String, coachText: String? = nil, summaryDescription: String, question: String, subtitle: String? = nil, maxHours: Int, selectedMinutes: Int, selectedHours: Int) {
        self.id = id
        self.coachText = coachText
        self.summaryDescription = summaryDescription
        self.question = question
        self.subtitle = subtitle
        self.maxHours = maxHours
        self.selectedMinutes = selectedMinutes
        self.selectedHours = selectedHours
        
    }
}

class PlannerDistanceQuestion: TrainingPlannerEntry, Identifiable, ObservableObject {
    @Published var id: String
    @Published var coachText: String?
    @Published var summaryDescription: String
    @Published var question: String
    @Published var subtitle: String?
    @Published var range: ClosedRange<Double>§§
    @Published var selectedValue: Int
    
    init(id: String, coachText: String? = nil, summaryDescription: String, question: String, subtitle: String? = nil, range: ClosedRange<Double>, selectedValue: Int) {
        self.id = id
        self.coachText = coachText
        self.summaryDescription = summaryDescription
        self.question = question
        self.subtitle = subtitle
        self.range = range
        self.selectedValue = selectedValue
    }
}

class PlannerCountQuestion: TrainingPlannerEntry, Identifiable, ObservableObject {
    @Published var id: String
    @Published var coachText: String?
    @Published var summaryDescription: String
    @Published var question: String
    @Published var subtitle: String?
    @Published var maxCount: Int
    @Published var selectedCount: Int
    
    init(id: String, coachText: String? = nil, summaryDescription: String, question: String, subtitle: String? = nil, maxCount: Int, selectedCount: Int) {
        self.id = id
        self.coachText = coachText
        self.summaryDescription = summaryDescription
        self.question = question
        self.subtitle = subtitle
        self.maxCount = maxCount
        self.selectedCount = selectedCount
        
    }
}
