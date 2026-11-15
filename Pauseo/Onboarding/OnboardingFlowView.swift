import SwiftUI

struct OnboardingFlowView: View {
    @EnvironmentObject private var appState: AppState
    @State private var step: Int = 0
    @State private var nicotineType: NicotineType? = nil
    @State private var goalMode: GoalMode? = nil
    @State private var mainTrigger: TriggerCategory? = nil

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                if step > 0 {
                    Button(action: { step -= 1 }) {
                        HStack(spacing: 4) {
                            Image(systemName: "chevron.left")
                            Text("Back")
                        }
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    }
                    .buttonStyle(.plain)
                }
                Spacer()
            }
            .frame(height: 44)
            .padding(.horizontal)
            .padding(.top, 8)

            switch step {
            case 0:
                WelcomeStep(onNext: { step = 1 })
            case 1:
                NicotineTypeStep(selection: $nicotineType, onNext: { step = 2 })
            case 2:
                GoalModeStep(selection: $goalMode, onNext: { step = 3 })
            case 3:
                TriggerStep(selection: $mainTrigger, onNext: { step = 4 })
            case 4:
                NotificationsStep(onComplete: { appState.completeOnboarding() })
            default:
                EmptyView()
            }
        }
        .background(Color.pauseoBackground.ignoresSafeArea())
    }
}

// MARK: - Welcome

private struct WelcomeStep: View {
    let onNext: () -> Void

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
            }
            .padding(.horizontal, 32)
            Spacer()
            Button("Let's begin", action: onNext)
                .buttonStyle(PauseoPrimaryButtonStyle())
                .padding(.horizontal)
                .padding(.bottom, 40)
        }
    }
}

// MARK: - Nicotine Type

private struct NicotineTypeStep: View {
    @Binding var selection: NicotineType?
    let onNext: () -> Void

    var body: some View {
        SelectionStep(
            title: "What do you use?",
            options: NicotineType.allCases,
            selection: $selection,
            onNext: onNext
        )
    }
}

// MARK: - Goal Mode

private struct GoalModeStep: View {
    @Binding var selection: GoalMode?
    let onNext: () -> Void

    var body: some View {
        SelectionStep(
            title: "What's your goal?",
            options: GoalMode.allCases,
            selection: $selection,
            onNext: onNext
        )
    }
}

// MARK: - Main Trigger

private struct TriggerStep: View {
    @Binding var selection: TriggerCategory?
    let onNext: () -> Void

    var body: some View {
        SelectionStep(
            title: "What usually triggers your cravings?",
            options: TriggerCategory.allCases,
            selection: $selection,
            onNext: onNext
        )
    }
}

// MARK: - Notifications

private struct NotificationsStep: View {
    let onComplete: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            VStack(spacing: 16) {
                Text("Reminders later.")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                Text("For now we'll start without setting up notifications. What matters most is having support ready when a craving hits.")
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal, 32)
            Spacer()
            VStack(spacing: 12) {
                Button("Go to the app", action: onComplete)
                    .buttonStyle(PauseoPrimaryButtonStyle())
                Button("Not now", action: onComplete)
                    .buttonStyle(PauseoSecondaryButtonStyle())
            }
            .padding(.horizontal)
            .padding(.bottom, 40)
        }
    }
}

// MARK: - Generic Selection Step

private struct SelectionStep<T: RawRepresentable & CaseIterable & Hashable>: View
    where T.RawValue == String {
    let title: String
    let options: T.AllCases
    @Binding var selection: T?
    let onNext: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            Text(LocalizedStringKey(title))
                .font(.title2)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
                .padding(.top, 24)
                .padding(.bottom, 24)

            ScrollView {
                VStack(spacing: 10) {
                    ForEach(Array(options), id: \.rawValue) { option in
                        OptionChip(
                            title: option.rawValue,
                            isSelected: selection == option,
                            action: { selection = option }
                        )
                    }
                }
                .padding(.horizontal)
            }

            Button("Next", action: onNext)
                .buttonStyle(PauseoPrimaryButtonStyle())
                .padding(.horizontal)
                .padding(.top, 16)
                .padding(.bottom, 40)
        }
    }
}

// MARK: - Option Chip

private struct OptionChip: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Text(LocalizedStringKey(title))
                    .font(.callout)
                Spacer()
                if isSelected {
                    Image(systemName: "checkmark")
                        .font(.callout.weight(.semibold))
                }
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .background(isSelected ? Color.pauseoPrimary : Color.pauseoSurface)
            .foregroundStyle(isSelected ? Color.white : Color.pauseoTextPrimary)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(isSelected ? Color.clear : Color.pauseoBorder, lineWidth: 1)
            )
        }
        .buttonStyle(.plain)
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }
}

#Preview {
    OnboardingFlowView()
        .environmentObject(AppState())
}
