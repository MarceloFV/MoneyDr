import 'package:flutter/material.dart';
import 'package:money/nav.dart';
import 'package:money/models/revenue.dart';
import 'package:money/screen/screen_model.dart';

class ChatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenModel(
      index: 2,
      content: _ChartsContent(),
      leading: false,
      title: "Graficos",
      onPressed: () => navigateAddPage(context),
    );
  }

  clearAllData() async {
        RevenueDataBase helper = RevenueDataBase.instance;

        List listOfRevenue = await helper.queryAllRows();

        listOfRevenue.forEach((rev) {
          helper.delete(rev['id']);
        });
      }
}

class _ChartsContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Ainda não disponível, aguarde por atualizações!",
      ),
    );
  }
}
