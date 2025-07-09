import SwiftUI

struct SourcesView: View {
    @EnvironmentObject var vm: SourcesViewModel

    var body: some View {
        NavigationView {
            Group {
                if vm.isLoading {
                    ProgressView("Loading...")
                } else if let error = vm.error {
                    Text("Error: \(error)")
                } else {
                    List(vm.allSources) { source in
                        HStack {
                            Text(source.name)
                            Spacer()
                            if vm.isSelected(source) {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.blue)
                            }
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            vm.toggleSelection(for: source)
                        }
                    }
                    .listStyle(InsetGroupedListStyle())
                }
            }
            .navigationTitle("Sources")
            .toolbar {
                Button("Reload") {
                    vm.fetchSources()
                }
            }
            .onAppear {
                if vm.allSources.isEmpty {
                    vm.fetchSources()
                }
            }
        }
    }
}