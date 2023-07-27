import SwiftUI
import Firebase
@main
struct adminApp_1_0_0_App: App {
    @UIApplicationDelegateAdaptor (AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            
            rootView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any ]? = nil) -> Bool {
        FirebaseApp.configure ()
        
        return true
    }
}
