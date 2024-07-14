import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  // Constructor to initialize the widget with optional parameters for onChanged callback, hintText, and obscureText.
  CustomTextFormField({
    super.key,
    this.onChanged,
    this.hintText,
    this.obscureText = false,
  });

  // The hint text displayed inside the TextFormField.
  final String? hintText;

  // Whether the text should be obscured (useful for password fields).
  bool? obscureText;

  // Callback function to handle changes in the text field.
  Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // Whether to obscure the text (e.g., for passwords).
      obscureText: obscureText!,

      // Validator function to check if the field is empty.
      validator: (data) {
        if (data!.isEmpty) {
          return 'Field is required';
        }
        return null; // Return null if there's no validation error.
      },

      // Callback function to handle changes in the text field.
      onChanged: onChanged,

      // Decoration for the TextFormField.
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white),
      ),
    );
  }
}



// ### Explanation:

// 1. **Constructor**: 
//    - The constructor initializes the widget with optional parameters for the `onChanged` callback, `hintText`, and `obscureText`.
//    - `this.onChanged`: A callback function that gets called whenever the text in the field changes.
//    - `this.hintText`: The hint text to be displayed inside the `TextFormField`.
//    - `this.obscureText = false`: A boolean to determine whether the text should be obscured (useful for password fields). It defaults to `false`.

// 2. **final String? hintText**:
//    - A final variable to store the hint text for the `TextFormField`.

// 3. **bool? obscureText**:
//    - A boolean variable to store whether the text should be obscured.

// 4. **Function(String)? onChanged**:
//    - A callback function to handle changes in the text field. It takes a string parameter which is the current value of the text field.

// 5. **TextFormField**:
//    - This is the main widget that creates the text input field.

// 6. **obscureText: obscureText!**:
//    - This sets the `obscureText` property of the `TextFormField` based on the value of `obscureText`. The `!` operator is used to assert that `obscureText` is not null.

// 7. **validator: (data) {...}**:
//    - This is a validator function that checks if the input data is empty. If it is, it returns the error message 'Field is required'. Otherwise, it returns `null`, indicating no validation error.

// 8. **onChanged: onChanged**:
//    - This sets the `onChanged` callback of the `TextFormField` to the function passed in through the constructor.

// 9. **decoration: InputDecoration(...)**:
//    - This sets the decoration for the `TextFormField`, including the border, hint text, and hint text style.
//    - `border` and `enabledBorder`: These define the border style of the `TextFormField`.
//    - `hintText`: This sets the hint text inside the `TextFormField`.
//    - `hintStyle`: This sets the style for the hint text, specifically the color in this case.

// This widget can be reused throughout your app for consistent text input fields with validation and customization options.