
import SwiftUI

struct MenuMain_View: View {
    @StateObject private var viewModel = Menu_ViewModel()
    @State private var showAddMealSheetView = false
    @State private var selectedMealForShow: Meal? = nil
    @State var shouldScroll: Bool = true
    var body: some View {
        NavigationStack {
           
            ZStack (alignment: .bottom) {
                ScrollView {
//                    .disabled(true)
                    if self.viewModel.arrayOfMealIn.isEmpty {
                        Text ("no meal")
                    } else {
                        ForEach (self.viewModel.arrayOfMealIn, id: \.self) {meal in
                            MenuId_View(meal: meal, haveOfNot: self.viewModel.checkProduct (me: meal.products))
                                .onTapGesture {
                                    self.selectedMealForShow = meal
                                    print("button tapped")
                                }
                        }
                    }
                }
                .environment(\.isScrollEnabled, shouldScroll)

                Button {
                    self.showAddMealSheetView.toggle()
                } label: {
                    Text ("Создать новое блюдо")
                }
                .buttonStyle (.bordered)
            }
            
            
            .navigationTitle ("Меню")
        }
        .onAppear {
            self.viewModel.getMeal()
        }
        .sheet (isPresented: self.$showAddMealSheetView) {
            AddMealSheet_View()
                .environmentObject (viewModel)
                .onDisappear {
                    self.viewModel.getMeal()
                }
        }
        .sheet (item: self.$selectedMealForShow, content: {meal in
            MenuIdSheet_View(meal: meal, haveOfNot: self.viewModel.checkProduct(me: meal.products))
        })
        
    }
    
}

struct MenuMain_View_Previews: PreviewProvider {
    static var previews: some View {
        MenuMain_View()
    }
}




//
//
//
//import SwiftUI
//
//struct MenuMain_View: View {
//    @StateObject private var viewModel = Menu_ViewModel()
//    @State private var showAddMealSheetView = false
//    var body: some View {
//        NavigationStack{
//        ZStack(alignment: .bottom){
//            List{
//                if self.viewModel.arrayOfMealIn.isEmpty{
//                    Text("no meal")
//                }else{
//                    ForEach(self.viewModel.arrayOfMealIn, id: \.self){meal in
//                        MenuId_View(meal: meal)
//                    }
//                }
//            }
//            Button{
//                self.showAddMealSheetView.toggle()
//            }label: {
//                Text("Создать новое блюдо")
//            }
//            .buttonStyle(.bordered)
//        }
//    }
//        .onAppear{
//            self.viewModel.getMeal()
//        }
//        .sheet(isPresented: self.$showAddMealSheetView){
//            AddMealSheet_View()
//                .environmentObject(viewModel)
//        }
//    }
//}
//
//struct MenuMain_View_Previews: PreviewProvider {
//    static var previews: some View {
//        MenuMain_View()
//    }
//}
