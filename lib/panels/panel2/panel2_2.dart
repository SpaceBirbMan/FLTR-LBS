import 'cubit/panel2_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Окошко для результатов (ничего нового почти)
class Panel2_2 extends StatelessWidget {
  const Panel2_2({super.key});

  double calculate(double initialCapital, int duration, double interestRate) {
    return initialCapital * (1 + (interestRate * duration) / 100);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<Panel2Cubit, Panel2State>(
      builder: (context, state) {
        if (state is! Panel2Data) return const SizedBox.shrink();

        final double total = calculate(
          state.initialCapital,
          state.duration,
          state.interestRate,
        );

        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("op.13"),
              const Text(
                'Results',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Text(
                'Starting capital: ${state.initialCapital.toStringAsFixed(2)} conventional units.',
                style: const TextStyle(fontSize: 18),
              ),
              Text(
                'Accrual period: ${state.duration} years',
                style: const TextStyle(fontSize: 18),
              ),
              Text(
                'Rate: ${state.interestRate.toStringAsFixed(2)}%',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              Text(
                'Overall: ${total.toStringAsFixed(2)} conventional units. Congratulations!',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}