import 'panel2_cubit.dart';


abstract class HistoryState {
  const HistoryState();
}

class HistoryLoading extends HistoryState {}

class HistoryLoaded extends HistoryState {
  final List<Panel2Data> history;

  const HistoryLoaded(this.history);

  List<Object> get props => [history];
}