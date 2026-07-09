//
//  SpashScreen.swift
//  Bloom
//
//  Created by Ananda Rachmawati Purwanto on 03/07/26.
//

import SwiftUI

struct SpashScreen: View {
    var body: some View {
        ZStack{
            Image("AssetSplash")
            Image("Logo")
        }
        .background(LinearGradient(
            colors: [
                Color.AppTheme.white,
                Color.AppTheme.softPink
            ],
            startPoint: .leading,
            endPoint: .trailing
        ))
    }
}

#Preview {
    SpashScreen()
}
