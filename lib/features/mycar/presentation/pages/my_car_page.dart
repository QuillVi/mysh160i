import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mymotorcycle/features/mycar/presentation/cubit/my_car_cubit.dart';

class MyCarPage extends StatelessWidget {
  const MyCarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyCarCubit, MyCarState>(
      builder: (context, state) {
        return Center(
          child: Text(
            state.info?.title ?? 'My Car',
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      },
    );
  }
}
