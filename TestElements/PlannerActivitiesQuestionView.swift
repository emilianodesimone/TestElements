

import SwiftUI

struct PlannerActivitiesQuestionView: View {
    @ObservedObject var plannerActivitiesSelection: PlannerActivitiesSelection
    @State private var showSelection = false
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Button(action: {
                            // Action for the button
                            showSelection = true
                        }) {
                            Image(systemName: "plus")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding(10)
                                .frame(width: 30, height: 30)
                                .foregroundColor(.white)
                        }
                        .background(Color.blue)
                        .clipShape(Circle())
                        .padding()
                Text("Add sports")
                    .font(.callout.bold())
                    .foregroundColor(.blue)
                Spacer()
            }
            List{
                ForEach(Array(plannerActivitiesSelection.selectedActivities)) { item in
                    ActivitiesQuestionCell(activityType: item, remove: {
                        withAnimation {
                            plannerActivitiesSelection.remove(activity: item)
                        }
                    })
                    .id(item.rawValue)
                }
                }
            
            .listStyle(PlainListStyle())
        }
        .frame(height: 800)
        .fullScreenCover(isPresented: $showSelection) {
            PlannerActivitiesSelectionView(plannerActivitiesSelection: plannerActivitiesSelection)
        }
    }
    
}

struct ActivitiesQuestionCell: View {
    var activityType: KnownActivityType
    var remove: () -> ()
    
    var body: some View {
        HStack{
            activityType.icon
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(10)
                .frame(width: 30, height: 30)
                .background(Color(red: Double(activityType.rawValue)/50.0, green: 1 - Double(activityType.rawValue)/50, blue: Double(activityType.rawValue)/50.0))
                .clipShape(Circle())
            Text(activityType.identifier)
            Spacer()
            Button(action: {
                        remove()
                    }) {
                        Image(systemName: "minus")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(10)
                            .frame(width: 30, height: 30)
                            .foregroundColor(.white)
                    }
                    .background(Color.blue)
                    .clipShape(Circle())
                    .padding()
        }
        .frame(height: 40)
        .contentShape(Rectangle()) //Makes sure the whole cell is tappable, even though it is transparent
        
    }
    
    
}
