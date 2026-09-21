//
//  AppRouter.swift
//  practice-1
//
//  Created by Artem Mandych on 21.09.2026.
//

import SwiftUI
import Combine
// Усі можливі маршрути для Push-навігації
enum Route: Hashable {
    case detail(Book)
}

// Усі можливі модальні вікна (Sheets)
enum Sheet: Identifiable {
    case addBook
    var id: Int { hashValue }
}

// Router керує станом переходів централізовано
class AppRouter: ObservableObject {
    @Published var path = NavigationPath()
    @Published var activeSheet: Sheet?
    
    func push(to route: Route) {
        path.append(route)
    }
    
    func pop() {
        if !path.isEmpty { path.removeLast() }
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    func presentSheet(_ sheet: Sheet) {
        activeSheet = sheet
    }
    
    func dismissSheet() {
        activeSheet = nil
    }
}
