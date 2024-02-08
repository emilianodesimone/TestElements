import SwiftUI

extension AnyTransition {
    static var pushFromRight: AnyTransition {
        let insertion = AnyTransition.move(edge: .trailing)
            .combined(with: .opacity)
        let removal = AnyTransition.move(edge: .leading)
            .combined(with: .opacity)
        return .asymmetric(insertion: insertion, removal: removal)
    }
    
    static var pushFromLeft: AnyTransition {
        let insertion = AnyTransition.move(edge: .leading)
            .combined(with: .opacity)
        let removal = AnyTransition.move(edge: .trailing)
            .combined(with: .opacity)
        return .asymmetric(insertion: insertion, removal: removal)
    }
}


struct ContentView: View {
    @StateObject var plannerData = TrainingPlannerData()
    @State private var currentPageIndex: Int = 0
    @State private var pageTransition: AnyTransition = .pushFromLeft
    @State private var isDone: Bool = false
    
    private var done: (() -> Void)? {
        guard currentPageIndex < plannerData.questions.count else { return nil }
        if currentPageIndex ==  plannerData.questions.count - 1 {
            return { isDone.toggle() }
        } else { return {
            pageTransition = .pushFromRight
            
            withAnimation {
                currentPageIndex = min(currentPageIndex + 1, plannerData.questions.count - 1)
            }
            
        }
        }
    }
    
    private var back: (() -> Void)? {
        guard currentPageIndex > 0 else { return nil }
        return {
            pageTransition = .pushFromLeft
            withAnimation {
                currentPageIndex = max(0, currentPageIndex - 1)
            }
        }
    }
    
    private var doneText: String {
        guard currentPageIndex < plannerData.questions.count else { return "" }
        return currentPageIndex < plannerData.questions.count - 1 ? "Continue" : (isDone ? "Undo" : "Done")
    }
    
    var body: some View {
        
        VStack(alignment: .leading){
            QuestionsProgressBar(totalNumberOfQuestions: plannerData.questions.count, currentQuestion: currentPageIndex + 1, back: back)
            Group{
                PlannerQuestionPage(page: currentPageIndex)
            }.id(currentPageIndex)
                .transition(pageTransition)
                .animation(.default, value: currentPageIndex)
            if let done {
                HStack{
                    Spacer()
                    Button(action: {done()}, label: {
                    Text(doneText)
                        .frame(width: 343, height: 48, alignment: .center)
                        .background(.blue)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                    
                })
                    Spacer()
                }
            }
            HStack {
                Spacer()
                VStack(alignment: .leading){
                    ForEach(plannerData.questions, id: \.id) { question in
                            Text("\(question.id) answers: \(question.idsSelected.joined(separator: ", "))")
                    }
                }.font(.footnote)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(isDone ? .red : .black, lineWidth: 2))
                Spacer()
            }
            Spacer()
        }.environmentObject(plannerData)
    }
}
    

#Preview {
    ContentView()
}
