//
//  BloomPin.swift
//  Bloom
//
//  Created by Ananda Rachmawati Purwanto on 02/07/26.
//
import SwiftUI

struct BloomMapPin: View {

    var isSelected: Bool = false

    var body: some View {

        ZStack {

            Circle()
                .fill(
                    isSelected
                    ? Color.AppTheme.activePink
                    : Color.white
                )
                .frame(width: 46, height: 46)

            Image("location")
                .resizable()
                .scaledToFit()
                .frame(width: 22, height: 22)
                .foregroundStyle(
                    isSelected
                    ? .white
                    : .AppTheme.activePink
                )

        }
        .shadow(radius: 6)

    }
}

#Preview {
    BloomMapPin()
}