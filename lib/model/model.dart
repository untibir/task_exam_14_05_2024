import 'package:dio/dio.dart';

class Todo {
  final int userId;
  final int id;
  final String title;
  final bool completed;

  Todo({
    required this.userId,
    required this.id,
    required this.title,
    required this.completed,
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      completed: json['completed'],
    );
  }
}

Future<List<Todo>> fetchUsers() async {
  final dio = Dio();
  final response = await dio.get('https://jsonplaceholder.typicode.com/todos');

  if (response.statusCode == 200) {
    final List<dynamic> data = response.data;
    return data.map((json) => Todo.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load users');
  }
}
