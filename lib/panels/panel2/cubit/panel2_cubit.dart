import 'package:flutter_bloc/flutter_bloc.dart';

part 'panel2_state.dart';

/// сам кубит на базе определённых состояний
class Panel2Cubit extends Cubit<Panel2State> {
  Panel2Cubit()
      : super(Panel2Data(
          initialCapital: 0,
          duration: 0,
          interestRate: 0,
          isCalculated: false,
          currentPanelIndex: 0,
        ));

  void updateData(double initialCapital, int duration, double interestRate) {
    if (state is Panel2Data) {
      emit(Panel2Data(
        initialCapital: initialCapital,
        duration: duration,
        interestRate: interestRate,
        isCalculated: true,
        currentPanelIndex: (state as Panel2Data).currentPanelIndex,
      ));
    }
  }

  void switchPanel(int index) {
    if (state is Panel2Data) {
      final currentState = state as Panel2Data;
      emit(Panel2Data(
        initialCapital: currentState.initialCapital,
        duration: currentState.duration,
        interestRate: currentState.interestRate,
        isCalculated: currentState.isCalculated,
        currentPanelIndex: index,
      ));
    }
  }
}