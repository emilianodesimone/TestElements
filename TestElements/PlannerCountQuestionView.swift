import SwiftUI

struct PlannerCountQuestionView: View {
    @Binding var question: PlannerCountQuestion
    
    var body: some View {
            Picker("Count", selection: $question.selectedCount) {
                ForEach(0...question.maxCount
                        , id: \.self) { count in
                    HStack{
                        Spacer()
                        Text("\(count)")
                        Spacer()
                    }.padding(.trailing)
                }
            }
            .pickerStyle(WheelPickerStyle())
    }
}

#Preview {
    PlannerCountQuestionView(question: .constant(PlannerCountQuestion(id: "CQ1", summaryDescription: "Event duration in days", question: "How many days the event lasts?", maxCount: 1000, selectedCount: 0)))
}
