import SwiftUI

struct PlannerSingleAnswerPage: View {
    @StateObject var plannerData = TrainingPlannerData()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                if let coachText = plannerData.multiAnswerQuestion.coachText {
                    PlannerCoachView(text: coachText)
                }
                VStack(alignment: .leading, spacing: 0){
                    
                    Text(plannerData.singleAnswerQuestion.question)
                        .font(.headline)
                    if let subtitle = plannerData.singleAnswerQuestion.subtitle { Text(subtitle).font(.subheadline) }
                    
                }.padding()
                ForEach($plannerData.singleAnswerQuestion.answers, id: \.self) { $answer in
                    PlannerSingleAnswerCell(answer: answer.answer,
                                            isSelected: answer.isSelected)
                    .onTapGesture {
                        for i in  plannerData.singleAnswerQuestion.answers.indices {
                            plannerData.singleAnswerQuestion.answers[i].isSelected = false
                        }
                        answer.isSelected = true
                    }
                    Divider()
                }
            }
            Text("Ids selected: \(plannerData.singleAnswerQuestion.idSelected ?? "")")
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
#Preview {
    PlannerSingleAnswerPage()
}

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
