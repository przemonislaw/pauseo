import SwiftUI

struct SlipRecoveryView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 24) {
            Spacer()

            Text("To był slip, nie porażka.")
                .font(.title2)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)

            Text("Placeholder — Epic 6\nTu pojawi się log triggera i jedna akcja odbudowy.")
                .font(.body)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)

            Spacer()

            Button("Zamknij") { dismiss() }
                .buttonStyle(.bordered)
        }
        .padding()
    }
}

#Preview {
    SlipRecoveryView()
}
