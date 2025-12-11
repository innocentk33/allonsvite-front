You are an expert Senior Flutter Developer and UI/UX Designer specialized in building modern, scalable mobile applications.
# Project: Allons Vite (Carpooling MVP - Côte d'Ivoire)
## Tech Stack & Architecture
- **Framework:** Flutter (Dart)
- **Architecture:** Feature-First Clean Architecture (Pragmatic/Simplified).
- **State Management:** Riverpod (with `riverpod_generator` & annotations `@riverpod`)
- **Navigation:** GoRouter.
- **Networking:** Dio
- **Functional Programming:** fpdart (used for error handling in the Data Layer).
- **Error Handling:** fpdart (`Either`, `Option`, `Unit`).
- **Style:** Clean, minimalist, modern, adhering to Material 3 design principles.
- **Local Storage:** FlutterSecureStorage (Sensitive data) & SharedPreferences (Flags).
- **Icon Pack:** lucide_icons
- **Fonts:** - Headings/Buttons: "Jokker" (Local)
    - Body Text: "Inter" (Google Fonts)

## CODE STYLE & RULES

### 1. General Flutter Best Practices
- **Const Correctness:** Always use `const` constructors for widgets that do not change.
- **Null Safety:** Strictly adhere to null safety. Avoid `!` (bang operator).
- **Structure:** Feature-based architecture (e.g., `lib/features/auth/`).
- **Imports:** Use relative imports for files within the same feature.

### 2. State Management (Riverpod) - STRICT
- **Command:** ALWAYS use `fvm` before run any command in terminal and code generation exmple : (`fvm flutter pub get`).
- **Generation:** ALWAYS use `@riverpod` annotations and code generation (`fvm dart run build_runner watch --delete-conflicting-outputs`).
- **Widgets:** Use `ConsumerWidget` instead of `StatelessWidget` when accessing state.
- **Ref:** Use `WidgetRef ref` in the `build` method.
- **Async:** When using `FutureProvider` or `StreamProvider`, ALWAYS handle the `AsyncValue` states (data, error, loading) in the UI using pattern matching (`.when`).
- 
- **Example:**
```dart
  // WRONG
  class MyWidget extends StatelessWidget {  }

  // RIGHT
  class MyWidget extends ConsumerWidget {
    @override
    Widget build(BuildContext context, WidgetRef ref) {
      final value = ref.watch(myProvider);
      return value.when(
        data: (data) => Text(data),
        loading: () => const CircularProgressIndicator(),
        error: (err, stack) => Text('Error: $err'),
      );
    }
  }
  ```
### 3. Folder Structure (Feature-First)

Files MUST be organized by **Feature**, then by **Layer**.

``` text
lib/src/features/
  ├── auth/                  # Feature Name
  │   ├── data/              # Repositories, DataSources, Providers
  │   ├── domain/            # Models/Entities (with fromJson Pure Dart)
  │   ├── presentation/      # Screens, Widgets, Controllers
  ├── trips/
  │   ├── ...
Shared UI: lib/src/core/widgets/

Routing: lib/src/router/app_router.dart

Core logic: lib/src/core/ (Exceptions, Extensions, Theme).
```
------------------------------------------------------------------------

## 3. Architecture Rules by Layer

### A. Domain Layer (Pragmatic)

-   Contains Data Models (Entities).
-   **No Riverpod in Entities.**
-   **Serialization: Classes SHOULD include fromJson and toJson methods to avoid creating separate DTOs.**
-   **Dependencies: Keep it as pure as possible, but basic Flutter types (e.g., Color, VoidCallback) are allowed if it simplifies UI binding.**
-   **Logic: Can contain basic helper getters (e.g., User.isProfileComplete or Trip.formattedDate).**

### B. Data Layer

-   **Pattern: Repository Pattern with separate Data Sources.**
  - **Separation**:
    - RemoteDataSource: Handles API calls (Dio). 
    - LocalDataSource: Handles FlutterSecureStorage and SharedPreferences. 
    - Repository: Orchestrates data fetching (Remote + Local).
  - **Injection**:
    - NEVER pass `Ref` inside a Repository class. 
    - Dependencies must be injected via the constructor. 
    - Use a `feature_providers.dart `file in the `data` folder to wire everything up using Riverpod.
  - **Error Handling (fpdart)**:
  - Repositories MUST catch exceptions from DataSources. 
  - Repositories MUST return `Future<Either<Failure, T>>`. 
  - NEVER throw exceptions to the Domain/Presentation layer.
  - **Example**:
```dart
Future<Either<Failure, Unit>> login(String phone) async {
  try {
    // remoteDataSource returns a User model directly (no DTO conversion needed)
    final user = await _remoteDataSource.login(phone);
    await _localDataSource.saveToken(user.token);
    return right(unit);
  } catch (e) {
    return left(Failure(e.toString()));
  }
}
```

------------------------------------------------------------------------

### C. Presentation Layer (UI & State)

#### Controllers:

-   Use `@riverpod` + AsyncNotifier / Notifier.
-   Expose `AsyncValue<T>`.
-   Call Repository methods.
-   Use `.fold()` to handle Either.
-   **No navigation inside controllers.**

#### Widgets:

-   Use `ConsumerWidget` / `ConsumerStatefulWidget`.
-   Use `ref.listen` for side effects (navigation, snackbars).
-   UI must contain **no business logic**.

#### Example:

```dart
@riverpod
class AuthController extends _$AuthController {
  @override
  FutureOr<void> build() {}

  Future<void> login(String phone) async {
    state = const AsyncLoading();
    final repo = ref.read(authRepositoryProvider);
    final result = await repo.login(phone);

    state = result.fold(
      (failure) => AsyncError(failure.message, StackTrace.current),
      (success) => const AsyncData(null),
    );
  }
}
```

------------------------------------------------------------------------

## 4. Navigation Rules (GoRouter)

-   Centralized in `app_router.dart`.
-   Use `redirect` for auth/profile guards.
-   Redirection uses:
    -   token presence
    -   profile completion flag
-   Router must be reactive to Auth state.
-   UI triggers navigation; Router decides final destination.

------------------------------------------------------------------------
## 5. Critical Business Logic & Patterns

### A. Authentication Flow

1.  Phone Input → Request OTP\
2.  OTP Input → Verify\
3.  On success:
    -   Save Token
    -   Fetch User Profile (API). if not exists → go to Create Profile. else → go to Home.
    -   Save `is_profile_completed`

**Rules:** - If not completed → `/create-profile` - If completed →
`/home`
### C. Profile Update API

Endpoint: `POST /api/me/update`\
Required: `phone`, `firstname`, `lastname`.

-   Repository must read phone from Local Storage before calling API.
## 6. Coding Standards

-   **Imports:** Relative for feature-internal files; package imports
    for core/shared.
-   **Async:** Prefer `async/await` over `.then()`.
-   **Linting:** Standard Flutter lints.
-   **Riverpod:**
    -   `ref.watch` inside build.
    -   `ref.read` in callbacks.
