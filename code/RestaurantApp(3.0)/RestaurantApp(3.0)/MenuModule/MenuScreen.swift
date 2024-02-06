import SwiftUI

struct MenuScreen: View {
    
    @EnvironmentObject var viewModel: MenuViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView {
                
                NavigationLink {
                    CreateNewDishScreen()
                } label: {
                    Text("Create new dish")
                        .styleOne()
                }
            }
            .padding(.horizontal, 16)
            
            .toolbar {
                ToolbarItem(placement: .navigation) {
                    Text("Menu")
                        .styleMainText_30()
                }
            }
            .toolbar(.hidden, for: .tabBar)
        }
    }
}

#Preview {
    MenuScreen()
        .environmentObject(MenuViewModel())
}
