import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart' hide LatLng;
import 'package:latlong2/latlong.dart';

import 'package:url_launcher/url_launcher.dart';

import '../models/tournament.dart';

class LocationPage extends StatelessWidget {
  const LocationPage({super.key, required this.tournament});

  final Tournament tournament;

  @override
  Widget build(BuildContext context) {
    final lat = double.tryParse(tournament.geolocation!.split(' ')[0]);
    final lng = double.tryParse(tournament.geolocation!.split(' ')[1]);

    if (lat == null || lng == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Localização'),
        ),
        body: Center(
          child: Text("Localização não definida"),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Localização'),
      ),
      body: FlutterMap(
        options: MapOptions(initialCenter: LatLng(lat, lng), initialZoom: 19),
        children: [
          TileLayer(
            // Display map tiles from any source
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png', // OSMF's Tile Server
            userAgentPackageName: 'br.dev.julliano.torneios_app',
            maxNativeZoom: 19, // Scale tiles when the server doesn't support higher zoom levels
            // And many more recommended properties!
          ),
          MarkerLayer(markers: [
            Marker(
              width: 64.0,
              height: 64.0,
              point: LatLng(lat, lng),
              child: const Icon(
                Icons.location_on,
                size: 48,
              ),
            ),
          ]),
          RichAttributionWidget(
            // Include a stylish prebuilt attribution widget that meets all requirments
            attributions: [
              TextSourceAttribution(
                'OpenStreetMap contributors',
                onTap: () =>
                    launchUrl(Uri.parse('https://openstreetmap.org/copyright')), // (external)
              ),
              // Also add images...
            ],
          ),
        ],
      ),
    );
  }
}
