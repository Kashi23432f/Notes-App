# Flutter Priority Notes App 📝🚀

A sleek, modern, and highly efficient Notes Application built with **Flutter**. It allows users to manage daily tasks and thoughts with full offline CRUD capabilities powered by **SQLite**, featuring an automated, smart priority-sorting engine.

![Flutter](https://shields.io)
![SQLite](https://shields.io)
![License](https://shields.io)

## ✨ Features

*   **Full CRUD Operations:** Seamlessly **C**reate, **R**ead, **U**pdate, and **D**elete notes.
*   **Smart Priority Sorting:** Assign priority levels (High, Medium, Low) to notes. High-priority notes automatically stay pinned at the top.
*   **Local SQLite Storage:** 100% offline-first architecture. Your notes never leave your device.
*   **Real-time Modification:** Instant UI updates upon inserting, modifying, or deleting notes.
*   **Clean Architecture:** Structured state management and responsive UI layout.

## 🛠️ Tech Stack

*   **Frontend Framework:** Flutter (Dart)
*   **Local Database:** SQLite (`sqflite` package)
*   **State Management:** [Insert your choice, e.g., Provider / Riverpod / Bloc / setState]

## 🚀 Getting Started

### Prerequisites

Before running this project, ensure you have:
*   [Flutter SDK](https://flutter.dev) installed (v3.0.0+ recommended).
*   An Android/iOS Emulator or a physical device connected.

### Installation & Setup

1. **Clone the repository:**
   ```bash
   git clone https://github.com
   cd flutter-priority-notes
   ```

2. **Get Flutter packages:**
   ```bash
   flutter pub get
   ```

3. **Run the application:**
   ```bash
   flutter run
   ```

## 📂 Project Structure

```text
lib/
│
├── database/
│   └── db_helper.dart      # SQLite database configuration & CRUD queries
│
├── models/
│   └── note_model.dart     # Note data model with priority attributes
│
├── screens/
│   ├── home_screen.dart    # Notes list view (sorted by priority)
│   └── note_edit_screen.dart # Screen to insert, update, or modify notes
│
└── main.dart               # App entry point
```


