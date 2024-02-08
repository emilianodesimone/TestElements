import SwiftUI

struct PlannerQuestionPage: View {
    var page: Int
    @EnvironmentObject var plannerData: TrainingPlannerData
    
    var body: some View {
        if page >= 0 && plannerData.questions.count > 0 && page < plannerData.questions.count {
            ScrollView {
                VStack(alignment: .leading) {
                    if let coachText = plannerData.questions[page].coachText {
                        PlannerCoachView(text: coachText)
                    }
                    VStack(alignment: .leading, spacing: 0){
                        Text(plannerData.questions[page].question)
                            .font(.headline)
                        if let subtitle = plannerData.questions[page].subtitle { Text(subtitle).font(.subheadline) }
                        
                    }.padding()
                    view(atPage: page)
                    Spacer()
                }
            }
        }
    }
    
    @ViewBuilder
    func view(atPage page: Int) -> some View {
        if plannerData.questions[page] is TrainingQuestionWithAnswers {
            QuestionWithAnswersView(questionWithAnswers: binding(atPage: page, toType: TrainingQuestionWithAnswers.self))
        } else if plannerData.questions[page] is PlannerDistanceQuestion {
            PlannerDistanceQuestionView(question: binding(atPage: page, toType: PlannerDistanceQuestion.self))
        } else if plannerData.questions[page] is PlannerDateQuestion {
            PlannerDateQuestionView(question: binding(atPage: page, toType: PlannerDateQuestion.self))
        } else {
            EmptyView()
        }
    }
    
    func binding<T>(atPage page: Int, toType type: T.Type) -> Binding<T> where T: TrainingPlannerEntry {
        Binding<T>(get: { plannerData.questions[page] as! T}, set: { plannerData.questions[page] = $0 })
    }
}
