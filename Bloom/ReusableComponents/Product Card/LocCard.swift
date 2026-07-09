import SwiftUI

struct LocCard : View {
    let image: String
    let title: String
    let subtitle: String
    
    var body: some View {
        HStack(spacing : 12){
            Image("loc")
                .resizable()
                .scaledToFit()
                .frame(width: 32, height: 40)
            VStack(alignment: .leading){
                Text(title)
                    .font(.system(size: 24, weight: .bold))
                Text(subtitle)
                    .font(.system(size: 24, weight: .regular))
            }
            Spacer()
        }
        .font(Font.body.bold())
        .padding()
    }
}

#Preview {
    LocCard(image: "loc", title: "The Breeze", subtitle: "Green Office Park")
}
