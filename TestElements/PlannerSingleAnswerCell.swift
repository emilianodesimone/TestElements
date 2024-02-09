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
            ZStack {
                Circle()
                    .stroke(answer.isSelected ? .blue : .gray, lineWidth: 2)
                    .frame(width: 16, height: 16)
                if answer.isSelected {
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 10, height: 10)
                }
            }
        }.background(.white)
//            .onTapGesture {
//                withAnimation {
//                    answer.isSelected.toggle()
//                }
//            }
        .padding()
    }
}
