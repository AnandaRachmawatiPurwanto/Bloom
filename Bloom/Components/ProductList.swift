//
//  ProductList.swift
//  Bloom
//
//  Created by Ananda Rachmawati Purwanto on 03/07/26.
//
import SwiftUI

struct ProductList: View {

    let products:[String]

    var body: some View{

        VStack(alignment:.leading, spacing: 12){

            Text("Product Available")
                .font(.headline)

            LazyVGrid(
                columns:[
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ],
                spacing:20
            ){

                ForEach(products,id:\.self){ item in

                    HStack{

                        Circle()
                            .fill(Color.pink)
                            .frame(width:16,height:16)

                        Text(item)
                        
                        Spacer()

                    }

                }

            }

        }
        .padding()
        .background(.white)
        .overlay{
            RoundedRectangle(cornerRadius:24)
                .stroke(Color.pink,lineWidth:1)
        }
        .clipShape(RoundedRectangle(cornerRadius:24))

    }

}

#Preview {
    ProductList(products: ["Pads", "Panty Liners", "Tampons", "Menstrual Cups"])
}
