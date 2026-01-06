# User Auth Module

A robust User Authentication and Profile Management module built using Flutter and Firebase.

Download link :- https://drive.google.com/file/d/1-RsfqVX0eiEIhDM3TwCS9gOkkGyO9pDe/view?usp=sharing 

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
