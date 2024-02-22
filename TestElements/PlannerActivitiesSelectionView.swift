import SwiftUI

struct PlannerActivitiesQuestionView: View {
    @Binding var plannerActivitiesSelection: PlannerActivitiesSelection
    
    @State private var showSelection = false
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Button(action: {
                            // Action for the button
                            showSelection = true
                        }) {
                            Image(systemName: "plus") // System plus icon
                                .resizable() // Make the image resizable
                                .aspectRatio(contentMode: .fit) // Keep the aspect ratio
                                .padding(10) // Add some padding inside the button
                                .frame(width: 30, height: 30) // Size of the button
                                .foregroundColor(.white) // Color of the plus icon
                        }
                        .background(Color.blue) // Button background color
                        .clipShape(Circle())
                        .padding()
                Text("Add sports")
                    .font(.callout.bold())
                    .foregroundColor(.blue)
                Spacer()
            }
            List(Array(plannerActivitiesSelection.selectedActivities)) { item in
                ActivitySelectionCell(activityType: item)
                    .id(item.rawValue)
            }.listStyle(PlainListStyle())
        }
        .frame(height: 800)
        .fullScreenCover(isPresented: $showSelection) {
            PlannerActivitiesSelectionView(plannerActivitiesSelection: $plannerActivitiesSelection)
        }
    }
    
}

struct PlannerActivitiesSelectionView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var plannerActivitiesSelection: PlannerActivitiesSelection
    @State private var identifier = UUID()

    var body: some View {
        ZStack{
            Color.gray
            VStack{
                Group{
                    VStack{
                        Text("Select Sports")
                            .font(.callout.bold())
                            .padding()
                        List(KnownActivityType.allValues) { item in
                            ActivitySelectionCell(activityType: item)
                                .id(item.rawValue)
                                .onTapGesture {
                                    if plannerActivitiesSelection.selectedActivities.contains(item) {
                                        plannerActivitiesSelection.selectedActivities.remove(item)
                                    } else {
                                        plannerActivitiesSelection.selectedActivities.insert(item)
                                    }
                                    identifier = UUID()
                                }
                                .listRowBackground(plannerActivitiesSelection.selectedActivities.contains(item) ? Color.black.opacity(0.5) : Color.white)
                        }.listStyle(PlainListStyle())
                        
                        
                    }.background(Color.white) // Background color for the VStack
                }
                    .cornerRadius(10) // Rounded corners for the VStack
                    .padding()
                Spacer()
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Done")
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .background(.white)
                        .clipShape(Rectangle())
                        .cornerRadius(10)
                }.padding()
            }
        }
           
    }
}

struct ActivitySelectionCell: View {
    var activityType: KnownActivityType
    
    var body: some View {
        HStack{
            activityType.icon
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(10) // Add some padding inside the button
                .frame(width: 30, height: 30) // Size of the button
                .foregroundColor(.black)
                .background(Color(red: Double(activityType.rawValue)/50.0, green: 1 - Double(activityType.rawValue)/50, blue: Double(activityType.rawValue)/50.0))
                .clipShape(Circle())
            Text(activityType.identifier)
            Spacer()
        }
        .frame(height: 40)
        .contentShape(Rectangle()) //Makes sure the whole cell is tappable, even though it is transparent
        
    }
    
    
}

#Preview {
    PlannerActivitiesSelectionView(plannerActivitiesSelection: .constant(TrainingPlannerData.activitiesSelection1Example))
}
