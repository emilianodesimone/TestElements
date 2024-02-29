import SwiftUI

struct PlannerCancelView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack{
            Color.gray.ignoresSafeArea()
            
            VStack{
                Spacer()
                VStack(spacing: 16){
                    Text("Stop your consultation with the Suunto AI Coach.")
                        .font(.callout.bold())
                        .multilineTextAlignment(.center)
                    Text("If you cancel, this conversation won’t be saved.")
                        .font(.callout)
                        .multilineTextAlignment(.center)
                    Button {
                        
                    } label: {
                        Text("Cancel consultation")
                            .frame(height: 50)
                            .frame(maxWidth: .infinity)
                            
                            .foregroundColor(.red)
                            .clipShape(Rectangle())
                            .cornerRadius(10)
                    }
                }
                .padding()
                .background(.white)
                .cornerRadius(10)
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Go Back")
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

#Preview {
    PlannerCancelView()
}
