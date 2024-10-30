import 'package:flutter/material.dart';
import 'package:mvvm/ViewModel/text_View_Model.dart';
import 'package:provider/provider.dart';

class TextUi extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final textViewModel = Provider.of<TextViewModel>(context);
    return Column(
      mainAxisSize:MainAxisSize.min,
      children: [
         TextField(
      controller: textViewModel.titleController,
      maxLines: 3,
      decoration: InputDecoration(
        label: Text("ここにタイトル！")
      ),
    ),
    SizedBox(height: 8,),
    TextField(
      controller: textViewModel.recipeController,
      maxLines: 25,
      decoration: InputDecoration(
        label: Text("ここにレシピ！")
      ),
    )
      ],
    );
  }
  
}

class SavedText extends StatelessWidget{
  late String title,recipe;

  SavedText({required this.title,required this.recipe});

  @override
  Widget build(BuildContext context) {
    final textView = Provider.of<TextViewModel>(context);
    textView.titleController = TextEditingController(text: title);
    textView.recipeController = TextEditingController(text: recipe);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
      controller: textView.titleController,
      maxLines: 3,
      decoration: InputDecoration(
        label: Text("ここにタイトル！")
      ),
    ),
    SizedBox(height: 8,),
    TextField(
      controller: textView.recipeController,
      maxLines: 25,
      decoration: InputDecoration(
        label: Text("ここにレシピ！")
      ),
    )
      ],
    );
  }

}