
import SwiftUI

struct ProductCard: View {
    @State private var quantity: Int = 1
    
    var body: some View {
        ZStack(alignment: .top) {
            
            VStack(spacing: 16) {
                Text("Regular Pad")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(.black)
                
                HStack(spacing: 24) {
                    Button(action: {}
                    ) {
                        Text("Add")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.black)
                            .frame(maxWidth: 162, maxHeight: 36)
                            .background(Color(red: 1.0, green: 0.75, blue: 0.8))
                            .clipShape(
                                RoundedRectangle(cornerRadius: 40)
                            )
                    }
                    
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
                
                Image("Pads")
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
        ProductCard()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
