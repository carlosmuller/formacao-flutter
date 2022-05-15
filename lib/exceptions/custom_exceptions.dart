

class Unauthorized implements Exception{

}

class BadRequest implements Exception{}

final HttpStatusExceptionMapper = {
  400: BadRequest(),
  401: Unauthorized(),
};

