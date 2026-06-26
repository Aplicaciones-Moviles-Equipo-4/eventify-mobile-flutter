# Eventify Hosts Application Development

Implement a Flutter mobile application for event hosts using the provided specifications, including Riverpod for state management, Dio for HTTP, and GoRouter for navigation.

## User Review Required

> [!NOTE]
> The implementation will follow the provided folder structure and technical stack.
> The backend URL is fixed to `https://eventify-platform.onrender.com/api/v1`.

## Proposed Changes

### Configuration & Setup

#### [pubspec.yaml](file:///C:/Users/RIPLEY/AndroidStudioProjects/eventify_amfitriones/pubspec.yaml)
- Add dependencies: `flutter_riverpod`, `riverpod`, `dio`, `json_annotation`, `go_router`, `flutter_secure_storage`, `shared_preferences`, `google_fonts`, `intl`, `uuid`, `freezed_annotation`.
- Add dev_dependencies: `build_runner`, `json_serializable`, `freezed`.

#### [NEW] [env.dart](file:///C:/Users/RIPLEY/AndroidStudioProjects/eventify_amfitriones/lib/config/env.dart)
- Define base URL and timeouts.

#### [NEW] [app_router.dart](file:///C:/Users/RIPLEY/AndroidStudioProjects/eventify_amfitriones/lib/config/router/app_router.dart)
- Configure GoRouter with all specified routes (Login, Register, Dashboard, Quotes, Events, Profile).

---

### Core & Data Layer

#### [NEW] [api_client.dart](file:///C:/Users/RIPLEY/AndroidStudioProjects/eventify_amfitriones/lib/data/datasources/remote/api_client.dart)
- Singleton Dio instance with `AuthInterceptor` and `LoggingInterceptor`.

#### [NEW] Models
- Implement `UserModel`, `ProfileModel`, `QuoteModel`, `ServiceItemModel`, `ReviewModel`, `SocialEventModel` using `json_serializable` and `freezed`.

#### [NEW] Services
- Implement `AuthService`, `ProfileService`, `QuoteService`, `OrganizerService`, `ReviewService`, `EventService`.

---

### Presentation Layer (Riverpod)

#### [NEW] Providers
- Implement `AuthNotifier`, `ProfileNotifier`, `QuoteFormNotifier`, `OrganizersProvider`, etc., to manage application state.

---

### UI Implementation

#### [NEW] Screens
- Implement all screens: `LoginScreen`, `RegisterScreen`, `DashboardScreen`, `OrganizerDetailScreen`, `QuoteFormScreen`, `QuotesScreen`, `QuoteDetailScreen`, `EventsScreen`, `ProfileScreen`.

#### [NEW] Widgets
- Implement reusable widgets like `AppTextField`, `AppButton`, `LoadingOverlay`, `StatusBadge`, etc.

---

## Verification Plan

### Automated Tests
- Run `flutter test` (if applicable, basic unit tests for validators).
- Run `flutter pub run build_runner build` to ensure all code generation is correct.

### Manual Verification
- Verify Login/Register flow.
- Verify Organizer browsing and filtering.
- Verify Quote creation with service items.
- Verify Quote acceptance/rejection.
- Verify Event listing.
- Verify Profile editing.
- Verify persistent authentication via Secure Storage.
