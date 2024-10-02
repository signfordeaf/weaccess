class HttpErrorMessage {
  final int statusCode;
  final String message;

  HttpErrorMessage(this.statusCode, this.message);

  @override
  String toString() => 'HttpException($statusCode): $message';
}

class BadRequestException extends HttpErrorMessage {
  BadRequestException()
      : super(
          400,
          'Bad request: The server could not understand the request due to invalid syntax.',
        );
}

class UnauthorizedException extends HttpErrorMessage {
  UnauthorizedException()
      : super(
          401,
          'Unauthorized: Authentication is required and has failed or has not yet been provided.',
        );
}

class ForbiddenException extends HttpErrorMessage {
  ForbiddenException()
      : super(
          403,
          'Forbidden: The server understood the request, but it refuses to authorize it.',
        );
}

class NotFoundException extends HttpErrorMessage {
  NotFoundException()
      : super(
          404,
          'Not found: The requested resource could not be found on the server.',
        );
}

class ServerException extends HttpErrorMessage {
  ServerException()
      : super(
          500,
          'Server error: The server encountered an internal error and was unable to complete the request.',
        );
}

class UnknownException extends HttpErrorMessage {
  UnknownException(int statusCode)
      : super(
          statusCode,
          'Unexpected error: An unexpected error occurred with status code $statusCode.',
        );
}
