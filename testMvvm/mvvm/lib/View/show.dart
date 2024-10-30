import 'package:flutter/material.dart';

class Show {
  snac(){
    return  SnackBar(
    behavior: SnackBarBehavior.floating,
    padding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
    margin: const EdgeInsetsDirectional.all(16),
    content: Row(
      children: const [
        Icon(
          Icons.close,
          color: Colors.red,
        ),
        SizedBox(width: 8),
        Text(
          '入力が足りません！',
          style: TextStyle(color: Colors.green),
        ),
      ],
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    showCloseIcon: true,
    elevation: 4.0,
    backgroundColor: Colors.white,
    dismissDirection: DismissDirection.horizontal,
  );
  }
}