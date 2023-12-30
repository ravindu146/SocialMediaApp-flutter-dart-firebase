import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mini_social_media_app_2/components/my_list_tile.dart';
import 'package:mini_social_media_app_2/helper/helper_functions.dart';

import '../components/my_back_button.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Users').snapshots(),
        builder: (context, snapshot) {
          // Error
          if (snapshot.hasError) {
            displayMessageToTheUser('Something Went Wrong!', context);
          }

          // show loading circle
          else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          // if there's no data to be shown
          else if (snapshot.data == null) {
            return Text('no Data.. ');
          }

          // get all the users
          else if (snapshot.hasData) {
            final users = snapshot.data!.docs;

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50, left: 25),
                  child: Row(
                    children: [
                      MyBackButton(),
                    ],
                  ),
                ),

                // list of users to the app
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        // get individual user
                        final user = users[index];

                        // Get the data from each user
                        String username = user['username'];
                        String email = user['email'];

                        return MyListTile(title: username, subtitle: email);
                      },
                    ),
                  ),
                ),
              ],
            );
          }

          return Center(
            child: Text("Unexpected state"),
          );
        },
      ),
    );
  }
}
