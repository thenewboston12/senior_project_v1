import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:camera/camera.dart';
import 'package:audioplayers/audioplayers.dart';

import 'package:flutter_japan_v3/data/model/ml_camera.dart';
import 'package:flutter_japan_v3/data/entity/recognition.dart';

import 'package:flutter_japan_v3/ui/settings.dart';
import 'package:flutter_japan_v3/ui/profile.dart';

class MainPage extends HookConsumerWidget {
  const MainPage({Key? key}) : super(key: key);
  static String routeName = '/main';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final mlCamera = ref.watch(mlCameraProvider(size));
    final recognitions = ref.watch(recognitionsProvider);
    final settings = ref.watch(settingsProvider);

    var watchForMask = settings.showMask;

    //filter the needed recognitions based on the settings
    final filteredRecognitions = recognitions.where((recognition) {
      switch (recognition.label) {
        case 0:
        case 3:
          return true; // Always keep awake and drowsy recognitions
        case 4:
        case 5:
          return settings.showMask;
        case 1:
          return settings.showCellPhone;
        case 2:
          return settings.showCigarette;
        default:
          return false;
      }
    }).toList();

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text(
          "Detection page",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey[300],
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Settings(),
              ),
            );
          },
          icon: const Icon(Icons.settings, color: Colors.black),
        ),
      ),
      body: Stack(
        children: [
          mlCamera.when(
            data: (mlCamera) => Stack(
              children: [
                CameraView(
                  cameraController: mlCamera.cameraController,
                ),
                buildBoxes(filteredRecognitions, context, watchForMask),
              ],
            ),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            error: (err, stack) => Center(
              child: Text(
                err.toString(),
              ),
            ),
          ),
          OverflowBox(
            alignment: Alignment.bottomCenter,
            minWidth: 0.0,
            minHeight: 0.0,
            maxWidth: double.infinity,
            maxHeight: double.infinity,
            child: Container(
              alignment: Alignment.center,
              height: 100,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: Colors.grey[300],
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    fixedSize: const Size(100, 40),
                    elevation: 5,
                    backgroundColor: Colors.black,
                    shadowColor: Colors.black),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "End Trip",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBoxes(
      List<Recognition> recognitions, BuildContext context, bool isMask) {
    bool hasMask = false;
    Set<String> violations = {};

    for (var recognition in recognitions) {
      var displayLabel = recognition.displayLabel;

      if (displayLabel == 'drowsy') {
        violations.add('Drowsiness');
      }
      if (displayLabel == 'cell_phone') {
        violations.add('Cell Phone');
      }
      if (displayLabel == 'cigarette') {
        violations.add('Smoking behavior');
      }

      if (displayLabel == 'without_mask') {
        violations.add('Mask Absence');
      }

      if (isMask && displayLabel == 'with_mask') {
        hasMask = true;
      }

      if (isMask && (displayLabel == 'without_mask')) {
        hasMask = false;
      }
    }

    if (isMask && !hasMask) {
      violations.add("Mask Absence");
    }

    // if no violations then do nothing
    if (violations.isEmpty) {
      return const SizedBox();
    }

    String text = '';

    for (var alert in violations) {
      text += alert;
      text += " ";
    }
    text += "was detected!";

    final player = AudioCache();
    player.play('warning.mp3');

    const primaryColor = Color(0xffe53935); // e53935
    const secondaryColor = Color(0xffff1744); // ff1744
    const accentColor = Color(0xffffffff);

    return Dialog(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          width: MediaQuery.of(context).size.width / 1.5,
          height: MediaQuery.of(context).size.height / 5,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [primaryColor!, secondaryColor!]),
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                    offset: const Offset(12, 26),
                    blurRadius: 50,
                    spreadRadius: 0,
                    color: Colors.grey.withOpacity(.1)),
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: accentColor.withOpacity(.05),
                radius: 25,
                child: Image.network(
                    "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/FlutterBricksLogo-Med.png?alt=media&token=7d03fedc-75b8-44d5-a4be-c1878de7ed52"),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text("Warning!",
                  style: TextStyle(
                      color: accentColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 3.5,
              ),
              Text(text,
                  style: const TextStyle(
                      color: accentColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w300)),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ));
  }
}

class CameraView extends StatelessWidget {
  const CameraView({
    Key? key,
    required this.cameraController,
  }) : super(key: key);

  final CameraController cameraController;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      /// from camera 0.7.0, change aspect ratio
      /// https://pub.dev/packages/camera/changelog#070
      aspectRatio: 1 / cameraController.value.aspectRatio,
      child: CameraPreview(cameraController),
    );
  }
}
