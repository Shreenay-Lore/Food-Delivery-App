class AppException implements Exception {
  final String? message;
  final String? prefix;
  final String? url;

  AppException([this.message, this.prefix, this.url]);
}

class BadRequestException extends AppException {
  BadRequestException([String? message, String? url]) : super(message, 'Bad Request', url);
}

class FetchDataException extends AppException {
  FetchDataException([String? message, String? url]) : super(message, 'Unable to process', url);
}

class ApiNotRespondingException extends AppException {
  ApiNotRespondingException([String? message, String? url]) : super(message, 'Api not responded in time', url);
}

class UnAuthorizedException extends AppException {
  UnAuthorizedException([String? message, String? url]) : super(message, 'UnAuthorized request', url);
}

class InternetException extends AppException {
  InternetException([String? message, String? url]) : super(message, 'No Internet', url);
}

class RequestTimeOut extends AppException {
  RequestTimeOut([String? message, String? url]) : super(message, 'Request Time Out', url);
}

class ServerException extends AppException {
  ServerException([String? message, String? url]) : super(message, 'Internal Server Error', url);
}

class InvalidUrlException extends AppException {
  InvalidUrlException([String? message, String? url]) : super(message, 'Invalid Url', url);
}
