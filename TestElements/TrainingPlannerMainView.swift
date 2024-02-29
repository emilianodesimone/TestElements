import SwiftUI

struct TrainingPlannerMainView: View {
    @StateObject var plannerData = TrainingPlannerData()
    @State private var currentItemID: String?
    @State private var pageTransition: AnyTransition = .pushFromLeft
    @State private var showSummary: Bool = false
    @State private var showCancel: Bool = false
    var currentPageIndex: Int {
        plannerData.entries.firstIndex(where: { $0.entryId == currentItemID }) ?? 0
    }
    
    private var done: (() -> Void)? {
        guard currentPageIndex < plannerData.entries.count else { return nil }
        if currentPageIndex ==  plannerData.entries.count - 1 {
            return { showSummary = true }
        } else { return {
            pageTransition = .pushFromRight
            withAnimation {
                self.currentItemID = plannerData.entries[currentPageIndex + 1].entryId
            }
            
        }
        }
    }
    
    private var back: (() -> Void)? {
        guard currentPageIndex > 0 else { return nil }
        return {
            pageTransition = .pushFromLeft
            withAnimation {
                self.currentItemID = plannerData.entries[currentPageIndex - 1].entryId
            }
        }
    }
    
    private var doneText: String {
        guard currentPageIndex < plannerData.entries.count else { return "" }
        return currentPageIndex < plannerData.entries.count - 1 ? "CONTINUE" : "DONE"
    }
    
    var body: some View {
        if let itemId = currentItemID ?? plannerData.entries.first?.entryId {
            NavigationView{
                VStack(alignment: .leading){
                    NavigationLink(destination: TrainingPlannerSummaryView(shouldShow: $showSummary), isActive: $showSummary, label: {})
                    QuestionsProgressBar(totalNumberOfQuestions: plannerData.entries.count, currentQuestion: currentPageIndex + 1, back: back)
                    Group{
                        PlannerEntryPage(id: itemId)
                    }.id(currentPageIndex)
                        .transition(pageTransition)
                        .animation(.default, value: currentPageIndex)
                    if let done {
                        HStack{
                            Spacer()
                            VStack{
                                Button(action: {done()}, label: {
                                    Text(doneText)
                                        .font(.callout.bold())
                                        .frame(width: 343, height: 48, alignment: .center)
                                        .background(.blue)
                                        .foregroundColor(.white)
                                        .clipShape(RoundedRectangle(cornerRadius: 6))
                                    
                                })
                                Button(action: { showCancel = true }, label: {
                                    Text("CANCEL")
                                        .font(.callout.bold())
                                        .frame(width: 343, height: 48, alignment: .center)
                                        .background(.white)
                                        .foregroundColor(.blue)
                                        .clipShape(RoundedRectangle(cornerRadius: 6))
                                    
                                })
                            }
                            Spacer()
                        }
                    }
                    Spacer()
                }
                
            }.environmentObject(plannerData)
                .navigationViewStyle(.stack)
                .fullScreenCover(isPresented: $showCancel) {
                    PlannerCancelView()
                }
            
        }
    }
}
    

//#Preview {
//    ContentView()
//}
