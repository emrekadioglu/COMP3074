# COMP3074 – Lab 4 (Room + Jetpack Compose) – Reflection Answers

1. **Is Room a replacement for SQLite, or an abstraction over SQLite?** An abstraction. Data is still stored in a SQLite database; Room generates the repetitive access code on top of it.
2. **Role of @Entity?** Marks a Kotlin class as a database table; each object is one row, each property a column.
3. **Role of a DAO?** Defines the allowed database operations (insert, delete, update, queries) as an interface; Room generates the implementation.
4. **Why are insert and delete suspend functions?** Database I/O is slow and must not block the main thread. Suspend functions run inside coroutines (viewModelScope) so the UI stays responsive.
5. **Why can a SELECT return Flow<List<Customer>>?** Room tracks the tables a query reads and re-runs it when they change, emitting a new list each time.
6. **Why is Cursor no longer visible?** Room maps result rows to Customer objects internally, so application code never touches a Cursor.
7. **Why does the list update without View All?** The UI collects a Flow; whenever the table changes Room emits a new list and Compose recomposes.
8. **Responsibility of CustomerViewModel?** Holds UI-related data, exposes the customer Flow, and launches database work (add/update/delete/search) in viewModelScope, keeping it out of composables.
9. **Advantages over SQLiteOpenHelper?** Less boilerplate, compile-time SQL validation, automatic object mapping, Boolean mapping, Flow support, cleaner separation (DAO/ViewModel).
10. **What did direct SQLite teach that Room hides?** Manual CREATE TABLE SQL, ContentValues, Cursor iteration, Boolean-to-int conversion, and manual refresh of the list.
