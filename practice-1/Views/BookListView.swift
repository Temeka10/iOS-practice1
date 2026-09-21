//
//  BookListView.swift
//  practice-1
//
//  Created by Artem Mandych on 21.09.2026.
//

import SwiftUI
import Combine
struct BookListView: View {
    @StateObject var viewModel: BookListViewModel
    @EnvironmentObject var router: AppRouter // Отримуємо роутер з середовища
    
    var body: some View {
        NavigationStack(path: $router.path) { // Підключаємо шлях Router'а
            List(viewModel.books) { book in
                // Перехід на екран деталей (Push)
                Button(action: { router.push(to: .detail(book)) }) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(book.title).font(.headline)
                            Text(book.author).font(.subheadline).foregroundColor(.gray)
                        }
                        Spacer()
                        if book.isFavorite {
                            Image(systemName: "heart.fill").foregroundColor(.red)
                        }
                    }
                }
                .foregroundColor(.primary)
            }
            .navigationTitle("Мої книги")
            .toolbar {
                // Відкриття модального вікна
                Button(action: { router.presentSheet(.addBook) }) {
                    Image(systemName: "plus")
                }
            }
            .onAppear { viewModel.loadBooks() }
            
            // Обробка переходів (Push)
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .detail(let book):
                    BookDetailView(book: book, onFavoriteToggle: { id in
                        viewModel.toggleFavorite(for: id)
                    })
                }
            }
            // Обробка модальних вікон (Sheet)
            .sheet(item: $router.activeSheet) { sheet in
                switch sheet {
                case .addBook:
                    AddBookView(onSave: { newBook in
                        viewModel.addBook(newBook)
                    })
                }
            }
        }
    }
}
