//
//  CheckoutCard.swift
//  Bloom
//
//  Created by Rendi Septrian on 04/07/26.
//

import SwiftUI

struct CheckoutCard: View {
    let image : String
    let title : String
    let subtitle : String
    let amount : Int

    var body: some View {
        HStack(spacing:12)
        {
            Image(image)
                .resizable()
                .frame(width: 48, height: 48)
                .background(Color(.pink).opacity(0.5))
                .clipShape(Circle())
            VStack(alignment:.leading, spacing:4)
            {
                Text(title)
                    .font(.headline)
                Text(subtitle)
            }
            Spacer()
            Text("Rp \(amount)")
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 20)
        .frame(maxWidth: 354, maxHeight: 92)
        .cornerRadius(16)
        .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color(.pink).opacity(0.5), lineWidth: 0.5))
    }
}

#Preview {
    CheckoutCard(image: "pads", title: "Mastercard", subtitle: "**** **** **** 1234", amount: 100000)
}
