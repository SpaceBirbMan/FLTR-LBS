import 'package:flutter/material.dart';
import 'panels/panel1.dart' as panel1;
import 'panels/panel2.dart' as panel2;
import 'panels/panel3.dart' as panel3;

class App extends StatefulWidget {
  const App({super.key});

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  final List<Widget> _panels = [
    panel1.Panel1(),
    panel2.Panel2(),
    panel3.Panel3(),
  ];

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  void _onButtonPressed(int delta) {
    int newPage = _currentPage + delta;
    if (newPage >= 0 && newPage < _panels.length) {
      _pageController.animateToPage(
        newPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Соснов К.А. ВМК-22'),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              children: _panels,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: _currentPage > 0 ? () => _onButtonPressed(-1) : null, // Неактивна на первой панели
              ),
              IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: _currentPage < _panels.length - 1 ? () => _onButtonPressed(1) : null, // Неактивна на последней панели
              ),
            ],
          ),
        ],
      ),
    );
  }
}