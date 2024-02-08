import SwiftUI

struct QuestionWithAnswersView: View {
    @Binding var questionWithAnswers: TrainingQuestionWithAnswers
    
    var body: some View {
        ForEach(questionWithAnswers.answers.indices, id: \.self) { index in
            if questionWithAnswers.type == .multiAnswer {
                PlannerMultiAnswerCell(answer: $questionWithAnswers.answers[index])
            } else if questionWithAnswers.type == .singleAnswer {
                PlannerSingleAnswerCell(answer: questionWithAnswers.answers[index])
                    .onTapGesture {
                        for i in questionWithAnswers.answers.indices {
                            questionWithAnswers.answers[i].isSelected = false
                        }
                        questionWithAnswers.answers[index].isSelected = true
                    }
            }
            Divider()
        }
    }
}
