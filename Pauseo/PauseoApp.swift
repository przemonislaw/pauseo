import SwiftUI

@main
struct PauseoApp: App {
    @StateObject private var appState = AppState()
    @StateObject private var eventStore = EventStore()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(appState)
                .environmentObject(eventStore)
        }
    }
}

struct RootView: View {
    @EnvironmentObject private var appState: AppState

    var body: some View {
        if appState.onboardingCompleted {
            HomeView()
        } else {
            OnboardingFlowView()
        }
    }
}
