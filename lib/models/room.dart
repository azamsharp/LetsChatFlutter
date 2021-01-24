

class Room {

  final String title; 
  final String description; 

  Room({this.title, this.description});

  Map<String, dynamic> toMap() {
    return {
      "title": title, 
      "description": description
    };
  }

}