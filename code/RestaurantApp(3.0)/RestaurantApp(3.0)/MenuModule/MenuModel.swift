import Foundation
import UIKit

struct Dish {
    
    var id: String // 16
    var name:String // 16
    var price:Double // 16
    var description:String? // 16
    var imageUrls:String? //16
    var stars:Double // 16
    var products:[Product] // 42
    var gm:Int16 // 2 байта
    var kcal:Int16 // 2
    var category:String // 1
    var image:UIImage?
}

enum DishCategory:String, CaseIterable {
    
    case appetizer = "Appetizer"      // закуски
    case soup = "Soup"                // супы
    case salad = "Salad"
    case mainCourse = "Main Course"
    case sideDish = "Side Dish"       // гарнир
    case dessert = "Dessert"
    case beverage = "Beverage"        // напиток
    case breakfast = "Breakfast"
    case brunch = "Brunch"
    case sandwich = "Sandwich"        // бутерброд
    case pizza = "Pizza"
    case pasta = "Pasta"
    case seafood = "Seafood"          // морепродукты
    case vegan = "Vegan"
    case glutenFree = "Gluten-Free"
    case comfortFood = "Comfort Food" // домашняя кухня
    case international = "International"
    case barbecue = "Barbecue"
    case snack = "Snack"
    case fusion = "Fusion"            // перекус
    case some = "Some"
}

