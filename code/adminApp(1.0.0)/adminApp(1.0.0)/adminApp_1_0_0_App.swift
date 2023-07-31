import SwiftUI
import Firebase
@main
struct adminApp_1_0_0_App: App {
    @UIApplicationDelegateAdaptor (AppDelegate.self) var delegate
    @StateObject var authViewModel = AuthViewModel()
    var body: some Scene {
        WindowGroup {
            
            rootView()
                .environmentObject(authViewModel)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any ]? = nil) -> Bool {
        FirebaseApp.configure ()
        
        return true
    }
}
