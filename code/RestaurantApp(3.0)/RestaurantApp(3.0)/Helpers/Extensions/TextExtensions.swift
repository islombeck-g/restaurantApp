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
    
    func styleMainText_10() -> some View {
        self
            .font(.custom("GillSans-Bold", size: 10))
            .foregroundStyle(.darkGreen)
    }
    func styleMainText_15() -> some View {
        self
            .font(.custom("GillSans-Bold", size: 15))
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
    func styleMainText_30() -> some View {
        self
            .font(.custom("GillSans-Bold", size: 30))
            .foregroundStyle(.darkGreen)
    }
    
    func styleMainText_10_black() -> some View {
        self
            .font(.custom("GillSans-Bold", size: 10))
    }
    func styleMainText_15_black() -> some View {
        self
            .font(.custom("GillSans-Bold", size: 15))
    }
    func styleMainText_20_black() -> some View {
        self
            .font(.custom("GillSans-Bold", size: 20))
    }
    func styleMainText_25_black() -> some View {
        self
            .font(.custom("GillSans-Bold", size: 25))
    }
    func styleMainText_30_black() -> some View {
        self
            .font(.custom("GillSans-Bold", size: 30))
    }
   
}

