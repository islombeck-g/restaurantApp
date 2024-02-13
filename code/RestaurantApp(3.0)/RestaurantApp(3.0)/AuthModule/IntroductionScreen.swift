import SwiftUI

struct IntroductionScreen: View {
    
    @EnvironmentObject private var authViewModel:AuthViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                GeometryReader { geometry in
                    Image("intro_0")
                        .resizable()
                        .scaledToFill()
                    
                    VStack {
                        Text("It will be interesting \nlet's start")
                            .styleMainText_25_black()
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.white)
                            .position(x: geometry.size.width/2, y: geometry.size.height/2)
                        
                        NavigationLink {
                            AuthScreen()
                                .environmentObject(authViewModel)
                        } label: {
                            Text("Go to auth")
                                .foregroundStyle(.white)
                                .styleMainText_20_black()
                        }
                        .position(x: geometry.size.width/2, y: geometry.size.height/2.5)
                    }
                }
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    IntroductionScreen()
        .environmentObject(AuthViewModel(userStateManager: UserManager.shared))
}
