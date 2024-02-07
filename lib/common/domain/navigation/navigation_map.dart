enum NavigationPage { splash, map, pointsList }

class NavigationMap {
  static final Map<NavigationPage, String> _navigationMap = {
    NavigationPage.splash: 'splash-page',
    NavigationPage.map: 'map-page',
    NavigationPage.pointsList: 'points-page',
  };

  static String getPage(NavigationPage page) {
    return _navigationMap[page]!;
  }
}
