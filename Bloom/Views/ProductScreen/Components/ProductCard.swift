
import SwiftUI

struct ProductCard: View {
    @EnvironmentObject var appState: AppState
    let product: VendingMachineProduct
    
    var isSelected: Bool {
        appState.selectedProduct?.id == product.id
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            
            VStack(spacing: 16) {
                Text(product.name)
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(.black)
                
                HStack(spacing: 24) {
                    Button(action: {
                        if isSelected {
                            appState.selectedProduct = nil
                            appState.selectedQuantity = 1
                        } else {
                            appState.selectedProduct = product
                            appState.selectedQuantity = 1
                        }
                    }) {
                        Text(isSelected ? "Added" : (product.stock > 0 ? "Add" : "Out of Stock"))
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(product.stock > 0 ? .black : .secondary)
                            .frame(maxWidth: 162, maxHeight: 36)
                            .background(isSelected ? Color.green.opacity(0.2) : (product.stock > 0 ? Color(red: 1.0, green: 0.75, blue: 0.8) : Color.gray.opacity(0.3)))
                            .clipShape(
                                RoundedRectangle(cornerRadius: 40)
                            )
                    }
                    .disabled(product.stock == 0)
                    
                }
            }
            .padding(.top, 70)
            .padding(.bottom, 24)
            .padding(.horizontal, 20)
            .frame(width: 170)
            .background(Color.white)
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color(red: 1.0, green: 0.4, blue: 0.47), lineWidth: 1.5)
            )
            .padding(.top, 60)
            
            
            ZStack {
                Circle()
                    .fill(Color(red: 1.0, green: 0.4, blue: 0.47))
                    .frame(width: 126, height: 126)
                
                Image(product.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 87, height: 89)
                    .foregroundColor(.white)
            }
        }
    }
}

struct ProductCardView_Previews: PreviewProvider {
    static var previews: some View {
        ProductCard(product: VendingMachineProduct(name: "Regular Pad", imageName: "pads", price: 15000, stock: 10))
            .environmentObject(AppState())
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
