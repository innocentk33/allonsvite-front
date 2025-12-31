import 'package:allonsvite/features/rides/domain/model/ride_detail.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/exceptions/failure.dart';
import '../model/ride.dart';

abstract class RideRepository {
  Future<Either<Failure, List<Ride>>> getRides(RideSearchParams params);
  Future<Either<Failure, RideDetail>> getRideDetail(int id);
}
