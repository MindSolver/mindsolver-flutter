import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:mindsolver_flutter/utils/constants.dart';
import 'dart:convert';

import 'mental_health_center.dart';

class WelfareScreen extends StatefulWidget {
  @override
  _WelfareScreenState createState() => _WelfareScreenState();
}

class _WelfareScreenState extends State<WelfareScreen> {
  late GoogleMapController mapController;
  final LatLng _center = const LatLng(37.6257, 127.0730);
  bool _isListVisible = false;

  Future<LatLng> _geocodeAddress(String address) async {
    final apiKey =
        'AIzaSyB3L7d_ImmAoQSz02dpvXRlIQCzIijjDPs'; // 여기에 자신의 Google Maps API 키를 입력하세요.
    final encodedAddress = Uri.encodeComponent(address);
    final apiUrl =
        'https://maps.googleapis.com/maps/api/geocode/json?address=$encodedAddress&key=$apiKey';

    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
      final results = data['results'] as List;
      if (results.isNotEmpty) {
        final location = results[0]['geometry']['location'];
        final lat = location['lat'];
        final lng = location['lng'];
        return LatLng(lat, lng);
      }
    }
    return LatLng(0, 0); // 주소를 찾을 수 없는 경우 디폴트 좌표 반환
  }

  Set<Marker> markers = {};

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;

    for (var center in centers) {
      _geocodeAddress(center.address).then((latLng) {
        setState(() {
          markers.add(Marker(
            markerId: MarkerId(center.division),
            position: latLng,
            infoWindow: InfoWindow(
              title: center.division,
              snippet: center.address,
            ),
          ));
        });
      });
    }

    setState(() {
      markers = markers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 17.0,
            ),
            markers: markers,
          ),
          if (_isListVisible)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.45, // 바텀시트 높이 조절
                padding: EdgeInsets.all(16),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _isListVisible = false;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPurpleDarkerColor,
                        foregroundColor: Colors.white,
                      ),
                      child: Text('닫기'),
                    ),
                    // 여기에 목록을 넣으세요
                    Expanded(
                      child: ListView.builder(
                        itemCount: centers.length, // 예시를 위해 10개의 아이템으로 설정
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(centers[index].division),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(centers[index].address),
                                Text(centers[index].email),
                                Text(centers[index].phone1),
                              ],
                            ),
                            onTap: () async {
                              final address = centers[index].address;
                              final LatLng latLng =
                                  await _geocodeAddress(address);
                              mapController.animateCamera(
                                CameraUpdate.newCameraPosition(
                                  CameraPosition(
                                    target: latLng,
                                    zoom: 17.0,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _isListVisible = !_isListVisible;
          });
        },
        backgroundColor: kPurpleDarkerColor,
        foregroundColor: Colors.white,
        child: Icon(_isListVisible ? Icons.map : Icons.list),
      ),
    );
  }
}
