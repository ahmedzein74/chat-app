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
