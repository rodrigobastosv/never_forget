import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/material.dart';
import 'package:never_forget/core/bloc/menu_bloc.dart';
import 'dart:math';

import 'package:never_forget/core/bloc/navigation_bloc.dart';
import 'package:never_forget/enum/menu_status.dart';
import 'package:never_forget/enum/page.dart';
import 'package:never_forget/model/menu.dart';

class GuillotineMenu extends StatefulWidget {
  @override
  _GuillotineMenuState createState() => _GuillotineMenuState();
}

class _GuillotineMenuState extends State<GuillotineMenu>
    with SingleTickerProviderStateMixin {
  AnimationController animationControllerMenu;
  Animation<double> animationMenu;
  Animation<double> animationTitleFadeInOut;
  MenuStatus menuAnimationStatus;

  NavigationBloc navigationBloc;
  MenuBloc menuBloc;

  @override
  void initState() {
    super.initState();
    menuAnimationStatus = MenuStatus.closed;

    navigationBloc = BlocProvider.of<NavigationBloc>(context);
    menuBloc = BlocProvider.of<MenuBloc>(context);

    menuBloc.initMenus([
      Menu(
          title: 'Calendário',
          icon: Icons.calendar_today,
          onTap: () => navigationBloc.navigateToPage(Page.RemindersCalendar),
          isPicked: true),
      Menu(
          title: 'Lembretes',
          icon: Icons.list,
          onTap: () => navigationBloc.navigateToPage(Page.RemindersList),
          isPicked: false),
      Menu(
          title: 'Adicionar',
          icon: Icons.add,
          onTap: () => navigationBloc.navigateToPage(Page.SaveReminder),
          isPicked: false),
      Menu(
          title: 'Preferências',
          icon: Icons.settings,
          onTap: () => navigationBloc.navigateToPage(Page.Settings),
          isPicked: false)
    ]);

    /// Initialization of the animation controller
    animationControllerMenu = new AnimationController(
        duration: const Duration(
          milliseconds: 750,
        ),
        vsync: this)
      ..addListener(() {});

    /// Initialization of the menu appearance animation
    animationMenu =
        new Tween(begin: -pi / 2.0, end: 0.0).animate(new CurvedAnimation(
      parent: animationControllerMenu,
      curve: Curves.bounceOut,
      reverseCurve: Curves.bounceIn,
    ))
          ..addListener(() {
            setState(() => {});
          })
          ..addStatusListener((AnimationStatus status) {
            if (status == AnimationStatus.completed) {
              menuAnimationStatus = MenuStatus.open;
            } else if (status == AnimationStatus.dismissed) {
              menuAnimationStatus = MenuStatus.closed;
            } else {
              menuAnimationStatus = MenuStatus.animating;
            }
          });

    /// Initialization of the menu title fade out/in animation
    animationTitleFadeInOut =
        new Tween(begin: 1.0, end: 0.0).animate(new CurvedAnimation(
      parent: animationControllerMenu,
      curve: new Interval(
        0.0,
        0.5,
        curve: Curves.ease,
      ),
    ));
  }

  @override
  void dispose() {
    animationControllerMenu.dispose();
    super.dispose();
  }

  /// Play the animation in the direction that depends on the current menu status
  void _playAnimation() {
    try {
      if (menuAnimationStatus == MenuStatus.animating) {
        // During the animation, do not do anything
      } else if (menuAnimationStatus == MenuStatus.closed) {
        animationControllerMenu.forward().orCancel;
      } else {
        animationControllerMenu.reverse().orCancel;
      }
    } on TickerCanceled {
      // the animation go cancelled, probably because disposed
    }
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    Color primaryColor = Theme.of(context).primaryColor;
    Color primaryColorDark = Theme.of(context).primaryColorDark;

    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    double angle = animationMenu.value;

    return Transform.rotate(
      angle: angle,
      origin: Offset(24.0, 56.0),
      alignment: Alignment.topLeft,
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: screenWidth,
          height: screenHeight,
          color: primaryColor,
          child: Stack(
            children: <Widget>[
              /// Menu title
              Positioned(
                top: 32.0,
                left: 40.0,
                width: screenWidth,
                height: 24.0,
                child: Transform.rotate(
                  alignment: Alignment.topLeft,
                  origin: Offset.zero,
                  angle: pi / 2.0,
                  child: Center(
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      child: Opacity(
                        opacity: animationTitleFadeInOut.value,
                        child: StreamBuilder<Page>(
                          stream: navigationBloc.navigationStream,
                          builder: (_, snapshot) {
                            return Text(
                              menuBloc.getPickedMenu()?.title,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: primaryColorDark,
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2.0,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              /// Hamburger icon
              Positioned(
                top: 32.0,
                left: 4.0,
                child: IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: primaryColorDark,
                  ),
                  onPressed: _playAnimation,
                ),
              ),

              /// Menu content
              StreamBuilder<List<Menu>>(
                stream: BlocProvider.of<MenuBloc>(context).menusStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final menus = snapshot.data;
                    return Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 56.0),
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        child: (menuAnimationStatus == MenuStatus.closed ||
                                menuAnimationStatus == MenuStatus.animating)
                            ? Container()
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ListView.builder(
                                    itemBuilder: (_, i) => Container(
                                      color: menus[i].isPicked
                                          ? primaryColorDark
                                          : primaryColor,
                                      child: ListTile(
                                        leading: Icon(menus[i].icon),
                                        title: Text(menus[i].title),
                                        onTap: () {
                                          _playAnimation();
                                          menuBloc.pickMenu(menus[i]);
                                        },
                                      ),
                                    ),
                                    itemCount: menus.length,
                                    shrinkWrap: true,
                                  ),
                                ],
                              ),
                      ),
                    );
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
