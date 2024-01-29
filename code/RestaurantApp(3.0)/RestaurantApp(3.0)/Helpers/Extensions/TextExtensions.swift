import Foundation
import SwiftUI

extension Text {
    func styleOne() -> some View {
        self
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color("darkGreen"))
            .clipShape(.rect(cornerRadius: 8))
            .padding(.vertical)
            .bold()
    }
}
