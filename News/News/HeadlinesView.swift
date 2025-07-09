import SwiftUI

struct HeadlinesView: View {
    @EnvironmentObject var sourcesVM: SourcesViewModel
    @EnvironmentObject var savedVM: SavedViewModel
    @StateObject private var vm = HeadlinesViewModel()
    @State private var selectedArticle: Article?
    @State private var showSafari = false

    var body: some View {
        NavigationView {
            Group {
                if vm.isLoading {
                    ProgressView("Loading...")
                } else if let error = vm.error {
                    Text("Error: \(error)")
                } else if vm.articles.isEmpty {
                    Text("No articles. Select sources in the Sources tab.")
                        .multilineTextAlignment(.center)
                } else {
                    List(vm.articles) { article in
                        ArticleRow(article: article)
                            .onTapGesture {
                                selectedArticle = article
                                showSafari = true
                            }
                            .swipeActions(edge: .trailing) {
                                Button {
                                    savedVM.save(article)
                                } label: {
                                    Label("Save", systemImage: "bookmark")
                                }
                                .tint(.blue)
                            }
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationTitle("Headlines")
            .onAppear {
                vm.fetchHeadlines(for: sourcesVM.selectedSources)
            }
            .sheet(isPresented: $showSafari) {
                if let urlString = selectedArticle?.url, let url = URL(string: urlString) {
                    SafariView(url: url)
                }
            }
            .onChange(of: sourcesVM.selectedSources) { newSources in
                vm.fetchHeadlines(for: newSources)
            }
        }
    }
}