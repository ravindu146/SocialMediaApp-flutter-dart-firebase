import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mini_social_media_app_2/components/my_drawer.dart';
import 'package:mini_social_media_app_2/components/my_list_tile.dart';
import 'package:mini_social_media_app_2/components/my_post_button.dart';
import 'package:mini_social_media_app_2/components/my_textfield.dart';
import 'package:mini_social_media_app_2/database/firestore.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final TextEditingController newPostController = TextEditingController();

  // get Firestore access

  final FirestoreDatabase database = FirestoreDatabase();

  // post message
  void postMessage() {
    // only post the message if there's something in the text field
    if (newPostController.text.isNotEmpty) {
      String messasge = newPostController.text;
      database.addPost(messasge);
    }

    // clear the controller
    newPostController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text('W A L L'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      drawer: MyDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(25),
            child: Row(
              children: [
                // Text field
                Expanded(
                  child: MyTextField(
                      hintText: 'Say Something..',
                      obscureText: false,
                      controller: newPostController),
                ),

                // Post button
                MyPostButton(
                  onTap: postMessage,
                ),
              ],
            ),
          ),
          // Text field for the user to type

          // Posts
          StreamBuilder(
            stream: database.getPostsStream(),
            builder: (context, snapshot) {
              // Show the loading circle
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              // get all posts
              final posts = snapshot.data!.docs;

              // If there are no posts
              if (snapshot.data == null || posts.isEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(25),
                    child: Text('No Posts... Post Something!'),
                  ),
                );
              }

              // The list of posts
              return Expanded(
                child: ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    // Get each individual post
                    final post = posts[index];

                    // Get data for each post

                    String message = post["PostMessage"];
                    String userEmail = post["UserEmail"];
                    Timestamp timestamp = post["Timestamp"];

                    // return as a list tile
                    return MyListTile(title: message, subtitle: userEmail);
                  },
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
