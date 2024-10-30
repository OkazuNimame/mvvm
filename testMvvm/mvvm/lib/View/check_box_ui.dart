import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mvvm/ViewModel/check_box_viewModel.dart';

class CheckBoxListView extends StatelessWidget {
  

  
  @override
  Widget build(BuildContext context) {
     final viewModel = Provider.of<CheckBoxViewModel>(context);
    
    return Center(
      child:  ListView.builder(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(), // 必要以上にスクロールしない
          itemCount: viewModel.value.length,
          itemBuilder: (context, index) {
            return CheckboxListTile(
              title: Text(viewModel.value[index]),
              value: viewModel.check[index],
              onChanged: (bool? value) {
                viewModel.select(index); // 選択を更新
              },
            );
          },
        ),
    );
    
  }
}

class SavedCheckBox extends StatelessWidget{
  late List<bool> data;

  SavedCheckBox({required this.data});
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CheckBoxViewModel>(context);
    List<bool> getCheckData(){
      return viewModel.check;
    }
     return Center(
      child:  ListView.builder(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(), // 必要以上にスクロールしない
          itemCount: viewModel.value.length,
          itemBuilder: (context, index) {
            return CheckboxListTile(
              title: Text(viewModel.value[index]),
              value: data[index],
              onChanged: (bool? value) {
                viewModel.changeSelect(index,data); // 選択を更新
              },
            );
          },
        ),
    );
  }

}
