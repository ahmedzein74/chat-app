import 'package:chat_app/constant.dart';
import 'package:chat_app/helper/show_snack_bar.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/pages/register_page.dart';
import 'package:chat_app/widget/custom_button.dart';
import 'package:chat_app/widget/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  // Making this a static field so it can be accessed using the class name, not an object instance.
  static String id = 'LoginPage';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Form key to manage form state and validate input.
  GlobalKey<FormState> formKey = GlobalKey();

  // Variables to manage loading state and user input.
  bool isLoading = false;
  String? email, password;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      // Show a loading indicator when isLoading is true.
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
                // Displaying the logo.
                Center(child: Image.asset('assets/images/scholar.png')),
                // App title.
                const Center(
                  child: Text(
                    'Scholar Chat',
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontFamily: 'pacifico'),
                  ),
                ),
                // Login header.
                const Row(
                  children: [
                    Text('LOGIN',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        )),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                // Custom text field for email input.
                CustomTextFormField(
                  onChanged: (data) {
                    email = data;
                  },
                  hintText: 'Email',
                ),
                const SizedBox(
                  height: 20,
                ),
                // Custom text field for password input, with obscure text.
                CustomTextFormField(
                  obscureText: true,
                  onChanged: (data) {
                    password = data;
                  },
                  hintText: 'password',
                ),
                const SizedBox(
                  height: 30,
                ),
                // Custom button for login action.
                CustomButton(
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      // Show loading indicator.
                      isLoading = true;
                      setState(() {});

                      try {
                        // Attempt to log in the user.
                        await loginUser();
                        // Navigate to the chat page on success.
                        Navigator.pushNamed(context, ChatPage.id,
                            arguments: email);
                      } on FirebaseAuthException catch (ex) {
                        // Show appropriate error message if login fails.
                        if (ex.code == 'user-not-found') {
                          showSnackBar(
                              context, 'No user found for that email.');
                        } else if (ex.code == 'wrong-password') {
                          showSnackBar(context,
                              'Wrong password provided for that user.');
                        }
                      } catch (ex) {
                        // Show generic error message for other exceptions.
                        showSnackBar(context, 'There was an error');
                      }
                      // Hide loading indicator.
                      isLoading = false;
                      setState(() {});
                    } else {
                      // Handle form validation failure if needed.
                    }
                  },
                  text: 'LOGIN',
                ),
                const SizedBox(height: 20),
                // Link to the register page.
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'don\'t have an account ?',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RegisterPage.id);
                      },
                      child: const Text(
                        'Register Now',
                        style: TextStyle(color: Colors.grey, fontSize: 24),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Method to log in the user with email and password.
  Future<void> loginUser() async {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}


 

// Explanation:

// 2. **LoginPage**: A `StatefulWidget` to manage user input and loading state.
//    - `static String id = 'LoginPage';`: This allows us to reference this page using `LoginPage.id`.
//    - `String? email, password;`: Variables to store user input for email and password.
// 3. **_LoginPageState**: The state class where the UI and logic are defined.
//    - `GlobalKey<FormState> formKey = GlobalKey();`: A key to manage the form's state.
//    - `bool isLoading = false;`: A flag to manage the loading state.
//    - `String? email, password;`: Variables to store user input.
// 4. **ModalProgressHUD**: A widget to show a loading spinner when `isLoading` is true.
// 5. **Scaffold**: The main UI structure of the login page.
// 6. **Form**: A widget to manage the form fields and their validation.
// 7. **CustomTextFormField**: Custom widgets for input fields (email and password).
//    - `onChanged`: A callback to update the email and password variables.
// 8. **CustomButton**: A custom button to trigger the login action.
//    - `onTap`: A callback that validates the form, shows the loading indicator, attempts to log in the user, and handles any errors.
// 9. **Future<void> loginUser()**: A method that uses Firebase Authentication to log in the user with the provided email and password.

// This structure ensures a clean and responsive UI while providing clear feedback to the user during the login process.