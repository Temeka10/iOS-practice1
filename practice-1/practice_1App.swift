//
//  practice_1App.swift
//  practice-1
//
//  Created by Artem Mandych on 21.09.2026.
//

import SwiftUI
import Combine
@main
struct practice_1App: App {
    // Створюємо глобальний роутер
    @StateObject private var router = AppRouter()
    
    var body: some Scene {
        WindowGroup {
            BookListView(
                viewModel: BookListViewModel(
                    service: RemoteLibraryService()
//                     service: MockFailingLibraryService()
                )
            )
            .environmentObject(router) // Впроваджуємо роутер у SwiftUI Environment
        }
    }
}
