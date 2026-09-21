//
//  practice_1App.swift
//  practice-1
//
//  Created by Artem Mandych on 21.09.2026.
//

import SwiftUI

@main
struct practice_1App: App {
    var body: some Scene {
        WindowGroup {
            // Передаємо залежності ззовні (Dependency Injection)
            BookListView(
                viewModel: BookListViewModel(
                    service: MockLibraryService(),
                    sortStrategy: TitleSortStrategy()
                )
            )
        }
    }
}
