import 'package:chat_app/constant.dart';

class Message {
  // Fields to store the message text and the id of the message.
  final String message;
  final String id;

  // Constructor to initialize the Message object.
  Message(this.message, this.id);

  // Factory constructor to create a Message object from JSON data.
  factory Message.fromjson(jsonData) {
    return Message(
      jsonData[KMessage], // Retrieve the message text using the KMessage key.
      jsonData['id'], // Retrieve the message id using the 'id' key.
    );
  }
}



// Explanation:

// 1. **Fields**:
//    - `final String message;`: This field stores the message text.
//    - `final String id;`: This field stores the id of the message.

// 2. **Constructor**:
//    - `Message(this.message, this.id);`: This is the main constructor for the `Message` class, which initializes the `message` and `id` fields with the provided values.

// 3. **Factory Constructor**:
//    - `factory Message.fromjson(jsonData);`: This factory constructor creates a `Message` object from JSON data. It allows for easy conversion from JSON to a `Message` object.

// 4. **fromjson Method**:
//    - `jsonData[KMessage]`: This retrieves the message text from the JSON data using the `KMessage` key, which is defined in the `constant.dart` file.
//    - `jsonData['id']`: This retrieves the message id from the JSON data using the 'id' key.

// This class can be used to represent messages in your chat application, and the factory constructor makes it easy to create `Message` objects from JSON data retrieved from Firebase or other sources.
