import 'package:pointz/common/domain/interfaces/generic_error_interface.dart';

class LocationError implements CustomError {
  @override
  String message;
  LocationError(this.message);
}
