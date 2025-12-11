import 'package:fpdart/fpdart.dart';
import '../../../../core/exceptions/failure.dart';
import '../ride.dart';

abstract class RideRepository {
  Future<Either<Failure, List<Ride>>> getRides(RideSearchParams params);
}
