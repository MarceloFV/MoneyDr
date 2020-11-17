import 'package:flutter/material.dart';
import 'package:money/screen/create_revenue_screen.dart';

Future<bool> navigateAddPage(context) async {
  try {
    var val = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateRevenueScreen(),
      ),
    );
    if (val == null) return false;
    return val;
  } catch (err) {
    return false;
  }
}
