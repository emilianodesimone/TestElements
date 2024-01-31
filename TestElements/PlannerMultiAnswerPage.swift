import SwiftUI

struct PlannerMultiAnswerPage: View {
    @StateObject var plannerData = TrainingPlannerData()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                if let coachText = plannerData.multiAnswerQuestion.coachText {
                    PlannerCoachView(text: coachText)
                }
                VStack(alignment: .leading, spacing: 0){
                    
                    Text(plannerData.multiAnswerQuestion.question)
                        .font(.headline)
                    if let subtitle = plannerData.multiAnswerQuestion.subtitle { Text(subtitle).font(.subheadline) }
                    
                }.padding()
                ForEach($plannerData.multiAnswerQuestion.answers, id: \.self) { $answer in
                    PlannerMultiAnswerCell(answer: answer.answer, isSelected: $answer.isSelected)
                    Divider()
                }
            }
            
            Text("Ids selected: \(plannerData.multiAnswerQuestion.idsSelected.joined(separator: ", "))")
        }
    }
    
}


struct PlannerMultiAnswerCell: View {
    let answer: String
    @Binding var isSelected: Bool
    
    var body: some View {
        HStack(alignment: .center){
            VStack(alignment: .leading) {
                Text(answer)
                    .font(.callout)
            }
            Spacer()
                    Image("icon-checkmark-circled")
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 32, height: 32)
                        .foregroundColor(.green)
                        .overlay(
                            Group{ if !isSelected { Circle()
                                    .frame(width: 26.6, height: 26.6)
                                .foregroundColor(.gray) }
                                
            })
            .onTapGesture {
                withAnimation {
                    isSelected.toggle()
                }
            }
        }.padding()
    }
}

#Preview {
    PlannerMultiAnswerPage()
}
