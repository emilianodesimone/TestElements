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
            QuestionWithAnswersView(questionWithAnswers: plannerData.entry(withId: id) as! TrainingQuestionWithAnswers)
        } else if plannerData.entry(withId: id) is PlannerDistanceQuestion {
            PlannerDistanceQuestionView(question: plannerData.entry(withId: id) as! PlannerDistanceQuestion)
        } else if plannerData.entry(withId: id) is PlannerDateQuestion {
            PlannerDateQuestionView(question: plannerData.entry(withId: id) as! PlannerDateQuestion)
        } else if plannerData.entry(withId: id) is PlannerDurationQuestion {
            PlannerDurationQuestionView(question: plannerData.entry(withId: id) as! PlannerDurationQuestion)
        } else if plannerData.entry(withId: id) is PlannerCountQuestion {
            PlannerCountQuestionView(question: plannerData.entry(withId: id) as! PlannerCountQuestion)
        } else if plannerData.entry(withId: id) is PlannerActivitiesSelection {
                PlannerActivitiesQuestionView(plannerActivitiesSelection: plannerData.entry(withId: id) as! PlannerActivitiesSelection)
        } else {
            EmptyView()
        }
    }
    
//    func binding<T>(atId id: String, toType type: T.Type) -> Binding<T> where T: TrainingPlannerEntry {
//        Binding<T>(get: { plannerData.entry(withId: id) as! T}, set: { entry in
//            if let index = plannerData.entries.firstIndex(where: { $0.entryId == entry.entryId }) { plannerData.entries[index] = entry} })
//    }
}
