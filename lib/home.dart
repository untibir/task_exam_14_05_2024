import 'package:flutter/material.dart';
import 'model/model.dart';

class MyExamApi extends StatelessWidget {
  const MyExamApi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'ToDo List Exam',
              style: TextStyle(
                color: Color.fromARGB(255, 220, 16, 227),
              ),
            ),
          ],
        ),
      ),
      body: FutureBuilder<List<Todo>>(
        future: fetchUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Todo todo = snapshot.data![index];
                return Dismissible(
                  key: Key(todo.id.toString()),
                  onDismissed: (direction) {},
                  child: Container(
                    height: 80,
                    margin: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: todo.completed
                          ? Colors.green.withOpacity(0.3)
                          : Colors.red.withOpacity(0.3),
                    ),
                    child: Center(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: todo.completed
                              ? Colors.green
                              : Colors.red.withOpacity(0.7),
                          child: Text(
                            todo.id.toString(),
                            style: TextStyle(
                              color:
                                  todo.completed ? Colors.black : Colors.white,
                            ),
                          ),
                        ),
                        title: Text(todo.title.toString()),
                        trailing: Icon(
                          todo.completed ? Icons.check_circle : Icons.replay,
                          color: todo.completed ? Colors.green : Colors.red,
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
