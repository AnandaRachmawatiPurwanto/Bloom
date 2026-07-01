//
//  DistanceComponents.swift
//  Bloom
//
//  Created by Ananda Rachmawati Purwanto on 01/07/26.
//

import SwiftUI

enum DistanceType {
    case distance
    case walking

    var icon: String {
        switch self {
        case .distance:
            return "location.fill"

        case .walking:
            return "figure.walk"
        }
    }
}

struct DistanceComponent: View {

    let value: String
    let type: DistanceType

    var body: some View {

        HStack(spacing: 8) {

            Image(systemName: type.icon)
                .font(.system(size: 14))
                .foregroundStyle(Color.AppTheme.activePink)

            Text(value)
                .font(.AppTheme.regularContent)

        }
    }
}

#Preview {

    HStack(spacing: 32) {

        DistanceComponent(
            value: "120 m away",
            type: .distance
        )

        DistanceComponent(
            value: "5 mins",
            type: .walking
        )

    }
    .padding()
}

