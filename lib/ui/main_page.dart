import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:camera/camera.dart';

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
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Settings()));
          },
          icon: const Icon(Icons.settings, color: Colors.black),
        ),
      ),
      body: Stack(children: [
        mlCamera.when(
          data: (mlCamera) => Stack(
            children: [
              CameraView(cameraController: mlCamera.cameraController),
              buildBoxes(
                recognitions,
                mlCamera.actualPreviewSize,
                mlCamera.ratio,
              ),
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Profile()));
                },
                child: const Text("End Trip",
                    style: TextStyle(color: Colors.white))),
          ),
        ),
      ]),
    );
  }

  Widget buildBoxes(
      List<Recognition> recognitions, Size actualPreviewSize, double ratio) {
    if (recognitions.isEmpty) {
      return const SizedBox();
    }
    return Stack(
      children: recognitions.map((result) {
        return BoundingBox(
          result: result,
          actualPreviewSize: actualPreviewSize,
          ratio: ratio,
        );
      }).toList(),
    );
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

class BoundingBox extends StatelessWidget {
  const BoundingBox({
    Key? key,
    required this.result,
    required this.actualPreviewSize,
    required this.ratio,
  }) : super(key: key);
  final Recognition result;
  final Size actualPreviewSize;
  final double ratio;
  @override
  Widget build(BuildContext context) {
    final renderLocation = result.getRenderLocation(
      actualPreviewSize,
      ratio,
    );
    return Positioned(
      left: renderLocation.left,
      top: renderLocation.top,
      width: renderLocation.width,
      height: renderLocation.height,
      child: Container(
        width: renderLocation.width,
        height: renderLocation.height,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.cyan,
            width: 1,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(2),
          ),
        ),
        child: buildBoxLabel(result, context),
      ),
    );
  }

  Align buildBoxLabel(Recognition result, BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: FittedBox(
        child: ColoredBox(
          color: Colors.blue,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                result.displayLabel,
              ),
              Text(
                ' ${result.score.toStringAsFixed(2)}',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
