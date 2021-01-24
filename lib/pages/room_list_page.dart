
import 'package:flutter/material.dart';
import 'package:lets_chat/pages/add_room_page.dart';
import 'package:lets_chat/view_models/add_room_view_model.dart';
import 'package:provider/provider.dart';


class RoomListPage extends StatelessWidget {

  void _navigateToAddRoomPage(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => 
      ChangeNotifierProvider(
        create: (context) => AddRoomViewModel(), 
        child: AddRoomPage() 
      )
      , fullscreenDialog: true
    ));
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Rooms"), 
        actions: [
          GestureDetector(
            onTap: () {
              _navigateToAddRoomPage(context); 
            },
            child: Icon(Icons.add)
          )
        ],
      )
    );
    
  }
}