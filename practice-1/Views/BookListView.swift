//
//  BookListView.swift
//  practice-1
//
//  Created by Artem Mandych on 21.09.2026.
//

import SwiftUI

struct BookListView: View {
    @StateObject var viewModel: BookListViewModel
    
    var body: some View {
        NavigationView {
            List(viewModel.books) { book in
                VStack(alignment: .leading) {
                    Text(book.title).font(.headline)
                    Text(book.author).font(.subheadline).foregroundColor(.gray)
                    Text(book.status.rawValue).font(.caption).foregroundColor(.blue)
                }
            }
            .navigationTitle("Мої книги")
            .onAppear {
                viewModel.loadBooks()
            }
        }
    }
}
