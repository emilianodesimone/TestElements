import SwiftUI

struct PlannerActivitiesSelectionView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var plannerActivitiesSelection: PlannerActivitiesSelection

    var body: some View {
        ZStack{
            Color.gray.ignoresSafeArea()
            VStack{
                Group{
                    VStack{
                        Text("Select Sports")
                            .font(.callout.bold())
                            .padding()
                        ScrollView {
                            LazyVStack(spacing: 0){
                                ActivitySelectionSection(plannerActivitiesSelection: plannerActivitiesSelection, activities: KnownActivityType.popular, title: "popular")
                                ActivitySelectionSection(plannerActivitiesSelection: plannerActivitiesSelection, activities: KnownActivityType.allValues, title: "All")
                            }
                        }
                    }.background(Color.white)
                        
                }.cornerRadius(10)
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
                }
            }.padding()
        }
           
    }
}

struct ActivitySelectionSection: View {
    @ObservedObject var plannerActivitiesSelection: PlannerActivitiesSelection
    var activities: [KnownActivityType]
    var title: String
    
    var body: some View {
        Section(header: CustomSectionHeader(title: title)) {
            ForEach(activities) { item in
                ActivitySelectionCell(activityType: item, isSelected: plannerActivitiesSelection.selectedActivities.contains(item))
                    .id(item.rawValue)
                    .onTapGesture {
                        if plannerActivitiesSelection.selectedActivities.contains(item) {
                            plannerActivitiesSelection.selectedActivities.removeAll(where: { $0 == item })
                        } else {
                            plannerActivitiesSelection.selectedActivities.append(item)
                        }
                    }
                    .frame(height: 60)
                    .background(plannerActivitiesSelection.selectedActivities.contains(item) ? Color.black.opacity(0.3) : Color.white)
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
