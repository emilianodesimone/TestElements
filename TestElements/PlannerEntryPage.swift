import SwiftUI

struct PlannerEntryPage: View {
    var id: String
    @EnvironmentObject var plannerData: TrainingPlannerData
    
    var body: some View {
        if let currentEntry = plannerData.entry(withId: id) {
            ScrollView {
                VStack(alignment: .leading) {
                    if let coachText = currentEntry.coachText {
                        PlannerCoachView(text: coachText)
                    }
                    VStack(alignment: .leading, spacing: 0){
                        Text(currentEntry.question)
                            .font(.headline)
                        if let subtitle = currentEntry.subtitle { Text(subtitle).font(.subheadline) }
                        
                    }.padding()
                    view(forId: id)
                    Spacer()
                }
            }
        }
    }
    
    @ViewBuilder
    func view(forId id: String) -> some View {
        if plannerData.entry(withId: id) is TrainingQuestionWithAnswers {
            QuestionWithAnswersView(questionWithAnswers: binding(atId: id, toType: TrainingQuestionWithAnswers.self))
        } else if plannerData.entry(withId: id) is PlannerDistanceQuestion {
            PlannerDistanceQuestionView(question: binding(atId: id, toType: PlannerDistanceQuestion.self))
        } else if plannerData.entry(withId: id) is PlannerDateQuestion {
            PlannerDateQuestionView(question: binding(atId: id, toType: PlannerDateQuestion.self))
        } else if plannerData.entry(withId: id) is PlannerDurationQuestion {
            PlannerDurationQuestionView(question: binding(atId: id, toType: PlannerDurationQuestion.self))
        } else if plannerData.entry(withId: id) is PlannerCountQuestion {
            PlannerCountQuestionView(question: binding(atId: id, toType: PlannerCountQuestion.self))
        } else {
            EmptyView()
        }
    }
    
    func binding<T>(atId id: String, toType type: T.Type) -> Binding<T> where T: TrainingPlannerEntry {
        Binding<T>(get: { plannerData.entry(withId: id) as! T}, set: { entry in
            if let index = plannerData.entries.firstIndex(where: { $0.id == entry.id }) { plannerData.entries[index] = entry} })
    }
}
