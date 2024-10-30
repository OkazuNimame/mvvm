import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mvvm/View/button_ui.dart';
import 'package:mvvm/View/check_box_ui.dart';
import 'package:mvvm/View/image_ui.dart';
import 'package:mvvm/View/text_ui.dart';
import 'package:mvvm/ViewModel/Image_View_Model.dart';
import 'package:mvvm/ViewModel/text_View_Model.dart';
import 'package:mvvm/main.dart';
import 'package:provider/provider.dart';

class SavedRecipe extends StatefulWidget{
  late int id;
  late String title,recipe,imagePath,check;

  SavedRecipe({required this.id,required this.title,required this.recipe,required this.imagePath,required this.check});
  _SavedRecipe createState() => _SavedRecipe();
}

class _SavedRecipe extends State<SavedRecipe>{
  @override
  Widget build(BuildContext context) {
    SavedText savedText = SavedText(title: widget.title, recipe: widget.recipe);
    final textvilew = Provider.of<TextViewModel>(context);
    List<bool> boolList = widget.check.split(",").map((e) => e.toLowerCase() == 'true').toList();
    SavedCheckBox savedCheckBox = SavedCheckBox(data: boolList);
    ChengButton chengButton = ChengButton(id: widget.id,checks: boolList,);
    final checkbox = SavedCheckBox(data: boolList);
    final imageHandler = Provider.of<ImageHandler>(context,listen: false);
    ImageUi imageUi = ImageUi();
    imageHandler.imageData = widget.imagePath;


   return Scaffold(

     appBar: AppBar(
        title: Text("Add Recipe!!"),
        backgroundColor: Colors.blue,
        leading: IconButton(onPressed: (){
Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MainState()),
      
    );
    textvilew.titleController = TextEditingController();
    textvilew.recipeController = TextEditingController();
    imageHandler.imageData = "assets/image.jpeg";
        }, icon: Icon(Icons.arrow_back),
        ),
     ),

    floatingActionButton: FloatingActionButton(onPressed: (){

      imageHandler.pickAndSaveImage();

    },child: Icon(Icons.photo),),

    body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             savedText,
        SizedBox(height: 8,),
        imageUi,
        SizedBox(height: 8,),
        savedCheckBox,
        SizedBox(height: 8,),
        SizedBox(
          height: 100,
          child:Center(
            child: chengButton,
          )
        )
          ],
        )
        )
   );
  }

}