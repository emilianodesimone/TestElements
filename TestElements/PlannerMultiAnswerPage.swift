import SwiftUI

struct PlannerMultiAnswerPage: View {
    @Binding var question: MultiAnswerQuestion
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
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
            Image(systemName: isSelected ? "checkmark" : "")
              .resizable()
              .frame(width: 9, height: 9)
              .foregroundColor(.white)
              .padding(5)
              .background(isSelected ? .green : .gray)
              .clipShape(Circle())
                        
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
                                                                          ])))
}
