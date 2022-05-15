

class Unauthorized implements Exception{

}

class BadRequest implements Exception{}

class Conflict implements Exception{}

final HttpStatusExceptionMapper = {
  400: BadRequest(),
  401: Unauthorized(),
  409: Conflict()
};

