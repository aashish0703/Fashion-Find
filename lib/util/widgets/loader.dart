import 'package:flutter/material.dart';

class OverlayLoader {
  static OverlayEntry? _overlayEntry;
  static bool _isVisible = false;

  static void show(BuildContext context) {
    if (_isVisible) {
      debugPrint("Overlay already visible.");
      return;
    }

    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          const ModalBarrier(color: Colors.black54, dismissible: false),
          Center(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 10),
                  Text("Loading...", style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
          ),
        ],
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final overlay = Overlay.of(context, rootOverlay: true);
      if (_overlayEntry != null) {
        overlay.insert(_overlayEntry!);
        _isVisible = true;
        debugPrint("Overlay inserted.");
      } else {
        debugPrint("Failed to insert overlay: No valid Overlay found.");
      }
    });
  }

  static void hide() {
    Future.delayed(const Duration(milliseconds: 500), () {
      if (!_isVisible || _overlayEntry == null) {
        debugPrint("No overlay to remove.");
        return;
      }

      _overlayEntry?.remove();
      _overlayEntry = null;
      _isVisible = false;
      debugPrint("Overlay removed.");
    });


  }
}
