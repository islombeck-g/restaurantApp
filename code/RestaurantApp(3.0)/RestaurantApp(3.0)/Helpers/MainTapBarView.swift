//
//  MainTabBarView.swift
//  RestaurantApp(3.0)
//
//  Created by Islombek Gofurov on 24/01/24.
//

import SwiftUI

struct MainTapBarView: View {
    var userStateManager:UserManager = UserManager.shared
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("main tap")
                Button("logOut"){
                    self.userStateManager.signOut()
                    print("--------")
                }
            }
        }
        
    }
}

#Preview {
    MainTapBarView()
}
