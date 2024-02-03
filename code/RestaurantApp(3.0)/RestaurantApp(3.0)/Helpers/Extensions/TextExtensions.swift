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
    
    func styleOneWithCustomFont() -> some View {
        self
            .font(.custom("GillSans-Bold", size: 20))
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color("darkGreen"))
            .clipShape(.rect(cornerRadius: 8))
//            .padding(.vertical)
//            .bold()
    }
    func styleMainText_30() -> some View {
        self
            .font(.custom("GillSans-Bold", size: 30))
            .foregroundStyle(.darkGreen)
    }
    func styleMainText_20() -> some View {
        self
            .font(.custom("GillSans-Bold", size: 20))
            .foregroundStyle(.darkGreen)
    }
    func styleMainText_25() -> some View {
        self
            .font(.custom("GillSans-Bold", size: 25))
            .foregroundStyle(.darkGreen)
    }
    func styleMainText_10() -> some View {
        self
            .font(.custom("GillSans-Bold", size: 10))
            .foregroundStyle(.darkGreen)
    }
}

