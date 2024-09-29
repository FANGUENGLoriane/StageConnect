import 'package:flutter/material.dart';

class Message extends StatefulWidget {
  const Message({super.key, required this.message, required this.ReceivedUid, required this.currentUid});
final String message;
final String ReceivedUid;
  final String currentUid;
  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  @override
  Widget build(BuildContext context) {
    return Row(
      // si l'uid du user actuel est = a celui du recepteur, alors positionné le message a la fin du containeur
      mainAxisAlignment: widget.currentUid == widget.ReceivedUid? MainAxisAlignment.end: MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(18, 8, 18, 8),
          decoration: BoxDecoration(
            color: widget.currentUid == widget.ReceivedUid? Colors.green:Colors.grey,
          borderRadius: BorderRadius.circular(7)
          ),
          child: Text(widget.message),
        )
      ],
    );
  }
}
