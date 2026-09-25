# ## Практична робота 4: Мережевий шар (Networking)

### Джерело даних (API)
У проєкті використано відкрите API **Open Library**.
- **Базова адреса:** `https://openlibrary.org`
- **Endpoint:** `/search.json`
- **Параметри:** `q=ios+development` (пошук), `limit=10` (кількість).
- **Формат:** JSON. Відповідь містить масив об'єктів `docs`. Парсинг виконується за допомогою `Decodable` (DTO моделі `OpenLibraryResponse`, `OpenLibraryBook`).
- **Авторизація:** Не вимагається (відкрите API).

### Мережевий компонент та Архітектура
Мережевий шар відокремлено за допомогою патерну Dependency Injection.
- Використовується нативний `URLSession` та сучасний concurrency (`async/await`).
- Сервіс `RemoteLibraryService` імплементує протокол `LibraryServiceProtocol`.
- Усі мережеві виклики відв'язані від View. ViewModel обробляє стани (`.loading`, `.success`, `.error`, `.empty`) і гарантує оновлення UI на `@MainActor` (головному потоці).

### Обробка відмов
Створено спеціальний `enum NetworkError : LocalizedError` для типізації відмов:
1. Некоректний URL (`invalidURL`)
2. Транспортна помилка — немає інтернету (`transportError`)
3. Невдалий HTTP-статус, наприклад 404 або 500 (`invalidResponse(Int)`)
4. Помилка парсингу JSON (`decodingError`)

### Як перевірити негативні сценарії:
У файлі `practice_1App.swift` можна передати `MockFailingLibraryService()` замість `RemoteLibraryService()` у ViewModel. 
Цей Mock-сервіс керовано викидає 500-ту помилку сервера (HTTP Status Error) з затримкою в 1 секунду. При цьому на екрані відобразиться користувацьке повідомлення про помилку та кнопка "Повторити запит".
