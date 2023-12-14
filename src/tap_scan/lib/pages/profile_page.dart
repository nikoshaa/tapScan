import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tap_scan/components/components.dart';
import 'package:tap_scan/pages/my_scans_page.dart';
import 'package:tap_scan/providers/user_provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(
                height: 25,
              ),
              const Text(
                "Profile",
                style: TextStyle(
                  color: Color.fromRGBO(0, 198, 232, 1),
                  fontWeight: FontWeight.w700,
                  fontSize: 21,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const BackButton(),
              const SizedBox(
                height: 40,
              ),
              Stack(
                children: [
                  const ProfilePic(),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: InkWell(
                      onTap: () async {
                        try {
                          setState(() {
                            _isLoading = true;
                          });
                          final ImageSource? source =
                              await showDialog<ImageSource>(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text("Select the image source"),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(
                                      context, ImageSource.camera),
                                  child: const Text("Camera"),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(
                                      context, ImageSource.gallery),
                                  child: const Text("Gallery"),
                                ),
                              ],
                            ),
                          );

                          if (source == null) return;

                          final image =
                              await ImagePicker().pickImage(source: source);
                          if (image == null) return;
                          final cropped = await ImageCropper()
                              .cropImage(sourcePath: image.path);

                          if (cropped == null) return;

                          final currentUser = FirebaseAuth.instance.currentUser;

                          final ref = FirebaseStorage.instance
                              .ref()
                              .child('profile')
                              .child('${currentUser!.uid}.png');

                          await ref.putFile(File(cropped.path));

                          await currentUser
                              .updatePhotoURL(await ref.getDownloadURL());
                          await currentUser.reload();

                          if (context.mounted) {
                            context
                                .read<UserProvider>()
                                .setUser(FirebaseAuth.instance.currentUser);
                          }
                        } finally {
                          setState(() {
                            _isLoading = false;
                          });
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(0, 198, 232, 1),
                          borderRadius: BorderRadius.circular(90),
                        ),
                        child: _isLoading
                            ? const SizedBox(
                                width: 28,
                                height: 28,
                                child: Padding(
                                  padding: EdgeInsets.all(2.0),
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : const Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                              ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                // Wrap the "Edit Profile" text with InkWell for tap interaction
                onTap: () {
                  // Navigate to the edit profile page when tapped
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          const EditProfilePage(), // Create EditProfilePage class
                    ),
                  );
                },
                child: const Text(
                  "Edit Profile",
                  style: TextStyle(
                    color: Color.fromRGBO(0, 198, 232, 1),
                  ),
                ),
              ),
              const ProfileDatas(),
            ],
          ),
        ),
        floatingActionButton: const MainFloatingActionButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: const MainBottomNavBar(
          index: 1,
        ),
      ),
    );
  }
}

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  // User? currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<UserProvider?>(context)?.user;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Edit Email:"),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                hintText: "Enter your email",
              ),
            ),
            const SizedBox(height: 20),
            const Text("Edit Name:"),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                hintText: "Enter your name",
              ),
            ),
            const SizedBox(height: 20),
            const Text("Edit Phone Number:"),
            TextField(
              controller: _phoneNumberController,
              decoration: const InputDecoration(
                hintText: "Enter your phone number",
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {});
                FirebaseFirestore.instance
                    .collection('users')
                    .doc(currentUser!.uid)
                    .set({
                  'username': _nameController.text.trim(),
                  'email': _emailController.text.trim(),
                  'phoneNumber': _phoneNumberController.text.trim(),
                });
                Navigator.pop(context);
                // Save the edited data to Firestore or perform necessary actions
                // For simplicity, just print the edited data for now
              },
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileDatas extends StatelessWidget {
  const ProfileDatas({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? currentUser = FirebaseAuth.instance.currentUser;

    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser!.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Menampilkan indikator loading jika data belum tersedia
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        // Mendapatkan data dari dokumen Firestore
        String email = snapshot.data!['email'];
        String name = snapshot.data!['username'];
        String phoneNumber = snapshot.data!['phoneNumber'];

        return Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            ProfileData(
              icon: Icons.email,
              label: email,
            ),
            ProfileData(
              icon: Icons.person,
              label: name,
            ),
            ProfileData(
              icon: Icons.phone,
              label: phoneNumber,
            ),
          ],
        );
      },
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
    final user = context.watch<UserProvider>();

    return SizedBox(
      width: 150,
      height: 150,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(90),
        child: user.user?.photoURL != null
            ? Image.network(
                user.user!.photoURL!,
                fit: BoxFit.cover,
              )
            : Image.asset(
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
