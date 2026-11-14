import SwiftUI

struct AppProgressView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 24) {
            Spacer()

            Text("What are you learning?")
                .font(.title2)
                .fontWeight(.bold)

            Text("Placeholder — Epic 8\nA summary of triggers and cravings will go here.")
                .font(.body)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)

            Spacer()

            Button("Close") { dismiss() }
                .buttonStyle(.bordered)
        }
        .padding()
    }
}

#Preview {
    AppProgressView()
}
