import Foundation
import SwiftUI

extension Color {
    static var random: Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}

extension Image {
    
    static func getSafeImage(named: String) -> Image {
        
        let uiImage = UIImage(named: named) ?? UIImage(named: "unknown")
        return Image(uiImage: uiImage!)
    }
}


