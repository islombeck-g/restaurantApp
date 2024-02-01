import Foundation
import UIKit

struct Product:Identifiable, Hashable{
    let id: String
    var name:String
    var count:Int
    let price:Double
}

struct MarketProduct:Hashable, Encodable, Identifiable {
    let id: String
    let name: String
    var price: Double
}

enum ProductsAPIError {

    case serverError(String)
    case userError(String)
    
    var description: String {
        switch self {
        case .serverError(let message):
            return message
        case .userError(let message):
            return message
        }
    }
}
