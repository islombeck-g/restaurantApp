

import Foundation


struct Product:Identifiable{
    let id: String?
    let name:String
    let count:Int
    let price:Int
    
}

enum productNames:String{
    case a = "картошка"
    case b = "баклажан"
    case c = "говядина"
    case d = "горох"
    case e = "индюк"
    case f = "капуста"
    case g = "кетчуп"
    case h = "кукуруза"
    case i = "куриные ножки"
    case j = "курица"
    case k = "светлый лук"
    case l = "красный лук"
    case m = "майонез"
    case n = "морковь"
    case o = "огурец"
    case p = "оливковое масло"
    case q = "подсолнечное масло"
    case r = "помидор"
    case s = "ребрышко"
    case t = "рис"
    case u = "рыба"
    case v = "яйца"
    case w = "сливочное масло"
    case x = "соевый соус"
    case y = "сосиски"
    case z = "спагетти"
}
