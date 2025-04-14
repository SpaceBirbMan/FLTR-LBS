import 'cubit/panel2_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'panel2_3.dart';
import 'cubit/panel2_history_cubit.dart';

// На первом экране в leading AppBar добавить IconButton, и при нажатии на нее используя класс Navigator открыть новый экран с результатами. 
class Panel2_1 extends StatefulWidget {
  final formKey = GlobalKey<FormState>();

  Panel2_1({super.key});

  @override
  State<Panel2_1> createState() => Panel2_1State();
}

/// Окошко с рассчётами
class Panel2_1State extends State<Panel2_1> {
  final agreedToTerms = ValueNotifier<bool>(false);
  final TextEditingController capitalController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController rateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final cubit = BlocProvider.of<Panel2Cubit>(context);
    if (cubit.state is Panel2Data) {
      final state = cubit.state as Panel2Data;
      capitalController.text = state.initialCapital.toString();
      durationController.text = state.duration.toString();
      rateController.text = state.interestRate.toString();
    }
  }

  void submit() {
    if (widget.formKey.currentState!.validate() && agreedToTerms.value) {
      final cubit = BlocProvider.of<Panel2Cubit>(context);
      
      cubit.saveData(
        double.parse(capitalController.text),
        int.parse(durationController.text),
        double.parse(rateController.text),
      );

      cubit.switchPanel(1);
    }
  }

  @override
  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar( // Добавлено ради кнопки
      title: const Text("Investment Calculator"),
      leading: Builder(
  builder: (innerContext) {
    return IconButton(
      icon: const Icon(Icons.show_chart),
      onPressed: () {
        Navigator.push(
          innerContext,
          MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value: BlocProvider.of<HistoryCubit>(innerContext),
              child: const Panel2_3(),
                  ),
                ),
              );
            },
          );
        },
      ),
    ),
    body: BlocBuilder<Panel2Cubit, Panel2State>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: widget.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Auth: Sosnov K.A."),
                TextFormField(
                  controller: capitalController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) return "Enter starting capital";
                    if (double.tryParse(value) == null) return "Statring or Initial capital it's decimal, number if you want, but not this!";
                    if (double.parse(value) < 0) return "Bruh... Bro, pay off your debts pls";
                    return null;
                  },
                  decoration: const InputDecoration(labelText: "Starting capital"),
                ),
                TextFormField(
                  controller: durationController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) return "Enter duration";
                    if (int.tryParse(value) == null) return "No, this is not an integer";
                    if (int.parse(value) <= 0) return "Straight in past, great!";
                    return null;
                  },
                  decoration: const InputDecoration(labelText: "Duration (years)"),
                ),
                TextFormField(
                  controller: rateController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) return "Enter interest rate";
                    if (double.tryParse(value) == null) return "NO!";
                    if (double.parse(value) <= 0) return "How is it feeling, put money in the bank and pay extra, waiting for stonks?";
                    return null;
                  },
                  decoration: const InputDecoration(labelText: "Interest rate (%)"),
                ),
                ValueListenableBuilder<bool>(
                  valueListenable: agreedToTerms,
                  builder: (v , value, vv) => Column(
                    children: [
                      CheckboxListTile(
                        title: const Text("Agree with terms (what terms)"),
                        value: value,
                        onChanged: (bool? newValue) {
                          if (newValue != null) {
                            agreedToTerms.value = newValue;
                          }
                        },
                      ),
                      if (!value)
                        const Text(
                          "Please agree to the terms",
                          style: TextStyle(color: Colors.redAccent),
                        ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: submit,
                  child: const Text("Calculate"),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}
}