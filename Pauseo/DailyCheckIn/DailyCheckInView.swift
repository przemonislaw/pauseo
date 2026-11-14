import SwiftUI

struct DailyCheckInView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 24) {
            Spacer()

            Text("Daily check-in")
                .font(.title2)
                .fontWeight(.bold)

            Text("Placeholder — Epic 7\nA quick check-in (< 30 seconds) will go here.")
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
    DailyCheckInView()
}
