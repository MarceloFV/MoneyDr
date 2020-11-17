import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class TotalValue extends StatefulWidget {
  final double value;

  const TotalValue({Key key, this.value = 0}) : super(key: key);

  @override
  _TotalValueState createState() => _TotalValueState();
}

class _TotalValueState extends State<TotalValue> {
  final controller = new MoneyMaskedTextController(leftSymbol: 'R\$ ');

  @override
  Widget build(BuildContext context) {
    bool isNegative = false;
    if (widget.value < 0) {
      isNegative = true;
    }
    controller.updateValue(widget.value);

    return Container(
      color: Colors.deepPurpleAccent,
      width: double.infinity,
      child: Center(child: _TotalValueContent(text: controller.text, isNegative: isNegative,)),
    );
  }
}

class _TotalValueContent extends StatelessWidget {
  final bool isNegative;
  final String text;

  const _TotalValueContent({Key key, this.text, this.isNegative = false}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontSize: Theme.of(context).textTheme.headline3.fontSize,
          color: isNegative ? Colors.redAccent : Colors.white),
    );
  }
}
