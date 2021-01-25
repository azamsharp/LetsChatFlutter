

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lets_chat/view_models/message_list_view_model.dart';
import 'package:lets_chat/view_models/message_view_model.dart';
import 'package:lets_chat/view_models/room_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MessageListPage extends StatefulWidget {

  final RoomViewModel room; 

  MessageListPage({@required this.room}); 

  @override 
  _MessageListPage createState() => _MessageListPage(); 
}

class _MessageListPage extends State<MessageListPage> {

  MessageListViewModel _messageListVM; 
  final _messageTextController = TextEditingController(); 
  RoomViewModel room; 

  List<MessageViewModel> _messages = List<MessageViewModel>(); 

  @override
  void initState() {
    super.initState();
    room = widget.room; 

    _messageListVM = MessageListViewModel(room: room); 
    _populateMessagesByRoom(widget.room); 
  }

  void _populateMessagesByRoom(RoomViewModel room) {

  }

  void _sendMessage(BuildContext context) async {
    
    final messageText = _messageTextController.text; 
    final sharedPreferences = await SharedPreferences.getInstance(); 
    final username = sharedPreferences.get("username");

    if(messageText.isNotEmpty) {
      final isSaved = await _messageListVM.sendMessage(room.roomId, messageText, username); 
      if(isSaved) {
        // the list will be updated automatically 
      } 
    }
  }

  Widget _buildMessageList(List<MessageViewModel> messages) {
    return Expanded(
          child: ListView.builder(
        itemCount: messages.length, 
        itemBuilder: (context, index) {
          final message = messages[index]; 

          return ListTile(
            title: Text(message.messageText)
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final room = widget.room; 

    return Scaffold(
      appBar: AppBar(
        title: Text(room.title)
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        StreamBuilder<List<MessageViewModel>>(
          stream: _messageListVM.messagesStream.stream, 
          builder: (context, snapshot) {
            if(snapshot.hasError) {
              return Text("Error: ${snapshot.error}"); 
            }

            switch(snapshot.connectionState) {
              case ConnectionState.waiting: 
                return const Text("Loading..."); 
              default: 
                if(!snapshot.hasData) {
                  return const Text("No data"); 
                }
            }

            return _buildMessageList(snapshot.data); 
          

          }
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                    child: TextField(
                    controller: _messageTextController, 
                    decoration: InputDecoration(
                      hintText: "Enter message"
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send), 
                  color: Colors.green,
                  onPressed: () {
                    _sendMessage(context); 
                  },
                )
              ],
            ),
          ),
        )
      ])
    ); 
    
  }
}