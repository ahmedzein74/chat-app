import 'package:chat_app/constant.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/pages/cubits/chat_cubit/chat_cubit.dart';
import 'package:chat_app/widget/chat_buble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatelessWidget {
  static String id = 'chatPage';

  TextEditingController controller = TextEditingController();
  List<Message> messageList = [];

  // Controller to manage the scrolling of the ListView.
  final ScrollController scrollController = ScrollController();

  // Function to scroll to the end of the ListView.
  void scrollToEnd() {
    scrollController.jumpTo(
      0,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get the email passed as an argument to the ChatPage.
    var email = ModalRoute.of(context)!.settings.arguments as String;
    void sendMessage({required String data, required String email}) {
      BlocProvider.of<ChatCubit>(context)
          .sendMessage(message: data, email: email);
      controller.clear();
      scrollToEnd();
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
          Expanded(
            child: BlocConsumer<ChatCubit, ChatState>(
              listener: (context, state) {
                if (state is ChatSuccess) {
                  messageList = state.messageList;
                }
              },
              builder: (context, state) {
                return ListView.builder(
                  reverse: true,
                  controller: scrollController,
                  itemCount: messageList.length,
                  itemBuilder: (context, index) {
                    // Display different chat bubbles based on the message sender.
                    return messageList[index].id == email
                        ? ChatBuble(
                            message: messageList[index],
                          )
                        : ChatBubleForFrind(
                            message: messageList[index],
                          );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(11.0),
            child: TextField(
              controller: controller,
              onSubmitted: (data) {
                sendMessage(data: data, email: email);
              },
              decoration: InputDecoration(
                hintText: 'Send Message',
                hintStyle: const TextStyle(color: kPrimaryColor),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.send),
                  color: kPrimaryColor,
                  onPressed: () {
                    if (controller.text.isNotEmpty) {
                      sendMessage(data: controller.text, email: email);
                    }
                  },
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

