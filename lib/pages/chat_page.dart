import 'package:chat_app/constant.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/widget/chat_buble.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatPage extends StatelessWidget {
  static String id = 'chatPage';

  // Access the messages collection in Firestore. If it doesn't exist, it will be created.
  CollectionReference messages =
      FirebaseFirestore.instance.collection(KMessagesCollections);

  // Controller to manage the text field input.
  TextEditingController controller = TextEditingController();

  // Controller to manage the scrolling of the ListView.
  final ScrollController scrollController = ScrollController();

  // Function to scroll to the end of the ListView.
  void scrollToEnd() {
    scrollController.jumpTo(
      // scrollController.position.maxScrollExtent, // Commented out to prevent error
      0,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get the email passed as an argument to the ChatPage.
    var email = ModalRoute.of(context)!.settings.arguments;

    // Function to send a message and scroll to the end.
    void sendMessage() {
      if (controller.text.isNotEmpty) {
        messages.add(
          {
            KMessage: controller.text,
            KCreatedAt: DateTime.now(),
            'id': email,
          },
        );
        controller.clear();
        scrollToEnd();
      }
    }

    // StreamBuilder to listen for real-time updates from Firestore.
    return StreamBuilder<QuerySnapshot>(
      // Fetch data ordered by creation time in descending order.
      stream: messages.orderBy(KCreatedAt, descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // List to hold messages.
          List<Message> listMessage = [];

          // Loop through the documents and create Message objects.
          for (var i = 0; i < snapshot.data!.docs.length; i++) {
            listMessage.add(Message.fromjson(snapshot.data!.docs[i]));
          }

          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: kPrimaryColor,
              centerTitle: true,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/scholar.png',
                    height: 60,
                  ),
                  const Text(
                    'Chat',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            body: Column(
              children: [
                // Expanded widget to allow the ListView to take up available space.
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: scrollController,
                    itemCount: listMessage.length,
                    itemBuilder: (context, index) {
                      // Display different chat bubbles based on the message sender.
                      return listMessage[index].id == email
                          ? ChatBuble(
                              message: listMessage[index],
                            )
                          : ChatBubleForFrind(
                              message: listMessage[index],
                            );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(11.0),
                  child: TextField(
                    controller: controller,
                    // Send the message when the user submits the text.
                    onSubmitted: (data) {
                      sendMessage();
                    },
                    decoration: InputDecoration(
                      hintText: 'Send Message',
                      hintStyle: const TextStyle(color: kPrimaryColor),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.send),
                        color: kPrimaryColor,
                        onPressed: sendMessage,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: kPrimaryColor),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          // Show a loading indicator if data is not available.
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
              backgroundColor: kPrimaryColor,
            ),
          );
        }
      },
    );
  }
}


// Explanation:



// 1. CollectionReference:
//    - `messages`: A reference to the messages collection in Firestore.

// 2. TextEditingController:
//    - `controller`: A controller to manage the input in the text field.

// 3. ScrollController:
//    - `scrollController`: A controller to manage the scrolling behavior of the ListView.

// 4. scrollToEnd():
//    - A function to scroll to the end of the ListView.


// 5. **ModalRoute.of(context)!.settings.arguments**:
//    - Retrieves the email passed as an argument to the ChatPage.

// 6. sendMessage():
//    - A function to send a message to Firestore and scroll to the end.

// 7. StreamBuilder:
//     - Listens for real-time updates from the Firestore collection and rebuilds the UI accordingly.

// 8. Expanded:
//     - Expands the ListView to take up available space in the column.

// 9. ListView.builder:
//     - Builds the list of messages dynamically.

// 10. **CircularProgressIndicator**:
//     - Displays a loading indicator while waiting for data from Firestore.

