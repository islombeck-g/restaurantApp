
import Foundation

struct MealProduct:Hashable{
    let countOfProduct:Int
    let nameOfProduct:String
}

struct Meal:Hashable{
    let id:String
    let name:String
    let icon:String
    let products:[MealProduct]
}
