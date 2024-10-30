import 'package:flutter/material.dart';

class TextViewModel extends ChangeNotifier {
  TextEditingController titleController = TextEditingController();
  TextEditingController recipeController = TextEditingController();

  // 例: テキストが空でないかチェックする関数
  bool isTitleValid() => titleController.text.isNotEmpty;

  bool isRecipeValid() => recipeController.text.isNotEmpty;
}
