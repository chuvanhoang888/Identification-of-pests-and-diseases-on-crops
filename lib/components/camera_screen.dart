import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_detect_disease_datn/components/display_picture_screen.dart';
import 'package:project_detect_disease_datn/size_config.dart';

class CameraScreen extends StatefulWidget {
  static String routeName = "camera";
  const CameraScreen({Key? key}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  String? _image0;
  final picker = ImagePicker();
  late CameraController _controller;
  Future<void>? _controllerInizializer;
  Future<CameraDescription> getCamera() async {
    final c = await availableCameras();
    return c.first;
  }

  Future<void> chooseImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    //print(pickedFile!.path.toString());
    ///data/user/0/com.example.project_detect_disease_datn/cache/image_picker8534895213644557141.jpg
    setState(() {
      _image0 = pickedFile!.path;
    });
    if (pickedFile!.path == null) retrieveLosData();
  }

  Future<void> retrieveLosData() async {
    final LostDataResponse response = await picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _image0 = response.file!.path;
      });
    } else {
      print(response.file);
    }
  }

  @override
  void initState() {
    super.initState();
    getCamera().then((camera) {
      setState(() {
        _controller = CameraController(camera, ResolutionPreset.high);
        _controllerInizializer = _controller.initialize();
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.black),
      child: Stack(children: [
        Positioned.fill(
          bottom: getProportionateScreenHeight(120),
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
            child: Stack(
              children: [
                FutureBuilder(
                    future: _controllerInizializer,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return CameraPreview(_controller);
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
                // Container(
                //   width: 600,
                //   height: 600,
                //   child: SvgPicture.asset(
                //     "assets/icons/fullscreen_maximize_icon.svg",
                //     color: Colors.white,
                //   ),
                // )
              ],
            ),
          ),
        ),
        Positioned.fill(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              leading: InkWell(
                onTap: () => Navigator.of(context).pop(),
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
              actions: [
                InkWell(
                  onTap: () => _controller.setFlashMode(FlashMode.always),
                  child: Icon(
                    Icons.flash_off,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(15),
                )
              ],
              backgroundColor: Colors.transparent,
              backwardsCompatibility:
                  false, //Phải có cái này mới dùng được SystemUiOverlayStyle
              systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarIconBrightness: Brightness.light,
                  statusBarColor: Colors.black),
            ),
            body: Container(
              child: Stack(children: [
                Positioned(
                  bottom: 10,
                  right: 60,
                  left: 60,
                  child: Column(
                    children: [
                      Text(
                        "CHẨN ĐOÁN",
                        style: TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                            fontWeight: FontWeight.w300),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(10),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () async {
                              chooseImage().whenComplete(() {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => DisplayPictureScreen(
                                      // Pass the automatically generated path to
                                      // the DisplayPictureScreen widget.
                                      imagePath: _image0!,
                                    ),
                                  ),
                                );
                              });
                            },
                            child: FaIcon(
                              FontAwesomeIcons.solidFolderOpen,
                              color: Colors.white,
                              size: 50,
                            ),
                          ),
                          Column(
                            children: [
                              InkWell(
                                onTap: () async {
                                  try {
                                    // Ensure that the camera is initialized.
                                    await _controllerInizializer;

                                    // Attempt to take a picture and then get the location
                                    // where the image file is saved.
                                    final image =
                                        await _controller.takePicture();

                                    setState(() {
                                      _image0 = image.path;
                                    });
                                    // If the picture was taken, display it on a new screen.
                                    await Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DisplayPictureScreen(
                                          // Pass the automatically generated path to
                                          // the DisplayPictureScreen widget.
                                          imagePath: _image0!,
                                        ),
                                      ),
                                    );
                                  } catch (e) {
                                    // If an error occurs, log the error to the console.
                                    print(e);
                                  }
                                },
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                        height: 80,
                                        width: 80,
                                        decoration: BoxDecoration(
                                            color: Colors.grey.withOpacity(0.9),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(40)))),
                                    Container(
                                        height: 60,
                                        width: 60,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            // border: Border.all(
                                            //     color: Colors.black, width: 2),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30)))),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () {},
                            child: SvgPicture.asset(
                              "assets/icons/find-bug2.svg",
                              color: Colors.white,
                              width: 50,
                              height: 50,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        )
      ]),
    );
  }
}
