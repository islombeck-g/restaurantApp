import SwiftUI

struct AuthScreen: View {
    
    @EnvironmentObject var viewModel:AuthViewModel
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                VStack(spacing: 0) {
                    ZStack(alignment: .top) {
                        
                        Image("v1")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .frame(height: geometry.size.height/2.5)

                        Image("v2")
                            .resizable()
                            .scaledToFit()
                            .frame(height: geometry.size.height/2.5)
                            .padding(.top, 60)
                            .padding(.trailing, 70)
                        
                        Image("v3")
                            .resizable()
                            .scaledToFit()
                            .frame(height: geometry.size.height/2.5)
                            .frame(maxWidth: .infinity, alignment: .topLeading)
                        
                    }
                    .frame(height: geometry.size.height/2)
                    .padding(.top, -30)
                    
                    Group {
//                        VStack(spacing: 20) {
                            CustomTextField(name: "Email", text: self.$viewModel.email, isSecured: false)
                        
                        Spacer()
                            .frame(height: 20)
                        
                            CustomTextField(name: "Password", text: self.$viewModel.password, isSecured: true)
                            
//                        }
                    }
                    .padding(.horizontal, 32)
                    
                }
                
               
                
               
            }
            .ignoresSafeArea()
            
        }
    }
}

#Preview {
    AuthScreen()
        .environmentObject(AuthViewModel())
}

