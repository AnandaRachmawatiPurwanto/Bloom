//
//  Font.swift
//  Bloom
//
//  Created by Ananda Rachmawati Purwanto on 01/07/26.
//
import SwiftUI

extension Font {
    struct AppTheme {
        static let screenTitle = Font.system(
            size: 40,
            weight: .bold,
            design: .default
        )

        static let sectionHeader = Font.system(
            size: 24,
            weight: .regular,
            design: .default
        )

        static let sectionTitle = Font.system(
            size: 30,
            weight: .bold,
            design: .default
        )

        static let regular = Font.system(
            size: 16,
            weight: .regular,
            design: .default
        )

        static let boldRegular = Font.system(
            size: 16,
            weight: .bold,
            design: .default
        )

        static let content = Font.system(
            size: 14,
            weight: .bold,
            design: .default
        )
        static let regularContent = Font.system(
            size: 14,
            weight: .regular,
            design: .default
        )

        static let caption = Font.system(
            size: 11,
            weight: .regular,
            design: .default
        )
        static let captionBold = Font.system(
            size: 10,
            weight: .bold,
            design: .default
        )
        
    }
}
