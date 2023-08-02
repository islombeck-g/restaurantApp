import SwiftUI

struct EmployeerListView: View {
    let person: EmployeerStruct
    var body: some View {
        VStack{
            
        }
    }
}

struct EmployeerListView_Previews: PreviewProvider {
    static var previews: some View {
        EmployeerListView(person: EmployeerStruct(id: "", name: "Some Name", phone: "79001239323", position: "cashier" , email: "some@gmail.com", photoUrl: "user", bossEmail: "boss@gmail.com"))
    }
}
