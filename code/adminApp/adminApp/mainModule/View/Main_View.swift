//
//  main_View.swift
//  adminApp
//
//  Created by Islombek Gofurov on 03.07.2023.
//

import SwiftUI

struct Main_View: View {
    @StateObject private var viewModel = MainViewModel()
    @Binding var authView:Bool
    var body: some View {
        List{
            Button{
                do{
                    try self.viewModel.signOut()
                    authView.toggle()
                }catch{
                    
                }
            }label: {
                Text("logOut")
            }
        }
    }
}

struct main_View_Previews: PreviewProvider {
    @State static var me = true
    static var previews: some View {
        Main_View(authView: $me)
    }
}
