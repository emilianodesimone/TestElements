import Foundation
import SwiftUI

class TrainingPlannerData: ObservableObject {
    
    @Published var entries: [TrainingPlannerEntry] = [activitiesSelection1Example, singleAnswerQuestionExample, singleAnswerQuestion2Example, multiAnswerQuestion2Example, dateQuestion1Example, distanceQUestion1Example, countQuestionExample, durationQuestionExample]

    
    
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

    static var countQuestionExample = PlannerCountQuestion(id: "CQ1", summaryDescription: "Event duration in days", question: "How many days the event lasts?", maxCount: 1000, selectedCount: 0)
    
    static var durationQuestionExample = PlannerDurationQuestion(id: "Dur1", summaryDescription: "Duration of your training", question: "How long do you want to train", maxHours: 24, selectedMinutes: 0, selectedHours: 0)

    static var distanceQUestion1Example = PlannerDistanceQuestion(id: "DQ2", summaryDescription: "Distance of the run", question: "What is the distance of the race?", subtitle: "Pick a value in km", maxDistanceInMeters: 100000, selectedValueInMeters: 0)
    
    static var activitiesSelection1Example = PlannerActivitiesSelection(id: "AS1", summaryDescription: "Preferred activities", question: "Which activities do you prefer?", subtitle: "You can choose multiple", selectedActivities: Array<KnownActivityType>())
    
    func entry(withId id: String) -> TrainingPlannerEntry? {
        entries.first(where: { $0.entryId == id })
    }
}

protocol TrainingPlannerEntry {
    var entryId: String { get }
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
    @Published var entryId: String
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
        self.entryId = id
        self.type = type
        self.coachText = coachText
        self.summaryDescription = summaryDescription
        self.question = question
        self.subtitle = subtitle
        self.answers = answers
    }
}

class PlannerDateQuestion: TrainingPlannerEntry, Identifiable, ObservableObject {
    @Published var entryId: String
    @Published var coachText: String?
    @Published var summaryDescription: String
    @Published var question: String
    @Published var subtitle: String?
    @Published var range: ClosedRange<Date>
    @Published var selectedValue: Date
    
    init(id: String, coachText: String? = nil, summaryDescription: String, question: String, subtitle: String? = nil, range: ClosedRange<Date>, selectedValue: Date) {
        self.entryId = id
        self.coachText = coachText
        self.summaryDescription = summaryDescription
        self.question = question
        self.subtitle = subtitle
        self.range = range
        self.selectedValue = selectedValue
    }
}

class PlannerDurationQuestion: TrainingPlannerEntry, Identifiable, ObservableObject {
    @Published var entryId: String
    @Published var coachText: String?
    @Published var summaryDescription: String
    @Published var question: String
    @Published var subtitle: String?
    @Published var maxHours: Int
    @Published var selectedMinutes: Int
    @Published var selectedHours: Int
    
    init(id: String, coachText: String? = nil, summaryDescription: String, question: String, subtitle: String? = nil, maxHours: Int, selectedMinutes: Int, selectedHours: Int) {
        self.entryId = id
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
    @Published var entryId: String
    @Published var coachText: String?
    @Published var summaryDescription: String
    @Published var question: String
    @Published var subtitle: String?
    @Published var maxDistanceInMeters: Int
    @Published var selectedValueInMeters: Int
    
    init(id: String, coachText: String? = nil, summaryDescription: String, question: String, subtitle: String? = nil, maxDistanceInMeters: Int, selectedValueInMeters: Int) {
        self.entryId = id
        self.coachText = coachText
        self.summaryDescription = summaryDescription
        self.question = question
        self.subtitle = subtitle
        self.maxDistanceInMeters = maxDistanceInMeters
        self.selectedValueInMeters = selectedValueInMeters
    }
}

class PlannerCountQuestion: TrainingPlannerEntry, Identifiable, ObservableObject {
    @Published var entryId: String
    @Published var coachText: String?
    @Published var summaryDescription: String
    @Published var question: String
    @Published var subtitle: String?
    @Published var maxCount: Int
    @Published var selectedCount: Int
    
    init(id: String, coachText: String? = nil, summaryDescription: String, question: String, subtitle: String? = nil, maxCount: Int, selectedCount: Int) {
        self.entryId = id
        self.coachText = coachText
        self.summaryDescription = summaryDescription
        self.question = question
        self.subtitle = subtitle
        self.maxCount = maxCount
        self.selectedCount = selectedCount
        
    }
}

class PlannerActivitiesSelection: TrainingPlannerEntry, Identifiable, ObservableObject {
    @Published var entryId: String
    @Published var coachText: String?
    @Published var summaryDescription: String
    @Published var question: String
    @Published var subtitle: String?
    @Published var selectedActivities: Array<KnownActivityType>
    
    init(id: String, coachText: String? = nil, summaryDescription: String, question: String, subtitle: String? = nil, selectedActivities: Array<KnownActivityType>) {
        self.entryId = id
        self.coachText = coachText
        self.summaryDescription = summaryDescription
        self.question = question
        self.subtitle = subtitle
        self.selectedActivities = selectedActivities
        
    }
    
    func remove(activity: KnownActivityType) {
        objectWillChange.send()
        var newActivities = selectedActivities
        newActivities.removeAll(where: {$0 == activity})
        selectedActivities = newActivities
    }
}


enum KnownActivityType: Int, CaseIterable, Equatable, Identifiable, Hashable {
    var id: Int { self.rawValue }
    
    case walking = 0,
         running = 1,
         cycling = 2,
         cross_country_skiing = 3,
         other_1 = 4,
         other_2 = 5,
         other_3 = 6,
         other_4 = 7,
         other_5 = 8,
         other_6 = 9,
         mountain_biking = 10,
         hiking = 11,
         roller_skating = 12,
         downhill_skiing = 13,
         paddling = 14,
         rowing = 15,
         golf = 16,
         indoor = 17,
         parkour = 18,
         ballgames = 19,
         outdoor_gym = 20,
         swimming = 21,
         trail_running = 22,
         gym = 23,
         nordic_walking = 24,
         horseback_riding = 25,
         motor_sports = 26,
         skateboarding = 27,
         water_sports = 28,
         climbing = 29,
         snowboarding = 30,
         ski_touring = 31,
         fitness_class = 32,
         soccer = 33,
         tennis = 34,
         basketball = 35,
         badminton = 36,
         baseball = 37,
         volleyball = 38,
         american_football = 39,
         table_tennis = 40,
         racquet_ball = 41,
         squash = 42,
         floorball = 43,
         handball = 44,
         softball = 45,
         bowling = 46,
         cricket = 47,
         rugby = 48,
         ice_skating = 49,
         ice_hockey = 50,
         yoga = 51,
         indoor_cycling = 52,
         treadmill = 53,
         crossfit = 54,
         crosstrainer = 55,
         roller_skiing = 56,
         indoor_rowing = 57,
         stretching = 58,
         track_and_field = 59,
         orienteering = 60,
         standup_paddling = 61,
         combat_sport = 62,
         kettlebell = 63,
         dancing = 64,
         snow_shoeing = 65,
         frisbee = 66,
         futsal = 67,
         
         multisport = 68,
         aerobics = 69,
         trekking = 70,
         sailing = 71,
         kayaking = 72,
         circuit_training = 73,
         triathlon = 74,
         padel = 75,
         cheerleading = 76,
         boxing = 77,
         scubaDiving = 78,
         freeDiving = 79,
         adventure_racing = 80,
         gymnastics = 81,
         canoeing = 82,
         mountaineering = 83,
         telemarkSkiing = 84,
         openwater_swimming = 85,
         windsurfing = 86,
         kitesurfing_kiting = 87,
         paragliding = 88,
         snorkeling = 90,
         surfing = 91,
         swimRun = 92,
         duathlon = 93,
         aquathlon = 94,
         obstacle_racing = 95,
         fishing = 96,
         hunting = 97,
         transition = 98,
         gravel_cycling = 99,
         mermaiding = 100,
         jumpRope = 102,
    none = -1
    
    static var allValues: [KnownActivityType] = {
        return (-1...35).compactMap { KnownActivityType(rawValue: $0) }.filter{!popular.contains($0)}
    }()
    
    static var popular: [KnownActivityType] = {
        return [.running, .trail_running, .cycling, .gym]
    }()
    
    var identifier: String {
        switch self {
        case .running: return "running"
        case .walking: return "walking"
        case .cycling: return "cycling"
        case .mountain_biking: return "mountain-biking"
        case .gravel_cycling: return "gravel-cycling"
        case .hiking: return "hiking"
        case .roller_skating: return "roller-skating"
        case .downhill_skiing: return "downhill-skiing"
        case .cross_country_skiing: return "cross-country-skiing"
        case .paddling: return "paddling"
        case .rowing: return "rowing"
        case .golf: return "golf"
        case .ballgames: return "ballgames"
        case .swimming: return "swimming"
        case .trail_running: return "trail-running"
        case .nordic_walking: return "nordic-walking"
        case .horseback_riding: return "horseback-riding"
        case .motor_sports: return "motor-sports"
        case .skateboarding: return "skateboarding"
        case .water_sports: return "water-sports"
        case .climbing: return "climbing"
        case .snowboarding: return "snowboarding"
        case .ski_touring: return "ski-touring"
        case .soccer: return "soccer"
        case .gym: return "gym"
        case .fitness_class: return "fitness-class"
        case .indoor: return "indoor"
        case .outdoor_gym: return "outdoor-gym"
        case .parkour: return "parkour"
        case .tennis: return "tennis"
        case .basketball: return "basketball"
        case .badminton: return "badminton"
        case .baseball: return "baseball"
        case .volleyball: return "volleyball"
        case .american_football: return "american-football"
        case .table_tennis: return "table-tennis"
        case .racquet_ball: return "racquet-ball"
        case .squash: return "squash"
        case .floorball: return "floorball"
        case .handball: return "handball"
        case .softball: return "softball"
        case .bowling: return "bowling"
        case .cricket: return "cricket"
        case .rugby: return "rugby"
        case .ice_skating: return "ice-skating"
        case .ice_hockey: return "ice-hockey"
        case .yoga: return "yoga"
        case .indoor_cycling: return "indoor-cycling"
        case .treadmill: return "treadmill"
        case .crossfit: return "crossfit"
        case .crosstrainer: return "crosstrainer"
        case .roller_skiing: return "roller-skiing"
        case .indoor_rowing: return "indoor-rowing"
        case .stretching: return "stretching"
        case .track_and_field: return "track-and-field"
        case .orienteering: return "orienteering"
        case .standup_paddling: return "standup-paddling"
        case .combat_sport: return "combat-sport"
        case .kettlebell: return "kettlebell"
        case .dancing: return "dancing"
        case .snow_shoeing: return "snow-shoeing"
        case .frisbee: return "frisbee"
        case .futsal: return "futsal"
        case .multisport: return "multisport"
        case .aerobics: return "aerobics"
        case .trekking: return "trekking"
        case .sailing: return "sailing"
        case .kayaking: return "kayaking"
        case .circuit_training: return "circuit-training"
        case .triathlon: return "triathlon"
        case .padel: return "padel"
        case .cheerleading: return "cheerleading"
        case .boxing: return "boxing"
        case .scubaDiving: return "scubadiving"
        case .freeDiving: return "freediving"
        case .mermaiding: return "mermaiding"
        case .adventure_racing: return "adventure-racing"
        case .gymnastics: return "gymnastics"
        case .canoeing: return "canoeing"
        case .mountaineering: return "mountaineering"
        case .telemarkSkiing: return "telemark-skiing"
        case .openwater_swimming: return "openwater-swimming"
        case .windsurfing: return "windsurfing"
        case .kitesurfing_kiting: return "kitesurfing-kiting"
        case .paragliding: return "paragliding"
        case .snorkeling: return "snorkeling"
        case .surfing: return "surfing"
        case .swimRun: return "swimrun"
        case .duathlon: return "duathlon"
        case .aquathlon: return "aquathlon"
        case .obstacle_racing: return "obstacle-racing"
        case .fishing: return "fishing"
        case .hunting: return "hunting"
        case .transition: return "transition"
        case .jumpRope: return "jumpRope"
        case .other_1: return "other1"
        case .other_2: return "other2"
        case .other_3: return "other3"
        case .other_4: return "other4"
        case .other_5: return "other5"
        case .other_6: return "other6"
        case .none: return "none"
        }
    }
    
    var systemIcons: [String] { [
        "house", "house.fill", "house.circle", "house.circle.fill", "music.note",
        "music.note.list", "music.quarternote.3", "music.mic", "music.mic.circle",
        "music.mic.circle.fill", "arrow.right.circle", "arrow.right.circle.fill",
        "arrow.right.square", "arrow.right.square.fill", "arrow.up.left.and.down.right.magnifyingglass",
        "arrow.up.left.and.arrow.down.right", "arrow.up.left.circle", "arrow.up.left.circle.fill",
        "arrow.up.backward", "arrow.up.backward.circle", "arrow.up.backward.circle.fill",
        "arrow.up.backward.square", "arrow.up.backward.square.fill", "arrow.down.right.circle",
        "arrow.down.right.circle.fill", "arrow.down.right.square", "arrow.down.right.square.fill",
        "arrow.up.forward", "arrow.up.forward.circle", "arrow.up.forward.circle.fill",
        "arrow.up.forward.square", "arrow.up.forward.square.fill", "arrow.down.left.circle",
        "arrow.down.left.circle.fill", "arrow.down.left.square", "arrow.down.left.square.fill",
        "arrow.forward.circle", "arrow.forward.circle.fill", "arrow.forward.square",
        "arrow.forward.square.fill", "arrow.up.left.and.arrow.down.right.circle",
        "arrow.up.left.and.arrow.down.right.circle.fill", "arrow.up.left.and.arrow.down.right.square",
        "arrow.up.left.and.arrow.down.right.square.fill", "arrow.backward.circle",
        "arrow.backward.circle.fill", "arrow.backward.square", "arrow.backward.square.fill",
        "arrow.down.circle", "arrow.down.circle.fill", "arrow.down.square",
        "arrow.down.square.fill", "arrow.up.circle", "arrow.up.circle.fill",
        "arrow.up.square", "arrow.up.square.fill", "arrow.left.circle",
        "arrow.left.circle.fill", "arrow.left.square", "arrow.left.square.fill",
        "arrow.right.circle", "arrow.right.circle.fill", "arrow.right.square",
        "arrow.right.square.fill", "arrow.up.left.and.arrow.down.right.circle",
        "arrow.up.left.and.arrow.down.right.circle.fill", "arrow.up.left.and.arrow.down.right.square",
        "arrow.up.left.and.arrow.down.right.square.fill", "arrow.backward.circle",
        "arrow.backward.circle.fill", "arrow.backward.square", "arrow.backward.square.fill",
        "arrow.down.circle", "arrow.down.circle.fill", "arrow.down.square",
        "arrow.down.square.fill", "arrow.up.circle", "arrow.up.circle.fill",
        "arrow.up.square", "arrow.up.square.fill", "arrow.left.circle",
        "arrow.left.circle.fill", "arrow.left.square", "arrow.left.square.fill",
        "arrow.right.circle", "arrow.right.circle.fill", "arrow.right.square",
        "arrow.right.square.fill", "arrow.up.left.and.arrow.down.right.circle",
        "arrow.up.left.and.arrow.down.right.circle.fill", "arrow.up.left.and.arrow.down.right.square",
        "arrow.up.left.and.arrow.down.right.square.fill", "arrow.backward.circle",
        "arrow.backward.circle.fill", "arrow.backward.square", "arrow.backward.square.fill",
        "arrow.down.circle", "arrow.down.circle.fill", "arrow.down.square",
        "arrow.down.square.fill", "arrow.up.circle", "arrow.up.circle.fill",
        "arrow.up.square", "arrow.up.square.fill", "arrow.left.circle",
        "arrow.left.circle.fill", "arrow.left.square", "arrow.left.square.fill",
        "arrow.right.circle", "arrow.right.circle.fill", "arrow.right.square",
        "arrow.right.square.fill", "arrow.up.left.and.arrow.down.right.circle",
        "arrow.up.left.and.arrow.down.right.circle.fill", "arrow.up.left.and.arrow.down.right.square",
        "arrow.up.left.and.arrow.down.right.square.fill", "arrow.backward.circle",
        "arrow.backward.circle.fill", "arrow.backward.square", "arrow.backward.square.fill",
        "arrow.down.circle", "arrow.down.circle.fill", "arrow.down.square",
        "arrow.down.square.fill", "arrow.up.circle", "arrow.up.circle.fill",
        "arrow.up.square", "arrow.up.square.fill", "arrow.left.circle",
        "arrow.left.circle.fill", "arrow.left.square", "arrow.left.square.fill",
        "arrow.right.circle", "arrow.right.circle.fill", "arrow.right.square",
        "arrow.right.square.fill", "arrow.up.left.and.arrow.down.right.circle",
        "arrow.up.left.and.arrow.down.right.circle.fill", "arrow.up.left.and.arrow.down.right.square",
        "arrow.up.left.and.arrow.down.right.square.fill"
    ] }
    
    var icon: Image {
        if self.rawValue > 0 && self.rawValue < systemIcons.count {
            return Image(systemName: systemIcons[self.rawValue])
        }
        return Image(systemName: "nosign")
    }
}
