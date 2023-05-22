import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/home_model.dart';
import '../models/gallery_model.dart';

import '../widgets/image_container.dart';
import '../widgets/no_internet.dart';
import '../widgets/error_msg.dart';

// Widget implements the home page for generating new random images
class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with WidgetsBindingObserver {
  GalleryModel? _galleryModel;
  HomeModel? _homeModel;

  @override
  void initState() {
    super.initState();
    // add this app as observer for the app to call the didChangeAppLifecycleState function
    WidgetsBinding.instance.addObserver(this);
  }

  // ensure the liked image gets saved even after the widget gets removed from the widget tree
  // e.g. by switching to another screen
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    if (_homeModel!.like && _galleryModel != null && _homeModel!.currentImage != null) {
      _galleryModel!.saveImage(_homeModel!.currentImage!); // save current image
      // don't generate the new image during dispose (could cause potential bugs)
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _homeModel!.generateImage(); // generate a new image to avoid bugs and unnecessary deletion of the image
      });
    }
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _galleryModel = Provider.of<GalleryModel>(context, listen: false);
    _homeModel = Provider.of<HomeModel>(context, listen: false);
  }

  // ensure the current liked image gets saved even when the app gets closed (paused / inactive)
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // is the app paused or inactive?
    if (state == AppLifecycleState.paused || state == AppLifecycleState.inactive) {
      if (_homeModel!.like && _galleryModel != null && _homeModel!.currentImage != null) {
        _galleryModel!.saveImage(_homeModel!.currentImage!); // save the current image
        _homeModel!.generateImage(); // generate a new image to avoid bugs and unnecessary deletion of the image
      }
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      // use the gallery model, which holds necessary variables / states
      child: Consumer<HomeModel>(
        builder: (context, homeModel, _) {
          // use a future builder to wait for the image to be fetched
          return FutureBuilder<Uint8List?>(
            future: homeModel.futureImage,
            builder: (BuildContext context, AsyncSnapshot<Uint8List?> snapshot) {
              // while image is beeing fetched display a loading spinner and grey out the buttons
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedButton.icon(
                            onPressed: null,
                            icon: Icon(homeModel.likeIcon),
                            label: Text('Like'),
                          ),
                          SizedBox(width: 16),
                          ElevatedButton(
                            onPressed: null,
                            child: Text('Next'),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
                // if an error occurs, display an error message and a try-again button
              } else if (snapshot.hasError) {
                return Column(
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: ErrorMsg(errorIcon: Icons.error, errorMsg: 'Error loading image'),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
                      child: ElevatedButton.icon(
                        onPressed: () {
                          homeModel.generateImage();
                        },
                        icon: Icon(Icons.refresh),
                        label: Text('Try again'),
                      ),
                    ),
                  ],
                );
                // if theres no internet connection display the No-Internet-dialog
                // and add an error message and try-again button to the screen
              } else if (snapshot.data == null) {
                homeModel.currentImage = null;
                // ensure that the widget tree has finished rendering the current frame
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => NoInternetDialog(),
                  );
                });
                return Column(
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: ErrorMsg(errorIcon: Icons.error, errorMsg: 'Error loading image'),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
                      child: ElevatedButton.icon(
                        onPressed: () {
                          homeModel.generateImage();
                        },
                        icon: Icon(Icons.refresh),
                        label: Text('Try again'),
                      ),
                    ),
                  ],
                );
                // else display the generated image and a like, next button
              } else {
                homeModel.currentImage = snapshot.data; // set the currentImage of home model to the new value
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                          child: AspectRatio(
                            aspectRatio: 3 / 5,
                            child: ImageContainer(
                              imageSource: snapshot.data!,
                              borderRadius: 10,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              // toggle the like button
                              homeModel.like = !homeModel.like;
                            },
                            icon: Icon(homeModel.likeIcon),
                            label: Text('Like'),
                          ),
                          SizedBox(width: 16),
                          ElevatedButton(
                            onPressed: () {
                              // if the image is liked save it before generating a new one
                              final galleryModel = Provider.of<GalleryModel>(context, listen: false);
                              if (homeModel.like) {
                                galleryModel.saveImage(snapshot.data!);
                              }
                              homeModel.generateImage();
                            },
                            child: Text('Next'),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
            },
          );
        },
      ),
    );
  }
}
