// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class ServerException extends Equatable implements Exception {
  final String? msg;
  const ServerException({
    this.msg,
  });

  @override
  List<Object?> get props => [msg];
  @override
  String toString() => '$msg';
}

class FetchDataException extends ServerException {
  const FetchDataException([message]) : super(msg: 'Error During Communication');
}

class BadRequestException extends ServerException {
  const BadRequestException([message]) : super(msg: 'Bad Request');
}

class UnauthorizedException extends ServerException {
  const UnauthorizedException([message]) : super(msg: 'Unauthorized');
}

class NotFoundException extends ServerException {
  const NotFoundException([message]) : super(msg: 'Request Info Not Found');
}

class ConflictException extends ServerException {
  const ConflictException([message]) : super(msg: 'Conflict Occurred');
}

class InternalServerErrorException extends ServerException {
  const InternalServerErrorException([message]) : super(msg: 'Internal Server Error');
}

class NoInternetConnectionException extends ServerException {
  const NoInternetConnectionException([message])
      : super(msg: 'No Internet Connection');
}

class CacheException implements Exception {}
