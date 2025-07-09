import XCTest
@testable import News

class ArticlesHeadlinesAppTests: XCTestCase {
    func testArticlePersistence() {
        let article = Article(title: "Test", description: "Testing", author: "Author", url: "https://example.com", urlToImage: nil, source: Source(id: "abc", name: "Test Source"))
        Persistence.saveArticles([article])
        let loaded = Persistence.loadArticles()
        XCTAssertEqual(loaded, [article])
    }

    func testSourcePersistence() {
        let source = Source(id: "abc", name: "News")
        Persistence.saveSources([source])
        let loaded = Persistence.loadSources()
        XCTAssertEqual(loaded, [source])
    }

    func testToggleSourceSelection() {
        let vm = SourcesViewModel()
        let source = Source(id: "abc", name: "News")
        vm.allSources = [source]
        vm.toggleSelection(for: source)
        XCTAssertTrue(vm.selectedSources.contains(source))
        vm.toggleSelection(for: source)
        XCTAssertFalse(vm.selectedSources.contains(source))
    }
}
