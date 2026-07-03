import SwiftUI

struct CheckoutButton: View {
    let title: String
    let imageName: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 128) {
                Text(title)
                    .font(.headline)
                
                Text(title)
                    .font(.headline)
            }
            .padding()
            .background(Color.pink)
            .cornerRadius(16)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    CheckoutButton(
        title: "Apple",
        imageName: "appleLogo"
    ) {
        print("Tapped")
    }
}
