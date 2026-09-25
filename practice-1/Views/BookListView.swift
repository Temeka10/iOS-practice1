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
    @EnvironmentObject var router: AppRouter
    
    var body: some View {
        NavigationStack(path: $router.path) {
            Group {
                switch viewModel.state {
                case .idle, .loading:
                    ProgressView("Завантаження книг...")
                        .scaleEffect(1.5)
                    
                case .empty:
                    VStack {
                        Image(systemName: "tray")
                            .font(.system(size: 50))
                            .foregroundColor(.gray)
                        Text("Книг не знайдено.")
                            .font(.title2)
                            .padding()
                        Button("Оновити", action: viewModel.loadBooks)
                    }
                    
                case .error(let message):
                    VStack(spacing: 16) {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .font(.system(size: 50))
                            .foregroundColor(.red)
                        Text("Виникла помилка")
                            .font(.title2).bold()
                        Text(message)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.secondary)
                            .padding(.horizontal)
                        
                        Button(action: viewModel.loadBooks) {
                            Text("Повторити запит")
                                .bold()
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                    
                case .success:
                    List(viewModel.books) { book in
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
                }
            }
            .navigationTitle("Мої книги")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: { router.presentSheet(.addBook) }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .onAppear {
                if case .idle = viewModel.state {
                    viewModel.loadBooks()
                }
            }
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .detail(let book):
                    BookDetailView(book: book, onFavoriteToggle: { id in
                        viewModel.toggleFavorite(for: id)
                    })
                }
            }
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
