import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/panels/panel3/cubit/nasa_state.dart';
import 'cubit/nasa_cubit.dart';

class Panel3 extends StatelessWidget {
  const Panel3({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NasaCubit()..loadData(),
      child: Container(
        color: Colors.blue[100],
        child: Center(
          child: BlocBuilder<NasaCubit, NasaState>(
            builder: (context, state) {
              if (state is NasaLoadingState) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is NasaLoadedState) {
                return ListView.builder(
                  itemCount: state.data.photos?.length ?? 0,
                  itemBuilder: (context, index) {
                    final photo = state.data.photos?[index];
                    if (photo?.imgSrc == null) {
                      return _buildPlaceholder(null);
                    }
                    return SizedBox(
                      height: 500,
                      width: 500,
                      child: Image.network(
                        photo!.imgSrc!,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const Center(child: CircularProgressIndicator());
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return _buildPlaceholder(photo.imgSrc!);
                        },
                      ),
                    );
                  },
                );
              }
              if (state is NasaErrorState) {
                return const Center(child: Text("Loading error, sorry("));
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholder(var imgSrc) {
    return Container(
      height: 200,
      width: 200,
      color: Colors.grey[300],
      child: Text(imgSrc),
    );
  }
}