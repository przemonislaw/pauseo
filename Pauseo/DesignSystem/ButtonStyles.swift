import SwiftUI

struct PauseoPrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.body.weight(.semibold))
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(Color.pauseoPrimary)
            )
            .foregroundStyle(.white)
            .opacity(configuration.isPressed ? 0.85 : 1)
    }
}

struct PauseoSecondaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.body.weight(.medium))
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(Color.pauseoNeutralAction.opacity(0.16))
            )
            .foregroundStyle(Color.pauseoNeutralAction)
            .opacity(configuration.isPressed ? 0.7 : 1)
    }
}

struct PauseoCompactButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.caption.weight(.medium))
            .frame(maxWidth: .infinity)
            .padding(.vertical, 10)
            .background(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(Color.pauseoNeutralAction.opacity(0.16))
            )
            .foregroundStyle(Color.pauseoNeutralAction)
            .opacity(configuration.isPressed ? 0.7 : 1)
    }
}

struct PauseoDestructiveButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.body.weight(.medium))
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(Color.red.opacity(0.16))
            )
            .foregroundStyle(Color.red)
            .opacity(configuration.isPressed ? 0.7 : 1)
    }
}
