enum NavigationPage {
  splash,
  map,
}

class NavigationMap {
  static final Map<NavigationPage, String> _navigationMap = {
    NavigationPage.splash: 'splash-page',
    NavigationPage.map: 'map-page',
  };

  static String getPage(NavigationPage page) {
    return _navigationMap[page]!;
  }
}
