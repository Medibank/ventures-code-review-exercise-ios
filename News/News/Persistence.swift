import Foundation

struct Persistence {
    static let savedArticlesKey = "savedArticles"
    static let selectedSourcesKey = "selectedSources"

    static func saveArticles(_ articles: [Article]) {
        if let data = try? JSONEncoder().encode(articles) {
            UserDefaults.standard.set(data, forKey: savedArticlesKey)
        }
    }

    static func loadArticles() -> [Article] {
        guard let data = UserDefaults.standard.data(forKey: savedArticlesKey),
              let articles = try? JSONDecoder().decode([Article].self, from: data) else {
            return []
        }
        return articles
    }

    static func saveSources(_ sources: [Source]) {
        if let data = try? JSONEncoder().encode(sources) {
            UserDefaults.standard.set(data, forKey: selectedSourcesKey)
        }
    }

    static func loadSources() -> [Source] {
        guard let data = UserDefaults.standard.data(forKey: selectedSourcesKey),
              let sources = try? JSONDecoder().decode([Source].self, from: data) else {
            return []
        }
        return sources
    }
}