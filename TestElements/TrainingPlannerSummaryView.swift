import SwiftUI

struct TrainingPlannerSummaryView: View {
    @EnvironmentObject var plannerData: TrainingPlannerData
    
    @State private var showFirework = false
    @Binding var shouldShow: Bool
    @State private var showEdit: Bool = false
    @State private var idToEdit: String = ""
    
    var body: some View {
            ZStack{
                NavigationLink(destination: PlannerEntryPage(id: idToEdit), isActive: $showEdit, label: {})
                ScrollView{
                    VStack(alignment: .leading){
                        Text("You are almost there")
                            .font(.headline.bold())
                            .padding()
                        Text("Congratulations! Please go through the answers and then you are able to generate a new program for you.")
                            .font(.callout)
                            .padding()
                        Text("PROGRAM INFORMATION")
                            .font(.headline.bold())
                            .padding()
                        
                        ForEach(plannerData.entries.indices, id: \.self) { index in
                            TrainingPlannerSummaryCell(entry: plannerData.entries[index],
                                                       action: { showEdit = true
                                idToEdit = plannerData.entries[index].id } )
                            Divider()
                        }
                        HStack{
                            Spacer()
                            Button(action: { showFirework = true }, label: {
                                Text("Generate the program")
                                    .frame(width: 343, height: 48, alignment: .center)
                                    .background(.blue)
                                    .foregroundColor(.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 6))
                                
                            })
                            Spacer()
                        }
                        
                    }
                }
                if showFirework {
                    FireworkEffectView()
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                withAnimation {
                                    showFirework = false
                                }
                            }
                        }
                }
            }
    }
}

struct SparkView: View {
    let id = UUID()
    var body: some View {
        let rand = Int.random(in: 0...100)
        let randomSize = CGFloat.random(in: 0...4)
        
        if rand % 2 == 0 {
            Circle()
                .fill(Color.random)
                .frame(width: 4, height: 4)
        } else {
            Rectangle()
                .fill(Color.random)
            .frame(width: randomSize, height: randomSize)
            .rotationEffect(Angle(degrees: Double.random(in: 0...359)))
        }
    }
}

extension Color {
    static var random: Color {
        return Color(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1))
    }
}

struct FireworkEffectView: View {
    @State private var animate = false
    private let sparks: Int = 2000 // Number of sparks in the firework
    
    var body: some View {
        ZStack {
            ForEach(0..<sparks, id: \.self) { _ in
                SparkView()
                    .opacity(animate ? 0 : 1)   
                    .scaleEffect(animate ? 3 : 1)
                    .offset(x: animate ? CGFloat.random(in: -500...500) : 0,
                            y: animate ? CGFloat.random(in: -500...500) : 0)
                    .animation(Animation.easeOut(duration: 1).delay(Double.random(in: 0...0.2)), value: animate)
            }
        }
        .onAppear {
            animate = true
        }
    }
}

struct TrainingPlannerSummaryCell: View {
    var entry: TrainingPlannerEntry
    var action: () -> ()
    
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Text(entry.summaryDescription)
                    .font(.caption)
                Text(summaryAnswerDescription(for: entry))
                    .font(.headline)
                    .foregroundColor(.cyan)
            }
            Spacer()
            Button(action: action, label: {
                Text("edit")
                    .foregroundColor(.blue)
            })
        }.padding()
    }
    
    func summaryAnswerDescription(for entry: TrainingPlannerEntry) -> String {
        if let entry = entry as? TrainingQuestionWithAnswers {
            return entry.answers.filter{ $0.isSelected }.map{ $0.answer}.joined(separator: ", ")
        } else if let entry = entry as? PlannerDistanceQuestion {
            return "\(entry.selectedValue) km"
        } else if let entry = entry as? PlannerDateQuestion {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM d, yyyy"
            return dateFormatter.string(from: entry.selectedValue)
        } else if let entry = entry as? PlannerCountQuestion {
            return "\(entry.selectedCount)"
        } else if let entry = entry as? PlannerDurationQuestion {
            return "\(entry.selectedHours)h : \(String(format: "%02d", entry.selectedMinutes))m"
        } else {
            return ""
        }
    }
}


//#Preview {
//    TrainingPlannerSummaryView()
//}
