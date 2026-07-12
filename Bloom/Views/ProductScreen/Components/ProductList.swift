//
//  ProductList.swift
//  Bloom
//
//  Created by Ananda Rachmawati Purwanto on 03/07/26.
//
import SwiftUI

struct ProductList: View {

    let products: [String]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(products, id: \.self) { item in
                    HStack(spacing: 6) {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                            .font(.system(size: 16, weight: .bold))
                        
                        Text(item)
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.green)
                    }
                }
            }
        }
    }
}

#Preview {
    ProductList(products: ["Night Pads", "Day Pads", "Regular Pads"])
}
