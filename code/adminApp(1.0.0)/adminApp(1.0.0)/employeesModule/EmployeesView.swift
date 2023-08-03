import SwiftUI

struct EmployeesView: View {
    @State private var showAddView: Bool = false
    var body: some View {
        NavigationStack{
            ZStack(alignment: .bottomTrailing){
                List{
                    Section{
                        ForEach((1...10), id: \.self){ i in
                            EmployeerListView(person: EmployeerStruct(id: "", name: "testName", phone: "+79098889933", position: "cashier", email: "some@gmail.com", photoUrl: "user", bossEmail: "testBoss@gmail.com"))
                            
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
        .sheet(isPresented: $showAddView) {
            
        }
    }
}

struct EmployeeView_Previews: PreviewProvider {
    static var previews: some View {
        EmployeesView()
    }
}
