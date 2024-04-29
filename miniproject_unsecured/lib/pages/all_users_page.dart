import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AllUsers extends StatefulWidget {
  const AllUsers({super.key});

  @override
  State<AllUsers> createState() => _AllUsersState();
}

class _AllUsersState extends State<AllUsers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF1F2FF),
      appBar: AppBar(
        backgroundColor: const Color(0xffF1F2FF),
        title: const Text('All Users'),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          // print(snapshot.data?.docs.first.id);

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (!snapshot.hasData) {
            return const Center(
              child: Text(
                'No Data Available',
                style: TextStyle(color: Colors.black),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Text(
                    '${index + 1}',
                    style: const TextStyle(fontSize: 14),
                  ),
                  title: Text(snapshot.data!.docs[index]['name']),
                  trailing: IconButton(
                    onPressed: () {
                      // wrap it in alertdialog box
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Delete User'),
                            content: const Text(
                                'Are you sure you want to delete this user?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () async {
                                  Navigator.of(context).pop();
                                  try {
                                    await FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(snapshot.data!.docs[index].id)
                                        .delete();
                                    print('Deleted Successfully');
                                  } catch (e) {
                                    print(e);
                                  }
                                },
                                child: const Text('Delete'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
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
