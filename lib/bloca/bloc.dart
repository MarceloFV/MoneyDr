import 'dart:async';

import 'package:money/models/revenue.dart';
import 'package:rxdart/subjects.dart';

class Bloc {
  RevenueHelper helper = RevenueHelper();
  BehaviorSubject<List<Revenue>> _revenuesController =
      BehaviorSubject<List<Revenue>>();
  Stream<List<Revenue>> get output => _revenuesController.stream;
  StreamSink<List<Revenue>> get input => _revenuesController.sink;

  StreamController<Revenue> _singleRevenueController =
      StreamController<Revenue>();
  StreamSink<Revenue> get inAddRevenue => _singleRevenueController.sink;

  static Bloc instance = Bloc();

  Bloc() {
    getRevenues();

    _singleRevenueController.stream.listen(_handleAddRevenue);
  }

  getRevenues() async {
    List<Revenue> revenues = await helper.revenues;

    input.add(revenues);
  }

  _handleAddRevenue(Revenue revenue) async {
    await helper.addRevenue(revenue);

    getRevenues();
  }

  void dispose() {
    _revenuesController.close();
    _singleRevenueController.close();
  }
}
