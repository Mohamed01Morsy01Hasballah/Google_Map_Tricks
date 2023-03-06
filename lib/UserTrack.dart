import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'Bloc/cubit.dart';
import 'Bloc/states.dart';

class  UserTrack extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return   BlocConsumer<CubitMapCubit,MapStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit=CubitMapCubit.get(context);
        return Scaffold(
          body: cubit.currentLocation == null ?Center(child:CircularProgressIndicator()):
          Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              GoogleMap(
                initialCameraPosition: CameraPosition(
                    target: LatLng(cubit.currentLocation!.latitude!,cubit.currentLocation!.longitude!),
                    zoom: 13.5
                ),
                markers: {
                  Marker(
                      markerId: MarkerId('current'),
                      position: LatLng(
                          cubit.currentLocation!.latitude!,
                         cubit. currentLocation!.longitude!
                      ),
                      infoWindow: InfoWindow(
                          title: 'current location'
                      )
                  ),

                  Marker(
                      markerId: MarkerId('source'),
                      position: CubitMapCubit.source,
                      infoWindow: InfoWindow(
                          title: 'Start'
                      )

                  ),
                  Marker(
                      markerId: MarkerId('distination'),
                      position: CubitMapCubit.distination,
                      infoWindow: InfoWindow(
                          title: 'end'
                      )

                  ),

                },
                polylines:cubit. myPolyine.toSet(),
                onMapCreated: (mapController){
                  cubit.controller.complete(mapController);
                },
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(color:Colors.black.withOpacity(0.3),
                    height: 200,
                    width: double.infinity,
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Distance Between start And End :  ${cubit.calculateDistance(CubitMapCubit.source.latitude,CubitMapCubit.source.longitude,CubitMapCubit.distination.latitude,CubitMapCubit.distination.longitude)} '


       ,style: TextStyle(color: Colors.white,fontSize: 20),),
                        SizedBox(height:10 ,),
                        Text(
                          'Distance Between two Current Location and End   :  ${cubit.calculateDistance(cubit.currentLocation!.latitude,cubit.currentLocation!.longitude,CubitMapCubit.distination.latitude,CubitMapCubit.distination.longitude)} '


                          ,style: TextStyle(color: Colors.white,fontSize: 20),),
//
                      ],
                    )
                ),
              )
            ],
          ),


        );
      },

    );
  }
}
