import SwiftUI

struct PrivacySafetyView: View {
    @EnvironmentObject private var eventStore: EventStore
    @Environment(\.dismiss) private var dismiss
    @State private var showingDeleteConfirmation = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 32) {
                    infoSection(title: "Co zapisujemy") {
                        Text("Twoje dane są przechowywane lokalnie na urządzeniu. Nie tworzysz konta i nie wysyłamy niczego na serwer.")
                            .foregroundStyle(.secondary)
                        VStack(alignment: .leading, spacing: 8) {
                            row("Zdarzenia cravingów")
                            row("Zdarzenia slipów")
                        }
                    }

                    infoSection(title: "Gdzie są dane") {
                        Text("Dane zostają wyłącznie na tym urządzeniu. Brak konta. Brak synchronizacji. Brak kopii w chmurze.")
                            .foregroundStyle(.secondary)
                    }

                    infoSection(title: "Usuń dane") {
                        Text("Możesz usunąć wszystkie lokalne dane w dowolnym momencie.")
                            .foregroundStyle(.secondary)
                        Button("Usuń wszystkie dane lokalne", role: .destructive) {
                            showingDeleteConfirmation = true
                        }
                        .frame(maxWidth: .infinity)
                        .buttonStyle(.bordered)
                        .controlSize(.regular)
                    }

                    infoSection(title: "Informacja medyczna") {
                        Text("pauseo.app wspiera budowanie nawyków i rozpoznawanie triggerów. Nie zastępuje porady lekarza, terapeuty ani farmaceuty. Jeśli rozważasz leki, nikotynową terapię zastępczą albo masz silne objawy odstawienia, skonsultuj się ze specjalistą.")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                    }
                }
                .padding()
            }
            .navigationTitle("Prywatność i dane")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Gotowe") { dismiss() }
                }
            }
            .alert("Usuń wszystkie dane?", isPresented: $showingDeleteConfirmation) {
                Button("Usuń", role: .destructive) { eventStore.deleteAll() }
                Button("Anuluj", role: .cancel) {}
            } message: {
                Text("Wszystkie zdarzenia cravingów i slipów zostaną trwale usunięte. Tej operacji nie można cofnąć.")
            }
        }
    }

    @ViewBuilder
    private func infoSection<Content: View>(
        title: String,
        @ViewBuilder content: () -> Content
    ) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.headline)
            content()
        }
    }

    private func row(_ text: String) -> some View {
        Label(text, systemImage: "iphone")
            .font(.subheadline)
            .foregroundStyle(.secondary)
    }
}

#Preview {
    PrivacySafetyView()
        .environmentObject(EventStore())
}
