import Foundation

class HeadlinesListData {
    
    private var headlinesList = [ArticleEntity]()
    
    static let shared = HeadlinesListData()
    
    private init() {}
    
    func getHeadlines() -> [ArticleEntity] {
        return headlinesList
    }
    
    func setHeadlines(data: [ArticleEntity]) {
        headlinesList = data
    }
    
}
