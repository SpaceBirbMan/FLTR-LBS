import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/history_cubit_state.dart';
import 'cubit/panel2_history_cubit.dart';
import 'package:intl/intl.dart';

class Panel2_3 extends StatelessWidget {
  const Panel2_3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recent calculations')),
      body: BlocBuilder<HistoryCubit, HistoryState>(
        builder: (context, state) {
          if (state is HistoryLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HistoryLoaded) {
            return ListView.builder(
              itemCount: state.history.length,
              itemBuilder: (context, index) {
                final item = state.history[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    title: Text('Capital: ${item.initialCapital.toStringAsFixed(2)}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Duration: ${item.duration} mon.'),
                        Text('Rate: ${item.interestRate}%'),
                        if (item.createdAt != null)
                          Text('Data: ${DateFormat('dd.MM.yyyy HH:mm').format(item.createdAt!)}'),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return const Center(child: Text('N/A'));
        },
      ),
    );
  }
}