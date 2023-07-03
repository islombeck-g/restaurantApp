//
//  main_ViewModel.swift
//  adminApp
//
//  Created by Islombek Gofurov on 03.07.2023.
//

import Foundation


final class MainViewModel:ObservableObject{
    
    
    
    func signOut()throws{
        try AuthManager.me.signOut()
    }
}
