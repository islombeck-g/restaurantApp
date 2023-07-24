
import SwiftUI
struct MenuMain_View: View {
    @EnvironmentObject var viewModel:Menu_ViewModel
    @State private var showAddMealSheetView = false
    @State private var selectedMealForShow: Meal? = nil
    
    let columnsSize = [
       GridItem(.adaptive(minimum:170))
   ]
    
    var body: some View {
        NavigationStack {
            
            ZStack (alignment: .bottom) {
                
                ScrollView {
                    
                    if self.viewModel.arrayOfMeal.isEmpty{
                        
                        Text ("no meal")
                    } else {
                        LazyVGrid(columns: columnsSize, spacing: 10){
                            
                            ForEach(self.viewModel.arrayOfMeal , id: \.self) { meal in
                                
                                MenuId_View(meal: meal)
                                    .onTapGesture {
                                        self.selectedMealForShow = meal
                                        print("button tapped")
                                    }
                            }
                        }
                     
                    }
                }
                Button {
                    self.showAddMealSheetView.toggle()
                } label: {
                    Text ("Создать новое блюдо")
                }
                .buttonStyle (.bordered)
            }
            .navigationTitle ("Меню")
        }
        .onAppear{
            self.viewModel.getMeal()
        }
        .sheet (isPresented: self.$showAddMealSheetView) {
            AddMealSheet_View()
                .environmentObject (viewModel)
                .onDisappear {
                }
        }
        .sheet (item: self.$selectedMealForShow, content: {meal in
            MenuIdSheet_View(meal: meal)
        })
    }
}

struct MenuMain_View_Previews: PreviewProvider {
    static var previews: some View {
        let menuViewModel = Menu_ViewModel()
        MenuMain_View()
            .environmentObject(menuViewModel)
    }
}
//
//
//import SwiftUI
//struct MenuMain_View: View {
//    @EnvironmentObject var viewModel:Menu_ViewModel
//    @State private var showAddMealSheetView = false
//    @State private var selectedMealForShow: Meal? = nil
//    var body: some View {
//        NavigationStack {
//
//            ZStack (alignment: .bottom) {
//                ScrollView {
//                    if self.viewModel.arrayOfMeal.isEmpty{
//                        Text ("no meal")
//                    } else {
//                        ForEach(self.viewModel.arrayOfMeal , id: \.self){meal in
//                            MenuId_View(meal: meal)
//                                .onTapGesture {
//                                    self.selectedMealForShow = meal
//                                    print("button tapped")
//                                }
//                        }
//                    }
//                }
//                Button {
//                    self.showAddMealSheetView.toggle()
//                } label: {
//                    Text ("Создать новое блюдо")
//                }
//                .buttonStyle (.bordered)
//            }
//            .navigationTitle ("Меню")
//        }
//        .onAppear{
//            self.viewModel.getMeal()
//        }
//        .sheet (isPresented: self.$showAddMealSheetView) {
//            AddMealSheet_View()
//                .environmentObject (viewModel)
//                .onDisappear {
//                }
//        }
//        .sheet (item: self.$selectedMealForShow, content: {meal in
//            MenuIdSheet_View(meal: meal)
//        })
//    }
//}
//
//struct MenuMain_View_Previews: PreviewProvider {
//    static var previews: some View {
//        let menuViewModel = Menu_ViewModel()
//        MenuMain_View()
//            .environmentObject(menuViewModel)
//    }
//}
