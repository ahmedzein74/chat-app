import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/pages/login_page.dart';
import 'package:chat_app/pages/register_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

Future<void> main() async {
  // Ensure the Flutter framework is initialized before using any Flutter features
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase with the platform-specific options
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Start the Flutter application
  runApp(const ScholarChat());
}

class ScholarChat extends StatelessWidget {
  const ScholarChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Disable the debug banner in the top-right corner
      debugShowCheckedModeBanner: false,

      // Define the routes for navigation
      routes: {
        LoginPage.id: (context) => LoginPage(),
        RegisterPage.id: (context) => RegisterPage(),
        ChatPage.id: (context) => ChatPage(),
      },

      // Set the initial route to the login page
      initialRoute: LoginPage.id,
    );
  }
}

// Comments:
// routes => We use Navigator.pushNamed(context, routeName) to navigate to different pages
// This maps a string (routeName) to a widget, allowing us to navigate to the widget by its name
// When using routes, we do not use the 'home' property. Instead, we should use 'initialRoute' to define the starting page.
// ```

// ### Explanation:

// 1. **Imports**:
//    - Importing necessary packages and files.

// 2. **main() Function**:
//    - `WidgetsFlutterBinding.ensureInitialized();`: Ensures the Flutter framework is initialized before using any Flutter features.
//    - `await Firebase.initializeApp(...)`: Initializes Firebase with the platform-specific options.
//    - `runApp(const ScholarChat());`: Starts the Flutter application by running the `ScholarChat` widget.

// 3. **ScholarChat Class**:
//    - A `StatelessWidget` that represents the main application.

// 4. **MaterialApp**:
//    - The root of the application.
//    - `debugShowCheckedModeBanner: false`: Disables the debug banner in the top-right corner.
//    - `routes`: A map of route names to widget builders, used for navigation.
//      - `LoginPage.id: (context) => LoginPage()`: Maps the route name for the login page to the `LoginPage` widget.
//      - `RegisterPage.id: (context) => RegisterPage()`: Maps the route name for the register page to the `RegisterPage` widget.
//      - `ChatPage.id: (context) => ChatPage()`: Maps the route name for the chat page to the `ChatPage` widget.
//    - `initialRoute: LoginPage.id`: Sets the initial route to the login page, which means the application will start with the `LoginPage` widget.

// 5. **Comments**:
//    - Explain how the routes work and why we use `initialRoute` instead of `home` when defining named routes. 

// This setup ensures that the application starts with the login page and allows for navigation to the register and chat pages using named routes.