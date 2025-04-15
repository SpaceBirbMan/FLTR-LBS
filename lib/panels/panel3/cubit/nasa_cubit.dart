import 'package:flutter_application_1/panels/panel3/requests/api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'nasa_state.dart';
import '../models/nasa.dart';

class NasaCubit extends Cubit<NasaState> {
 NasaCubit(): super(NasaLoadingState());

 Future<void> loadData() async {
  try {
    Map<String, dynamic> apiData = await getNasaData('opportunity', '100', 'eQnprvXukgfNomTanZiHT1DqLApcABzFjI350dyZ');
    Nasa nasaData = Nasa.fromJson(apiData);
    emit(NasaLoadedState(data: nasaData));
  } catch(_) {
    emit(NasaErrorState());
    return;
  }
 }
}