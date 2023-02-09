import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_scanner/config/app_theme.dart';
import 'package:qr_scanner/models/qr_model.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

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
      body: Center(child: Text(qr.value)),
    );
  }
}
