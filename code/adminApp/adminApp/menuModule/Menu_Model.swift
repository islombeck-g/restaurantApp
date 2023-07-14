
import Foundation

struct MealProduct:Hashable{
    let countOfProduct:Int
    let nameOfProduct:String
    var haveOrNot: Bool
}

struct Meal:Hashable, Identifiable{
    let id:String
    let name:String
    let icon:String
    let products:[MealProduct]
}


struct MealImage:Hashable{
    let name:String
    let url:String

}


let imageList = [
    MealImage(name: "бургер и кола", url: ""),
    MealImage(name: "гамбургер", url: ""),
    MealImage(name: "греческий салат", url: ""),
    MealImage(name: "иранский кебаб", url: ""),
    MealImage(name: "картошка фри", url: ""),
    MealImage(name: "кебаб", url: ""),
    MealImage(name: "лапша", url: ""),
    MealImage(name: "овощи на гриле", url: ""),
    MealImage(name: "овощной бургер", url: ""),
    MealImage(name: "овощной микс", url: ""),
    MealImage(name: "овощной шашлык", url: ""),
    MealImage(name: "пельмени", url: ""),
    MealImage(name: "пицца 4 сезона", url: ""),
    MealImage(name: "соусы", url: ""),
    MealImage(name: "стейк из котлеты", url: ""),
    MealImage(name: "стейк из ребрышек", url: ""),
    MealImage(name: "стейк", url: ""),
    MealImage(name: "суши с креветками", url: ""),
    MealImage(name: "суши с лососем", url: ""),
    MealImage(name: "тако", url: ""),
    MealImage(name: "татарский суп", url: ""),
    MealImage(name: "уйгурский лагман", url: "")
]
