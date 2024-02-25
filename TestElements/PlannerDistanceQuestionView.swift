import SwiftUI

struct PlannerDistanceQuestionView: View {
    @ObservedObject var question: PlannerDistanceQuestion
    
        
    
    var body: some View {
        HStack{ Spacer()
            Picker(
                "Select a distance in km",
                selection: $question.selectedValueInMeters
            ){
                ForEach(Array(stride(from: 0, to: question.maxDistanceInMeters, by: 100)), id: \.self) { distance in
                    Text(String(format: "%.1f km", Double(distance) / 1000.0))
                }
            }
            .pickerStyle(WheelPickerStyle())
            .padding()
            Spacer()
        }
        Spacer()
    }
}
