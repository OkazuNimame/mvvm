import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mvvm/ViewModel/Image_View_Model.dart';

class ImageUi extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   final imageViewModel = Provider.of<ImageHandler>(context);

   return imageViewModel.imageData != "assets/image.jpeg"?
   SizedBox(
    height: 300,
    child: Image.file(File(imageViewModel.imageData)),
   ):SizedBox(
    height: 300,
    child: Image.asset(imageViewModel.imageData),
   );
   
  }

}

class SavedImage extends StatelessWidget{
  late String imagePath;
  SavedImage({required this.imagePath});
  @override
  Widget build(BuildContext context) {
    final imageHandler = Provider.of<ImageHandler>(context);
    imageHandler.imageData = imagePath;
     return imageHandler.imageData != "assets/image.jpeg"?
   SizedBox(
    height: 300,
    child: Image.file(File(imageHandler.imageData)),
   ):SizedBox(
    height: 300,
    child: Image.asset(imageHandler.imageData),
   );
  }

}