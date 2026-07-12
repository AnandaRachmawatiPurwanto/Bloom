
import SwiftUI

struct ImgCard: View {
    let image : String
    let title : String
    
    var body: some View {
        VStack(){
            Image(image)
                .resizable()
                .frame(width: 78, height: 78)
            Text(title)
                .font(.title .weight(.bold) )
        }
        .padding(10)
        .frame(width: 351, height: 368)
        .background(Color(.white))
        .cornerRadius(30)
    }
}


#Preview {
    ImgCard(image:"success", title:"Collected")
}
