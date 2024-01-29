import SwiftUI

struct IntroductionScreen: View {
    
    @EnvironmentObject private var authViewModel:AuthViewModel
    
    var body: some View {
        NavigationStack {
            Text("Hi guys, it should be interesting")
            Image("Bowl Icon")
            NavigationLink {
                AuthScreen()
                    .environmentObject(authViewModel)
            } label: {
                Text("go to auth")
            }
            Image("Chef Hat Icon")
                .frame(maxWidth: .infinity, alignment: .leading)
        }

        
    }
}

#Preview {
    IntroductionScreen()
        .environmentObject(AuthViewModel(userStateManager: UserManager.shared))
}
