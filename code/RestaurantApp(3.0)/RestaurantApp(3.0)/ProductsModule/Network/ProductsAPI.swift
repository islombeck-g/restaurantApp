import Foundation
import FirebaseFirestore

final class ProductsAPI:ObservableObject {
    
    let db = Firestore.firestore().collection("Products")
    
 
    func push(product: Product) {
        
        
    }
}

//MARK: for download productList
//func forOne() {
//    let productCollection = Firestore.firestore().collection("Products")
//
//    for i in ConstProducts {
//        print("Processing product \(i.name)")
//        do {
//            // Create a reference to a new document with a random id
//            let newProductRef = productCollection.document()
//            // Set the data of the new document with the product name, price and id
//            try newProductRef.setData(from: Products(id: newProductRef.documentID, name: i.name, price: i.price), merge: false)
//        } catch let error {
//            print("Error updating document for product \(i.name): \(error)")
//        }
//    }
//}
//let ConstProducts = [
//    Products(id: "P001", name: "Apple", price: 0.99),
//    Products(id: "P002", name: "Banana", price: 0.79),
//    Products(id: "P003", name: "Carrot", price: 0.59),
//    Products(id: "P004", name: "Date", price: 1.29),
//    Products(id: "P005", name: "Egg", price: 0.19),
//    Products(id: "P006", name: "Flour", price: 2.49),
//    Products(id: "P007", name: "Grape", price: 2.99),
//    Products(id: "P008", name: "Honey", price: 4.99),
//    Products(id: "P009", name: "Ice cream", price: 3.49),
//    Products(id: "P010", name: "Jam", price: 2.99),
//    Products(id: "P011", name: "Kiwi", price: 0.99),
//    Products(id: "P012", name: "Lemon", price: 0.49),
//    Products(id: "P013", name: "Milk", price: 1.99),
//    Products(id: "P014", name: "Noodle", price: 1.49),
//    Products(id: "P015", name: "Olive", price: 3.99),
//    Products(id: "P016", name: "Peanut", price: 2.49),
//    Products(id: "P017", name: "Quinoa", price: 4.99),
//    Products(id: "P018", name: "Rice", price: 1.99),
//    Products(id: "P019", name: "Salmon", price: 9.99),
//    Products(id: "P020", name: "Tomato", price: 0.99),
//    Products(id: "P021", name: "Udon", price: 2.99),
//    Products(id: "P022", name: "Vanilla", price: 3.99),
//    Products(id: "P023", name: "Butter", price: 2.99),
//    Products(id: "P024", name: "Xylitol", price: 5.99),
//    Products(id: "P025", name: "Yogurt", price: 1.99),
//    Products(id: "P026", name: "Zucchini", price: 1.49),
//    Products(id: "P027", name: "Bread", price: 2.49),
//    Products(id: "P028", name: "Cheese", price: 3.99),
//    Products(id: "P029", name: "Butter", price: 2.99),
//    Products(id: "P030", name: "Sugar", price: 1.49),
//    Products(id: "P031", name: "Salt", price: 0.99),
//    Products(id: "P032", name: "Pepper", price: 1.99),
//    Products(id: "P033", name: "Coffee", price: 4.99),
//    Products(id: "P034", name: "Tea", price: 3.99),
//    Products(id: "P035", name: "Water", price: 0.99),
//    Products(id: "P036", name: "Juice", price: 2.99),
//    Products(id: "P037", name: "Soda", price: 1.99),
//    Products(id: "P038", name: "Beer", price: 3.99),
//    Products(id: "P039", name: "Wine", price: 9.99)]
