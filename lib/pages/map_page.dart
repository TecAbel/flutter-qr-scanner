import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:qr_scanner/config/app_theme.dart';
import 'package:qr_scanner/models/qr_model.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  MapType mapType = MapType.normal;

  @override
  Widget build(BuildContext context) {
    QrModel? qr = ModalRoute.of(context)?.settings.arguments as QrModel;

    CameraPosition initialPosition = CameraPosition(
      target: qr.getLatLng(),
      zoom: 17,
      tilt: 60,
    );

    Set<Marker> markers = <Marker>{};

    markers.add(Marker(
      markerId: const MarkerId('geo-location'),
      position: qr.getLatLng(),
    ));

    if (qr.value.isEmpty) {
      return const Center(
        child: Text('falta arguments qrModel!'),
      );
    }
    return Scaffold(
      appBar: CupertinoNavigationBar(
        leading: IconButton(
          icon: const Icon(
            Icons.keyboard_arrow_left,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        middle: const Text(
          'map',
          style: TextStyle(color: Colors.white),
        ),
        trailing: IconButton(
          icon: const Icon(
            Icons.location_on,
            size: 25,
            color: Colors.white,
          ),
          onPressed: () async {
            final GoogleMapController controller = await _controller.future;
            controller.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                  target: qr.getLatLng(),
                  zoom: 17,
                ),
              ),
            );
          },
        ),
        backgroundColor: CustomAppTheme.primaryColor,
      ),
      body: GoogleMap(
        mapType: mapType,
        initialCameraPosition: initialPosition,
        zoomControlsEnabled: false,
        markers: markers,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.layers),
        onPressed: () {
          setState(() {
            switch (mapType) {
              case MapType.normal:
                mapType = MapType.satellite;
                break;
              case MapType.satellite:
                mapType = MapType.terrain;
                break;
              case MapType.terrain:
                mapType = MapType.normal;
                break;
              default:
            }
          });
        },
      ),
    );
  }
}
