import SwiftUI

struct HomeView: View {
    @State private var showingCravingFlow = false
    @State private var showingSlipRecovery = false
    @State private var showingPrivacy = false

    var body: some View {
        VStack(spacing: 0) {
            Spacer()

            VStack(spacing: 12) {
                Text("What now?")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text("You don't have to handle the whole day.\nChoose one small action.")
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }

            Spacer()

            Button("I'm having a craving") {
                showingCravingFlow = true
            }
            .buttonStyle(PauseoPrimaryButtonStyle())
            .padding(.bottom, 32)

            SecondaryActionButton(title: "I've had a slip") { showingSlipRecovery = true }

            Button("Privacy and data") { showingPrivacy = true }
                .font(.caption2)
                .foregroundStyle(.tertiary)
                .padding(.top, 24)
                .padding(.bottom, 24)
        }
        .padding()
        .background(Color.pauseoBackground.ignoresSafeArea())
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
            Text(LocalizedStringKey(title))
                .multilineTextAlignment(.center)
        }
        .buttonStyle(PauseoCompactButtonStyle())
    }
}

#Preview {
    HomeView()
}
