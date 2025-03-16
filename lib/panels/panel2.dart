import 'package:flutter/material.dart';

class Panel2 extends StatefulWidget {
  const Panel2({super.key});
  @override
  Panel2State createState() => Panel2State(); // Панели в панели
}

/// Основа
class Panel2State extends State<Panel2> {
  int currentPanelIndex = 0;
  final PageController pageController = PageController();

  double initialCapital = 0;
  int duration = 0;
  double interestRate = 0;
  bool isCalculated = false;

  void switchPanel(int index) {
    setState(() {
      currentPanelIndex = index;
    });
    pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void updateData(double initialCapital, int duration, double interestRate) {
    setState(() {
      this.initialCapital = initialCapital;
      this.duration = duration;
      this.interestRate = interestRate;
      this.isCalculated = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container( // костыляха
      color: Colors.green[100],
      child: Column(
      children: [
        Expanded(
          child: PageView(
            controller: pageController,
            children: [
              Panel2_1(
                onNext: () => switchPanel(1),
                updateData: updateData,
                initialCapital: initialCapital,
                duration: duration,
                interestRate: interestRate,
              ),
              Panel2_2(
                initialCapital: initialCapital,
                duration: duration,
                interestRate: interestRate,
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: currentPanelIndex > 0 ? () => switchPanel(0) : null,
            ),
            IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: (currentPanelIndex < 1 && isCalculated) ? () => switchPanel(1) : null,
            ),
          ],
        ),
      ],
    ),
    );
  }
}

/// Панелька с рассчётами
class Panel2_1 extends StatefulWidget {
  final VoidCallback onNext;
  final Function(double, int, double) updateData;
  final double initialCapital;
  final int duration;
  final double interestRate;

  const Panel2_1({
    super.key,
    required this.onNext,
    required this.updateData,
    required this.initialCapital,
    required this.duration,
    required this.interestRate,
  });

  @override
  Panel2_1State createState() => Panel2_1State();
}

/// "Обработчик событий" для первой панельки
class Panel2_1State extends State<Panel2_1> {
  final formKey = GlobalKey<FormState>();
  late double initialCapital;
  late int duration;
  late double interestRate;
  bool agreedToTerms = false;

  @override
  void initState() {
    super.initState();
    initialCapital = widget.initialCapital;
    duration = widget.duration;
    interestRate = widget.interestRate;
  }

  void submit() {
    if (formKey.currentState!.validate() && agreedToTerms) {
      formKey.currentState!.save();

      // Передача данных во вторую панель
      widget.updateData(initialCapital, duration, interestRate);

      // Сам переход
      widget.onNext();
    }
  }

  Widget build(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Auth: Sosnov K.A."),
          TextFormField(
            keyboardType: TextInputType.number,
            initialValue: initialCapital.toString(),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Enter starting capital";
              }
              if (double.tryParse(value) == null) {
                return "Please enter a valid number";
              }
              if (double.parse(value) < 0) {
                return "Bruh... Bro, pay off your debts pls";
              }
              return null;
            },
            onSaved: (value) => initialCapital = double.parse(value!),
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              labelText: "Starting capital",
              errorStyle: TextStyle(color: Colors.redAccent),
            ),
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            initialValue: duration.toString(),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Enter accrual period";
              }
              if (int.tryParse(value) == null || duration < 0) {
                return "Please enter a valid integer";
              }
              return null;
            },
            onSaved: (value) => duration = int.parse(value!),
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              labelText: "Accrual period (years)",
              errorStyle: TextStyle(color: Colors.redAccent),
            ),
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            initialValue: interestRate.toString(),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Enter interest rate";
              }
              if (double.tryParse(value) == null || interestRate < 0) {
                return "Please enter a valid number";
              }
              return null;
            },
            onSaved: (value) => interestRate = double.parse(value!),
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              labelText: "Rate (%)",
              errorStyle: TextStyle(color: Colors.redAccent),
            ),
          ),
          CheckboxListTile(
            title: Text("Agree with terms (what terms)"),
            value: agreedToTerms,
            onChanged: (bool? value) {
              if (value != null) {
                setState(() {
                  agreedToTerms = value;
                });
              }
            },
          ),
          if (!agreedToTerms)// todo.visuals: Убирать ошибки при начале ввода
            Text(
              "Please agree to the terms",
              style: TextStyle(color: Colors.redAccent),
            ),
          ElevatedButton(
            onPressed: submit,
            child: Text("Calculate"),
          ),
        ],
      ),
    ),
  );
}
}

/// Панель с результатом
class Panel2_2 extends StatelessWidget {
  final double initialCapital;
  final int duration;
  final double interestRate;

  const Panel2_2({
    super.key,
    required this.initialCapital,
    required this.duration,
    required this.interestRate,
  });

  double calculate() {
    return initialCapital * (1 + (interestRate * duration) / 100);
  }

  // Сгенерено
  @override
  Widget build(BuildContext context) {
    final double total = calculate();

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("op.13"),
          Text(
            'Results',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Text(
            'Starting capital: ${initialCapital.toStringAsFixed(2)} conventional units.',
            style: TextStyle(fontSize: 18),
          ),
          Text(
            'Accrual period: $duration years',
            style: TextStyle(fontSize: 18),
          ),
          Text(
            'Rate: ${interestRate.toStringAsFixed(2)}%',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 20),
          Text(
            'Overall: ${total.toStringAsFixed(2)} conventional units. Congratulations!',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
          ),
        ],
      ),
    );
  }
}