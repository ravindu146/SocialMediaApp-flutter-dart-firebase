import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mini_social_media_app_2/theme/dark_mode.dart';
import 'package:mini_social_media_app_2/theme/light_mode.dart';
import 'package:mini_social_media_app_2/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void logout() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              // Drawer header
              DrawerHeader(
                  child: Icon(
                Icons.heat_pump_rounded,
                color: Theme.of(context).colorScheme.inversePrimary,
              )),

              // home title
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: ListTile(
                  leading: Icon(Icons.person),
                  title: Text('H O M E'),
                  onTap: () {
                    // pop the drawer
                    Navigator.pop(context);

                    // navigate to the page
                    Navigator.pushNamed(context, '/home_page');
                  },
                ),
              ),

              //profile

              Padding(
                padding: const EdgeInsets.all(25.0),
                child: ListTile(
                  leading: Icon(Icons.person),
                  title: Text('P R O F I L E'),
                  onTap: () {
                    // pop the drawer
                    Navigator.pop(context);

                    // navigate to the page
                    Navigator.pushNamed(context, '/profie_page');
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(25.0),
                child: ListTile(
                  leading: Icon(Icons.group),
                  title: Text('U S E R S'),
                  onTap: () {
                    // pop the drawer
                    Navigator.pop(context);

                    // navigate to the page
                    Navigator.pushNamed(context, '/users_page');
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(25.0),
                child: ListTile(
                  // leading: Icon(Icons.group),
                  title: Row(
                    children: [
                      Text('D A R K   M O D E'),
                      Switch(
                          value: themeProvider.currentTheme == darkMode,
                          onChanged: (value) {
                            themeProvider.toggleTheme();
                          })
                    ],
                  ),
                  onTap: () {
                    // pop the drawer
                    Navigator.pop(context);

                    // navigate to the page
                    Navigator.pushNamed(context, '/users_page');
                  },
                ),
              ),
            ],
          ),

          // Users

          // Logout tile
          Padding(
            padding: const EdgeInsets.only(left: 25.0, bottom: 25),
            child: ListTile(
              leading: Icon(Icons.logout),
              title: Text('L O G O U T'),
              onTap: () {
                // pop the drawer
                Navigator.pop(context);

                // logout
                logout();
              },
            ),
          ),
        ],
      ),
    );
  }
}
