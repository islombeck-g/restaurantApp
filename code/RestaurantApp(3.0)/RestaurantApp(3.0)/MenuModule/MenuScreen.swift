import SwiftUI

struct MenuScreen: View {
    
    @EnvironmentObject var viewModel: MenuViewModel
    @State private var isHeroAnimation:Bool = true
    var body: some View {
        NavigationStack {
            if !isHeroAnimation {
                HStack {
                    Text("Menu")
                        .styleMainText_30()
                }
            }
            VStack {
            ScrollView {
                    ForEach(0..<self.viewModel.dishes.count, id:\.self) { index in
                        GeometryReader { geometry in
                        MenuDetailListView(dish: self.$viewModel.dishes[index])
                            .offset(y: self.viewModel.dishes[index].isExpanded ? -geometry.frame(in: .global).minY: 0)
                            .opacity(self.isHeroAnimation ? (self.viewModel.dishes[index].isExpanded ? 1 : 0) : 1)
                            .padding(.horizontal, self.viewModel.dishes[index].isExpanded ? 0 : 16)
                            
                            .onTapGesture {
//                                if !self.isHeroAnimation {
                                    withAnimation(.easeInOut(duration: 0.5)) {
                                        self.viewModel.dishes[index].isExpanded.toggle()
                                        self.isHeroAnimation.toggle()
                                    }
//                                }
                                
                                
                            }
                        }
                        .frame(height: self.viewModel.dishes[index].isExpanded ? UIScreen.main.bounds.height : 160)
                        .simultaneousGesture(
                            DragGesture(minimumDistance: self.viewModel.dishes[index].isExpanded ? 0 : 110).onChanged({ (_) in
                                print("dragging")
                            })
                        )
//                        Divider()
                }
                NavigationLink {
                    CreateNewDishScreen()
                } label: {
                    Text("Create new dish")
                        .styleOne()
                        .padding(.horizontal, 16)
                }
                
            }
           
            
        }
        }
    }
}

#Preview {
    MenuScreen()
        .environmentObject(MenuViewModel())
}
