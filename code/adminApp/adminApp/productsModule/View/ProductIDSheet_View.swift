//
//  ProductIDSheet_View.swift
//  adminApp
//
//  Created by Islombek Gofurov on 07.07.2023.
//

import SwiftUI

struct ProductIDSheet_View: View {
    var product:Product
    var body: some View {
        VStack{
            List{
              
            }
            
        }
    }
}

struct ProductIDSheet_View_Previews: PreviewProvider {
    static var previews: some View {
        ProductIDSheet_View(product: Product(id: "", name: "картошка", count: 1, price: 1))
    }
}
