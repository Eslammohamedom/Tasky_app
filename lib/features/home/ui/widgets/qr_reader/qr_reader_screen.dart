import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:taski/core/helpers/extentions.dart';
import 'package:taski/core/routing/routs.dart';
import 'package:taski/core/theming/colors.dart';

import '../../../../task_details/ui/task_details_screen.dart';


class QrScannerScreen extends StatefulWidget {
  const QrScannerScreen({super.key});

  @override
  State<QrScannerScreen> createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends State<QrScannerScreen> {
  bool _isNavigating = false;
  final MobileScannerController cameraController = MobileScannerController();

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }
  void _handleQrDetection(BarcodeCapture capture) {
    if (_isNavigating) return;

    final List<Barcode> barcodes = capture.barcodes;
    if (barcodes.isNotEmpty && barcodes.first.rawValue != null) {
      final String codeValue = barcodes.first.rawValue!;

      // Target Format Pattern validation check
      final Uri? uri = Uri.tryParse(codeValue);

      if (uri != null && uri.scheme == 'taskyapp' && uri.host == 'item') {
        final String? itemId = uri.queryParameters['id'];

        if (itemId != null) {
          setState(() {
            _isNavigating = true;
          });

          cameraController.stop();

          // Move down to display item inspection details
           context.pushNamed(Routes.taskDetailsScreen,arguments: itemId.toString())
          .then((_) {
            setState(() {
              _isNavigating = false;
            });
            cameraController.start();
          });
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Unrecognized QR template data schema format.'),
            duration: Duration(milliseconds: 700),
          ),
        );
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Reader'),
        actions: [
          ValueListenableBuilder<MobileScannerState>(
            valueListenable: cameraController,
            builder: (context, state, child) {
              // Safely read the torchState from the controller's main state object
              final isTorchOn = state.torchState == TorchState.on;
              return IconButton(
                icon: Icon(
                  isTorchOn ? Icons.flash_on : Icons.flash_off,
                  color: isTorchOn ? AppColorsManager.mainBlue : AppColorsManager.grey,
                ),
                onPressed: () {
                  cameraController.toggleTorch();
                },
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          MobileScanner(
            controller: cameraController,
            onDetect: _handleQrDetection,
          ),
          Center(
            child: Container(
              width: 240,
              height: 240,
              decoration: BoxDecoration(
                border: Border.all(color: AppColorsManager.mainBlue, width: 4),
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}