import SwiftUI
import FirebaseDatabase

enum PaymentType {
    case applePay, gopay, qris
}

struct CheckoutView: View {
    @State private var selectedPayment: PaymentType? = nil
    @State private var navigateToSuccess = false
    @State private var navigateToFailed = false
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 28) {
                
                // MARK: - Location Card
                LocCard(image: "loc", title: "The Breeze", subtitle: "Green Office Park")
                
                // MARK: - Checkout card
                CheckoutCard(image: "pads", title: "Regular Pads", subtitle: "1 item", amount: 100000)
                
                // MARK: - Summary
                VStack(alignment: .leading, spacing: 16) {
                    Text("Summary").bold()
                    
                    HStack{
                        Text("Product")
                        Spacer()
                        Text("Rp. \(10000)")
                    }
                    HStack{
                        Text("Discount (NEWUSER)")
                        Spacer()
                        Text("-Rp. \(2000)")
                            .foregroundStyle(.pink)
                    }
                    
                    Divider()
                    
                    HStack{
                        Text("Total")
                        Spacer()
                        Text("Rp. \(8000)")
                    }
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
                    guard selectedPayment != nil else {
                        print("Pilih metode pembayaran terlebih dahulu!")
                        return
                    }
                    
                    triggerMesinPembalut()
                    
                } content: {
                    HStack {
                        Text("Proceed")
                    }
                }
            }
            .padding()
        }
        .navigationDestination(isPresented: $navigateToSuccess) {
            PaySuccess().navigationBarBackButtonHidden(true)
        }
        .navigationDestination(isPresented: $navigateToFailed) {
            PayFailed().navigationBarBackButtonHidden(true)
        }
    }
    
    // MARK: - Fungsi Firebase
    private func triggerMesinPembalut() {
        print("Mengirim sinyal ke IoT...")
        
        // Memasukkan URL database secara eksplisit sangat penting untuk region asia-southeast1
        let databaseURL = "https://vending-pembalut-default-rtdb.asia-southeast1.firebasedatabase.app"
        let ref = Database.database(url: databaseURL).reference()
        
        // Menargetkan variabel trigger_keluarkan di dalam node MESIN_PEMBALUT_01
        ref.child("vending_machines/MESIN_PEMBALUT_01/trigger_keluarkan").setValue(true) { error, _ in
            if let error = error {
                print("Gagal mengirim sinyal: \(error.localizedDescription)")
                navigateToFailed = true
            } else {
                print("Berhasil! Mesin pembalut diaktifkan.")
                navigateToSuccess = true
            }
        }
    }
}

#Preview {
    NavigationStack {
        CheckoutView()
            .environmentObject(AppState())
    }
}
