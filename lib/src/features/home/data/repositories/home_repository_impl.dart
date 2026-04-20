import '../../domain/entities/home.dart';
import '../../domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  @override
  Future<Home> getHome() async {
    //Aca queremos simular una llamada a una API, pero como no tenemos una API real, vamos a simular un delay y luego devolver un Home con datos ficticios.
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return const Home(
      estimatedRate: 0,
      receiveAmount: 0,
      estimatedTime: '10 Min',
    );
  }
}
