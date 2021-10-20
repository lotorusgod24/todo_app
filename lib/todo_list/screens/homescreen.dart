import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tasker/auth/widgets/google_sign_in.dart';
import 'package:tasker/todo_list/services/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String taskName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff45aaaa),
      appBar: AppBar(
        backgroundColor: Color(0xff454545),
        title: Text('Tasker'),
        centerTitle: true,
        actions: [
          ElevatedButton(
            onPressed: () {
              final provider =
                  Provider.of<GoogleSignInProvider>(context, listen: false);
              provider.googleLogOut();
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                Color(0xff454545),
              ),
            ),
            child: Text('Logout'),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: CloudFirestoreApi.userCollection.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          } else
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(
                      snapshot.data!.docs[index]['task'],
                    ),
                    // trailing: IconButton(
                    //   onPressed: () async {
                    //     await CloudFirestoreApi.deleteTask();
                    //   },
                    //   icon: Icon(Icons.delete),
                    // ),
                  ),
                );
              },
            );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(
            () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Add new task'),
                    content: TextFormField(
                      onChanged: (String value) {
                        taskName = value;
                      },
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () async {
                          await CloudFirestoreApi.createNewTask(task: taskName);
                          Navigator.pop(context);
                        },
                        child: Text('Add'),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Color(0xff454545),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0xff454545),
      ),
    );
  }
}
