import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tap_scan/components/components.dart';
import 'package:tap_scan/layouts/main_layout_page.dart';
import 'package:tap_scan/pages/my_scans_page.dart';
import 'package:tap_scan/pages/progrees.dart';

class CameraPage extends StatefulWidget {
  final List<CameraDescription>? cameras;
  const CameraPage({this.cameras, Key? key}) : super(key: key);

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController controller;
  XFile? pictureFile;

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    final cameras = widget.cameras;
    if (cameras == null || cameras.isEmpty) {
      print("No cameras available");
      return;
    }

    print("Masuk controller");
    controller = CameraController(
      cameras[0],
      ResolutionPreset.medium,
    );

    try {
      controller.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      }).catchError((Object e) {
        if (e is CameraException) {
          switch (e.code) {
            case 'CameraAccessDenied':
              // Handle access errors here.
              break;
            default:
              // Handle other errors here.
              break;
          }
        }
      });
    } catch (e) {
      print("Error initializing camera: $e");
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // fetch screen size
    final size = MediaQuery.of(context).size;
    var camera = controller.value;
    var scale = size.aspectRatio * camera.aspectRatio;
    if (scale < 1) scale = 1 / scale;

    goToMain() {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const MyScansPage(),
        ),
      );
    }

    Future<void> sendPostImage(File imageFile) async {
      var stream = http.ByteStream(imageFile.openRead());
      stream.cast();

      var length = await imageFile.length();

      const String apiUrl = "http://192.168.76.9:5006/media/upload";

      var uri = Uri.parse(apiUrl);

      var request = http.MultipartRequest("POST", uri);

      request.fields['token'] = '#@<!3c8e_237bc+v)ps;*&er';

      var multipartFile = http.MultipartFile(
        'image', stream, length,
        // filename: imageFile.path
      );
      request.files.add(multipartFile);

      print("Sending the request");
      var response = await request.send();
      print("request sent");

      if (response.statusCode == 200) {
        print('Image uploaded successfully');
        // Handle any additional logic after successful upload
      } else {
        print('Failed to upload image. Status code: ${response.statusCode}');
      }

      // request.headers.addAll({
      //   "Content-Type": "multipart/form-data",
      //   "Accept": "application/json",
      // });

      // try {
      //   print("Masuk post image");
      //   // Create a new multipart request
      //   var request = http.MultipartRequest('POST', Uri.parse(apiUrl));

      //   // Add the image file to the request
      //   request.files
      //       .add(await http.MultipartFile.fromPath('image', imageFile.path));

      //   print("Sending the request");
      //   // Send the request
      //   var response = await request.send();

      //   print("request sent");
      //   // Check the response status
      //   if (response.statusCode == 200) {
      //     print('Image uploaded successfully');
      //     // Handle any additional logic after successful upload
      //   } else {
      //     print('Failed to upload image. Status code: ${response.statusCode}');
      //   }
      // } catch (error) {
      //   print('Error uploading image: $error');
      // }
    }

    postImage(path) async {
      if (!controller.value.isInitialized) {
        print("Camera is not initialized");
        return;
      }

      File imageFile = File(path);
      await sendPostImage(imageFile);
    }

    return MainLayoutPage(
      leftIcon: Icons.arrow_back,
      rightIcon: Icons.more_horiz,
      leftIconFunction: goToMain,
      description:
          "Point the camera at the ID card you want to verify Make sure the image is clear",
      title: "Verification",
      cleanLayout: true,
      widget: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: controller.value.isInitialized
                  ? SizedBox(
                      height: 300,
                      width: 300,
                      child: Transform.scale(
                          scale: scale, child: CameraPreview(controller)),
                    )
                  : const CircularProgressIndicator(),
            ),
            const SizedBox(
              height: 30,
            ),
            MainButton(
              function: () {
                print("Take a picture");
                takePicture().then(
                  (XFile? file) {
                    if (mounted) {
                      setState(() {
                        pictureFile = file;
                      });
                      if (file != null) {
                        // get image path
                        print("Masuk if image not null");
                        final path = file.path;
                        postImage(path);
                        Navigator.push(
                          context,
                          PageTransition(
                              child: const Progress(),
                              type: PageTransitionType.rightToLeftJoined,
                              childCurrent: const CameraPage()),
                        );
                      }
                    }
                  },
                );
              },
              buttonText: "Verification",
              onPressed: () {},
            ),
            const SizedBox(
              height: 30,
            ),
            const SecondaryButton()
          ],
        ),
      ),
      whiteBoxTopPadding: 10,
    );
  }

  Future<XFile?> takePicture() async {
    final CameraController cameraController = controller;
    if (!cameraController.value.isInitialized) {
      print("Camera is not initialized");
      return null;
    }

    if (cameraController.value.isTakingPicture) {
      print("A capture is already pending, do nothing");
      return null;
    }

    try {
      print("Masuk try take picture");
      final XFile file = await cameraController.takePicture();
      return file;
    } on CameraException catch (e) {
      print("Error taking picture: $e");
      return null;
    }
  }
}

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    super.key,
  });

  get http => null;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200, // Set the width
      height: 40, // Set the height
      child: OutlinedButton(
        onPressed: () async {
          // Pick an image from the device's gallery
          final pickedFile =
              await ImagePicker().pickImage(source: ImageSource.gallery);
          if (pickedFile != null) {
            // Upload the image file to your server or cloud storage
            final bytes = await pickedFile.readAsBytes();
            final String base64Image = base64Encode(bytes);

            // Send the base64 encoded image to your server
            final response = await http.post(
              Uri.parse('https://your-server.com/upload-image'),
              body: {'image': base64Image},
            );

            if (response.statusCode == 200) {
              // Image uploaded successfully
              print('Image uploaded successfully');
            } else {
              // Image upload failed
              print('Image upload failed');
            }
          }
        },
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color.fromRGBO(0, 198, 232, 1),
          side: const BorderSide(
            width: 2,
            color: Color.fromRGBO(0, 198, 232, 1),
          ), // Border width and color
          backgroundColor: Colors.transparent, // Transparent background
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0), // Border radius
          ),
        ),
        child: const Text('Upload Image'),
      ),
    );
  }
}
