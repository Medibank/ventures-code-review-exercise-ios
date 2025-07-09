import Foundation

class SourcesViewModel: ObservableObject {
    @Published var allSources: [Source] = []
    @Published var selectedSources: [Source] = Persistence.loadSources()
    @Published var isLoading = false
    @Published var error: String?

    func fetchSources() {
        isLoading = true
        NewsAPIClient.fetchSources { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let sources):
                    self?.allSources = sources
                    // Preselect if none are previously selected
                    if self?.selectedSources.isEmpty ?? true {
                        self?.selectedSources = sources.prefix(3).map { $0 }
                        self?.persistSelectedSources()
                    }
                case .failure(let error):
                    self?.error = error.localizedDescription
                }
            }
        }
    }

    func toggleSelection(for source: Source) {
        if let idx = selectedSources.firstIndex(of: source) {
            selectedSources.remove(at: idx)
        } else {
            selectedSources.append(source)
        }
        persistSelectedSources()
    }

    func isSelected(_ source: Source) -> Bool {
        selectedSources.contains(source)
    }

    func persistSelectedSources() {
        Persistence.saveSources(selectedSources)
    }
}