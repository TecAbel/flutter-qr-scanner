import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/config/app_theme.dart';
import 'package:qr_scanner/pages/pages.dart';
import 'package:qr_scanner/services/ui_service.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UiService(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'QR reader',
        initialRoute: 'home',
        routes: {
          'home': (_) => const HomePage(),
          'map': (_) => const MapPage(),
        },
        theme: CustomAppTheme.lightTheme,
        darkTheme: CustomAppTheme.darkTheme,
      ),
    );
  }
}
