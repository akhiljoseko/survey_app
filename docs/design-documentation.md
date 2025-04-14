# 🏫 School Surveys App – Complete Documentation  

## **📌 Overview**  
The **School Surveys App** is a Flutter application designed for managing school surveys with **offline-first** capabilities. It follows **Clean Architecture** principles and uses **Hive** for local data persistence.  

### **🔹 Key Features**  
✅ **Authentication** (Login, Sign Up, Forgot Password)  
✅ **Survey Management** (Create, View, Edit, Delete)  
✅ **Survey Commencement Wizard** (Multi-step form with resume capability)  
✅ **Offline-First** (All data stored locally using Hive)  
✅ **State Management** (Cubit + Equatable)  
✅ **Form Validation** (Reusable validation utilities)  
✅ **Dynamic Routing** (GoRouter for navigation)  

---

## **📐 Architecture Overview**  
The app follows **Clean Architecture** with clear separation of concerns:  

### **1. Domain Layer** (Business Logic)  
- **Entities**: Pure data models (`Survey`, `SchoolData`, `User`)  
- **Repositories**: Abstract contracts (`AuthenticationRepository`, `SurveyRepository`)  
- **Enums & Value Classes**: `SurveyStatus`, `SchoolType`, `GradeLevel`  

### **2. Data Layer** (Persistence)  
- **Hive Implementation**: Local database operations  
- **Repositories**: Concrete implementations (`AuthenticationRepositoryImpl`, `SurveyRepositoryImpl`)  
- **Adapters**: Hive type adapters for models  

### **3. Presentation Layer** (UI + State)  
- **Cubits**: State management per feature (`AuthCubit`, `AddSurveyCubit`)  
- **Screens**: UI pages (`LoginScreen`, `HomeScreen`, `SurveyMetaViewScreen`)  
- **Widgets**: Reusable components (`EmailTextField`, `PrimaryButton`)  

### **4. Core & Utilities**  
- **Routing**: `GoRouter` setup  
- **Exceptions**: Custom error handling (`AppException`, `DatabaseException`)  
- **Validation**: Form validation utilities  

---

## **📁 Detailed Folder Structure**  

### **`lib/app/`** (App Configuration)  
```
routing/  
├── app_routes.dart   # Route definitions  
├── router.dart       # GoRouter setup  
└── survey_app.dart   # Main app widget  
```

### **`lib/core/`** (Shared Utilities)  
```
├── app_exception.dart  # Custom exceptions  
└── result.dart        # Standardized `Result` pattern (Success/Error)  
```

### **`lib/data/`** (Persistence Layer)  
```
authentication/  
├── authentication_exceptions.dart  
└── authentication_repository_impl.dart  

hive/  
├── hive_adapters.dart       # Hive type adapters  
├── hive_local_database.dart # DB operations  
└── data_base_exceptions.dart  

survey/  
├── survey_exceptions.dart  
├── survey_repository_impl.dart  
└── survey_service.dart  
```

### **`lib/domain/`** (Business Logic)  
```
constants/  
├── curriculum.dart  
├── grade_level.dart  
└── school_type.dart  

entities/  
├── base_entity.dart  
├── school_data.dart  
├── survey.dart  
├── survey_general_data.dart  
└── user.dart  

enums/  
└── survey_status.dart  

repository/  
├── authentication_repository.dart  
└── survey_repository.dart  
```

### **`lib/view/`** (UI Layer)  
```
add_survey/  
├── cubit/  
│   ├── add_survey_cubit.dart  
│   └── add_survey_state.dart  
├── add_survey_screen.dart  
└── survey_form_validations.dart   

home/  
├── cubit/  
├── widgets/  
└── home_screen.dart  

widgets/  
├── email_textfield.dart  
├── inline_date_input_field.dart  
├── primary_button.dart  
└── user_drop_down_button.dart  
```

---

## **🔁 State Management (Cubit + Equatable)**  
Each feature has a dedicated **Cubit** that:  
- Manages UI state  
- Handles business logic  
- Communicates with repositories  

**Example: `AddSurveyCubit`**  
```dart
class AddSurveyCubit extends Cubit<AddSurveyState> {
  final SurveyRepository _surveyRepository;

  Future<void> createSurvey(Survey survey) async {
    emit(state.copyWith(status: LoadStatus.loading));
    try {
      await _surveyRepository.createSurvey(survey);
      emit(state.copyWith(status: LoadStatus.success));
    } catch (e) {
      emit(state.copyWith(status: LoadStatus.failure, error: e.toString()));
    }
  }
}
```

---

## **🔐 Authentication Flow (Hive-Based)**  
- **No Firebase**: All auth data stored in Hive  
- **GoRouter** handles protected routes  
- **Auth steps**:  
  1. `SplashScreen` → Checks auth state  
  2. `LoginScreen` / `SignUpScreen` → Credentials validated against Hive  
  3. `HomeScreen` → After successful login  

---

## **📋 Survey Management**  
### **Survey Model**  
```dart
class Survey extends Equatable {
  final String id;
  final String urn;
  final SurveyStatus status;
  final DateTime dueDate;
  // ...other fields
}
```

### **CRUD Operations**  
- **Create**: `AddSurveyCubit` + `SurveyRepository`  
- **Read**: `HomeScreen` loads surveys from Hive  
- **Update**: `EditSurveyScreen` (if implemented)  
- **Delete**: `SurveyTabCubit` handles deletion  

### **Commencement Wizard**  
- Multi-step form (`SurveyCommencementScreen`)  
- Progress saved in Hive after each step  

---

## **✅ Validation Utilities**  
Reusable validators in `survey_form_validations.dart`:  
```dart
static String? validateName(String? name) {
  if (name == null || name.isEmpty) return "Name required";
  if (name.length < 3) return "Minimum 3 characters";
  return null;
}
```

---

## **🧭 Routing (GoRouter)**  
```dart
final router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (_, __) => SplashScreen()),
    GoRoute(path: '/login', builder: (_, __) => LoginScreen()),
    GoRoute(path: '/home', builder: (_, __) => HomeScreen()),
  ],
  redirect: (context, state) {
    final isLoggedIn = context.read<AuthCubit>().state.isAuthenticated;
    if (!isLoggedIn && state.location != '/login') return '/login';
    return null;
  },
);
```

---


## **📌 Conclusion**  
This app is **fully offline-capable**, scalable, and follows best practices in Flutter development. The **Hive-based** approach ensures data is always available, even without internet.  
