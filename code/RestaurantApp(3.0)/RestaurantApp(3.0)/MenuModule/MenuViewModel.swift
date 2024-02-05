import Foundation

class MenuViewModel: ObservableObject {
    
    @Published var dishes = ""
    
    @Published var ingredients: [Product] = []
}
