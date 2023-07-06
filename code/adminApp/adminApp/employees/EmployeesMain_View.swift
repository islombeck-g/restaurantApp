

import SwiftUI

struct EmployeesMain_View: View {
    @State private var showAddSheetView:Bool = false
    @State private var showEmployeeIDSheetView:Bool = false
    @ObservedObject private var viewModel = Employees_ViewModel()
    
    @State private var selectedEmployee: Employeer? = nil
    var body: some View {
        NavigationStack{
            ZStack(alignment: .bottomTrailing){
                List{
                    ForEach(self.viewModel.list){ employee in
                        EmployeeBanner_View(employee: employee)
                            .onTapGesture {
                                self.selectedEmployee = employee
                            }
                    }
                }
                Button{
                    self.showAddSheetView.toggle()
                }label: {
                    Image(systemName: "plus")
                        .frame(width: 50, height: 50)
                        .foregroundColor(.white)
                        .background(Color.black)
                        .font(.system(size: 25))
                        .cornerRadius(50)
                    
                } .offset(x: -20)
            }
        }
        .sheet(isPresented: $showAddSheetView,
               onDismiss: self.viewModel.get,
               content: {
            AddNewEmployeer_View()
                .interactiveDismissDisabled()
                .presentationDetents([.medium])
        })
        .sheet(item:  $selectedEmployee, onDismiss: self.viewModel.get){employee in
            EmployeeIDSheet_View(employee: employee, viewModel: viewModel)
                .presentationDetents([.medium])
                
        }
        
    }
    
    init(){
        self.viewModel.get()
    }
}







//struct EmployeesMain_View_Previews: PreviewProvider {
//    static var previews: some View {
//        EmployeesMain_View()
//    }
//}
