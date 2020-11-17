import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:money/bloca/bloc.dart';
import 'package:money/nav.dart';
import 'package:money/models/revenue.dart';
import 'package:money/screen/screen_model.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return ScreenModel(
      index: 1,
      content: _HistoryContent(),
      leading: false,
      title: "Historico",
      onPressed: () async {
        if (await navigateAddPage(context)) {
          setState(() {
            // print("atualiza");
          });
        }
      },
    );
  }
}

class _HistoryContent extends StatefulWidget {
  @override
  __HistoryContentState createState() => __HistoryContentState();
}

class __HistoryContentState extends State<_HistoryContent> {
  @override
  Widget build(BuildContext context) {
    MoneyMaskedTextController valueController =
        MoneyMaskedTextController(leftSymbol: 'R\$ ');
    Bloc bloc = Bloc();

    return StreamBuilder<List<Revenue>>(
      stream: bloc.output,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();
        if (snapshot.hasError)
          return Center(
            child: Text(snapshot.error),
          );
        if (snapshot.data.length == 0)
          return Text("Nenhum dados adicionado ainda");

        return ListView(
          children: snapshot.data.map<Widget>((revenue) {
            valueController.updateValue(revenue.value);
            return ListTile(
              leading: Padding(
                padding: EdgeInsets.only(top: 8),
                child: revenue.type == RevenueType.Expense
                    ? Icon(
                        Icons.remove_circle,
                        color: Colors.red,
                      )
                    : Icon(
                        Icons.add_circle,
                        color: Colors.green,
                      ),
              ),
              title: Text(revenue.title),
              subtitle: Text(revenue.description),
              trailing: Text(valueController.text),
            );
          }).toList(),
        );
      },
    );
  }
}
