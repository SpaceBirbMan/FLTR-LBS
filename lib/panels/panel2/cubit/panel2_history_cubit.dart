import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'history_cubit_state.dart';
import 'panel2_cubit.dart';

class HistoryCubit extends Cubit<HistoryState> {
  static const String _tableName = 'investment_history';
  Database? _database;

  HistoryCubit() : super(HistoryLoading()) {
    _initDatabase();
  }

  Future<void> _initDatabase() async {
    final Directory documentsDir = await getApplicationDocumentsDirectory();
    final String path = join(documentsDir.path, 'money_database.db');
    
    _database = await openDatabase(path);
    await loadHistory();
  }

  Future<void> loadHistory() async {
    if (_database == null) return;

    emit(HistoryLoading());
    
    final List<Map<String, dynamic>> maps = await _database!.query(
      _tableName,
      orderBy: 'createdAt DESC',
    );

    final history = maps.map((map) => Panel2Data.fromMap(map)).toList();
    emit(HistoryLoaded(history));
  }

  Future<void> deleteItem(int id) async {
    if (_database == null) return;

    await _database!.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );

    await loadHistory();
  }

  @override
  Future<void> close() async {
    await _database?.close();
    return super.close();
  }
}