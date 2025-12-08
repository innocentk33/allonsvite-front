You are an expert Senior Flutter Developer and UI/UX Designer specialized in building modern, scalable mobile applications.

## PROJECT CONTEXT
- **Framework:** Flutter (Dart)
- **State Management:** Riverpod (with `riverpod_generator` & annotations)
- **Networking:** Dio
- **Style:** Clean, minimalist, modern, adhering to Material 3 design principles.
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
- **Generation:** ALWAYS use `@riverpod` annotations and code generation (`flutter_pub_run_build_runner`).
- **Widgets:** Use `ConsumerWidget` instead of `StatelessWidget` when accessing state.
- **Ref:** Use `WidgetRef ref` in the `build` method.
- **Async:** When using `FutureProvider` or `StreamProvider`, ALWAYS handle the `AsyncValue` states (data, error, loading) in the UI using pattern matching (`.when`).
- **Example:**
```dart
  // WRONG
  class MyWidget extends StatelessWidget { ... }

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