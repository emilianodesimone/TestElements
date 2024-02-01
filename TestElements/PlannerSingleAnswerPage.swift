import SwiftUI

struct PlannerSingleAnswerPage: View {
    @Binding var question: SingleAnswerQuestion
    var back: (() -> Void)?
    var done: (() -> Void)?
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                if let back {
                    Button(action: back)
                    {
                        Image("icon-chevron-left")
                            .foregroundColor(.blue)
                            .padding()
                            .contentShape(Rectangle())
                    }
                }
                if let coachText = question.coachText {
                    PlannerCoachView(text: coachText)
                }
                VStack(alignment: .leading, spacing: 0){
                    
                    Text(question.question)
                        .font(.headline)
                    if let subtitle = question.subtitle { Text(subtitle).font(.subheadline) }
                    
                }.padding()
                ForEach($question.answers, id: \.self) { $answer in
                    PlannerSingleAnswerCell(answer: answer.answer,
                                            isSelected: answer.isSelected)
                    .onTapGesture {
                        for i in  question.answers.indices {
                            question.answers[i].isSelected = false
                        }
                        answer.isSelected = true
                    }
                    Divider()
                }
            }
            if let done {
                Button(action: {done()}, label: {
                    Text("Continue")
                        .frame(width: 343, height: 48, alignment: .center)
                        .background(.blue)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                    
                })
            }
            Spacer()
        }
    }
}
struct PlannerSingleAnswerCell: View {
    let answer: String
    var isSelected: Bool
    
    var body: some View {
        HStack(alignment: .center){
            VStack(alignment: .leading) {
                Text(answer)
                    .font(.headline)
            }
            Spacer()
            RadioButton(isSelected: isSelected)
        }.padding()
    }
}
//#Preview {
//    @StateObject var model = TrainingPlannerData()
//    
//    return PlannerSingleAnswerPage(question: $model.singleAnswerQuestionExample)
//}

struct RadioButton: View {
    var isSelected: Bool

    var body: some View {
        ZStack {
            Circle()
                .stroke(isSelected ? .blue : .gray, lineWidth: 2)
                .frame(width: 24, height: 24)
            if isSelected {
                Circle()
                    .fill(Color.blue)
                    .frame(width: 12, height: 12)
            }
        }
    }
}
