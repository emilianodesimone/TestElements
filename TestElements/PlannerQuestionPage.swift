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
                    ForEach(plannerData.questions[page].answers.indices, id: \.self) { index in
                        if plannerData.questions[page].type == .multiAnswer {
                            PlannerMultiAnswerCell(answer: $plannerData.questions[page].answers[index])
                        } else if plannerData.questions[page].type == .singleAnswer {
                            PlannerSingleAnswerCell(answer: $plannerData.questions[page].answers[index])
                                .onTapGesture {
                                    for i in plannerData.questions[page].answers.indices {
                                        plannerData.questions[page].answers[i].isSelected = false
                                    }
                                    plannerData.questions[page].answers[index].isSelected = true
                                }
                        }
                        Divider()
                    }
                    
                }
            }
        }
    }
}
