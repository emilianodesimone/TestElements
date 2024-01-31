import SwiftUI

struct PlannerCoachView: View {
    let text: String
    
    var body: some View {
        HStack(alignment: .top) {
            Image("icon-coach")
                .resizable()
                .renderingMode(.template)
                .foregroundColor(.orange)
                .frame(width: 26, height: 26, alignment: .top)
            Text(text)
            Spacer()
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(.gray, lineWidth: 1)
        )
        .padding()
        .frame(maxHeight: .infinity)
        
    }
}

#Preview {
    PlannerCoachView(text: "Example")
}
