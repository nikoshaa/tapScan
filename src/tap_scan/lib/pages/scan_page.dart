import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
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

    controller = CameraController(
      cameras[0],
      ResolutionPreset.max,
    );

    try {
      await controller.initialize();
      if (mounted) {
        setState(() {});
      }
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
    goToMain() {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const MyScansPage(),
        ),
      );
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
                      height: 200,
                      width: 300,
                      child: CameraPreview(controller),
                    )
                  : const CircularProgressIndicator(),
            ),
            const SizedBox(
              height: 30,
            ),
            MainButton(
              function: () {
                print("Takin picture");
                takePicture().then((XFile? file) {
                  if (mounted) {
                    setState(() {
                      pictureFile = file;
                    });
                    if (file != null) {
                      Navigator.push(
                        context,
                        PageTransition(
                            child: const Progress(),
                            type: PageTransitionType.rightToLeftJoined,
                            childCurrent: const CameraPage()),
                      );
                    }
                  }
                });
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

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200, // Set the width
      height: 40, // Set the height
      child: OutlinedButton(
        onPressed: () {
          // Add your button's onPressed action here
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
        child: const Text('Uplaod Image'),
      ),
    );
  }
}


//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Center(
//             child: SizedBox(
//               height: 400,
//               width: 400,
//               child: CameraPreview(controller),
//             ),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: ElevatedButton(
//             onPressed: () async {
//               pictureFile = await controller.takePicture();
//               setState(() {});
//             },
//             child: const Text('Capture Image'),
//           ),
//         ),
//         if (pictureFile != null)
//           Image.network(
//             pictureFile!.path,
//             height: 200,
//           )
//           //Android/iOS
//           // Image.file(File(pictureFile!.path)))
//       ],
//     );
//   }
// }
