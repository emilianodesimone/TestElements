import SwiftUI

struct PlannerMultiAnswerPage: View {
    @Binding var question: MultiAnswerQuestion
    var back: (() -> Void)?
    var done: (() -> Void)?
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                if let back {
                    Button(action: back)
                    {
                        Image("icon-chevron-left")
                            .foregroundColor(.blue)
                            .padding()
                            .contentShape(Rectangle())
                    }
                }
                if let coachText = question.coachText {
                    PlannerCoachView(text: coachText)
                }
                VStack(alignment: .leading, spacing: 0){
                    
                    Text(question.question)
                        .font(.headline)
                    if let subtitle = question.subtitle { Text(subtitle).font(.subheadline) }
                    
                }.padding()
                ForEach($question.answers, id: \.self) { $answer in
                    PlannerMultiAnswerCell(answer: answer.answer, isSelected: $answer.isSelected)
                    Divider()
                }
                 
            }
            if let done {
                Button(action: {done()}, label: {
                    Text("Continue")
                        .frame(width: 343, height: 48, alignment: .center)
                        .background(.blue)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                    
                })
            }
        }
        
    }
    
}


struct PlannerMultiAnswerCell: View {
    let answer: String
    @Binding var isSelected: Bool
    
    var body: some View {
        HStack(alignment: .center){
            VStack(alignment: .leading) {
                Text(answer)
                    .font(.callout)
            }
            Spacer()
                    Image("icon-checkmark-circled")
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 32, height: 32)
                        .foregroundColor(.green)
                        .overlay(
                            Group{ if !isSelected { Circle()
                                    .frame(width: 26.6, height: 26.6)
                                .foregroundColor(.gray) }
                                
            })
            .onTapGesture {
                withAnimation {
                    isSelected.toggle()
                }
            }
        }.padding()
    }
}

#Preview {
    return PlannerMultiAnswerPage(question: .constant(MultiAnswerQuestion(id: "Multi", coachText: "Hi! I am Suunto Coach, Your personal AI Assistant. I will help you to develop a personalized training program for you.",
                                                                          question: "What is that you want to achieve?",
                                                                          subtitle: "You can choose multiple",
                                                                          answers: [
                                                                            PlannerAnswer(id: "1", answer: "I want to keep fit", isSelected: false),
                                                                            PlannerAnswer(id: "2", answer: "Build up my cardio training", isSelected: false),
                                                                            PlannerAnswer(id: "3", answer: "Enhance endurance", isSelected: false),
                                                                            PlannerAnswer(id: "4", answer: "Enhance endurance", isSelected: false)
                                                                          ])), back: {}, done: {})
}
