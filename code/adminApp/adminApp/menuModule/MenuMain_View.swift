
import SwiftUI

struct MenuMain_View: View {
    @StateObject private var viewModel = Menu_ViewModel()
    var body: some View {
        VStack{
            List{
                if self.viewModel.arrayOfMealIn.isEmpty{
                    Text("no meal")
                }else{
                    ForEach(self.viewModel.arrayOfMealIn, id: \.self){meal in
                        Text(meal.name)
                    }
                }
                
            }
        }
        .onAppear{
            self.viewModel.getMeal()
        }
        
    }
}

struct MenuMain_View_Previews: PreviewProvider {
    static var previews: some View {
        MenuMain_View()
    }
}
