import SwiftUI

struct HomeView: View {
    @State private var showingCravingFlow = false
    @State private var showingSlipRecovery = false
    @State private var showingPrivacy = false

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
                showingCravingFlow = true
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .tint(.indigo)
            .padding(.bottom, 32)

            SecondaryActionButton(title: "Miałem slip") { showingSlipRecovery = true }

            Button("Prywatność i dane") { showingPrivacy = true }
                .font(.caption2)
                .foregroundStyle(.tertiary)
                .padding(.top, 8)

            Spacer()
        }
        .padding()
        .sheet(isPresented: $showingCravingFlow) { CravingFlowView() }
        .sheet(isPresented: $showingSlipRecovery) { SlipRecoveryView() }
        .sheet(isPresented: $showingPrivacy) { PrivacySafetyView() }
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
