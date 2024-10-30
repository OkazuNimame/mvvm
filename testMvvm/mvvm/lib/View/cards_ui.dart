import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mvvm/saved_recipe.dart';

import '../Repo/recipe_database.dart';

class Cards extends ChangeNotifier{
  Future<Widget> cards(BuildContext context, List<bool> check) async {
    final db = await RecipeDatabase.instance;
    String boolString = check.map((e) => e.toString()).join(",");
    List<Map<String, dynamic>> data = await db.getRowsWithSameCategory(boolString);
    List<Map<String, dynamic>> allData = await db.getData();

    if (allData.isNotEmpty && check.every((e) => e == false)) {
      return _buildPageView(context, allData);
    } else if (data.isNotEmpty) {
      return _buildPageView(context, data);
    } else {
      return Center(child: Text("Not Data"));
    }
  }

Widget _buildPageView(BuildContext context, List<Map<String, dynamic>> items) {
    return PageView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: GestureDetector(
            onLongPress: () {
              _showDeleteDialog(context, item["id"], item["title"]);
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 5,
              child: Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: ClipRRect(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                      child: item["image"] != "assets/image.jpeg" && item["image"] != null
                          ? Image.file(File(item["image"]), fit: BoxFit.cover)
                          : Image.asset(
                              "assets/image.jpeg",
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "タイトル：${item["title"]}",
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 5),
                          Text(
                            "レシピ：${item["recipe"]}",
                            style: TextStyle(fontSize: 16),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SavedRecipe(
                                      id: item["id"],
                                      title: item["title"],
                                      recipe: item["recipe"],
                                      imagePath: item["image"],
                                      check: item["checks"],
                                    ),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(top: 7.0),
                                child: Text(
                                  '詳細を見る',
                                  style: TextStyle(color: Colors.deepPurpleAccent, fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
   void _showDeleteDialog(BuildContext context, int id, String title) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('削除確認'),
          content: Text('$title を削除しますか？'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // ダイアログを閉じる
              },
              child: Text('キャンセル'),
            ),
            TextButton(
              onPressed: () async {
                final db = await RecipeDatabase.instance;
                await db.deleteRecipe(id); // データベースから削除
                Navigator.of(context).pop(); // ダイアログを閉じる
                // 必要に応じて、リストを更新する処理を追加
                notifyListeners();
              },
              child: Text('削除'),
            ),
          ],
        );
      },
    );
  }
}
