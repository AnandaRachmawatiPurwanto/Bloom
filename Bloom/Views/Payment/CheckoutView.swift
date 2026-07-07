import SwiftUI
enum PaymentType {
    case applePay, gopay, qris
}

struct CheckoutView: View {
    @State private var selectedPayment: PaymentType? = nil
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 28) {
                
                // MARK: - Location Card
                LocCard(image: "loc", title: "The Breeze", subtitle: "Green Office Park")
                
                // MARK: - Checkout card
                CheckoutCard(image: "pads", title: "Regular Pads", subtitle: "1 item", amount: 100000)
                
                // MARK: - Summary
                VStack(alignment: .leading, spacing: 16) {
                    Text("Summary")
                        .bold()
                    HStack{
                        Text("Product")
                        Spacer()
                        Text("Rp. \(10000)")}
                    HStack{
                        Text("Discount (NEWUSER)")
                        Spacer()
                        Text("-Rp. \(2000)")
                        .foregroundStyle(.pink)}
                   Divider()
                    HStack{
                        Text("Total")
                        Spacer()
                        Text("Rp. \(8000)")}
                    .bold()

                }
                
                // MARK: - Select Payment Methods
                VStack(spacing: 16) {
                                    PaymentCard(
                                        image: "apple.logo",
                                        title: "Apple Pay",
                                        isSelected: selectedPayment == .applePay,
                                        action: { selectedPayment = .applePay }
                                    )
                                    
                                    PaymentCard(
                                        image: "creditcard",
                                        title: "GoPay",
                                        isSelected: selectedPayment == .gopay,
                                        action: { selectedPayment = .gopay }
                                    )
                                    
                                    PaymentCard(
                                        image: "qrcode",
                                        title: "QRIS",
                                        isSelected: selectedPayment == .qris,
                                        action: { selectedPayment = .qris }
                                    )
                                }
                Spacer()
                // MARK: - Checkout Button
                BloomButton2 {
                    print("Checkout Tapped")
                } content: {
                    HStack {
                        Text("Proceed")
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    CheckoutView()
}
