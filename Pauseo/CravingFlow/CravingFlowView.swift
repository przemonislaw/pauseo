import SwiftUI

struct CravingFlowView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 24) {
            Spacer()

            Text("Mam craving teraz")
                .font(.title2)
                .fontWeight(.bold)

            Text("Placeholder — Epic 4\nTu pojawi się micro-akcja i log triggera.")
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
    CravingFlowView()
}
