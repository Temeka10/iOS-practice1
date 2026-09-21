# BookTracker (Практична 2)

## Архітектура: MVVM
Проєкт використовує архітектуру **MVVM** (Model-View-ViewModel), оскільки вона найкраще підходить для SwiftUI завдяки реактивному зв'язуванню даних (`@Published`, `ObservableObject`).
**Схема взаємодії:**
`View` -> спостерігає за -> `ViewModel` -> викликає -> `Service` -> створює -> `Model`

## Патерни проєктування
1. **Породжувальний: Builder (`BookBuilder`)**
   - *Задача:* Покрокове створення об'єкта `Book` з можливістю пропускати необов'язкові поля.
   - *Місце:* Використовується в `MockLibraryService` для створення тестових даних.
2. **Структурний: Adapter (`LegacyBookAdapter`)**
   - *Задача:* Адаптація застарілої моделі даних `LegacyBookData` до актуальної структури `Book`.
   - *Місце:* Використовується в `MockLibraryService`.
3. **Поведінковий: Strategy (`SortStrategy`)**
   - *Задача:* Інкапсуляція алгоритму сортування списку книг.
   - *Місце:* Використовується у `BookListViewModel` для гнучкого сортування масиву.

## Принципи SOLID
- **S (Single Responsibility):** `BookListView` відповідає лише за UI, `BookListViewModel` — за логіку підготовки даних, `MockLibraryService` — за постачання даних.
- **O (Open/Closed):** Щоб додати нове сортування, достатньо створити нову структуру, що реалізує `SortStrategy`, не змінюючи наявний код ViewModel.
- **L (Liskov Substitution) & D (Dependency Inversion):** ViewModel залежить від абстракції `LibraryServiceProtocol`. Ми можемо легко підмінити `MockLibraryService` на реальну базу даних, і програма продовжить працювати без змін у ViewModel.

## Антипатерни та їх уникнення
- **Massive View:** Уникнено завдяки винесенню бізнес-логіки та доступу до даних у ViewModel та Service.
- **Приховані залежності / Singleton:** Замість глобальних синглтонів використано Dependency Injection (передача залежностей через ініціалізатор у `practice_1App.swift`).
- **Пряме поєднання UI з даними:** View нічого не знає про Service, взаємодія відбувається виключно через ViewModel.
