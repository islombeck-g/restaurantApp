

import Foundation


struct Product:Identifiable, Hashable{
    let id: String?
    var name:String
    var count:Int
    let price:Double
    
    init(id: String, name: String, count: Int, price: Double) {
            self.id = id
            self.name = name
            self.count = count
            self.price = price
        }
    
}

//enum productNames:String, CaseIterable{
//
//    case a = "картошка"
//    case b = "баклажан"
//    case c = "говядина"
//    case d = "горох"
//    case e = "индюк"
//    case f = "капуста"
//    case g = "кетчуп"
//    case h = "кукуруза"
//    case i = "куриные ножки"
//    case j = "курица"
//    case k = "светлый лук"
//    case l = "красный лук"
//    case m = "майонез"
//    case n = "морковь"
//    case o = "огурец"
//    case p = "оливковое масло"
//    case q = "подсолнечное масло"
//    case r = "помидор"
//    case s = "ребрышко"
//    case t = "рис"
//    case u = "рыба"
//    case v = "яйца"
//    case w = "сливочное масло"
//    case x = "соевый соус"
//    case y = "сосиски"
//    case z = "спагетти"
//}


struct Products:Hashable {
    let name: String
    var price: Double
}

let ProductsArray = [
    Products(name: "картошка", price: 4.1),
    Products(name: "баклажан", price: 23.4),
    Products(name: "говядина", price: 70.0),
    Products(name: "горох", price: 12.3),
    Products(name: "индюк", price: 50.4),
    Products(name: "капуста", price: 3.2),
    Products(name: "кетчуп", price: 24.1),
    Products(name: "кукуруза", price: 10.79),
    Products(name: "куриные ножки", price: 21.53),
    Products(name: "курица", price: 40.99),
    Products(name: "светлый лук", price: 6.79),
    Products(name: "красный лук", price: 8.89),
    Products(name: "майонез", price: 24.1),
    Products(name: "морковь", price: 5.7),
    Products(name: "огурец", price: 23.4),
    Products(name: "оливковое масло", price: 31.99),
    Products(name: "подсолнечное масло", price: 22.99),
    Products(name: "помидор", price: 9.01),
    Products(name: "ребрышко", price: 90.99),
    Products(name: "рис", price: 12.49),
    Products(name: "рыба", price: 38.99),
    Products(name: "яйца", price: 8.99),
    Products(name: "сливочное масло", price: 14.99),
    Products(name: "соевый соус", price: 15.99),
    Products(name: "сосиски", price: 23.49),
    Products(name: "спагетти", price: 10.99),
    Products(name: "булочка", price: 10),
    Products(name: "гранат", price: 20),
    Products(name: "лимон", price: 30),
    Products(name: "майонез", price: 150),
    Products(name: "хлеб", price: 10),
    Products(name: "шоколад", price: 10),
    Products(name: "яйца", price: 11)
]
