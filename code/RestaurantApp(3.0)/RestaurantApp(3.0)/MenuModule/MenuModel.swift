import Foundation
import UIKit

struct Dish {
    
    var id: String // 16
    var name:String // 16
    var price:Double // 16
    var description:String? // 16
    var imageUrls:[String] //16
    var stars:Double // 16
    var products:[Product] // 42
    var gm:Int16 // 2 байта
    var kcal:Int16 // 2
    var category:DishCategory // 1
    
}

enum DishCategory: String, CaseIterable {
    case appetizer = "appetizer" //закуски
    case soup = "soup" //супы
    case salad = "salad"
    case mainCourse = "main_course"
    case sideDish = "side_dish" //гарнир
    case dessert = "dessert"
    case beverage = "beverage" //напиток
    case breakfast = "breakfast"
    case brunch = "brunch"
    case sandwich = "sandwich" //бутерброд
    case pizza = "pizza"
    case pasta = "pasta"
    case seafood = "seafood" //морепродукты
    case vegan = "vegan"
    case glutenFree = "gluten_free"
    case comfortFood = "comfort_food" //домашняя_кухня
    case international = "international"
    case barbecue = "barbecue"
    case snack = "snack"
    case fusion = "fusion" //перекус
}
