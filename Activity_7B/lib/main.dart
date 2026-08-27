import 'package:activity_7b/bloc/card_list/cart_list_bloc.dart';
import 'package:activity_7b/repository/poke_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_ui/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => PokeRepository(),
      child: BlocProvider(
        create: (context) =>
            CardListBloc(repository: context.read<PokeRepository>()),
        child: MaterialApp(
          title: 'Activity 7B',
          theme: AppTheme.darkTheme,
          debugShowCheckedModeBanner: false,
          // home: const CardListScreen(),
        ),
      ),
    );
  }
}
