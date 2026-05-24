import SwiftUI

struct AppProgressView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 24) {
            Spacer()

            Text("Czego się uczysz?")
                .font(.title2)
                .fontWeight(.bold)

            Text("Placeholder — Epic 8\nTu pojawi się podsumowanie triggerów i cravingów.")
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
    AppProgressView()
}
