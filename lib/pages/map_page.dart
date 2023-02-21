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

  final CameraPosition initialPosition = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    QrModel? qr = ModalRoute.of(context)?.settings.arguments as QrModel;
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
        backgroundColor: CustomAppTheme.primaryColor,
      ),
      // body: Center(child: Text(qr.value)),
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: initialPosition,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
