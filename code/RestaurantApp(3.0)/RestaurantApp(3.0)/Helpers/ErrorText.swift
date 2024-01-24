//
//  ErrorText.swift
//  RestaurantApp(3.0)
//
//  Created by Islombek Gofurov on 24/01/24.
//

import SwiftUI

struct ErrorText: View {
    let text:String
    var body: some View {
        Text(text)
            .foregroundStyle(.red)
            .padding()
            .background(Color.green.opacity(0.2))
            .clipShape(
                .rect(cornerRadius: 8)
            )
            
        
    }
}

#Preview {
    ErrorText(text: "someError")
}
