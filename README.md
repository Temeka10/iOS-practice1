# Практична робота 3: Навігація та Сценарії

### Карта навігації
**BookListView (Головний екран)**
   - `NavigationStack` зі списком усіх книг.
   - ➡️ *Дія:* Тап на книгу -> Push-перехід -> `BookDetailView`   
   - ➡️ *Дія:* Тап на "+" -> Modal (Sheet) -> `AddBookView`
[Список](/Users/mac/Desktop/ios_kpi/practice-1/docs/list.png)
[](docs/list.png)
**BookDetailView (Екран деталей)**
   - Показує повну інформацію про обрану сутність.
   - Має кастомну пружинну (spring) анімацію на кнопці "Додати в улюблені", яка змінює масштаб (scale) і колір. Дані оновлюються на попередньому екрані.
   - ⬅️ *Дія:* Кнопка "Back" -> Повернення до списку.
[Деталі](/Users/mac/Desktop/ios_kpi/practice-1/docs/detail.png)
**AddBookView (Створення)**
   - Форма для введення даних (Title, Author). Клавіатура не перекриває поля завдяки `Form`.
   - ⬅️ *Дія:* Зберегти/Скасувати -> Закриває модальне вікно та оновлює головний список.
[Додавання](/Users/mac/Desktop/ios_kpi/practice-1/docs/Add.png)
### Архітектура навігації
Реалізовано патерн **Router (Coordinator)** за допомогою класу `AppRouter : ObservableObject`. 
- `NavigationStack(path: $router.path)` керує Push-переходами (через Enum `Route`).
- Властивість `@Published var activeSheet: Sheet?` централізовано керує модальними вікнами.
- Передача даних працює через `Binding`/колбеки та оновлення стану у загальному сервісі (збереження в пам'яті).
