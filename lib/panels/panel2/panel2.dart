import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/panel2_cubit.dart';
import 'panel2_1.dart';
import 'panel2_2.dart';
import 'panel2_3.dart';
import 'cubit/panel2_history_cubit.dart';

/// Основной класс панелек
class Panel2 extends StatefulWidget {
  const Panel2({super.key});

  @override
  State<Panel2> createState() => _Panel2State();
  // => _Panel2State() - это сокращённая запись (arrow syntax) для возврата экземпляра класса _Panel2State, 
  // который является приватным классом (обозначается подчёркиванием в начале имени) и наследуется от State<Panel2>
}

class _Panel2State extends State<Panel2> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
     return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => Panel2Cubit()),
        BlocProvider(create: (context) => HistoryCubit()),
      ],
      child: Builder(
        builder: (context) {
          return BlocBuilder<Panel2Cubit, Panel2State>(
            builder: (context, state) {
              if (state is! Panel2Data) return const SizedBox.shrink();

          if (_pageController.hasClients && _pageController.page?.round() != state.currentPanelIndex) {
            _pageController.animateToPage(
              state.currentPanelIndex,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          }

          return Container(
            color: Colors.green[100],
            child: Column(
              children: [
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (index) => context.read<Panel2Cubit>().switchPanel(index),
                    children: [ // сюда загружаем экраны
                      Panel2_1(),
                      Panel2_2(),
                      Panel2_3(),
                    ],
                  ),
                ),
                Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back),
                            onPressed: state.currentPanelIndex > 0
                                ? () => context.read<Panel2Cubit>().switchPanel(state.currentPanelIndex - 1)
                                : null,
                          ),
                          IconButton(
                            icon: const Icon(Icons.arrow_forward),
                            onPressed: (state.currentPanelIndex < 2 && state.isCalculated)
                                ? () => context.read<Panel2Cubit>().switchPanel(state.currentPanelIndex + 1)
                                : null,
                          ),
                        ],
                      ),
              ],
            ),
          );
        },
      );
        },
     ),
     );
  }
}