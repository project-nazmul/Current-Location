import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Position? currentPosition;
  Placemark? address;

  determineCurrentPosition() async {

    //Check Device Permission
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {return;}
    }
    if (permission == LocationPermission.deniedForever) {return;}

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;

    List<Placemark> placemarks = await placemarkFromCoordinates(currentPosition!.latitude, currentPosition!.longitude);
    setState(() {
      address = placemarks[0];
    });
  }

  @override
  void didChangeDependencies() async{
    // TODO: implement didChangeDependencies
    await determineCurrentPosition();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Country: ${address?.country}'),
              Text('Name: ${address?.name}'),
              Text('Postal Code: ${address?.postalCode}'),
              Text('Street: ${address?.street}'),
              Text('Administrative Area: ${address?.administrativeArea}'),
              Text('Locality: ${address?.locality}'),
              Text('Thoroughfare: ${address?.thoroughfare}'),
              Text('Sub Administrative Area: ${address?.subAdministrativeArea}'),
              Text('Sub Locality: ${address?.subLocality}'),
            ],
          ),
        ),
      ),
    );
  }
}