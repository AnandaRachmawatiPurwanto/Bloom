import SwiftUI

struct ProductsView: View {
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 28) {
                
                // MARK: - Location Card
                LocCard(image: "loc", title: "The Breeze", subtitle: "Green Office Park")
                
                // MARK: - Products Grid
                
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(0..<4, id: \.self) { _ in
                        ProductCard()
                    }
                }
                
                // MARK: - Checkout Button
                BloomButton2 {
                    print("Checkout Tapped")
                } content: {
                    HStack {
                        Text("1 Item")
                        Spacer()
                        Text("Checkout")
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    ProductsView()
}
