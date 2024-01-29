import SwiftUI

class TrainingPlannerData: ObservableObject {
    static var howAreYouQuestionId = "How Are You"
    static var doYouLikePizzaQuestionId = "Pizza"
    static var doYouSupportLazioQuestionId = "Lazio"
    
    @Published var firstPageQuestions: [PlannerQuestion] = [
        PlannerQuestion(id: TrainingPlannerData.howAreYouQuestionId, question: "Are you ok?", subtitle: "Based on your recent mood", isSelected: false),
        PlannerQuestion(id: TrainingPlannerData.doYouLikePizzaQuestionId, question: "Do you like pizza?", subtitle: "Based on your recent meals", isSelected: false),
        PlannerQuestion(id: TrainingPlannerData.doYouSupportLazioQuestionId, question: "Is Lazio your favourite team?", subtitle: "Of course it is", isSelected: false)
    ]
    
    var firstPageQuestionsStates: [String: Bool] {
        return firstPageQuestions.reduce(into: [String: Bool]()) { dictionary, question in
            dictionary[question.id] = question.isSelected
        }
    }
    
    func isQuestionChecked(id: String) -> Bool {
        firstPageQuestionsStates[id] ?? false
    }
}

struct PlannerQuestion: Hashable {
    let id: String
    var question: String
    var subtitle: String
    var isSelected : Bool
}


struct PlannerQuestionsPage: View {
    @StateObject var plannerData = TrainingPlannerData()
    
    var body: some View {
        ForEach($plannerData.firstPageQuestions, id: \.self) { $question in
            PlannerQuestionView(question: question.question, subtitle: question.subtitle, isSelected: $question.isSelected)
            Divider()
        }
    }
    
}


struct PlannerQuestionView: View {
    let question: String
    let subtitle: String
    @Binding var isSelected: Bool
    
    var body: some View {
        HStack{
            VStack(alignment: .leading) {
                Text(question)
                    .font(.headline)
                Text(subtitle)
                    .font(.subheadline)
            }
            Spacer()
            Image(isSelected ? "icon-checkmark-circled" : "icon-plus-circled")
                .renderingMode(.template)
                .resizable()
                .frame(width: 32, height: 32)
                .foregroundColor(isSelected ? .blue : .gray)
                .onTapGesture {
                    withAnimation {
                        isSelected.toggle()
                    }
                }
        }.padding()
    }
}

#Preview {
    PlannerQuestionsPage()
}
