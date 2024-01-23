import SwiftUI

struct IntroductionScreen: View {
    
    @StateObject private var authViewModel:AuthViewModel = AuthViewModel()
    
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
}
