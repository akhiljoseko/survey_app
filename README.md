# 🏫 School Surveys App

A fully offline-capable **Flutter** application for creating, managing, and conducting school surveys, built as part of a technical assessment.

---

## 📌 Overview

The **School Surveys App** enables users to:
- Authenticate (Sign Up / Login / Forgot Password)
- Manage surveys (Create, Edit, Delete, View)
- Conduct multi-step survey commencement with dynamic school data input
- Persist all data locally (offline-first) using **Hive** database

Built following **Clean Architecture principles**, **Cubit + Equatable** for state management, and **GoRouter** for routing.

---

## ✨ Key Features

- ✅ User Authentication (Hive-based)
- ✅ Survey Creation and Management
- ✅ Dynamic, Multi-step Survey Commencement Wizard
- ✅ Offline-First Data Storage (Hive)
- ✅ Clean Architecture Implementation
- ✅ State Management using Cubit
- ✅ Robust Form Validation Utilities
- ✅ Dynamic Routing with GoRouter
- ✅ Mobile-Optimized UI (Android & iOS)

---

## 📐 Architecture Overview

The app structure follows a three-layer Clean Architecture:

- **Domain Layer**:  
  Business logic, entities, repositories contracts, enums, and value objects.
  
- **Data Layer**:  
  Hive implementations, repository implementations, adapters, and data services.

- **Presentation Layer**:  
  Screens, widgets, cubits, and routing.

---

## 📁 Project Structure

```plaintext
lib/
├── app/            # App configuration and routing
├── core/           # Shared utilities, error handling
├── data/           # Persistence logic (Hive database)
├── domain/         # Business logic (Entities, Repositories)
├── view/           # UI screens, widgets, Cubits
└── main.dart       # App entry point
assets/
├── icons/
├── images/
```

---

## ⚙️ Technologies Used

- **Flutter** (stable)
- **Dart** (stable)
- **Hive** (local database)
- **Cubit + Equatable** (State management)
- **GoRouter** (Routing)
- **Form Validation Utilities**

---

## 🛠️ How to Setup Locally

1. **Clone the repository**
   ```bash
   git clone https://github.com/akhiljoseko/survey_app.git
   cd survey_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate Hive TypeAdapters (if needed)**
   ```bash
   flutter packages pub run build_runner build
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

---


## 🔐 Authentication Flow

- SplashScreen → Login/SignUp → HomeScreen
- Authenticated routes are protected using GoRouter's redirect mechanism
- Credentials are securely stored using Hive (No external server/Firebase dependency)

---

## 📋 Survey Management Highlights

- Random URN generation for each survey
- Edit, Delete, and Start survey actions
- Dynamic school tabs based on total schools entered
- Complete flow tracking with statuses (Scheduled, Completed, With-held)

---

## 🔁 State Management

- **Cubit** for UI state handling per feature
- **Equatable** for efficient state comparison
- **Repository Pattern** for data access abstraction

---

## 📌 Important Notes

- This project is **strictly mobile-only** (Android & iOS).  
- The app is designed for **offline-first usage** and stores all critical data locally.
- **No cloud backend** is used.
- Focus is given to **form validations**, **mobile responsiveness**, and **clean code practices**.

---

## 📢 Acknowledgments

This project was created as a part of a technical assignment to showcase Flutter, Dart, architecture design, and offline-first mobile app development skills.

---


