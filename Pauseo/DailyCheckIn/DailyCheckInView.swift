import SwiftUI

struct DailyCheckInView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 24) {
            Spacer()

            Text("Dzienny check-in")
                .font(.title2)
                .fontWeight(.bold)

            Text("Placeholder — Epic 7\nTu pojawi się szybki check-in (< 30 sekund).")
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
    DailyCheckInView()
}
