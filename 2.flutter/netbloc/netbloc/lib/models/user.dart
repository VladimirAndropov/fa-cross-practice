

class User {
 

User._({required this.id,  required this.label,  required this.description,  required this.type,});

  final String id;
  final String label;
  final String description;
  final String type;


factory User.fromJson(Map<String, dynamic> data) {
   return User._(
     id: data['id'],
       label: data['label'] ?? '',
        description: data['description'] ?? '',
         type: data['type'] ?? '',
   );
}


}

