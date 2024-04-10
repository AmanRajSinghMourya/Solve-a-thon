import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:get/get.dart';

class Scancontroller extends GetxController {
  late List<CameraDescription> _cameras;
  late CameraController _cameraController;
  final RxBool _isInitialized = false.obs;
  CameraImage? _cameraImage;
  final RxList<Uint8List> image = <Uint8List>[].obs;

  CameraController get cameraController => _cameraController;
  bool get isInitialized => _isInitialized.value;
  List<Uint8List> get images => image;

  @override
  void onInit() {
    // _initializeCamera();
    super.onInit();
  }

  // void capture(){
  //   img.Image image = img.Image.fromBytes(_cameraImage!.width, _cameraImage!.height, _cameraImage!.planes[0].bytes);
  // }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  Future<void> initCamera() async {
    _cameras = await availableCameras();
    _cameraController = CameraController(
      _cameras[0],
      ResolutionPreset.max,
      imageFormatGroup: ImageFormatGroup.bgra8888,
    );

    await _cameraController.initialize().then((value) {
      _isInitialized.value = true;
      _cameraController.startImageStream((image) {
        _cameraImage = image;
      });
      _isInitialized.refresh();
    }).catchError((Object e) {
      if (e is CameraException) {
        print(e.description);
      }
    });
  }
}
