import UIKit
import SwiftUI

struct PlannerSlider: Hashable {
    let id: String
    var question: String
    var subtitle: String
    var sliderRange: ClosedRange<Double>
    var sliderValue: Double
}

struct PlannerSliderView: View {
    let question: String
    let subtitle: String
    let sliderRange: ClosedRange<Double>
    @Binding var value: Double
    
    var body: some View {
        VStack(alignment: .leading){
            VStack(alignment: .leading) {
                Text(question)
                    .font(.headline)
                Text(subtitle)
                    .font(.subheadline)
            }
            
            HStack{
                Spacer()
                Text("\(Int(value)) h")
                    .font(.title)
            }
            Slider(value: $value, in: sliderRange, step: 1)
                .onAppear {
                    let thumbImage = UIImage(systemName: "circle.fill")
                    UISlider.appearance().setThumbImage(thumbImage, for: .normal)
                    }
                .onDisappear{
                    UISlider.appearance().setThumbImage(nil, for: .normal)
                }
            Spacer()
            
        }.padding()
    }
}

struct PlannerSliderPage: View {
    @State private var model = PlannerSlider(id: "effortQuestion", question: "How many hours you are currently training in a week?", subtitle: "Some other info here", sliderRange: 0...168, sliderValue: 0)
    
    var body: some View {
        PlannerSliderView(question: model.question, subtitle: model.subtitle, sliderRange: model.sliderRange, value: $model.sliderValue)
    }
}

#Preview {
    PlannerSliderPage()
}
