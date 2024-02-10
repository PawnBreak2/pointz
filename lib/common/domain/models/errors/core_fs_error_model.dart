import '../../interfaces/generic_error_interface.dart';

class FSError implements CustomError {
  final String message;
  FSError(this.message);
}
