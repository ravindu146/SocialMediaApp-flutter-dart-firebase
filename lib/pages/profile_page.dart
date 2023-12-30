import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mini_social_media_app_2/components/my_back_button.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  // current logged in user
  User? currentUser = FirebaseAuth.instance.currentUser;

  // future to fetch user details

  Future<DocumentSnapshot<Map<String, dynamic>>> getUSerDetails() async {
    return await FirebaseFirestore.instance
        .collection("Users")
        .doc(currentUser!.email)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: getUSerDetails(),
        builder: (context, snapshot) {
          // loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          // Error
          else if (snapshot.hasError) {
            return Text("Error : ${snapshot.error}");
          }

          // Data received
          else if (snapshot.hasData) {
            // extract data

            Map<String, dynamic>? user = snapshot.data!.data();

            return Center(
              child: Column(
                children: [
                  const Padding(
                    padding: const EdgeInsets.only(top: 50, left: 25),
                    child: Row(
                      children: [
                        MyBackButton(),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 25,
                  ),

                  //profile picture
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: const EdgeInsets.all(25),
                    child: Icon(
                      Icons.person,
                      size: 64,
                    ),
                  ),

                  SizedBox(
                    height: 25,
                  ),

                  // username
                  Text(
                    user!['username'],
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),

                  // email
                  Text(
                    user!['email'],
                  ),
                ],
              ),
            );
          } else {
            return Text('No Data!');
          }
        },
      ),
    );
  }
}
