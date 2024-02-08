

import SwiftUI

struct PlannerDateQuestionView: View {
    @State private var question: PlannerDateQuestion = PlannerDateQuestion(id: "DQ1", range: Date().addingTimeInterval(-24*3600*30)...Date().addingTimeInterval(24*3600*30), selectedValue: Date())
    
    var body: some View {
        DatePicker(
                    "Select a date",
                    selection: $question.selectedValue,
                    in: question.range.lowerBound...question.range.upperBound,
                    displayedComponents: .date // Show only the date picker
                )
                .datePickerStyle(GraphicalDatePickerStyle()) // Use .wheelDatePickerStyle() for a spinner on older versions
                .padding()
    }
}

#Preview {
    PlannerDateQuestionView()
}


struct PlannerDateQuestion {
    var id: String
    var range: ClosedRange<Date>
    var selectedValue: Date
}
