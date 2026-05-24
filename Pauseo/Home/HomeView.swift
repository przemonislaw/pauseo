import SwiftUI

struct HomeView: View {
    @State private var showingCravingFlow = false
    @State private var showingSlipRecovery = false
    @State private var showingCheckIn = false
    @State private var showingProgress = false

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

            HStack(spacing: 12) {
                SecondaryActionButton(title: "Miałem slip") { showingSlipRecovery = true }
                SecondaryActionButton(title: "Check-in") { showingCheckIn = true }
                SecondaryActionButton(title: "Triggery") { showingProgress = true }
                SecondaryActionButton(title: "Postęp") { showingProgress = true }
            }

            Spacer()
        }
        .padding()
        .sheet(isPresented: $showingCravingFlow) { CravingFlowView() }
        .sheet(isPresented: $showingSlipRecovery) { SlipRecoveryView() }
        .sheet(isPresented: $showingCheckIn) { DailyCheckInView() }
        .sheet(isPresented: $showingProgress) { AppProgressView() }
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
