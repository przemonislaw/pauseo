import SwiftUI

struct OnboardingFlowView: View {
    @EnvironmentObject private var appState: AppState
    @State private var currentStep: Int = 0

    private let totalSteps = 5

    var body: some View {
        VStack(spacing: 32) {
            Spacer()

            Text("Onboarding")
                .font(.largeTitle)
                .fontWeight(.bold)

            Text("Krok \(currentStep + 1) z \(totalSteps)")
                .font(.subheadline)
                .foregroundStyle(.secondary)

            Text("Placeholder — Epic 2")
                .font(.body)
                .foregroundStyle(.tertiary)

            Spacer()

            Button(currentStep < totalSteps - 1 ? "Dalej" : "Zacznij spokojnie") {
                if currentStep < totalSteps - 1 {
                    currentStep += 1
                } else {
                    appState.completeOnboarding()
                }
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .tint(.indigo)
        }
        .padding()
    }
}

#Preview {
    OnboardingFlowView()
        .environmentObject(AppState())
}
