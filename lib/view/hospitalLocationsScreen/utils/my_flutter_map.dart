import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MyFlutterMap extends StatelessWidget {
  // final double lat;
  // final double long;
  final List<LatLng> points;

  MyFlutterMap({this.points});

  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center: LatLng(50.291853, 57.185929),
        zoom: 12.0,
      ),
      layers: [
        TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c']),
        MarkerLayerOptions(
          markers: points
              .map<Marker>(
                (latlng) => Marker(
                  width: 80.0,
                  height: 80.0,
                  point: LatLng(latlng.latitude, latlng.longitude),
                  builder: (ctx) =>
                      Icon(Icons.location_pin, color: Colors.red, size: 48),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
