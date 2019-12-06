import 'package:bloc_provider/bloc_provider.dart';
import 'package:never_forget/enum/page.dart';
import 'package:rxdart/rxdart.dart';

class NavigationBloc implements Bloc {
  final _navigationController = BehaviorSubject<Page>.seeded(Page.RemindersCalendar);
  Stream<Page> get navigationStream => _navigationController.stream;

  void navigateToPage(Page page) {
    _navigationController.add(page);
  }

  @override
  void dispose() {
    _navigationController.close();
  }
}