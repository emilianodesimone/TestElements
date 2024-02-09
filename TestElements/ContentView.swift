import SwiftUI

struct ContentView: View {
    @StateObject var plannerData = TrainingPlannerData()
    @State private var currentPageIndex: Int = 0
    @State private var pageTransition: AnyTransition = .pushFromLeft
    @State private var showSummary: Bool = false
    
    private var done: (() -> Void)? {
        guard currentPageIndex < plannerData.entries.count else { return nil }
        if currentPageIndex ==  plannerData.entries.count - 1 {
            return { showSummary = true }
        } else { return {
            pageTransition = .pushFromRight
            
            withAnimation {
                currentPageIndex = min(currentPageIndex + 1, plannerData.entries.count - 1)
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
        guard currentPageIndex < plannerData.entries.count else { return "" }
        return currentPageIndex < plannerData.entries.count - 1 ? "Continue" : "Done"
    }
    
    var body: some View {
        NavigationView{
            VStack(alignment: .leading){
                NavigationLink(destination: TrainingPlannerSummaryView(shouldShow: $showSummary), isActive: $showSummary, label: {})
                QuestionsProgressBar(totalNumberOfQuestions: plannerData.entries.count, currentQuestion: currentPageIndex + 1, back: back)
                Group{
                    PlannerEntryPage(page: currentPageIndex)
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
                Spacer()
            }
        }.environmentObject(plannerData)
    }
}
    

#Preview {
    ContentView()
}
