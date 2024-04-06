class NetworkException implements Exception {
  final _message;
  final _prefix;

  NetworkException(this._message, this._prefix);

  String toString() {
    return "$_prefix$_message";
  }
}

class NoInternetException extends NetworkException {
  NoInternetException(String message) : super(message, "Please check your internet connection");
}

class FetchDataException extends NetworkException {
  FetchDataException(String message)
      : super(message, "Error During Communication: ");
}

class BadRequestException extends NetworkException {
  BadRequestException(String message) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends NetworkException {
  UnauthorisedException(String message) : super(message, "Unauthorised: ");
}

class NotFoundException extends NetworkException {
  NotFoundException(String message) : super(message,'');
}


