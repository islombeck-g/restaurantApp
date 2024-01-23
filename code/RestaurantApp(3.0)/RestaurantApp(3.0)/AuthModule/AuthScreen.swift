import SwiftUI

struct AuthScreen: View {
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
                    
                    
                }
                
               
                
               
            }
            .ignoresSafeArea()
            .background(.red)
        }
    }
}

#Preview {
    AuthScreen()
}

