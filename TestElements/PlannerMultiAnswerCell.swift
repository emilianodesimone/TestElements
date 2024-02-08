import SwiftUI

struct PlannerMultiAnswerCell: View {
    @Binding var answer: PlannerAnswer
    
    var body: some View {
            HStack(alignment: .center){
                VStack(alignment: .leading) {
                    Text(answer.answer)
                        .font(.callout)
                }
                Spacer()
                Image(systemName: answer.isSelected ? "checkmark" : "")
                    .resizable()
                    .frame(width: 9, height: 9)
                    .foregroundColor(.white)
                    .padding(5)
                    .background(answer.isSelected ? .green : .gray)
                    .clipShape(Circle())
                
                    .onTapGesture {
                        withAnimation {
                            answer.isSelected.toggle()
                        }
                    }
            }.padding()
    }
}
