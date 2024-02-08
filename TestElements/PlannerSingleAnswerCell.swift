import SwiftUI


struct PlannerSingleAnswerCell: View {
    @Binding var answer: PlannerAnswer
    
    var body: some View {
        HStack(alignment: .center){
            VStack(alignment: .leading) {
                Text(answer.answer)
                    .font(.callout)
            }
            Spacer()
            RadioButton(isSelected: answer.isSelected)
        }
        .padding()
    }
}


struct RadioButton: View {
    var isSelected: Bool

    var body: some View {
        ZStack {
            Circle()
                .stroke(isSelected ? .blue : .gray, lineWidth: 2)
                .frame(width: 16, height: 16)
            if isSelected {
                Circle()
                    .fill(Color.blue)
                    .frame(width: 10, height: 10)
            }
        }
    }
}
