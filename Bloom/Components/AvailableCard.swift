//
//  AvailableCard.swift
//  Bloom
//
//  Created by Ananda Rachmawati Purwanto on 01/07/26.
//
import SwiftUI

enum AvailableCardStyle {
    case available
    case unavailable

    var color: Color {
        switch self {
        case .available:
            return .AppTheme.activeGreen
            
        case .unavailable:
            return .AppTheme.red
        }
    }

    var title: String {
        switch self {
        case .available:
            return "Available"

        case .unavailable:
            return "Unavailable"

        }
    }
}

struct AvailableCard: View {

    let style: AvailableCardStyle

    init(style: AvailableCardStyle = .available) {
        self.style = style
    }

    var body: some View {

        HStack(spacing: 10) {

            Circle()
                .fill(style.color)
                .frame(width: 8, height: 8)

            Text(style.title)
                .font(.AppTheme.regularContent)
                .foregroundStyle(style.color)

        }
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
        .frame(maxWidth: 120, maxHeight: 30)
        .background(Color.white)
        .clipShape(Capsule())
        .shadow(color: .black.opacity(0.05), radius: 40, y: 2)

    }
}

#Preview {
    VStack(spacing: 20) {
        AvailableCard(style: .available)
        AvailableCard(style: .unavailable)
    }
    .padding()
}
