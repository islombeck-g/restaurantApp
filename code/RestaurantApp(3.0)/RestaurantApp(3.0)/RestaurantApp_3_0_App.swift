//
//  RestaurantApp(3.0)
//
//  Created by Islombek Gofurov on 23/01/24.
//

import SwiftUI
import Firebase

@main
struct RestaurantApp_3_0_App: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var userStateManager:UserManager = UserManager.shared
    
    var body: some Scene {
        WindowGroup {
            
           MainView()
                .environmentObject(AuthViewModel(userStateManager: userStateManager))
        }
    }
}
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any ]? = nil) -> Bool {
        FirebaseApp.configure ()
        
        return true
    }
}
