import 'package:flutter_riverpod/flutter_riverpod.dart';

final isTextEmptyBeforeSavingProvider =
    AutoDisposeStateProvider<bool>((ref) => false);
