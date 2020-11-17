import 'package:flutter/material.dart';
import 'package:money/bloca/bloc.dart';
import 'package:money/models/revenue.dart';
import 'package:money/nav.dart';
import 'package:money/screen/screen_model.dart';
import 'package:money/widgets/total_value.dart';

enum PageType {
  Geral,
  Ganhos,
  Gastos,
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final tabs = [
    "Geral",
    "Ganhos",
    "Gastos",
  ];

  final tabsType = [
    PageType.Geral,
    PageType.Ganhos,
    PageType.Gastos,
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: ScreenModel(
        content: TabBarView(
          children: tabsType
              .map((type) => _HomeContent(
                    type: type,
                  ))
              .toList(),
        ),
        bottomAppBar: TabBar(
          isScrollable: false,
          tabs: tabs.map((tab) => Tab(text: tab)).toList(),
        ),
        leading: false,
        title: "Home",
        icon: Icon(Icons.add),
        onPressed: () async {
          if (await navigateAddPage(context)) setState(() {});
        },
        index: 0,
      ),
    );
  }
}

class _HomeContent extends StatefulWidget {
  final PageType type;

  const _HomeContent({Key key, this.type}) : super(key: key);
  @override
  __HomeContentState createState() => __HomeContentState();
}

class __HomeContentState extends State<_HomeContent> {
  @override
  Widget build(BuildContext context) {
    Bloc bloc = Bloc.instance;

    return StreamBuilder(
      stream: bloc.output,
      builder: (context, AsyncSnapshot<List<Revenue>> snapshot) {
        if (!snapshot.hasData)
          return Center(
            child: CircularProgressIndicator(),
          );
        if (snapshot.hasError) return Text("Ocorreu um erro");

        return SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: TotalValue(
                  value: value(snapshot.data, widget.type),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  child: Icon(
                    Icons.monetization_on,
                    size: 192,
                    color: Colors.amber,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

double value(List<Revenue> revenueList, PageType pageType) {
  double value = 0;
  if (pageType == PageType.Geral) {
    revenueList.forEach((revenue) {
      if (revenue.type == RevenueType.Profit) value += revenue.value;
      if (revenue.type == RevenueType.Expense) value -= revenue.value;
    });
  }
  if (pageType == PageType.Ganhos) {
    revenueList.forEach((revenue) {
      if (revenue.type == RevenueType.Profit) value += revenue.value;
    });
  }
  if (pageType == PageType.Gastos) {
    revenueList.forEach((revenue) {
      if (revenue.type == RevenueType.Expense) value += revenue.value;
    });
  }
  return value;
}
