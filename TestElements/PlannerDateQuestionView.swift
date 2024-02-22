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
