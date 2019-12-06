import 'package:bloc_provider/bloc_provider.dart';
import 'package:never_forget/model/menu.dart';
import 'package:rxdart/rxdart.dart';

class MenuBloc implements Bloc {
  final _menuController = BehaviorSubject<List<Menu>>.seeded([]);
  Stream<List<Menu>> get menusStream => _menuController.stream;

  List<Menu> get menus => _menuController.value;

  void initMenus(List<Menu> menus) {
    _updateMenus(menus);
  }

  void _updateMenus(List<Menu> menus) {
    _menuController.add(menus);
  }

  Menu getPickedMenu() {
    for (Menu menu in menus) {
      if (menu.isPicked) {
        return menu;
      }
    }
    return null;
  }

  void pickMenu(Menu pickedMenu) {
    final listMenus = List<Menu>.unmodifiable(menus);
    for (Menu menu in listMenus) {
      if (menu == pickedMenu) {
        menu.isPicked = true;
      } else {
        menu.isPicked = false;
      }
    }
    _updateMenus(listMenus);
  }

  @override
  void dispose() {
    _menuController.close();
  }
}