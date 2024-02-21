import SwiftUI

struct PlannerEntryPage: View {
    var page: Int
    @EnvironmentObject var plannerData: TrainingPlannerData
    
    var body: some View {
        if page >= 0 && plannerData.entries.count > 0 && page < plannerData.entries.count {
            ScrollView {
                VStack(alignment: .leading) {
                    if let coachText = plannerData.entries[page].coachText {
                        PlannerCoachView(text: coachText)
                    }
                    VStack(alignment: .leading, spacing: 0){
                        Text(plannerData.entries[page].question)
                            .font(.headline)
                        if let subtitle = plannerData.entries[page].subtitle { Text(subtitle).font(.subheadline) }
                        
                    }.padding()
                    view(atPage: page)
                    Spacer()
                }
            }
        }
    }
    
    @ViewBuilder
    func view(atPage page: Int) -> some View {
        if plannerData.entries[page] is TrainingQuestionWithAnswers {
            QuestionWithAnswersView(questionWithAnswers: binding(atPage: page, toType: TrainingQuestionWithAnswers.self))
        } else if plannerData.entries[page] is PlannerDistanceQuestion {
            PlannerDistanceQuestionView(question: binding(atPage: page, toType: PlannerDistanceQuestion.self))
        } else if plannerData.entries[page] is PlannerDateQuestion {
            PlannerDateQuestionView(question: binding(atPage: page, toType: PlannerDateQuestion.self))
        } else if plannerData.entries[page] is PlannerDurationQuestion {
            PlannerDurationQuestionView(question: binding(atPage: page, toType: PlannerDurationQuestion.self))
        } else if plannerData.entries[page] is PlannerCountQuestion {
            PlannerCountQuestionView(question: binding(atPage: page, toType: PlannerCountQuestion.self))
        } else {
            EmptyView()
        }
    }
    
    func binding<T>(atPage page: Int, toType type: T.Type) -> Binding<T> where T: TrainingPlannerEntry {
        Binding<T>(get: { plannerData.entries[page] as! T}, set: { plannerData.entries[page] = $0 })
    }
}
