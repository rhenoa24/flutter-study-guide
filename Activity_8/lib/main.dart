import 'package:activity_8/bloc/mtg/mtg_function_bloc.dart';
import 'package:activity_8/bloc/pokemon/card_list/poke_list_bloc.dart';
import 'package:activity_8/repository/poke_repository.dart';
import 'package:activity_8/repository/scryfall_repository.dart';
import 'package:activity_8/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_core/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => PokeRepository()),
        RepositoryProvider(create: (_) => ScryfallRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                PokeListBloc(repository: context.read<PokeRepository>()),
          ),
          BlocProvider(
            create: (context) =>
                MtgFunctionBloc(repository: context.read<ScryfallRepository>()),
          ),
        ],
        child: MaterialApp(
          title: 'Activity 8',
          theme: AppTheme.darkTheme,
          debugShowCheckedModeBanner: false,
          home: const HomeScreen(),
        ),
      ),
    );
  }
}
