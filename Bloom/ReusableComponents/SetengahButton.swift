//
//  Button.swift
//  Bloom
//
//  Created by Ananda Rachmawati Purwanto on 01/07/26.
//

//
//  BloomButton.swift
//  Bloom
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

    private let primaryColor = Color(
        red: 255 / 255,
        green: 101 / 255,
        blue: 125 / 255
    ) // #FF657D

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

    private var buttonWidth: CGFloat {
        switch style {
        case .filled:
            return 182
        case .outlined:
            return 122
        }
    }

    var body: some View {

        Button(action: action) {

            HStack(spacing: 8) {

                if let iconName {
                    Image(systemName: iconName)
                        .font(.system(size: 16, weight: .semibold))
                }

                Text(title)
                    .font(.AppTheme.boldRegular)
            }
            .foregroundStyle(
                style == .filled
                ? .white
                : primaryColor
            )
            .frame(
                width: maxWidth ? nil : buttonWidth,
                height: 40
            )
            .frame(maxWidth: maxWidth ? .infinity : nil)
            .background(
                style == .filled
                ? primaryColor
                : .white
            )
            .clipShape(Capsule())
            .overlay(
                Capsule()
                    .stroke(
                        style == .outlined ? primaryColor : .clear,
                        lineWidth: 1.5
                    )
            )
            .shadow(
                color: style == .filled
                ? primaryColor.opacity(0.25)
                : .clear,
                radius: 12,
                x: 0,
                y: 8
            )
        }
        .buttonStyle(.plain)
    }
}

#Preview {

    VStack(spacing: 20) {

        HStack(spacing: 12) {

            BloomButton(
                "View Details",
                style: .outlined
            ) {

            }

            BloomButton(
                "Choose Pads"
            ) {

            }
        }

        BloomButton(
            "Checkout",
            maxWidth: true
        ) {

        }

    }
    .padding()
}
