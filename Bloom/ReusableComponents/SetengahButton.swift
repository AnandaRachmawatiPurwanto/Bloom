//
//  Button.swift
//  Bloom
//
//  Created by Ananda Rachmawati Purwanto on 01/07/26.
//

import SwiftUI

enum BloomButtonStyle {
    case filled
    case outlined
}

struct BloomButton: View {

    let title: String
    let iconName: String?
    let style: BloomButtonStyle
    let maxWidth: Bool
    let action: () -> Void

    init(
        _ title: String,
        iconName: String? = nil,
        style: BloomButtonStyle = .filled,
        maxWidth: Bool = false,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.iconName = iconName
        self.style = style
        self.maxWidth = maxWidth
        self.action = action
    }

    var body: some View {

        Button(action: action) {

            HStack(spacing: 8) {

                if let iconName {
                    Image(systemName: iconName)
                }

                Text(title)
                    .font(.AppTheme.boldRegular)
            }
            .foregroundStyle(
                style == .filled
                ? .white
                : .pink
            )
            .padding(.horizontal, 16)
            .padding(.vertical, 9)
            .frame(maxWidth: 166, maxHeight: 40)
            .background(
                style == .filled
                ? Color.pink
                : Color.white
            )
            .clipShape(
                RoundedRectangle(cornerRadius: 40)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 40)
                    .stroke(
                        style == .outlined ? Color.pink : .clear,
                        lineWidth: 1.5
                    )
            )
            .shadow(
                color: style == .filled
                ? .pink.opacity(0.25)
                : .clear,
                radius: 40,
                y: 4
            )

        }

    }
}

#Preview {

    HStack() {

        BloomButton(
            "Get Direction",
            iconName: "location.fill",
            style: .outlined
        ) {

        }

        BloomButton(
            "Book"
        ) {

        }

    }
    .padding()

}
