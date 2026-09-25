//
//  NetworkError.swift
//  practice-1
//
//  Created by Artem Mandych on 23.09.2026.
//

import Foundation

// Перелік можливих помилок під час мережевих запитів
enum NetworkError: Error, LocalizedError {
    case invalidURL
    case transportError(Error)
    case invalidResponse(Int)
    case decodingError(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Неправильна адреса сервера."
        case .transportError(let error):
            return "Помилка з'єднання: \(error.localizedDescription)"
        case .invalidResponse(let code):
            return "Сервер повернув помилку. HTTP Статус: \(code)"
        case .decodingError(let error):
            return "Помилка обробки даних: \(error.localizedDescription)"
        }
    }
}
