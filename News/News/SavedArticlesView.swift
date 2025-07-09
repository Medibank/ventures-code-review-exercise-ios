import SwiftUI

struct SavedArticlesView: View {
    @EnvironmentObject var savedVM: SavedViewModel
    @State private var selectedArticle: Article?
    @State private var showSafari = false

    var body: some View {
        NavigationView {
            List {
                ForEach(savedVM.savedArticles) { article in
                    ArticleRow(article: article)
                        .onTapGesture {
                            selectedArticle = article
                            showSafari = true
                        }
                }
                .onDelete(perform: delete)
            }
            .navigationTitle("Saved")
            .sheet(isPresented: $showSafari) {
                if let urlString = selectedArticle?.url, let url = URL(string: urlString) {
                    SafariView(url: url)
                }
            }
            .toolbar {
                EditButton()
            }
        }
    }

    func delete(at offsets: IndexSet) {
        for idx in offsets {
            let article = savedVM.savedArticles[idx]
            savedVM.remove(article)
        }
    }
}