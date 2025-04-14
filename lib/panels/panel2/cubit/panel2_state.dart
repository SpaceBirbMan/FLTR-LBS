part of 'panel2_cubit.dart';

abstract class Panel2State {}

class Panel2Initial extends Panel2State {} // начальное состояние кубита, когда он создаётся (здесь можно что-то закинуть для инициализации)

class Panel2Data extends Panel2State {
  final double initialCapital;
  final int duration;
  final double interestRate;
  final bool isCalculated;
  final int currentPanelIndex;
  final DateTime? createdAt;

  Panel2Data({
    required this.initialCapital,
    required this.duration,
    required this.interestRate,
    required this.isCalculated,
    required this.currentPanelIndex,
    this.createdAt,
  });

  factory Panel2Data.initial() => Panel2Data(
        initialCapital: 0,
        duration: 0,
        interestRate: 0,
        isCalculated: false,
        currentPanelIndex: 0,
        createdAt: null,
      );

  factory Panel2Data.fromMap(Map<String, dynamic> map) => Panel2Data(
        initialCapital: map['initialCapital'] ?? 0,
        duration: map['duration'] ?? 0,
        interestRate: map['interestRate'] ?? 0,
        isCalculated: map['isCalculated'] == 1,
        currentPanelIndex: map['currentPanelIndex'] ?? 0,
        createdAt: map['createdAt'] != null 
            ? DateTime.parse(map['createdAt']) 
            : null,
      );

  Map<String, dynamic> toMap() => {
        'initialCapital': initialCapital,
        'duration': duration,
        'interestRate': interestRate,
        'isCalculated': isCalculated ? 1 : 0,
        'currentPanelIndex': currentPanelIndex,
        'createdAt': createdAt?.toIso8601String(),
      };

  List<Object?> get props => [
        initialCapital,
        duration,
        interestRate,
        isCalculated,
        currentPanelIndex,
        createdAt,
      ];
}