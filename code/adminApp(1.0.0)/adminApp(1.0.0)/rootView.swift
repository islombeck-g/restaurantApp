
import SwiftUI

struct rootView: View {
    @State private var authed:Bool = false
    @StateObject var authViewModel = AuthViewModel()
    var body: some View {
        NavigationStack{
            if authed{
                
            }else{
                LogInView()
                    .environmentObject(authViewModel)
            }
        }
    }
}

struct rootView_Previews: PreviewProvider {
    static var previews: some View {
        rootView()
    }
}
