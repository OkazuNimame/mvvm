import 'package:flutter/material.dart';
import 'package:mvvm/View/cards_ui.dart';
import 'package:mvvm/View/check_box_ui.dart';
import 'package:mvvm/View/drawer_ui.dart';
import 'package:mvvm/View/text_ui.dart';
import 'package:mvvm/ViewModel/Image_View_Model.dart';
import 'package:mvvm/ViewModel/check_box_viewModel.dart';
import 'package:mvvm/ViewModel/text_View_Model.dart';
import 'package:mvvm/add_recipe.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TextViewModel()), // テキストの状態管理
        ChangeNotifierProvider(create: (context) => ImageHandler()),   // 画像の状態管理
        ChangeNotifierProvider(create: (context) => CheckBoxViewModel()), // チェックボックスの状態管理
        ChangeNotifierProvider(create: (context) => Cards())
      ],
      child: MaterialApp( // MaterialAppを追加
        title: 'My Flutter App',
        theme: ThemeData(
          primarySwatch: Colors.blue, // 必要に応じてテーマを設定
        ),
        home: MainState(),
      ),
    ),
  ); 
}

class MainState extends StatefulWidget {
  @override
  MainApp createState() => MainApp();
}

class MainApp extends State<MainState> {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CheckBoxViewModel>(context);
    final cards = Provider.of<Cards>(context);
    CustomDrawer customDrawer = CustomDrawer();

    return Scaffold(
      appBar: AppBar(
        title: Text("Recipe"),
        backgroundColor: Colors.blue,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
            context, 
            MaterialPageRoute(builder: (context) => AddRecipe()),
          );
        },
        child: Icon(Icons.add),
      ),
      drawer: Drawer(
        child: customDrawer,
      ),
      body: FutureBuilder<Widget>(
        future: cards.cards(context, viewModel.check), // cardsメソッドを呼び出してFutureを設定
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator()); // 読み込み中
          } else if (snapshot.hasError) {
            return Center(child: Text("エラーが発生しました: ${snapshot.error}")); // エラーハンドリング
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text("データが見つかりません")); // データがない場合
          } else {
            return snapshot.data!; // cardsメソッドから返されたWidgetを表示
          }
        },
      ),
    );
  }
}
