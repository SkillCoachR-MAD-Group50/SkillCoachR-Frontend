# SkillCoachR

An AI-driven learning companion that helps users build personalized learning roadmaps, assess their skills, perform gap analysis, and receive weekly recommendations to achieve their goals.

## 🌟 Key Features

* **Authentication:** Secure sign-in and sign-up using Firebase Auth.
* **Onboarding & Profile Setup:** A comprehensive 5-step onboarding flow to understand user goals, current skills, and timeline.
* **Skill Assessment & Gap Analysis:** Evaluate current proficiency levels and identify the learning gap.
* **AI-Driven Roadmaps:** Generate custom, actionable learning roadmaps using the Groq API.
* **Progress Tracking:** Monitor milestones and daily/weekly tasks from a unified dashboard.

## 🏗️ Architecture & Technology Stack

SkillCoachR is built with a modern, scalable architecture using the following technologies:

### Frontend
* **Framework:** [Flutter](https://flutter.dev/) (Cross-platform UI toolkit)
* **State Management:** [Riverpod](https://riverpod.dev/) (`flutter_riverpod`, `riverpod_annotation`)
* **Routing:** [GoRouter](https://pub.dev/packages/go_router) for deep linking and declarative routing.
* **UI/UX:** Neo-Brutalist inspired design with `fl_chart` for data visualization, `google_fonts`, and `phosphor_flutter` for icons.

### Backend & AI
* **Backend as a Service:** [Firebase](https://firebase.google.com/) (Authentication, Cloud Firestore)
* **Cloud Functions:** Firebase Cloud Functions for secure server-side logic and AI integration.
* **AI Engine:** Groq API integration for generating personalized learning recommendations and roadmap milestones.

## 📂 Project Structure

The project follows a feature-first, layered architecture approach within the `lib/` directory:

```text
lib/
├── core/
│   ├── routing/       # GoRouter configuration (app_router.dart)
│   ├── theme/         # Application theme definitions
│   └── models/        # Shared data models
├── features/
│   ├── assessment/    # Skill assessment & gap analysis screens
│   ├── auth/          # Login and registration
│   ├── home/          # Main home screen
│   ├── profile/       # User profile management
│   ├── profile_setup/ # 5-step onboarding workflow
│   ├── quiz/          # Quiz and testing features
│   ├── roadmap/       # AI-driven learning roadmap & dashboard
│   └── splash/        # Splash screen & initial auth routing
└── main.dart          # Application entry point
```

## 🚀 Getting Started

Follow these instructions to get a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

* [Flutter SDK](https://docs.flutter.dev/get-started/install) (version `>=3.10.0 <4.0.0`)
* [Firebase CLI](https://firebase.google.com/docs/cli) (installed and logged in)
* IDE: VS Code, Android Studio, or IntelliJ IDEA with Flutter/Dart plugins installed.

### Installation & Setup

1. **Clone the repository:**
   ```bash
   git clone <repository-url>
   cd SkillCoachR-Frontend
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Generate code (Riverpod, Freezed, etc.):**
   The project uses code generation for state management and routing.
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

4. **Configure Firebase:**
   Ensure you have a Firebase project created. Initialize Firebase for your platform:
   ```bash
   flutterfire configure
   ```
   This will generate the `lib/firebase_options.dart` file automatically.

5. **Run the application:**
   You can run the app on your preferred emulator or connected device:
   ```bash
   flutter run
   ```

## 🛠️ Development Guidelines

* **State Management:** Use Riverpod `@riverpod` annotations for providers. Avoid managing complex state inside `StatefulWidget`.
* **Routing:** Always use `context.go()` or `context.push()` provided by GoRouter. Do not use standard `Navigator`.
* **Theming:** Rely on `AppTheme` properties rather than hardcoding colors and text styles.
