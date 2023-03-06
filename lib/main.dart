import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Bloc/cubit.dart';
import 'UserTrack.dart';

void main() {

  runApp( MyApp());
}



class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>CubitMapCubit()..getLocation()..getPolyline()..getLocation(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: UserTrack(),
      ),
    );
  }
}
