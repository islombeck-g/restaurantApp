import SwiftUI

struct IntroductionScreen: View {
    
    @EnvironmentObject private var authViewModel:AuthViewModel
    
    var body: some View {
        NavigationStack {
            Text("Hi guys, it should be interesting")
            NavigationLink {
                AuthScreen()
                    .environmentObject(authViewModel)
            } label: {
                Text("go to auth")
            }
        }

        
    }
}

#Preview {
    IntroductionScreen()
        .environmentObject(AuthViewModel(userStateManager: UserManager.shared))
}
