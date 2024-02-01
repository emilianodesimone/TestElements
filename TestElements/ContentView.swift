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
    
    private var done: () -> Void {
        {  guard currentPageIndex < plannerData.questions.count - 1 else { return }
            currentPageIndex = currentPageIndex + 1
            pageTransition = .pushFromRight}
    }
    
    private var back: () -> Void {
        {  guard currentPageIndex > 0 else { return }
            currentPageIndex = currentPageIndex - 1
            pageTransition = .pushFromLeft }
    }
    
    var body: some View {
        let thisPageQuestion: any TrainingPlannerQuestion = plannerData.questions[currentPageIndex]
        
        Group{
            if thisPageQuestion is MultiAnswerQuestion {
                PlannerMultiAnswerPage(question: Binding(
                    get: { plannerData.questions[currentPageIndex] as! MultiAnswerQuestion},
                    set: { newQuestion in plannerData.questions[currentPageIndex] = newQuestion }),
                                       back: currentPageIndex > 0 ? back : nil,
                                       done: currentPageIndex < plannerData.questions.count - 1 ? done : nil)
            }
            if thisPageQuestion is SingleAnswerQuestion {
                PlannerSingleAnswerPage(question: Binding(
                    get: { plannerData.questions[currentPageIndex] as! SingleAnswerQuestion},
                    set: { newQuestion in plannerData.questions[currentPageIndex] = newQuestion }),
                                        back: currentPageIndex > 0 ? back : nil,
                                        done: currentPageIndex < plannerData.questions.count - 1 ? done : nil)
            }
        }.id(currentPageIndex)
        .transition(pageTransition)
        .animation(.default, value: currentPageIndex)
        
        
        ForEach(plannerData.questions, id: \.id) { question in
            if question is MultiAnswerQuestion {
                let thisQuestion = question as! MultiAnswerQuestion
                Text("Multiquestion \(thisQuestion.id) selected: \(thisQuestion.idsSelected.joined(separator: ", "))")
            }
            if question is SingleAnswerQuestion {
                let thisQuestion = question as! SingleAnswerQuestion
                Text("Single question \(thisQuestion.id) selected: \(thisQuestion.idSelected ?? "")")
            }
        }
        Spacer()
    }
}
    

#Preview {
    ContentView()
}
