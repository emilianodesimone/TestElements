import SwiftUI

struct OptionToggle: View {
    var toggleRadius: Double
    var id = UUID()
    @Binding var isOn: Bool
    
    var body: some View {
        Circle()
            .frame(width: toggleRadius, height: toggleRadius)
            .foregroundColor(isOn ? .blue : .gray)
            .onTapGesture {
                isOn.toggle()
            }
        
    }
}

struct Day {
    let name: String
    let abbreviation: String
}

class MultiOptionModel: ObservableObject {
    @Published var options: [Bool]
    
    init(numberOfOptions: Int) {
        options = Array(repeating: false, count: numberOfOptions)
    }
}

struct OptionView: View {
    static let numberOfOptions: Int = 7
    @StateObject var model = MultiOptionModel(numberOfOptions: OptionView.numberOfOptions)
    
    
    var body: some View {
        HStack {
            ForEach(0..<model.options.count, id: \.self) { index in
                VStack {
                    OptionToggle(toggleRadius: 20, isOn: $model.options[index])
                    Text(weekDay(index, forFirstDay: 2))
                        .foregroundColor(model.options[index] ? .green : .gray)
                }
            }
        }
        .padding()
    }
    
    func weekDay(_ index: Int, forFirstDay firstDay: Int) -> String {
        guard 1...7 ~= firstDay else { return "" }
        guard 0...6 ~= index else { return "" }
        
        return Calendar.current.veryShortWeekdaySymbols[(firstDay + index - 1) % 7]
    }
    
    static func week(forFirstDay firstDay: Int) -> [String] {
        guard 1...7 ~= firstDay else { return [] }
        
        let indeces = (0..<7 ).map { (firstDay + $0 - 1) % 7 }
        
        let weekArray = indeces.compactMap { Calendar.current.veryShortWeekdaySymbols[$0] }
        
        return weekArray.count == 7 ? weekArray : []
    }
}

#Preview {
    OptionView()
}
