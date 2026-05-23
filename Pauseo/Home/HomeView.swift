import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack(spacing: 0) {
            Spacer()

            VStack(spacing: 12) {
                Text("Co teraz?")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text("Nie musisz ogarniać całego dnia.\nWybierz jedną małą akcję.")
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }

            Spacer()

            Button("Mam craving teraz") {
                // TODO: Epic 4 — Craving flow
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .tint(.indigo)
            .padding(.bottom, 32)

            HStack(spacing: 12) {
                SecondaryActionButton(title: "Miałem slip") {}
                SecondaryActionButton(title: "Check-in") {}
                SecondaryActionButton(title: "Triggery") {}
                SecondaryActionButton(title: "Postęp") {}
            }

            Spacer()
        }
        .padding()
    }
}

private struct SecondaryActionButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.caption)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(.bordered)
        .controlSize(.small)
    }
}

#Preview {
    HomeView()
}
