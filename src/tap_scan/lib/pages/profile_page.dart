import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tap_scan/components/components.dart';
import 'package:tap_scan/pages/login_page.dart';
import 'package:tap_scan/pages/my_scans_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
            padding: const EdgeInsets.all(20),
            child: const Column(
              children: [
                SizedBox(
                  height: 25,
                ),
                Text(
                  "Edit Profile",
                  style: TextStyle(
                    color: Color.fromRGBO(0, 198, 232, 1),
                    fontWeight: FontWeight.w700,
                    fontSize: 21,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                BackButton(),
                SizedBox(
                  height: 40,
                ),
                ProfilePic(),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Edit Profile",
                  style: TextStyle(
                    color: Color.fromRGBO(0, 198, 232, 1),
                  ),
                ),
                ProfileDatas()
              ],
            ),
          ),
          floatingActionButton: const MainFloatingActionButton(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: const MainBottomNavBar(
            index: 1,
          )),
    );
  }
}

class ProfileDatas extends StatelessWidget {
  const ProfileDatas({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        const ProfileData(
          icon: Icons.email,
          label: "Email",
        ),
        const ProfileData(
          icon: Icons.person,
          label: "Name",
        ),
        const ProfileData(
          icon: Icons.phone,
          label: "No Telp",
        ),
        ElevatedButton(
          onPressed: () {
            // Add your logout logic here
            // For example, sign out from authentication
            FirebaseAuth.instance.signOut();

            // Navigate to MyScansPage after logout
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const LoginPage(),
              ),
              (route) => false,
            );
          },
          child: const Text("Logout"),
        ),
      ],
    );
  }
}


class BackButton extends StatelessWidget {
  const BackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        InkWell(
          child: const Icon(Icons.arrow_back),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const MyScansPage(),
              ),
            );
          },
        ),
      ],
    );
  }
}

class ProfilePic extends StatelessWidget {
  const ProfilePic({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 150,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(90),
        child: Image.asset(
          "assets/images/profile.png",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class ProfileData extends StatelessWidget {
  final String label;
  final IconData icon;
  const ProfileData({super.key, required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Row(
            children: [
              Icon(icon, color: const Color.fromRGBO(0, 198, 232, 1)),
              const SizedBox(
                width: 20,
              ),
              Text(
                label,
                style: const TextStyle(
                  color: Color.fromRGBO(0, 198, 232, 1),
                ),
              ),
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }
}
