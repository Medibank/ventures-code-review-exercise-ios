import Foundation
import Combine

class HeadlinesViewModel: ObservableObject {
    @Published var articles: [Article] = []
    @Published var isLoading = false
    @Published var error: String?

    private var cancellables = Set<AnyCancellable>()

    func fetchHeadlines(for sources: [Source]) {
        guard !sources.isEmpty else {
            self.articles = []
            return
        }
        isLoading = true
        NewsAPIClient.fetchHeadlines(sources: sources) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let articles):
                    self?.articles = articles
                    self?.error = nil
                case .failure(let error):
                    self?.error = error.localizedDescription
                }
            }
        }
    }
}