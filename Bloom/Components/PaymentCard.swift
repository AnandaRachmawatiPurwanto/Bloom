import SwiftUI

struct PaymentCard: View {
    let image: String
    let title: String
    
    var isSelected: Bool
    var action: () -> Void

    var body: some View {
        Button(action: {
            action()
        }) {
            HStack(spacing: 12) {
                Image(systemName: image)
                    .frame(width: 40, alignment: .leading)
                    .foregroundColor(.black)

                Text(title)
                    .font(.headline)
                    .foregroundColor(.black)

                Spacer()

                Image(systemName: isSelected ? "largecircle.fill.circle" : "circle")
                    .foregroundStyle(isSelected ? .pink : .gray)
            }
            .padding(.vertical, 16)
            .padding(.horizontal, 20)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 40))
            .overlay(
                RoundedRectangle(cornerRadius: 40)
                    .stroke(isSelected ? .pink : .gray.opacity(0.5), lineWidth: 1)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - Preview dengan Dummy State
#Preview {
    PreviewPaymentCard()
}

struct PreviewPaymentCard: View {
    @State private var selectedPayment = "Apple Pay"

    var body: some View {
        VStack(spacing: 16) {
            PaymentCard(
                image: "apple.logo",
                title: "Apple Pay",
                isSelected: selectedPayment == "Apple Pay",
                action: { selectedPayment = "Apple Pay" }
            )
            
            PaymentCard(
                image: "creditcard",
                title: "GoPay",
                isSelected: selectedPayment == "GoPay",
                action: { selectedPayment = "GoPay" }
            )
        }
        .padding()
    }
}
