import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class LocationPicker extends ChangeNotifier {
  String _currentAddress = '';
  Position? _currentPosition;
  String? _sessionToken;
  var uuid = const Uuid();
  List<dynamic> _placesList = [];
  bool _isSearching = false;

  bool get isSearching => _isSearching;

  set isSearching(bool value) {
    _isSearching = value;
    notifyListeners();
  }

  String? get sessionToken => _sessionToken;

  set sessionToken(String? value) {
    _sessionToken = value;
    notifyListeners();
  }

  List<dynamic> get placesList => _placesList;

  set placesList(List<dynamic> value) {
    _placesList = value;
    notifyListeners();
  }

  String get currentAddress => _currentAddress;

  set currentAddress(String value) {
    _currentAddress = value;
    notifyListeners();
  }

  Position get currentPosition => _currentPosition!;

  set currentPosition(Position value) {
    _currentPosition = value;
  }

  Future<bool> _handleLocationPermission(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission? permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      AwesomeDialog(
          context: context,
          body: const Text('This app need your current location'),
          title: 'Location',
          animType: AnimType.scale,
          closeIcon: Icon(Icons.clear),
          customHeader: const Icon(
            Icons.location_on,
            size: 50,
            color: Colors.green,
          ),
          btnCancel: ElevatedButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          btnOk: ElevatedButton(
            child: const Text('Continue'),
            onPressed: () {
              Geolocator.openLocationSettings();
              Navigator.pop(context);
            },
          )).show();

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
      _currentPosition = position;
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
          '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.country}';
      // setState(() {
      //
      //   // addressController.text = _currentAddress!;
      // });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  void getSuggestions(String input) async {
    const kGoogleApiKey = 'AIzaSyCuPO4QpbmH7zZ3Q-FmyBfQMZQjC0I5vns';
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=$kGoogleApiKey&sessiontoken=$sessionToken';
    var response = await http.get(Uri.parse(request));
    if (response.statusCode == 200) {
      print(
          '///////////////////${response.body.toString()}/////////////////////////');
      placesList = jsonDecode(response.body.toString())['predictions'];
    } else {
      throw Exception('Failed to load data');
    }
  }
}
