import 'package:flutter/material.dart';
import 'package:money/screen/charts_screen.dart';
import 'package:money/screen/history_screen.dart';
import 'package:money/screen/home_screen.dart';
import 'package:money/screen/options_screen.dart';

class CustomBottomAppBar extends StatelessWidget {
  final int index;
  const CustomBottomAppBar({this.index = 0});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      child: IconTheme(
        data: IconThemeData(
          color: Theme.of(context).primaryColor,
        ),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: !(index == 0)
                  ? () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ),
                      );
                    }
                  : null,
            ),
            // const Spacer(),
            IconButton(
              icon: const Icon(Icons.history),
              onPressed: !(index == 1)
                  ? () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HistoryScreen(),
                        ),
                      );
                    }
                  : null,
            ),
            IconButton(
              icon: const Icon(Icons.equalizer),
              onPressed: !(index == 2)
                  ? () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatsScreen(),
                        ),
                      );
                    }
                  : null,
            ),
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: !(index == 3)
                  ? () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OptionsScreen(),
                        ),
                      );
                    }
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
