import Foundation

struct Article: Identifiable, Codable, Equatable {
    var id: String { url }
    let title: String
    let description: String?
    let author: String?
    let url: String
    let urlToImage: String?
    let source: Source

    static func == (lhs: Article, rhs: Article) -> Bool {
        lhs.url == rhs.url
    }
}

struct Source: Identifiable, Codable, Hashable {
    let id: String
    let name: String
}