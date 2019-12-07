import 'package:bloc_provider/bloc_provider.dart';
import 'package:never_forget/enum/page.dart';
import 'package:rxdart/rxdart.dart';

class NavigationBloc implements Bloc {
  final _navigationController = BehaviorSubject<Page>.seeded(Page.RemindersCalendar);
  Stream<Page> get navigationStream => _navigationController.stream;

  final _dataController = BehaviorSubject<dynamic>.seeded(null);
  Stream<dynamic> get dataStream => _dataController.stream;

  void navigateToPage(Page page) {
    _navigationController.add(page);
  }

  dynamic getData() {
    return _dataController.value;
  }

  void pushData(dynamic data) {
    _dataController.add(data);
  }

  void cleanData() {
    _dataController.add(null);
  }

  @override
  void dispose() {
    _navigationController.close();
    _dataController.close();
  }
}