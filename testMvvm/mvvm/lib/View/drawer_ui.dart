import 'package:flutter/material.dart';
import 'package:mvvm/View/check_box_ui.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final checkbox = CheckBoxListView();
    return Drawer(
      child: Container(
        color: Colors.blueAccent, // ドロワーの背景色
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue, // ヘッダーの背景色
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/cook.png'), // プロフィール画像
                  ),

                  Text(
                    'てるよ’s Recipe',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  Text(
                    'email@example.com',
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home, color: Colors.white),
              title: Text('ホーム', style: TextStyle(color: Colors.white)),
              onTap: () {
                // ホームをタップしたときの処理
                Navigator.pop(context);
              },
            ),
            SizedBox(
              height: 430,
              child: checkbox,
            ),
            Divider(color: Colors.white70), // アイテムの間に区切り線
            
          ],
        ),
      ),
    );
  }
}