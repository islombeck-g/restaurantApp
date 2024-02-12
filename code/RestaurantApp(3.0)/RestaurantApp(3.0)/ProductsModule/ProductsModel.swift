import Foundation
import UIKit

struct Product:Identifiable, Hashable{
    let id: String // 16
    var name:String // 16
    let price:Double // 8
    var count:Double // 8
}

struct MarketProduct:Hashable, Encodable, Identifiable {
    let id: String //16
    let name: String // 16
    var price: Double // 8
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
