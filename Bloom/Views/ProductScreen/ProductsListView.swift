import SwiftUI

struct ProductsView: View {
    @Environment(AppState.self) var appState
    @State private var viewModel: ProductsViewModel
    @State private var navigateToCheckout = false
    
    init(appState: AppState) {
        _viewModel = State(initialValue: ProductsViewModel(appState: appState))
    }
    
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 28) {
                
                // MARK: - Location Card
                LocCard(
                    image: "loc",
                    title: viewModel.machineName,
                    subtitle: viewModel.machineSubtitle
                )
                
                // MARK: - Products Grid
                
                LazyVGrid(columns: columns, spacing: 16) {
                    if !viewModel.products.isEmpty {
                        ForEach(viewModel.products) { product in
                            ProductCard(product: product)
                        }
                    } else {
                        ForEach(0..<4, id: \.self) { _ in
                            ProductCard(product: VendingMachineProduct(name: "Regular Pad", imageName: "pads", price: 15000, stock: 10))
                        }
                    }
                }
                
                // MARK: - Checkout Button
                BloomButton2 {
                    navigateToCheckout = true
                } content: {
                    HStack {
                        if !viewModel.checkoutItemCountText.isEmpty {
                            Text(viewModel.checkoutItemCountText)
                        }
                        Spacer()
                        Text(viewModel.checkoutText)
                    }
                }
                .disabled(!viewModel.hasSelection)
            }
            .padding()
        }
        .navigationDestination(isPresented: $navigateToCheckout) {
            CheckoutView(appState: appState)
        }
    }
}

#Preview {
    NavigationStack {
        ProductsView(appState: AppState())
            .environment(AppState())
    }
}
