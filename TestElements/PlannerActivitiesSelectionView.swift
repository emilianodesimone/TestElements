import SwiftUI

struct PlannerActivitiesSelectionView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var plannerActivitiesSelection: PlannerActivitiesSelection

    var body: some View {
        ZStack{
            Color.gray
            VStack{
                Group{
                    VStack{
                        Text("Select Sports")
                            .font(.callout.bold())
                            .padding()
                        ScrollView {
                            LazyVStack{
                                Section(header: CustomSectionHeader(title: "Popular")) {
                                    ForEach(KnownActivityType.popular) { item in
                                        ActivitySelectionCell(activityType: item, isSelected: plannerActivitiesSelection.selectedActivities.contains(item))
                                            .id(item.rawValue)
                                            .onTapGesture {
                                                if plannerActivitiesSelection.selectedActivities.contains(item) {
                                                    plannerActivitiesSelection.selectedActivities.removeAll(where: { $0 == item })
                                                } else {
                                                    plannerActivitiesSelection.selectedActivities.append(item)
                                                }
                                            }
                                            .background(plannerActivitiesSelection.selectedActivities.contains(item) ? Color.black.opacity(0.3) : Color.white)
                                    }
                                }
                                Section(header: CustomSectionHeader(title: "All")) {
                                    ForEach(KnownActivityType.allValues) { item in
                                        ActivitySelectionCell(activityType: item, isSelected: plannerActivitiesSelection.selectedActivities.contains(item))
                                            .id(item.rawValue)
                                            .onTapGesture {
                                                if plannerActivitiesSelection.selectedActivities.contains(item) {
                                                    plannerActivitiesSelection.selectedActivities.removeAll(where: { $0 == item })
                                                } else {
                                                    plannerActivitiesSelection.selectedActivities.append(item)
                                                }
                                            }
                                            .background(plannerActivitiesSelection.selectedActivities.contains(item) ? Color.black.opacity(0.3) : Color.white)
                                    }
                                }
                                
                                
                            }
                        }
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

struct CustomSectionHeader: View {
    var title: String

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .padding(.bottom, 5)
            Divider()
        }
        .padding(.horizontal)
    }
}

struct ActivitySelectionCell: View {
    var activityType: KnownActivityType
    var isSelected: Bool
    
    var body: some View {
        HStack{
            activityType.icon
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(10)
                .frame(width: 40, height: 40)
            Text(activityType.identifier)
            Spacer()
        }
        .foregroundColor(isSelected ? .blue : .black)
        .frame(height: 40)
        .contentShape(Rectangle()) //Makes sure the whole cell is tappable, even though it is transparent
        
    }
    
    
}

#Preview {
    PlannerActivitiesSelectionView(plannerActivitiesSelection: TrainingPlannerData.activitiesSelection1Example)
}
