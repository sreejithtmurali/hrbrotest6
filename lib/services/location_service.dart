import 'package:geocoding/geocoding.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geocoding_platform_interface/geocoding_platform_interface.dart';

import 'package:location/location.dart' as location;
import 'package:http/http.dart' as http;
import 'package:location/location.dart';

class LocationService{
late location.Location location2=location.Location();
  bool _serviceEnabled = false;
  PermissionStatus? _permissionGranted;
String _address="";

  String get address => _address;
  LocationData? currentLocation;

  Future<LocationData?> getLocation({
    bool silent = false,
    bool fast = false,
  }) async {
    if (fast && currentLocation != null) {
      return currentLocation;
    }

    _permissionGranted = await location2.hasPermission();
    if (_permissionGranted == PermissionStatus.denied ||
        _permissionGranted == PermissionStatus.deniedForever) {
      if (silent) {
        return null;
      } else {
        _permissionGranted = await location2.requestPermission();
        if (_permissionGranted != PermissionStatus.granted &&
            _permissionGranted != PermissionStatus.grantedLimited) {
          return null;
        }
      }
    }

    if (!silent) {
      _serviceEnabled = await location2.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await location2.requestService();
      }
    }

    currentLocation = await location2.getLocation().timeout(const Duration(seconds: 10));

    return currentLocation;
  }



  //
  // late LocationData _currentPosition;
  // late String _address,_dateTime;
  //
  // String get address => _address;
  // late GoogleMapController mapController;
  // late Marker marker;
  // var  location ;
  // late GoogleMapController _controller;
  //
  // void getUserLocation() async {
  //   var position = await GeolocatorPlatform.instance
  //       .getCurrentPosition();
  //
  //
  //    LatLng currentPostion = LatLng(position.latitude, position.longitude);
  //   _getAddress(currentPostion.latitude!.toDouble(), currentPostion.latitude!.toDouble())
  //       .then((value) {
  //     _address = "${value.first.administrativeArea}";
  //
  //   });
  //
  //
  // }
  //
  //
  //
  //
  //
  //
  // LatLng _initialcameraposition = LatLng(0.5937, 0.9629);
  // getLoc() async{
  //   bool _serviceEnabled;
  //   PermissionStatus _permissionGranted;
  //
  //   _serviceEnabled = await location.serviceEnabled();
  //   if (!_serviceEnabled) {
  //     _serviceEnabled = await location.requestService();
  //     if (!_serviceEnabled) {
  //       return;
  //     }
  //   }
  //
  //   _permissionGranted = await location.hasPermission();
  //   if (_permissionGranted == PermissionStatus.denied) {
  //     _permissionGranted = await location.requestPermission();
  //     if (_permissionGranted != PermissionStatus.granted) {
  //       return;
  //     }
  //   }
  //
  //   _currentPosition = await location.getLocation();
  //   _initialcameraposition = LatLng(_currentPosition.latitude!.toDouble(),_currentPosition.longitude!.toDouble());
  //   location.onLocationChanged.listen((LocationData currentLocation) {
  //     print("${currentLocation.longitude} : ${currentLocation.longitude}");
  //
  //       _currentPosition = currentLocation;
  //       _initialcameraposition = LatLng(_currentPosition.latitude!.toDouble(),_currentPosition.latitude!.toDouble());
  //
  //       DateTime now = DateTime.now();
  //       _dateTime = DateFormat('EEE d MMM kk:mm:ss ').format(now);
  //       _getAddress(_currentPosition.latitude!.toDouble(), _currentPosition.latitude!.toDouble())
  //           .then((value) {
  //         _address = "${value.first.administrativeArea}";
  //
  //     });
  //   });
  // }
  //
  //
  // Future<List<Placemark>> _getAddress(double lat, double lang) async {
  //   final coordinates =  placemarkFromCoordinates(lat, lang);
  //   List<Placemark> add = (await placemarkFromCoordinates(lat,lang));
  //   return add;
  // }


}