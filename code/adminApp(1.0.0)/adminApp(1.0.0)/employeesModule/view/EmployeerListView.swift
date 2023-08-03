import SwiftUI

struct EmployeerListView: View {
    let person: EmployeerStruct
    var body: some View {
        HStack{
            
            Image(person.photoUrl ?? "user")
                .resizable()
                .frame(width: 50, height: 50)
            VStack{
                HStack{
                    Spacer()
                        .frame(width: 20)
                    Text(person.name)
                    Spacer()
                    Divider()
                    Text(person.position)
                }
                
                
            }
            
            
        }
    }
}

struct EmployeerListView_Previews: PreviewProvider {
    static var previews: some View {
        EmployeerListView(person: EmployeerStruct(id: "", name: "Some Name", phone: "79001239323", position: "cashier" , email: "some@gmail.com", photoUrl: "user", bossEmail: "boss@gmail.com"))
    }
}
