import SwiftUI

struct PlannerSingleAnswerPage: View {
    @StateObject var plannerData = TrainingPlannerData()
    @State private var idSelected: String = ""
    
    var body: some View {
        ForEach($plannerData.singleAnswerQuestion.answers, id: \.self) { $answer in
            PlannerSingleAnswerCell(answer: answer.answer,
                                    subtitle: answer.subtitle,
                                    isSelected: Binding(get: { idSelected == answer.id },
                                                        set: { if $0 { self.idSelected = answer.id }})
            )
            Divider()
        }
    }
}
struct PlannerSingleAnswerCell: View {
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
            RadioButton(isSelected: isSelected)
                .onTapGesture {
                    withAnimation {
                        isSelected.toggle()
                    }
                }
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
