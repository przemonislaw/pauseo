import SwiftUI

final class AppState: ObservableObject {
    @AppStorage("onboardingCompleted") var onboardingCompleted: Bool = false

    func completeOnboarding() {
        onboardingCompleted = true
    }

    func resetOnboarding() {
        onboardingCompleted = false
    }
}
