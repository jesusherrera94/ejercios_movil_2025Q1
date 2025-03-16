import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'camera_image.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  runApp(MyApp(cameras: cameras));
}

class MyApp extends StatelessWidget {
  List<CameraDescription> cameras = [];

  MyApp({super.key, required this.cameras});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Face Detection',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: FaceDetectionScreen(cameras: cameras),
    );
  }
}

class FaceDetectionScreen extends StatefulWidget {
  final List<CameraDescription> cameras;

  FaceDetectionScreen({required this.cameras});

  @override
  _FaceDetectionScreenState createState() => _FaceDetectionScreenState();
}

class _FaceDetectionScreenState extends State<FaceDetectionScreen> {

  late CameraController _cameraController;
  late Future<void> _initializeControllerFuture;
  final FaceDetector _faceDetector = FaceDetector(options: FaceDetectorOptions(
    enableContours: false,
    enableClassification: false,
    enableLandmarks: false,
    enableTracking: false,
  ));

  List<Face> _faces = [];
  bool busy = false;

  @override
  void initState() {
    _loadCameraController();
    super.initState();
  }

  void _loadCameraController() async {
    // tenemos que agregar el format desde que el modelo solo soporta dos formatos.
    _cameraController = CameraController(widget.cameras[0], ResolutionPreset.max, imageFormatGroup: Platform.isIOS ? ImageFormatGroup.bgra8888 : ImageFormatGroup.nv21);
    _initializeControllerFuture = _cameraController.initialize().then((_) {
      if (!mounted) return;
      _cameraController.startImageStream(_processCameraImage);
    });
    
  }

  _processCameraImage(CameraImage image) async {
    if (busy) return;
    final inputImage = inputImageFromCameraImage(image, widget.cameras, 0, _cameraController);
    if (inputImage == null) return;
    busy = true;
    final List<Face> faces = await _faceDetector.processImage(inputImage);
    setState(() {
      _faces = faces;
      busy = false;
    });
  }

  @override
  void dispose() {
    _cameraController.dispose();
    _faceDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Face Detection Camera')),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              fit: StackFit.expand,
              children: <Widget>[
                CameraPreview(_cameraController),
                ..._faces.map((face) {
                  final padding = MediaQuery.of(context).padding;
                  return Positioned(
                    left: face.boundingBox.right - face.boundingBox.width - padding.left,
                    top: face.boundingBox.top - kToolbarHeight - padding.top,
                    width: face.boundingBox.width,
                    height: face.boundingBox.height,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.red, width: 2),
                      ),
                    ),
                  );
                }).toList(),
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

}