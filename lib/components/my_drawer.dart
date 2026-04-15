import 'package:flutter/material.dart';
import '../services/auth/auth_service.dart';
import '../pages/settings_page.dart';
import '../pages/all_members_chat.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void logout() {
    final auth = AuthService();
    auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              // Иконка в хедере
              const DrawerHeader(
                child: Center(
                  child: Icon(
                    Icons.message,
                    color: const Color(0xfff640f9b),
                    size: 56,
                  ),
                ),
              ),

              // Кнопка HOME
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  title: const Text("H O M E"),
                  leading: const Icon(
                    Icons.home,
                    color: Color(0xfff640f9b),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),

              // Кнопка COMMUNITY WALL
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  title: const Text("C O M M U N I T Y  W A L L"),
                  leading: const Icon(
                    Icons.groups,
                    color: Color(0xfff640f9b),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AllMembersChat(),
                      ),
                    );
                  },
                ),
              ),

              // Кнопка SETTINGS
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  title: const Text("S E T T I N G S"),
                  leading: const Icon(
                    Icons.settings,
                    color: Color(0xfff640f9b),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SettingsPage(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),

          // Кнопка LOGOUT (внизу)
          Padding(
            padding: const EdgeInsets.only(left: 25.0, bottom: 140),
            child: ListTile(
              title: const Text("L O G O U T"),
              leading: const Icon(
                Icons.logout,
                color: Color(0xfff640f9b),
              ),
              onTap: logout,
            ),
          ),
        ],
      ),
    );
  }
}