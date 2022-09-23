import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationPicker extends ChangeNotifier {
  String _currentAddress = '';

  String get currentAddress => _currentAddress;

  set currentAddress(String value) {
    _currentAddress = value;
    notifyListeners();
  }

  Position get currentPosition => _currentPosition!;

  set currentPosition(Position value) {
    _currentPosition = value;
  }

  Position? _currentPosition;

  Future<bool> _handleLocationPermission(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission? permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      AwesomeDialog(
        context: context,
        btnOk: ElevatedButton(
          child: const Text('Continue'),
          onPressed: () {
            Geolocator.openLocationSettings();
          },
        ),
        btnCancel: ElevatedButton(
          child: const Text('Continue'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ).show();

      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //     content: Text(
      //         'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // ScaffoldMessenger.of(context).showSnackBar(
        //     const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //     content: Text(
      //         'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> getCurrentPosition(BuildContext context) async {
    final hasPermission = await _handleLocationPermission(context);

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      //_currentPosition = position;
      //setState(() => _currentPosition = position);
      _getAddressFromLatLng(position);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(position.latitude, position.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      print("$place///////////////////////////");
      currentAddress =
          '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      // setState(() {
      //
      //   // addressController.text = _currentAddress!;
      // });
    }).catchError((e) {
      debugPrint(e);
    });
  }
}
