import 'package:chat_app/constant.dart';
import 'package:chat_app/helper/show_snack_bar.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/widget/custom_button.dart';
import 'package:chat_app/widget/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  /// اتعمل استاتك عشان نستدعيه باسم الكلاس مش الاوبجكت هيبقي فرق الاقواس بس
  static String id = 'RegisterPage';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Create variables to store email and password for Firebase authentication.
  String? email;
  String? password;

  /// Key to validate the form
  GlobalKey<FormState> formKey = GlobalKey();

  // Variable to manage loading state
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                const SizedBox(
                  height: 100,
                ),
                Center(child: Image.asset('assets/images/scholar.png')),
                const Center(
                  child: Text(
                    'Scholar Chat',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontFamily: 'pacifico',
                    ),
                  ),
                ),
                const Row(
                  children: [
                    Text(
                      'Register',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                  onChanged: (data) {
                    email = data;
                  },
                  hintText: 'Email',
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                  onChanged: (data) {
                    password = data;
                  },
                  hintText: 'Password',
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomButton(
                  text: 'Register',
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      // Show loading indicator
                      isLoading = true;
                      setState(() {});

                      try {
                        // Attempt to register the user
                        await registerUser();
                        // Navigate to ChatPage and pass email as argument
                        Navigator.pushNamed(context, ChatPage.id,
                            arguments: email);
                      } on FirebaseAuthException catch (ex) {
                        // Handle specific Firebase authentication errors
                        if (ex.code == 'weak-password') {
                          showSnackBar(context, 'Weak password');
                        } else if (ex.code == 'email-already-in-use') {
                          showSnackBar(context, 'Email already exists');
                        }
                      } catch (ex) {
                        // Handle general errors
                        showSnackBar(context, 'There was an error');
                      }
                      // Hide loading indicator
                      isLoading = false;
                      setState(() {});
                    } else {
                      // Form validation failed
                    }
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account?',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(color: Colors.grey, fontSize: 24),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Function to register a new user using Firebase authentication
  Future<void> registerUser() async {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
  }
}

// Explanation:

// 1. **State Variables**:
//    - `String? email;`: To store the user's email.
//    - `String? password;`: To store the user's password.
//    - `GlobalKey<FormState> formKey = GlobalKey();`: To validate the form.
//    - `bool isLoading = false;`: To manage the loading state.

// 2. **ModalProgressHUD**:
//    - A widget to show a loading indicator when `isLoading` is `true`.

// 3. **Form**:
//    - A widget that contains the form fields and manages form validation.

// 4. **registerUser()**:
//     - A function to register a new user using Firebase authentication.

// 5. **try-catch Block**:
//     - Handles Firebase authentication errors and shows appropriate messages using `showSnackBar`.

// 6. **Navigator.pushNamed**:
//     - Navigates to `ChatPage` and passes the user's email as an argument.

