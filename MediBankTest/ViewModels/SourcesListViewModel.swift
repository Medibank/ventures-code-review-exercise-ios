import Foundation

final class SourcesListViewModel {
    var data: Boxing<[ArticleEntity]> = Boxing([])

    func getStoredData() {
        data.value =  HeadlinesListData.shared.getHeadlines()
    }
    
}
