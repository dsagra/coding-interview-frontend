import '../entities/home.dart';

abstract class HomeRepository {
  Future<Home> getHome();
}