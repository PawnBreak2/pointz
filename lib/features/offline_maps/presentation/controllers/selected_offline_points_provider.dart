import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../points_in_map/domain/entities/point/marker_point_model.dart';

final selectedOfflinePointProvider = StateProvider<MarkerPoint?>((ref) => null);
