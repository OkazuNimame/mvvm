import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';  // パスプロバイダー
import 'package:image_picker/image_picker.dart';    // 画像ピッカー

class ImageHandler extends ChangeNotifier{
  // 画像を選択し、ローカルストレージにコピーしてパスを取得するメソッド

  String imageData = "assets/image.jpeg";
   pickAndSaveImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);  // ギャラリーから画像を選択

    if (pickedFile == null) return null;  // 画像が選択されなかった場合

    final File imageFile = File(pickedFile.path);
    final Directory appDir = await getApplicationDocumentsDirectory();  // アプリのローカルストレージディレクトリを取得
    final String folderPath = '${appDir.path}/MyImages';  // "MyImages"フォルダのパスを作成

    // フォルダが存在しない場合は作成
    final Directory folder = Directory(folderPath);
    if (!await folder.exists()) {
      await folder.create(recursive: true);
    }

    // 画像ファイルを新しいフォルダにコピー
    final String newImagePath = '$folderPath/${DateTime.now().millisecondsSinceEpoch}.png';
    final File newImage = await imageFile.copy(newImagePath);
     
   imageData = newImage.path;
   notifyListeners();
  }

  
}
