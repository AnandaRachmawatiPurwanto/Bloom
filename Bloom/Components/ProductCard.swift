
import SwiftUI

struct ProductCardView: View {
    // State untuk menyimpan logika jumlah item
    @State private var quantity: Int = 1
    
    var body: some View {
        ZStack(alignment: .top) {
            
            // 1. KOTAK UTAMA (CARD)
            VStack(spacing: 16) {
                Text("Regular Pad")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(.black)
                
                // Stepper (Tombol Minus, Angka, Tombol Plus)
                HStack(spacing: 24) {
                    // Tombol Minus
                    Button(action: {
                        // Logika dasar: hanya bisa dikurangi jika lebih dari 1
                        if quantity > 1 { quantity -= 1 }
                    }) {
                        Image(systemName: "minus")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.black)
                            .frame(width: 32, height: 32)
                            .background(Color(red: 1.0, green: 0.75, blue: 0.8)) // Pink muda
                            .clipShape(Circle())
                    }
                    
                    // Angka
                    Text("\(quantity)")
                        .font(.system(size: 20, weight: .regular))
                        .frame(width: 24)
                    
                    // Tombol Plus
                    Button(action: {
                        quantity += 1
                    }) {
                        Image(systemName: "plus")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.black)
                            .frame(width: 32, height: 32)
                            .background(Color(red: 1.0, green: 0.75, blue: 0.8)) // Pink muda
                            .clipShape(Circle())
                    }
                }
            }
            .padding(.top, 70) // Memberi ruang agar teks tidak tertabrak lingkaran
            .padding(.bottom, 24)
            .padding(.horizontal, 20)
            .frame(width: 170)
            .background(Color.white)
            .cornerRadius(16)
            // Menambahkan garis pinggir (border) merah/pink
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color(red: 1.0, green: 0.4, blue: 0.47), lineWidth: 1.5)
            )
            .padding(.top, 60) // Menggeser card ke bawah agar ZStack punya ruang untuk lingkaran
            
            
            // 2. LINGKARAN GAMBAR DI ATAS (OVERLAP)
            ZStack {
                Circle()
                    .fill(Color(red: 1.0, green: 0.4, blue: 0.47)) // Pink pekat
                    .frame(width: 126, height: 126)
                
                // Ganti "pad_image" dengan nama aset aslimu di Assets.xcassets
                // Sementara menggunakan ikon sistem sebagai placeholder
                Image("pads")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 87, height: 89)
                    .foregroundColor(.white)
            }
        }
    }
}

// Preview untuk melihat hasilnya langsung di Xcode Canvas
struct ProductCardView_Previews: PreviewProvider {
    static var previews: some View {
        ProductCardView()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
