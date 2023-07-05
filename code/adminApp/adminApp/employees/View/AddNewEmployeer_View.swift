
import SwiftUI
//import FirebaseDatabase
//import FirebaseDatabaseSwift
import FirebaseFirestore
struct Employeer:Identifiable{
    let id: String
    let name:String
    let phone:String
    let position:String
    let email:String
    let photoUrl:String?
    
    init(id: String, name: String, phone: String, position: String, email: String, photoUrl: String?) {
        self.id = id
        self.name = name
        self.phone = phone
        self.position = position
        self.email = email
        self.photoUrl = photoUrl
    }
}


final class Employees_ViewModel:ObservableObject{

    
    @Published var list = [Employeer]()
    
    @Published var name:String = ""
    @Published var phone:String = ""
    @Published var position:String = "cashier"
    @Published var email:String = "" 
    
    func get(){
        let db = Firestore.firestore()
        db.collection("employees").getDocuments{snapshot, error in
            if error == nil{
               
                if let snapshot = snapshot{
                    DispatchQueue.main.async {
                        self.list =  snapshot.documents.map{ i in
                            
                            return Employeer(id: i.documentID, name: i["name"] as! String , phone: i["phone"] as! String , position: i["position"] as! String , email:i["email"] as! String, photoUrl: i["photo"] as? String )
                        }
                    }
                }
            }else{
                print("error in FirebaseClass_ load\(String(describing: error))")
            }
            
        }
        
    }
    func add(){
        let db = Firestore.firestore()
        
        db.collection("employees").addDocument(data: ["name": self.name, "phone": self.phone, "position": self.position, "email": self.email, "photo": "defaultImage"]){ error in
            if error == nil{
                self.get()
            }else{
                print("error in addData \(String(describing: error))")
            }
            
        }
    }
    
    
  
    
}

enum positions{
    case cooker
    case cashier
}

struct AddNewEmployeer_View: View {
    @Environment(\.dismiss) var dismiss
    @StateObject
        private var viewModel = Employees_ViewModel()

    
    var body: some View {
        NavigationStack{
            VStack{
                TextField("Name", text: self.$viewModel.name)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 8).stroke(self.viewModel.name != "" ? .red: .gray, lineWidth: 2) )
                TextField("email", text: self.$viewModel.email)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 8).stroke(self.viewModel.email != "" ? .red: .gray, lineWidth: 2))
                TextField("phone", text: self.$viewModel.phone)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 8).stroke(self.viewModel.phone != "" ? .red: .gray, lineWidth: 2))
               
                Picker(selection: self.$viewModel.position, label: Text("Position")) {
                    Text("cashier").tag("cashier")
                    Text("cookier").tag("cookier")
                }
                .pickerStyle(.segmented)
                Button{
                    viewModel.add()
                    dismiss()
                }label: {
                    Text("Create employeer")
                        .foregroundColor(.blue)
                        .padding()
                    
                        .frame(width:  UIScreen.main.bounds.width - 50)
                        
                        .background(RoundedRectangle(cornerRadius: 8).fill(Color.gray))
                  
                    
                    
                }
                
                Spacer()
            }
            .padding(.all, 25)
            
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button{
                        dismiss()
                    }label: {
                        Image(systemName: "xmark")
                    }
                }
            }
            
        }
        .onTapGesture {}
        
        
    }
}

//struct AddNewEmployeer_View_Previews: PreviewProvider {
//    static var previews: some View {
//        AddNewEmployeer_View()
//    }
//}
