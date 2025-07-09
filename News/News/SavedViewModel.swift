import Foundation

class SavedViewModel: ObservableObject {
    @Published var savedArticles: [Article] = Persistence.loadArticles()

    func isSaved(_ article: Article) -> Bool {
        savedArticles.contains(article)
    }

    func save(_ article: Article) {
        if !isSaved(article) {
            savedArticles.append(article)
            Persistence.saveArticles(savedArticles)
        }
    }

    func remove(_ article: Article) {
        savedArticles.removeAll { $0 == article }
        Persistence.saveArticles(savedArticles)
    }
}