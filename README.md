<h1 align="center">Админ панель приложения "Ресторан"</h1> 
<h2 align="leading">О проекте</h2> 
<h4 align="leading">Приложение представляет собой административную панель, предназначенную для управления сотрудниками, блюдами и продуктами. Разработано в соответствии с архитектурой MV+ с использованием языков Swift и SwiftUI, а также интегрировано с Firebase для хранения данных.</h4>

<h2 align="leading">Технологии</h2> 
 <ul>
  <li>Swift</li>
  <li>SwiftUI</li>
  <li>Firebase (Firebase Authentication, Firebase Firestore)</li>
 </ul>

<h2 align="leading">Функциональность</h2> 
<h3>1. Сотрудники</h3>
 <ul>
  <li>Добавление новых сотрудников</li>
  <li>Удаление сотрудников</li>
 </ul>
<h3>2. Блюда</h3>
 <ul>
  <li>Создание блюд с определенными характеристиками</li>
 </ul>
<h3>3. Продукты</h3>
 <ul>
  <li>Просмотр имеющихся продуктов</li>
  <li>Заказ новых продуктов для пополнения запасов</li>
 </ul>

<h2 align="leading">Пример структуры данных:</h2> 

```Swift
struct Product:Identifiable, Hashable{
    let id: String // 16
    var name:String // 16
    let price:Double // 8
    var count:Double // 8
}
```
```Swift
struct MarketProduct:Hashable, Encodable, Identifiable {
    let id: String // 16
    let name: String // 16
    var price: Double // 8
}
```
```Swift
struct Dish: Identifiable {
    var id: String // 16
    var name: String // 16
    var price: Double // 16
    var description: String // 16
    var imageUrls: String? //16
    var stars: Double // 16
    var products: [Product] // 42
    var gm: Int16 // 2 байта
    var kcal: Int16 // 2
    var category: String // 1
    var image: UIImage?
    var isExpanded: Bool = false
}
```
<h2 align="leading">Использование</h2> 
<p>Позже...</p>
<h3>Примеры</h3>
<p>Ниже приведены скриншоты приложения:</p>
<div class="screenshot-container">
 <img src="путь_к_изображению" alt="Скриншот приложения">
 <img src="путь_к_другому_изображению" alt="Еще один скриншот приложения">
</div>


    
