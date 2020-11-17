import 'package:flutter/material.dart';
import 'package:money/models/revenue.dart';
import 'package:money/screen/screen_model.dart';

import '../nav.dart';

class OptionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenModel(
      index: 3,
      content: _OptionsContent(),
      leading: false,
      title: "Opções",
      onPressed: () => navigateAddPage(context),
    );
  }
}

class _OptionsContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Card(
            child: ListTile(
          leading: Icon(
            Icons.warning,
            color: Colors.red,
          ),
          title: Text("Apagar todos os dados"),
          onTap: () {
            RevenueDataBase dataBase = RevenueDataBase.instance;
            dataBase.dropDB();
          },
        ))
      ],
    );
  }
}
