import SwiftUI

struct QuestionWithAnswersView: View {
    @ObservedObject var questionWithAnswers: TrainingQuestionWithAnswers
    @State var id = UUID()
    
    var body: some View {
        ForEach(0 ..< questionWithAnswers.answers.count, id: \.self) { index in
            if questionWithAnswers.type == .multiAnswer {
                PlannerMultiAnswerCell(answer: $questionWithAnswers.answers[index])
            } else if questionWithAnswers.type == .singleAnswer {
                PlannerSingleAnswerCell(answer: $questionWithAnswers.answers[index])
                    .onTapGesture {
                        let newAnswers = questionWithAnswers.answers.indices.reduce(into: [PlannerAnswer]()) { result, newIndex in
                            let oldAnswer = questionWithAnswers.answers[newIndex]
                            let newAnswer = PlannerAnswer(id: oldAnswer.id, answer: oldAnswer.answer, isSelected: oldAnswer.id == questionWithAnswers.answers[index].id)
                            result.append(newAnswer)
                        }
                        questionWithAnswers.answers = newAnswers
                    }
                
            }
            Divider()
        }
        
    }
}
