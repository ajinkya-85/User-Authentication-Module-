# User Auth Module

A robust User Authentication and Profile Management module built using Flutter and Firebase. This project demonstrates a secure and scalable approach to handling user sessions, registration, and real-time data persistence.

## 📋 Task Details

**Develop a User Authentication Module with the following features:**

- User Registration
- User Sign-In (Login)
- Change Password functionality

**Additionally, create a separate page/module to:**

- Edit and update user profile details

**Guidelines**

- Secure password handling is mandatory (password hashing must be implemented).
- Maintain clean, readable, and well-structured code.
- Database integration is compulsory.
- Follow best practices for authentication and data security.

**Deliverables**

- Complete source code.
- Upload the project to GitHub and share the repository link.
- Clearly mention:
  - Programming language used
  - Framework(s) used
  - Database used

## � Tech Stack

- **Programming Language:** Dart
- **Framework:** Flutter
- **Database:** Cloud Firestore (NoSQL)
- **Authentication:** Firebase Authentication

## 🚀 Features

- **User Registration:** Secure sign-up flow capturing Username, Email, Mobile Number, and Address.
- **Authentication:** Email and Password login with input validation.
- **Profile Management:** View and update user details stored in Cloud Firestore.
- **Security:**
  - Secure password change functionality.
  - Email verification triggers on email updates.
- **UI/UX:**
  - Custom reusable widgets for consistent design.
  - Responsive layout handling.
  - Error handling via SnackBars.

## 🌳 Widget Tree Overview

The application follows a clean and modular widget hierarchy. Below is a high-level representation of the application structure:

```text
MyApp
 └── MaterialApp
      ├── Routes
      │    ├── '/signin': SignIn Screen
      │    ├── '/signup': SignUp Screen
      │    └── '/home': Home Screen
      │
      └── SignIn (Initial Route)
           └── Scaffold
                └── SafeArea
                     └── Padding
                          └── SingleChildScrollView
                               └── Column
                                    ├── Text (Header)
                                    ├── ReusableTextField (Email)
                                    ├── ReusableTextField (Password)
                                    ├── ReusableButton (Sign In)
                                    └── Row (Navigation to Sign Up)
```

## 📂 Project Structure

```text
lib/
├── main.dart                 # Application entry point and Firebase initialization
├── firebase_options.dart     # Firebase configuration
├── reusable_widgets/
│   ├── buttons.dart          # Custom styled ElevatedButton
│   └── textfield.dart        # Custom styled TextField with icons
└── screens/
    ├── home.dart             # User Profile & Dashboard
    ├── sign_in.dart          # Login Screen
    └── sign_up.dart          # Registration Screen
```
