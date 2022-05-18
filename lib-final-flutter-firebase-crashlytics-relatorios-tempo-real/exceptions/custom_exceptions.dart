
class HttpException implements Exception{}

class HttpUnauthorizedException implements HttpException{
  final String message;

  HttpUnauthorizedException(this.message);
}

class HttpBadRequestException implements HttpException{
  final String message;

  HttpBadRequestException(this.message);
}

class HttpConflictException implements HttpException{
  final String message;

  HttpConflictException(this.message);
}


