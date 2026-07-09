//
//  BloomIcon.swift
//  Bloom
//
//  Created by Ananda Rachmawati Purwanto on 01/07/26.
//

import SwiftUI

struct BloomIcon: View {

    var body: some View {

        ZStack {

            Circle()
                .fill(Color.AppTheme.activePink)
                .frame(width: 42, height: 42)

            Image(.location)
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
        }
    }
}

#Preview {
    BloomIcon()
}
