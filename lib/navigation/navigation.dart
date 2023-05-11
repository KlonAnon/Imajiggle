import 'package:flutter/material.dart';

import '../screens/home.dart';
import '../screens/gallery.dart';
import '../screens/history.dart';

class NavigationPage extends StatefulWidget {
  @override
  State<NavigationPage> createState() => _NavigationPage();
}

class _NavigationPage extends State<NavigationPage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = Home();
        break;
      case 1:
        page = Gallery();
        break;
      case 2:
        page = History();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isSmallScreen = constraints.maxWidth < 600;
        final bool isLargeScreen = constraints.maxWidth >= 600;
        final bool isExtended = constraints.maxWidth >= 1000;

        if (isSmallScreen) {
          return Scaffold(
            body: SafeArea(
              child: Container(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: page,
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: selectedIndex,
              onTap: (value) {
                setState(() {
                  selectedIndex = value;
                });
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: 'Favorites',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.history),
                  label: 'History',
                ),
              ],
            ),
          );
        } else if (isLargeScreen) {
          return Scaffold(
            body: SafeArea(
              child: Row(
                children: [
                  NavigationRail(
                    extended: isExtended,
                    destinations: [
                      NavigationRailDestination(
                        icon: Icon(Icons.home),
                        label: Text('Home'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.favorite),
                        label: Text('Favorites'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.history),
                        label: Text('History'),
                      ),
                    ],
                    selectedIndex: selectedIndex,
                    onDestinationSelected: (value) {
                      setState(() {
                        selectedIndex = value;
                      });
                    },
                  ),
                  Expanded(
                    child: Container(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      child: page,
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          throw UnimplementedError('no navigationwidget for $constraints');
        }
      },
    );
  }
}
