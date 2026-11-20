import SwiftUI

/// Single-screen onboarding (see docs/Product_MVP.md → Onboarding).
/// One promise, one privacy line, one action → Home.
/// Setup questions were removed because their answers were never stored or used;
/// they may return later only in context, when an answer visibly changes something.
struct OnboardingFlowView: View {
    @EnvironmentObject private var appState: AppState

    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            VStack(spacing: 16) {
                Text("Support when a craving hits.")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                Text("pauseo helps you choose one small action when a nicotine craving hits.")
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                Text("No account. Your data stays on your phone.")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.top, 8)
            }
            .padding(.horizontal, 32)
            Spacer()
            Button("Let's begin", action: { appState.completeOnboarding() })
                .buttonStyle(PauseoPrimaryButtonStyle())
                .padding(.horizontal)
                .padding(.bottom, 40)
        }
        .background(Color.pauseoBackground.ignoresSafeArea())
    }
}

#Preview {
    OnboardingFlowView()
        .environmentObject(AppState())
}
