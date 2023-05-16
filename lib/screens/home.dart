import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/home_model.dart';
import '../models/gallery_model.dart';
import '../widgets/image_container.dart';
import '../widgets/no_internet.dart';
import '../widgets/error_msg.dart';
import '../utils/image_operations.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Consumer<HomeModel>(
        builder: (context, homeModel, _) {
          return FutureBuilder<Uint8List?>(
            future: homeModel.futureImage,
            builder: (BuildContext context, AsyncSnapshot<Uint8List?> snapshot) {
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
              } else if (snapshot.data == null) {
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
              } else {
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
                              homeModel.like = !homeModel.like;
                            },
                            icon: Icon(homeModel.likeIcon),
                            label: Text('Like'),
                          ),
                          SizedBox(width: 16),
                          ElevatedButton(
                            onPressed: () {
                              final galleryModel = Provider.of<GalleryModel>(context, listen: false);
                              if (homeModel.like) {
                                galleryModel.addImage(snapshot.data!);
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
