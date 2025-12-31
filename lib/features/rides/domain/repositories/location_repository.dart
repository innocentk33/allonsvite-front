import 'package:allonsvite/core/exceptions/failure.dart';
import 'package:fpdart/fpdart.dart';
import '../location.dart';

abstract class LocationRepository {
  Future<Either<Failure, List<Location>>> getLocations();
}
