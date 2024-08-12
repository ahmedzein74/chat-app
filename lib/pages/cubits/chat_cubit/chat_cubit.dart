import 'package:bloc/bloc.dart';
import 'package:chat_app/constant.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  CollectionReference messages =
      FirebaseFirestore.instance.collection(KMessagesCollections);

  void sendMessage({required String message, required String email}) async {
    try {
      await messages.add(
        {
          KMessage: message,
          KCreatedAt: DateTime.now(),
          'id': email,
        },
      );
    } catch (e) {
      // Print the error for debugging purposes
      print("Error sending message: $e");
    }
  }

  void getMessage() {
    //stream
    messages.orderBy(KCreatedAt, descending: true).snapshots().listen(
      (event) {
        List<Message> messageList = [];
        messageList.clear();
        for (var doc in event.docs) {
          try {
            messageList.add(Message.fromjson(doc));
          } catch (e) {
            print("Error parsing message: $e");
          }
        }

        emit(ChatSuccess(messageList: messageList));
      },
    );
  }
}
