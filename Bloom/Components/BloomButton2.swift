import SwiftUI

struct BloomButton2<Content: View>: View {
    let maxWidth: Bool
    let action: () -> Void
    let content: Content

    init(
        maxWidth: Bool = true,
        action: @escaping () -> Void,
        @ViewBuilder content: () -> Content
    ) {
        self.maxWidth = maxWidth
        self.action = action
        self.content = content()
    }

    var body: some View {
        Button(action: action) {
            content
                .font(.AppTheme.boldRegular)
                .foregroundStyle(Color.white)
                .padding(.horizontal, 18)
                .padding(.vertical, 12)
                .frame(maxWidth: maxWidth ? .infinity : nil)
                .background(Color.pink)
                .clipShape(
                    RoundedRectangle(cornerRadius: 40)
                )
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    BloomButton2 {
        print("Tapped")
    } content: {
        HStack {
            Text("1 Item")
            Spacer()
            Text("Checkout")
        }
    }
}

#Preview {
    BloomButton2 {
        print("Tapped")
    } content: {
        
            Text("1 Item")
           
        
    }
}
