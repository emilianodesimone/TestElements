import SwiftUI

struct PlannerDateQuestionView: View {
    @Binding var question: PlannerDateQuestion
    
    var body: some View {
        HStack{ Spacer()
            DatePicker(
                "Select a date",
                selection: $question.selectedValue,
                in: question.range.lowerBound...question.range.upperBound,
                displayedComponents: .date // Show only the date picker
            )
            .datePickerStyle(GraphicalDatePickerStyle())
            .id(question.selectedValue) //Solves a graphical glitch
            .padding()
            Spacer()
        }
        Spacer()
    }
}

//#Preview {
//    PlannerDateQuestionView(question: .constant(PlannerDateQuestion(id: "DQ1", question: "Which is the date of the race?", range: Date().addingTimeInterval(-24*3600*30)...Date().addingTimeInterval(24*3600*30), selectedValue: Date())))
//}

struct PlannerDistanceQuestionView: View {
    @Binding var question: PlannerDistanceQuestion
    
    private var distanceSteps: [Int] {
        stride(from: question.range.lowerBound, through: question.range.upperBound, by: 1).map { Int($0) }
    }
    
    var body: some View {
        HStack{ Spacer()
            Picker(
                "Select a distance in km",
                selection: $question.selectedValue
            ){
                ForEach(distanceSteps, id: \.self) { distance in
                    Text("\(distance) km")
                }
            }
            .pickerStyle(WheelPickerStyle())
            .padding()
            Spacer()
        }
        Spacer()
    }
}

//#Preview {
//    PlannerDistanceQuestionView(question: .constant(PlannerDistanceQuestion(id: "DQ1", question: "Which is the distance the race?", range: 0...100, selectedValue: 0)))
//}
