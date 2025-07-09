import SwiftUI

struct ArticleRow: View {
    var article: Article

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            // For image loading: Use AsyncImage (iOS 15+) or Kingfisher if needed
            if let urlString = article.urlToImage, let url = URL(string: urlString) {
                AsyncImage(url: url) { image in
                    image.resizable().aspectRatio(contentMode: .fill)
                } placeholder: {
                    Color.gray.opacity(0.2)
                }
                .frame(width: 80, height: 80)
                .clipped()
                .cornerRadius(8)
            } else {
                Color.gray.opacity(0.1)
                    .frame(width: 80, height: 80)
                    .cornerRadius(8)
            }
            VStack(alignment: .leading, spacing: 6) {
                Text(article.title)
                    .font(.headline)
                    .lineLimit(2)
                if let desc = article.description {
                    Text(desc)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                }
                HStack {
                    Text(article.source.name)
                        .font(.caption)
                        .foregroundColor(.blue)
                    if let author = article.author {
                        Text("• \(author)")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
            }
        }
        .padding(.vertical, 6)
    }
}