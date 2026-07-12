//
//  SpashScreen.swift
//  Bloom
//
//  Created by Ananda Rachmawati Purwanto on 03/07/26.
//

import SwiftUI

struct SpashScreen: View {
    var body: some View {
        ZStack {
            Image("AssetSplash")
                //.resizable()
                .scaledToFit()
                .frame(width: 250)

            Image("Logo")
                .resizable()
                .scaledToFit()
                .frame(width: 130, height: 130)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            LinearGradient(
                colors: [
                    Color.AppTheme.white,
                    Color.AppTheme.softPink
                ],
                startPoint: .leading,
                endPoint: .trailing
            )
        )
        .ignoresSafeArea()
    }
}
#Preview {
    SpashScreen()
}
