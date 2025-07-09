import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var sourcesVM: SourcesViewModel
    @EnvironmentObject var savedVM: SavedViewModel

    var body: some View {
        TabView {
            HeadlinesView()
                .tabItem {
                    Label("Headlines", systemImage: "newspaper")
                }
            SourcesView()
                .tabItem {
                    Label("Sources", systemImage: "list.bullet")
                }
            SavedArticlesView()
                .tabItem {
                    Label("Saved", systemImage: "bookmark")
                }
        }
    }
}