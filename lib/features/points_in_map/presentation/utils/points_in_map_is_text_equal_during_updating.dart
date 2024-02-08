import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Used to check if the user inserts the same text for the label during the update.

final isTextEqualDuringUpdateProvider =
    AutoDisposeStateProvider<bool>((ref) => false);
