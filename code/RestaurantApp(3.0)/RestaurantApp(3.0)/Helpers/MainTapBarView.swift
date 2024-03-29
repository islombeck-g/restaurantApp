import SwiftUI

struct MainTapBarView: View {
    
    var userStateManager:UserManager = UserManager.shared
    
    @EnvironmentObject var customNavigation:CustomNavigationStack
    
    var body: some View {
//        NavigationStack {
            ZStack {
                VStack {
                    TabView(selection: $customNavigation.selectedTab) {
                        
                        MenuScreen()
                            .tag(TabCustom.menu)
                        
                        ProductsScreen()
                            .tag(TabCustom.cube)
                        
                        EmployeesScreen()
                            .tag(TabCustom.person)
                    }
                }
                
                if customNavigation.showCustomTapbar {
                    CustomTabBar(selectedTab: $customNavigation.selectedTab)
                        .frame(maxHeight: .infinity, alignment: .bottom)
                }       
            }
//        }
    }
}

#Preview {
    MainTapBarView()
        .environmentObject(CustomNavigationStack())
}


enum TabCustom: String, CaseIterable {
    case cube = "cube.box"
    case menu = "menucard"
    case person = "person.3"
}

struct CustomTabBar: View {
    
    @Binding var selectedTab: TabCustom
    private var fillImage: String {
        selectedTab.rawValue + ".fill"
    }
    var body: some View {
        VStack {
            HStack {
                ForEach (TabCustom.allCases, id: \.rawValue) { tab in
                    Spacer()
                    Image(systemName:  selectedTab == tab ? fillImage : tab.rawValue)
                        .scaleEffect(selectedTab == tab ? 1.55: 1.15)
                        .padding()
                        .foregroundStyle(selectedTab == tab ? Color("darkGreen"): .green)
                        .onTapGesture {
                            withAnimation {
                                selectedTab = tab
                            }
                        }
                    Spacer()
                }
            }
            .frame(height: 60)
            .background(.thinMaterial)
            .clipShape(.rect(cornerRadius: 8))
            .padding()
        }
    }
}
