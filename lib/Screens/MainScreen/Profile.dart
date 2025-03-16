import 'package:flutter/material.dart';
import 'package:nojia/Screens/Authentication/login.dart';
import 'package:nojia/constants.dart';
import 'package:nojia/providers/AuthProvider.dart';
import 'package:nojia/route.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildTop(),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    _buildProfileItem(Icons.person, 'Edit Profile', () {}),
                    _buildProfileItem(Icons.settings, 'Settings', () {}),
                    _buildProfileItem(Icons.help, 'Help & Support', () {}),
                    _buildProfileItem(Icons.logout, 'Logout', () {
                      Provider.of<AuthProvider>(context, listen: false)
                          .signOut();
                      AppNavigation.navigateReplace(context, const Login());
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: onTap,
    );
  }
}

Widget _buildTop() {
  return Consumer<AuthProvider>(
    builder: (context, auth, child) {
      return Column(
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            height: 100,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Text(
              auth.user?.fname.toUpperCase() ?? 'User not found',
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(
            auth.user?.email ?? 'User not found',
            style: const TextStyle(
              fontSize: 18,
              color: Colors.black,
            ),
          ),
        ],
      );
    },
  );
}
