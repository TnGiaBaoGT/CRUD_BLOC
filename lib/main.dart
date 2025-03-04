import 'package:api_crud/crud/crud_bloc.dart';
import 'package:api_crud/crud/crud_bloc_events.dart';
import 'package:api_crud/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
          create: (context) => CrudBloc(), //..add(FetchData() (Tương tự như inítState)
      child: HomePage(),
      ),
    );
  }
}
