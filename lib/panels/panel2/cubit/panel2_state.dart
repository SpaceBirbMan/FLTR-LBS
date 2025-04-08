part of 'panel2_cubit.dart';

abstract class Panel2State {}

class Panel2Initial extends Panel2State {} // начальное состояние кубита, когда он создаётся (здесь можно что-то закинуть для инициализации)
class Panel2Data extends Panel2State { // всё, что в себе хранит состояние и всё, что должно меняться/передаваться и так далее
  // Похоже на запись в Java кста
  final double initialCapital;
  final int duration;
  final double interestRate;
  final bool isCalculated;
  final int currentPanelIndex;

  Panel2Data({ 
    required this.initialCapital,
    required this.duration,
    required this.interestRate,
    required this.isCalculated,
    required this.currentPanelIndex,
  });
}