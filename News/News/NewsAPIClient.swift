import Foundation

struct NewsAPIClient {
    static let apiKey = "<#YOUR_NEWSAPI_KEY#>"
    static let baseURL = "https://newsapi.org/v2"

    static func fetchSources(completion: @escaping (Result<[Source], Error>) -> Void) {
        let urlString = "\(baseURL)/sources?language=en&apiKey=\(apiKey)"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error { completion(.failure(error)); return }
            guard let data = data else { completion(.failure(NSError())); return }
            do {
                let result = try JSONDecoder().decode(SourcesResponse.self, from: data)
                completion(.success(result.sources))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    static func fetchHeadlines(sources: [Source], completion: @escaping (Result<[Article], Error>) -> Void) {
        let sourcesParam = sources.map { $0.id }.joined(separator: ",")
        let urlString = "\(baseURL)/top-headlines?sources=\(sourcesParam)&apiKey=\(apiKey)"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error { completion(.failure(error)); return }
            guard let data = data else { completion(.failure(NSError())); return }
            do {
                let result = try JSONDecoder().decode(ArticlesResponse.self, from: data)
                let articles = result.articles.map { $0.toArticle() }
                completion(.success(articles))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

// MARK: - API Responses

private struct SourcesResponse: Codable {
    let sources: [Source]
}

private struct ArticlesResponse: Codable {
    let articles: [ArticleDTO]
}

private struct ArticleDTO: Codable {
    let title: String
    let description: String?
    let author: String?
    let url: String
    let urlToImage: String?
    let source: Source

    func toArticle() -> Article {
        Article(title: title, description: description, author: author, url: url, urlToImage: urlToImage, source: source)
    }
}
