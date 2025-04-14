import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:sqflite/sqflite.dart'; // У эмулятора случился отвал по неизвестной причине
import 'package:sqflite_common_ffi/sqflite_ffi.dart'; // Соответственно, нужно использовать ffi, для десктопной версии
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

part 'panel2_state.dart';

class Panel2Cubit extends Cubit<Panel2State> {
  static const String _tableName = 'investment_history';
  Database? _database;

  Panel2Cubit() : super(Panel2Data.initial()) {
    _initDatabase();
  }

  Future<void> _initDatabase() async {
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  final Directory documentsDir = await getApplicationDocumentsDirectory();
  final String path = join(documentsDir.path, 'money_database.db');

  _database = await openDatabase(
    path,
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE $_tableName('
        'id INTEGER PRIMARY KEY AUTOINCREMENT, '
        'initialCapital REAL, '
        'duration INTEGER, '
        'interestRate REAL, '
        'isCalculated INTEGER, '
        'currentPanelIndex INTEGER, '
        'createdAt TEXT)',
      );
    },
    version: 1,
  );
}

  Future<void> saveData(double initialCapital, int duration, double interestRate) async {
    if (_database == null) return;

    final newData = Panel2Data(
      initialCapital: initialCapital,
      duration: duration,
      interestRate: interestRate,
      isCalculated: true,
      currentPanelIndex: (state as Panel2Data).currentPanelIndex,
      createdAt: DateTime.now(),
    );

    await _database!.insert(
      _tableName,
      newData.toMap(),
    );

    emit(newData);
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
        createdAt: currentState.createdAt,
      ));
    }
  }

  @override
  Future<void> close() async {
    await _database?.close();
    return super.close();
  }
}