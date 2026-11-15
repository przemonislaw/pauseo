import SwiftUI

struct PrivacySafetyView: View {
    @EnvironmentObject private var eventStore: EventStore
    @Environment(\.dismiss) private var dismiss
    @State private var showingDeleteConfirmation = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 32) {
                    infoSection(title: "What we store") {
                        Text("Your data is stored locally on this device. You don't create an account, and nothing is sent to a server.")
                            .foregroundStyle(.secondary)
                        VStack(alignment: .leading, spacing: 8) {
                            row("Craving events")
                            row("Slip events")
                        }
                    }

                    infoSection(title: "Where your data is") {
                        Text("We store your data locally on your device. There is no account or syncing through pauseo.")
                            .foregroundStyle(.secondary)
                    }

                    infoSection(title: "Delete data") {
                        Text("You can delete all local data at any time.")
                            .foregroundStyle(.secondary)
                        Button("Delete all local data", role: .destructive) {
                            showingDeleteConfirmation = true
                        }
                        .buttonStyle(PauseoDestructiveButtonStyle())
                    }

                    infoSection(title: "Medical information") {
                        Text("pauseo.app supports building habits and recognizing triggers. It does not replace advice from a doctor, therapist, or pharmacist. If you're considering medication, nicotine replacement therapy, or have strong withdrawal symptoms, consult a qualified professional.")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                    }
                }
                .padding()
            }
            .background(Color.pauseoBackground.ignoresSafeArea())
            .navigationTitle("Privacy and data")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") { dismiss() }
                        .tint(.pauseoPrimary)
                }
            }
            .alert("Delete all data?", isPresented: $showingDeleteConfirmation) {
                Button("Delete", role: .destructive) { eventStore.deleteAll() }
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("All craving and slip events will be permanently deleted. This cannot be undone.")
            }
        }
    }

    @ViewBuilder
    private func infoSection<Content: View>(
        title: String,
        @ViewBuilder content: () -> Content
    ) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(LocalizedStringKey(title))
                .font(.headline)
            content()
        }
    }

    private func row(_ text: String) -> some View {
        Label(LocalizedStringKey(text), systemImage: "iphone")
            .font(.subheadline)
            .foregroundStyle(.secondary)
    }
}

#Preview {
    PrivacySafetyView()
        .environmentObject(EventStore())
}
