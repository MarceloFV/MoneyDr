import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:money/bloca/bloc.dart';
import 'package:money/models/revenue.dart';
import 'package:money/widgets/custom_bottom_app_bar.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:intl/intl.dart';

class CreateRevenueScreen extends StatefulWidget {
  @override
  _CreateRevenueScreenState createState() => _CreateRevenueScreenState();
}

class _CreateRevenueScreenState extends State<CreateRevenueScreen> {
  GlobalKey<_CreateRevenueContentState> revenueContentKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text("Adicionar"),
      ),
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton(
          onPressed: () async {
            Bloc bloc = Bloc.instance;

            Revenue revenue = revenueContentKey.currentState.createRevenue();
            if (revenue != null) {
              bloc.inAddRevenue.add(revenue);
              Scaffold.of(context).hideCurrentSnackBar();
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text("Adicionado com sucesso"),
                ),
              );

              await Future.delayed(Duration(milliseconds: 500));
            }

            await Future.delayed(Duration(milliseconds: 300));
            Navigator.pop(context, true);
          },
          child: Icon(Icons.check),
        ),
      ),
      body: CreateRevenueContent(
        key: revenueContentKey,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: CustomBottomAppBar(),
    );
  }
}

class CreateRevenueContent extends StatefulWidget {
  const CreateRevenueContent({Key key}) : super(key: key);
  @override
  _CreateRevenueContentState createState() => _CreateRevenueContentState();
}

class _CreateRevenueContentState extends State<CreateRevenueContent> {
  int activeIndex = 0;
  DateTime _dateTime = DateTime.now();
  TextEditingController titleController = TextEditingController(text: "");
  TextEditingController descController = TextEditingController(text: "");
  MoneyMaskedTextController valueController =
      MoneyMaskedTextController(leftSymbol: 'R\$ ');

  String get _timeText {
    return DateFormat.yMMMd().format(_dateTime);
  }

  Revenue createRevenue() {
    if (titleController.text == "") return null;
    return Revenue(
      title: titleController.text,
      description: descController.text,
      value: valueController.numberValue,
      time: _dateTime,
      type: (activeIndex == 0) ? RevenueType.Profit : RevenueType.Expense,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Botao para selecionar se é Despesa ou Lucro
              //(Pode ser um switch button)
              ToggleSwitch(
                minWidth: 90,
                initialLabelIndex: 0,
                labels: ['Lucro', 'Despesa'],
                activeBgColors: [Colors.blue, Colors.red],
                onToggle: (index) => activeIndex = index,
              ),
              // Titulo
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                    hintText: "Titulo", border: OutlineInputBorder()),
              ),
              // Descrição
              TextField(
                controller: descController,
                decoration: InputDecoration(
                    hintText: "Descrição", border: OutlineInputBorder()),
              ),
              // Valor
              TextField(
                keyboardType: TextInputType.number,
                controller: valueController,
                decoration: InputDecoration(
                    hintText: "Valor", border: OutlineInputBorder()),
              ),
              Row(
                children: [
                  Text("Data: "),
                  FlatButton(
                      child: Text(_timeText),
                      onPressed: () async {
                        DateTime selectedDate = await showDatePicker(
                          context: context,
                          initialDate: _dateTime,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );
                        if (selectedDate != null && selectedDate != _dateTime)
                          setState(() {
                            _dateTime = selectedDate;
                          });
                      }),
                ],
              )
              // Um calendario que inicialmente mostra a data de hoje
              // (Seletores material flutter gallery)
              // ADICIONAR UMA SNACKBAR PARA FALAR QUE DEU CERTO
            ],
          ),
        ),
      ),
    );
  }
}
