import 'package:flutter/material.dart';
import 'package:mvvm/Model/Recipe.dart';
import 'package:mvvm/Repo/recipe_database.dart';
import 'package:mvvm/View/show.dart';
import 'package:mvvm/ViewModel/Image_View_Model.dart';
import 'package:mvvm/ViewModel/check_box_viewModel.dart';
import 'package:mvvm/ViewModel/text_View_Model.dart';
import 'package:mvvm/main.dart';
import 'package:provider/provider.dart';

class ButtonUi extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final image = Provider.of<ImageHandler>(context);
    final text = Provider.of<TextViewModel>(context);
    final check = Provider.of<CheckBoxViewModel>(context);
    
   return TextButton(onPressed: ()async{
    Recipe data = Recipe(text.titleController.text, text.recipeController.text, image.imageData, check.check);
    final db = RecipeDatabase.instance;
if(text.titleController.text.isNotEmpty && text.recipeController.text.isNotEmpty && check.check.contains(true)){
  db.insertData(data.toMap());
   image.imageData = "assets/image.jpeg";
    
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainState()));
    text.titleController = TextEditingController();
    text.recipeController = TextEditingController();
}else{
                Show show = Show();
                final snac = show.snac();
                ScaffoldMessenger.of(context).showSnackBar(snac);
              }
    
   
    
   }, child: Text("保存",style: TextStyle(fontSize: 30)));
  }

}

class ChengButton extends StatelessWidget {
  late int id;
  late List<bool> checks;

  ChengButton({required this.id,required this.checks});

  @override
  Widget build(BuildContext context) {
    // listen: falseを追加してProviderから値を取得
    final image = Provider.of<ImageHandler>(context, listen: false);
    final text = Provider.of<TextViewModel>(context, listen: false);
    
    
    return TextButton(
      onPressed: () async {
        final db = await RecipeDatabase.instance;
        print("${text.titleController.text}");
        print(checks);
        // 入力チェック
        if (text.isTitleValid() &&
            text.isRecipeValid()&&
            checks.contains(true)) {
          // データの更新
          db.updateData(id, text.titleController.text, text.recipeController.text, image.imageData, checks);
          // メイン画面に戻る
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainState()));
          text.titleController = TextEditingController();
          text.recipeController = TextEditingController();
          image.imageData = "assets/image.jpeg";
        }else{
                Show show = Show();
                final snac = show.snac();
                ScaffoldMessenger.of(context).showSnackBar(snac);
              }
      },
      child: Text(
        "更新",
        style: TextStyle(fontSize: 30),
      ),
    );
  }
}
