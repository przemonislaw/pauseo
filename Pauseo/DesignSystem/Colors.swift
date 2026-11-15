import SwiftUI
import UIKit

/// Light mode uses the pauseo visual system approved in the Stitch design review
/// (warm ivory + deep indigo). Dark mode intentionally falls back to the exact
/// system colors the app used before this file existed, so dark mode behavior
/// is unchanged.
extension Color {
    static let pauseoBackground = Color(UIColor { trait in
        trait.userInterfaceStyle == .dark
            ? .systemBackground
            : UIColor(red: 0xF7 / 255, green: 0xF5 / 255, blue: 0xEF / 255, alpha: 1)
    })

    static let pauseoPrimary = Color(UIColor { trait in
        trait.userInterfaceStyle == .dark
            ? UIColor(Color.indigo)
            : UIColor(red: 0x39 / 255, green: 0x30 / 255, blue: 0x80 / 255, alpha: 1)
    })

    static let pauseoTextPrimary = Color(UIColor { trait in
        trait.userInterfaceStyle == .dark
            ? .label
            : UIColor(red: 0x22 / 255, green: 0x22 / 255, blue: 0x36 / 255, alpha: 1)
    })

    static let pauseoTextSecondary = Color(UIColor { trait in
        trait.userInterfaceStyle == .dark
            ? .secondaryLabel
            : UIColor(red: 0x62 / 255, green: 0x62 / 255, blue: 0x73 / 255, alpha: 1)
    })

    static let pauseoSurface = Color(UIColor { trait in
        trait.userInterfaceStyle == .dark
            ? .systemGray6
            : UIColor(red: 0xF0 / 255, green: 0xEE / 255, blue: 0xE8 / 255, alpha: 1)
    })

    static let pauseoBorder = Color(UIColor { trait in
        trait.userInterfaceStyle == .dark
            ? .separator
            : UIColor(red: 0x22 / 255, green: 0x22 / 255, blue: 0x36 / 255, alpha: 0.12)
    })

    /// For equal-weight neutral buttons (e.g. "I've had a slip", the three
    /// outcome options) that must not read as a colored/primary action.
    /// Dark branch matches this app's existing AccentColor exactly, so an
    /// unset `.tint` and this token look identical in dark mode.
    static let pauseoNeutralAction = Color(UIColor { trait in
        trait.userInterfaceStyle == .dark
            ? UIColor(red: 0x5B / 255, green: 0x82 / 255, blue: 0xE5 / 255, alpha: 1)
            : UIColor(red: 0x22 / 255, green: 0x22 / 255, blue: 0x36 / 255, alpha: 1)
    })
}
