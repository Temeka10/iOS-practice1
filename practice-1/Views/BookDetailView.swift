//
//  BookDetailView.swift
//  practice-1
//
//  Created by Artem Mandych on 21.09.2026.
//

import SwiftUI

struct BookDetailView: View {
    @State var book: Book
    var onFavoriteToggle: (UUID) -> Void
    
    // Стан для кастомної анімації серця
    @State private var scale: CGFloat = 1.0
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "book.closed.fill")
                .font(.system(size: 80))
                .foregroundColor(.blue)
                .padding(.top, 40)
            
            Text(book.title).font(.largeTitle).bold()
            Text(book.author).font(.title2).foregroundColor(.secondary)
            Text(book.status.rawValue).font(.headline).foregroundColor(.blue)
            
            Spacer()
            
            // Завдання: Власна анімація
            Button(action: {
                book.isFavorite.toggle()
                onFavoriteToggle(book.id)
                
                // Пружинна анімація збільшення
                withAnimation(.spring(response: 0.3, dampingFraction: 0.5)) {
                    scale = 1.5
                }
                // Повернення до звичайного розміру
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    withAnimation { scale = 1.0 }
                }
            }) {
                HStack {
                    Image(systemName: book.isFavorite ? "heart.fill" : "heart")
                    Text(book.isFavorite ? "В улюбленому" : "Додати в улюблені")
                }
                .font(.title2)
                .foregroundColor(book.isFavorite ? .red : .gray)
                .scaleEffect(scale) // Застосування анімації
            }
            .padding(.bottom, 50)
        }
        .padding()
        .navigationTitle("Деталі")
        .navigationBarTitleDisplayMode(.inline)
    }
}
