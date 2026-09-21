//
//  AddBookView.swift
//  practice-1
//
//  Created by Artem Mandych on 21.09.2026.
//

import SwiftUI
import Combine

struct AddBookView: View {
    @EnvironmentObject var router: AppRouter
    var onSave: (Book) -> Void
    
    @State private var title = ""
    @State private var author = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Інформація про книгу")) {
                    TextField("Назва книги", text: $title)
                    TextField("Автор", text: $author)
                }
            }
            .navigationTitle("Нова книга")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Скасувати") { router.dismissSheet() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Зберегти") {
                        let newBook = Book(id: UUID(), title: title, author: author, status: .unread)
                        onSave(newBook)
                        router.dismissSheet() // Повернення назад (сховати модалку)
                    }
                    .disabled(title.isEmpty || author.isEmpty) // Блокування, якщо порожньо
                }
            }
        }
    }
}
