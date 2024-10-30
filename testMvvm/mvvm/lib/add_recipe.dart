import 'package:flutter/material.dart';
import 'package:mvvm/View/button_ui.dart';
import 'package:mvvm/View/check_box_ui.dart';
import 'package:mvvm/View/image_ui.dart';
import 'package:mvvm/View/text_ui.dart';
import 'package:mvvm/ViewModel/Image_View_Model.dart';
import 'package:mvvm/ViewModel/text_View_Model.dart';
import 'package:mvvm/main.dart';
import 'package:provider/provider.dart';

class AddRecipe extends StatefulWidget{
  _AddRecipe createState() => _AddRecipe();
}

class _AddRecipe extends State<AddRecipe>{
  @override
  Widget build(BuildContext context) {
    final imageHandler = Provider.of<ImageHandler>(context);
    final textView = Provider.of<TextViewModel>(context);
    final imageUi = ImageUi();
    TextUi textUi = TextUi();
    final checkUi = CheckBoxListView();
    final buttonUi = ButtonUi();
   return Scaffold(
     appBar: AppBar(
        title: Text("Add Recipe!!"),
        backgroundColor: Colors.blue,
        leading: IconButton(onPressed: (){
Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MainState()),
    );
    textView.titleController = TextEditingController();
    textView.recipeController = TextEditingController();
        }, icon: Icon(Icons.arrow_back),
        ),
     ),
    floatingActionButton: FloatingActionButton(onPressed: (){
      imageHandler.pickAndSaveImage();
    },child: Icon(Icons.photo),),

    body: 

         SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             textUi,
        SizedBox(height: 8,),
        imageUi,
        SizedBox(height: 8,),
        checkUi,
        SizedBox(height: 8,),
        SizedBox(
          height: 100,
          child: Center(
            child: buttonUi,
          ),
        )
          ],
        )
        )
       
      
   );
  }

}