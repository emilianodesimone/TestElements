import SwiftUI

struct PlannerDurationQuestionView: View {
    @ObservedObject var question: PlannerDurationQuestion
    
    var body: some View {
        HStack {
            Picker("Hours", selection: $question.selectedHours) {
                ForEach(0...question.maxHours
                        , id: \.self) { hours in
                    HStack{
                        Spacer()
                        Text("\(hours) h")
                    }.padding(.trailing)
                }
            }
            .pickerStyle(WheelPickerStyle())
            
            Picker("Minutes", selection: $question.selectedMinutes) {
                ForEach(0..<60, id: \.self) { mins in
                    HStack{
                        Text("\(mins) min")
                        Spacer()
                    }.padding(.leading)
                }
            }
            .pickerStyle(WheelPickerStyle())
        }
        .padding()
    }
}

#Preview {
    PlannerDurationQuestionView(question: PlannerDurationQuestion(id: "Dur1", summaryDescription: "Duration of your training", question: "How long do you want to train", maxHours: 24, selectedMinutes: 0, selectedHours: 0))
}
