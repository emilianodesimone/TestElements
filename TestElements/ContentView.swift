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
        let thisPageQuestion: any TrainingPlannerQuestion = plannerData.questions[currentPageIndex]
        VStack(alignment: .leading){
            QuestionsProgressBar(totalNumberOfQuestions: plannerData.questions.count, currentQuestion: currentPageIndex + 1, back: back)
            Group{
                if thisPageQuestion is MultiAnswerQuestion {
                    PlannerMultiAnswerPage(question: Binding(
                        get: { plannerData.questions[currentPageIndex] as! MultiAnswerQuestion},
                        set: { newQuestion in plannerData.questions[currentPageIndex] = newQuestion }))
                }
                if thisPageQuestion is SingleAnswerQuestion {
                    PlannerSingleAnswerPage(question: Binding(
                        get: { plannerData.questions[currentPageIndex] as! SingleAnswerQuestion},
                        set: { newQuestion in plannerData.questions[currentPageIndex] = newQuestion }))
                }
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
                        if question is MultiAnswerQuestion {
                            let thisQuestion = question as! MultiAnswerQuestion
                            Text("\(thisQuestion.id) answers: \(thisQuestion.idsSelected.joined(separator: ", "))")
                        }
                        if question is SingleAnswerQuestion {
                            let thisQuestion = question as! SingleAnswerQuestion
                            Text("\(thisQuestion.id) answer: \(thisQuestion.idSelected ?? "")")
                        }
                    }
                }
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(isDone ? .red : .black, lineWidth: 2))
                
                
                
                Spacer()
            }
            Spacer()
        }
    }
}
    

#Preview {
    ContentView()
}

struct QuestionsProgressBar: View {
    var totalNumberOfQuestions: Int
    var currentQuestion: Int
    var back: (() -> Void)?
    
    
    var body: some View {
        ZStack(alignment: .center){
            GeometryReader{ proxy in
                HStack(alignment: .center) {
                    if let back {
                        Button(action: back)
                        {
                            Image("icon-chevron-left")
                                .foregroundColor(.blue)
                                .padding()
                                .contentShape(Rectangle())
                        }
                        .position(x: 0 , y: proxy.size.height / 2)
                        .padding(.leading)
                    }
                }
                ZStack(alignment: .leading){
                    Capsule()
                        .frame(width: 200, height: 4)
                        .foregroundColor(.gray)
                    Capsule()
                        .frame(width: (200.0 * Double(currentQuestion))/(Double(totalNumberOfQuestions)), height: 4)
                        .foregroundColor(.blue)
                        
                }.position(x: proxy.size.width / 2, y: proxy.size.height / 2)
            }
            HStack(alignment: .center){
                Spacer()
                Text( "\(currentQuestion)/\(totalNumberOfQuestions)")
            }
        }.frame(height: 40)
        .padding()
        
    }
}
