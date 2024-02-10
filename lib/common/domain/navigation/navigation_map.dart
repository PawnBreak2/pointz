enum NavigationPage { splash, map, pointsList, offlineMap, offlinePointsList }

class NavigationMap {
  static final Map<NavigationPage, String> _navigationMap = {
    NavigationPage.splash: 'splash-page',
    NavigationPage.map: 'map-page',
    NavigationPage.pointsList: 'favorite-points-page',
    NavigationPage.offlineMap: 'offline-map-page',
    NavigationPage.offlinePointsList: 'offline-points-list-page',
  };

  static String getPage(NavigationPage page) {
    return _navigationMap[page]!;
  }
}
