import 'package:flutter/material.dart';
import 'package:money/widgets/custom_bottom_app_bar.dart';

class ScreenModel extends StatefulWidget {
  final Widget content;
  final bool leading;
  final String title;
  final Function onPressed;
  final Icon icon;
  final Widget bottomAppBar;
  final int index;
  const ScreenModel(
      {this.content,
      this.title,
      this.onPressed,
      this.icon,
      this.index,
      this.leading,
      this.bottomAppBar});

  @override
  State createState() => _ScreenModelState();
}

class _ScreenModelState extends State<ScreenModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: widget.leading ?? true,
        title: Text(widget.title ?? "Bem vindo"),
        bottom: widget.bottomAppBar,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: widget.onPressed ?? _onPressed,
        child: widget.icon ?? Icon(Icons.add),
      ),
      body: widget.content ?? Container(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: CustomBottomAppBar(
        index: widget.index ?? 0,
      ),
    );
  }

  _onPressed() {
    print("Nao funciona");
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => CreateRevenueScreen(),
    //   ),
    // );
  }
}
