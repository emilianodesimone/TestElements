import SwiftUI

struct PlannerMultiAnswerPage: View {
    @StateObject var plannerData = TrainingPlannerData()
    
    var body: some View {
        ForEach($plannerData.multiAnswerQuestion.answers, id: \.self) { $answer in
            PlannerMultiAnswerCell(answer: answer.answer, subtitle: answer.subtitle, isSelected: $answer.isSelected)
            Divider()
        }
        
    }
    
}


struct PlannerMultiAnswerCell: View {
    let answer: String
    let subtitle: String?
    @Binding var isSelected: Bool
    
    var body: some View {
        HStack(alignment: .center){
            VStack(alignment: .leading) {
                Text(answer)
                    .font(.headline)
                Group{
                    if let subtitle {
                        Text(subtitle)
                            .font(.subheadline)
                    }
                }
            }
            Spacer()
                    Image("icon-checkmark-circled")
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 32, height: 32)
                        .foregroundColor(.green)
                        .overlay(
                            Group{ if !isSelected { Circle()
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
