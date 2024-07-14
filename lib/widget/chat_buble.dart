import 'package:chat_app/constant.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:flutter/material.dart';

class ChatBuble extends StatelessWidget {
  const ChatBuble({super.key, required this.message});
  final Message message; // final variable to hold the message object.
  @override
  Widget build(BuildContext context) {
    // we use Align  The Container would try to take as much horizontal space as possible, potentially stretching across the screen.
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding:
            const EdgeInsets.only(left: 16, top: 32, bottom: 32, right: 32),
        // margin destance between container and edge of phone
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
              bottomRight: Radius.circular(30)),
          color: kPrimaryColor,
        ),
        child: Text(message.message,
            style: const TextStyle(color: Colors.white, fontSize: 15)),
      ),
    );
  }
}

class ChatBubleForFrind extends StatelessWidget {
  const ChatBubleForFrind({super.key, required this.message});
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding:
            const EdgeInsets.only(left: 16, top: 32, bottom: 32, right: 32),
        // margin destance between container and edge of phone
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
              bottomLeft: Radius.circular(30)),
          color: Color(0xff006D84),
        ),
        child: Text(message.message,
            style: const TextStyle(color: Colors.white, fontSize: 15)),
      ),
    );
  }
}
