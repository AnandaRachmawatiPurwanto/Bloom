import SwiftUI

enum PaymentType {
    case applePay, gopay, qris
}

struct CheckoutView: View {
    @Environment(AppState.self) var appState
    @State private var viewModel: CheckoutViewModel
    
    init(appState: AppState) {
        _viewModel = State(initialValue: CheckoutViewModel(appState: appState))
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 28) {
                
                // MARK: - Location Card
                LocCard(
                    image: "loc",
                    title: viewModel.machineName,
                    subtitle: viewModel.machineSubtitle
                )
                
                // MARK: - Checkout card
                CheckoutCard(
                    image: viewModel.productImageName,
                    title: viewModel.productName,
                    subtitle: viewModel.quantityText,
                    amount: Int(viewModel.productPrice)
                )
                
                // MARK: - Summary
                VStack(alignment: .leading, spacing: 16) {
                    Text("Summary").bold()
                    
                    HStack{
                        Text("Product")
                        Spacer()
                        Text("Rp. \(Int(viewModel.productPrice))")
                    }
                    if viewModel.discount > 0 {
                        HStack{
                            Text("Discount (NEWUSER)")
                            Spacer()
                            Text("-Rp. \(Int(viewModel.discount))")
                                .foregroundStyle(.pink)
                        }
                    }
                    
                    Divider()
                    
                    HStack{
                        Text("Total")
                        Spacer()
                        Text("Rp. \(Int(viewModel.totalPrice))")
                    }
                    .bold()
                }
                
                // MARK: - Select Payment Methods
                VStack(spacing: 16) {
                    PaymentCard(
                        image: "apple.logo",
                        title: "Apple Pay",
                        isSelected: viewModel.selectedPayment == .applePay,
                        action: { viewModel.selectedPayment = .applePay }
                    )
                    
                    PaymentCard(
                        image: "creditcard",
                        title: "GoPay",
                        isSelected: viewModel.selectedPayment == .gopay,
                        action: { viewModel.selectedPayment = .gopay }
                    )
                    
                    PaymentCard(
                        image: "qrcode",
                        title: "QRIS",
                        isSelected: viewModel.selectedPayment == .qris,
                        action: { viewModel.selectedPayment = .qris }
                    )
                }
                
                Spacer()
                
                // MARK: - Checkout Button
                BloomButton2 {
                    viewModel.checkout()
                } content: {
                    HStack {
                        if viewModel.isProcessing {
                            ProgressView()
                                .tint(.white)
                        } else {
                            Text("Proceed")
                        }
                    }
                }
                .disabled(viewModel.isProcessing)
            }
            .padding()
        }
        .navigationDestination(isPresented: $viewModel.navigateToSuccess) {
            PaySuccess().navigationBarBackButtonHidden(true)
        }
        .navigationDestination(isPresented: $viewModel.navigateToFailed) {
            PayFailed().navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    NavigationStack {
        CheckoutView(appState: AppState())
            .environment(AppState())
    }
}
