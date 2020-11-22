import 'package:camera/camera.dart';
import 'package:etron_app/ui/shared/loading_widget.dart';
import 'package:etron_app/ui/theme.dart';
import 'package:flutter/material.dart';

class CameraView extends StatefulWidget {
  CameraView({Key key}) : super(key: key);

  @override
  _CameraViewState createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  CameraController controller;
  List<CameraDescription> cameras;

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null) {
      return LoadingWidget(description: '');
    } else if (!controller.value.isInitialized) {
      return LoadingWidget(description: '');
    } else {
      return Padding(
        padding: const EdgeInsets.all(24.0),
        child: ClipRRect(
            borderRadius: EtronTheme.roundedBorder,
            child: AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                child: CameraPreview(controller))),
      );
    }
  }

  initCamera() async {
    cameras = await availableCameras();
    controller = CameraController(cameras[1], ResolutionPreset.medium,
        enableAudio: false);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }
}
