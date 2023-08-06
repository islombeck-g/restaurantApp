import SwiftUI

struct EmployeesView: View {
    @State private var showAddView: Bool = false
    @State private var showEmployeerIdCart: Bool = false
    @State private var selectedEmployeer: EmployeerStruct?
    @EnvironmentObject var viewModel: EmployeeViewModel
    var body: some View {
        NavigationStack{
            ZStack(alignment: .bottomTrailing){
                List{
                    Section{
                        if self.viewModel.employeesArray.count > 0 {
                            ForEach(self.viewModel.employeesArray){ i in
                                EmployeerListView(person: i)
                                    .onTapGesture {
                                        self.selectedEmployeer = i
                                    }
                                
                            }
                            
                        }else{
                            Text("Работников пока нет(")
                        }
                       
                    }
                }
                Button{
                    self.showAddView.toggle()
                }label: {
                    Image(systemName: "plus")
                        .frame(width: 50, height: 50)
                        .foregroundColor(.white)
                        .background(Color.black)
                        .font(.system(size: 25))
                        .cornerRadius(50)
                    
                }
                .offset(x: -25, y: -10)
            }
            
        }
        .onAppear{
            self.viewModel.getEmployees()
        }
        .sheet(isPresented: $showAddView) {
            EmployeerAddView()
                .environmentObject(self.viewModel)
                .presentationDetents([.medium])
        }
        .sheet(item: $selectedEmployeer) { employeer in
            EmployyeeIDView(employee: employeer)
                .environmentObject(viewModel)
                .presentationDetents([.medium])
        }
        
    }
        
}

struct EmployeeView_Previews: PreviewProvider {
    static var previews: some View {
        EmployeesView()
            .environmentObject(EmployeeViewModel())
    }
}
