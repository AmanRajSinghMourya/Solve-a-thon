import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:solveathon/scan_controller.dart';

class CameraScreen extends StatelessWidget {
  const CameraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Scancontroller scancontroller = Get.put(Scancontroller());
    return scancontroller.isInitialized
        ? Scaffold(
            body: Column(
              children: [
                SizedBox(
                  child: CameraPreview(scancontroller.cameraController),
                ),
              ],
            ),
          )
        : Container();
  }
}
