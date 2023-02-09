import 'package:qr_scanner/models/qr_model.dart';
import 'package:qr_scanner/services/db_service.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> launchScan(QrModel qrModel) async {
  final url = qrModel.value;
  if (qrModel.type == ScanType.url) {
    // open web navigator
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }
}
