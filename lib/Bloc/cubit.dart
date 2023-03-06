import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:map_trick/Bloc/states.dart';



class CubitMapCubit extends Cubit<MapStates>{
  CubitMapCubit():super(initialState());
  static CubitMapCubit get(context) =>BlocProvider.of(context);
  static const LatLng source=LatLng(30.671538711922896, 30.05703672859341);
  static const LatLng distination=LatLng(30.672138508917943, 30.072849159999556);
  LocationData? currentLocation;
  final Completer<GoogleMapController> controller=Completer();

  void getLocation()async{
    Location location=Location();
    location.getLocation().then((value) {
      currentLocation=value;
      emit(GetLocationState());
    });
    GoogleMapController googleMapController=await controller.future;

    location.onLocationChanged.listen((event) {

        currentLocation=event;
        emit(GetLocationState());


        googleMapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          zoom: 13.5,
          target: LatLng(
              event.latitude!,
              event.longitude!
          )
      )
      ));
        emit(GetLocationState());


    });

  }
  List<Polyline> myPolyine=[];
  void getPolyline(){
    myPolyine.add(
        Polyline(
            polylineId: PolylineId('route'),
            points: [
              LatLng(source.latitude, source.longitude),
              LatLng(distination.latitude, distination.longitude),

            ],
            width: 3,
            color: Colors.blue
        )
    );
    emit(lineDrawState());

  }
  double calculateDistance(lat1, lon1, lat2, lon2){
    var p = 0.017453292519943295;
    var a = 0.5 - cos((lat2 - lat1) * p)/2 +
        cos(lat1 * p) * cos(lat2 * p) *
            (1 - cos((lon2 - lon1) * p))/2;
       emit(GetDistance());
    return 12742 * asin(sqrt(a));
  }


}

