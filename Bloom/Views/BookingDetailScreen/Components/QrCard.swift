//
//  ImgCard.swift
//  Bloom
//
//  Created by Rendi Septrian on 10/07/26.
//

import SwiftUI

struct QrCard: View {
    let image : String
    let title : String
    
    var body: some View {
        VStack(){
            Image(image)
                .resizable()
                .frame(width: 334, height: 334)
            Text(title)
                .font(.subheadline)
        }
        .padding(10)
        .frame(width: 351, height: 368)
        .background(Color(.white))
        .cornerRadius(30)
    }
}


#Preview {
    QrCard(image:"qr", title:"Scan this QR code at the vending machine")
}
