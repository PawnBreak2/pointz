import 'package:pointz/common/domain/interfaces/generic_error_interface.dart';

class NetworkError implements CustomError {
  @override
  final String message;
  NetworkError(this.message);
}
