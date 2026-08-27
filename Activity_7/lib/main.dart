import 'package:activity_7/bloc/cart_search_bloc.dart';
import 'package:activity_7/repository/scryfall_repository.dart';
import 'package:activity_7/screens/card_search_screen.dart';
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
      create: (_) => ScryfallRepository(),
      child: BlocProvider(
        create: (context) =>
            CardSearchBloc(repository: context.read<ScryfallRepository>()),
        child: MaterialApp(
          title: 'Activity 7A',
          theme: AppTheme.darkTheme,
          debugShowCheckedModeBanner: false,
          home: const CardSearchScreen(),
        ),
      ),
    );
  }
}
