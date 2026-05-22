import 'dart:convert';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart' as wf;
import 'package:webview_windows/webview_windows.dart' as ww;

class MuscleCharacterViewer extends StatefulWidget {
  final Map<String, double> muscleFatigue;

  const MuscleCharacterViewer({super.key, required this.muscleFatigue});

  @override
  State<MuscleCharacterViewer> createState() => _MuscleCharacterViewerState();
}

class _MuscleCharacterViewerState extends State<MuscleCharacterViewer> {
  wf.WebViewController? _mobileCtrl;
  ww.WebviewController? _winCtrl;

  bool _isLoading = true;
  bool _modelReady = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    if (Platform.isWindows) {
      _initWindows();
    } else {
      _initMobile();
    }

    // Safety timeout
    Future.delayed(const Duration(seconds: 15), () {
      if (mounted && _isLoading && !_modelReady) {
        setState(() {
          _isLoading = false;
          _errorMessage = "3D initialization timed out.";
        });
      }
    });
  }

  Future<void> _initWindows() async {
    _winCtrl = ww.WebviewController();
    try {
      await _winCtrl!.initialize();
      await _winCtrl!.setBackgroundColor(Colors.transparent);

      // Use webMessage stream for webview_windows
      _winCtrl!.webMessage.listen((data) {
        _handleJsMessage(data.toString());
      });

      // Load string content
      final html = await rootBundle.loadString('assets/3d/viewer.html');
      await _winCtrl!.loadStringContent(html);

      debugPrint('[3D] Windows WebView initialized');
      Future.delayed(const Duration(milliseconds: 1000), () => _sendModels());
    } catch (e) {
      debugPrint('[3D] Windows Init Error: $e');
      if (mounted) setState(() => _errorMessage = "Windows WebView Error: $e");
    }
  }

  void _initMobile() {
    _mobileCtrl = wf.WebViewController()
      ..setJavaScriptMode(wf.JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        wf.NavigationDelegate(onPageFinished: (_) => _sendModels()),
      )
      ..addJavaScriptChannel(
        'OnReady',
        onMessageReceived: (_) => _handleReady(),
      )
      ..addJavaScriptChannel(
        'OnMeshes',
        onMessageReceived: (m) => _handleMeshes(m.message),
      )
      ..addJavaScriptChannel(
        'OnLog',
        onMessageReceived: (m) => debugPrint('[3D JS] ${m.message}'),
      )
      ..loadFlutterAsset('assets/3d/viewer.html');
  }

  void _handleJsMessage(String data) {
    // Data arrives as "type:payload" or just "type"
    if (data == "ready") {
      _handleReady();
    } else if (data.startsWith("meshes:")) {
      _handleMeshes(data.substring(7));
    } else {
      debugPrint('[3D JS Log] $data');
    }
  }

  void _handleReady() {
    if (mounted) {
      setState(() {
        _modelReady = true;
        _isLoading = false;
      });
      _applyFatigue(widget.muscleFatigue);
    }
  }

  void _handleMeshes(String message) {
    // Hidden debug logic
  }

  Future<void> _sendModels() async {
    try {
      final charData = await rootBundle.load(
        'assets/models/rigedonoanimationMale3D.glb',
      );
      final charB64 = base64Encode(charData.buffer.asUint8List());

      final animData = await rootBundle.load('assets/models/Untitled.glb');
      final animB64 = base64Encode(animData.buffer.asUint8List());

      if (Platform.isWindows && _winCtrl != null) {
        await _winCtrl!.executeScript('loadCharacter("$charB64")');
        await _winCtrl!.executeScript('loadAnimation("$animB64")');
      } else if (_mobileCtrl != null) {
        await _mobileCtrl!.runJavaScript('loadCharacter("$charB64")');
        await _mobileCtrl!.runJavaScript('loadAnimation("$animB64")');
      }
    } catch (e) {
      debugPrint('[3D] Asset Error: $e');
    }
  }

  void _applyFatigue(Map<String, double> fatigue) {
    if (!_modelReady) return;
    final jsonStr = jsonEncode(fatigue);
    if (Platform.isWindows && _winCtrl != null) {
      _winCtrl!.executeScript('setMuscleFatigue($jsonStr)');
    } else if (_mobileCtrl != null) {
      _mobileCtrl!.runJavaScript('setMuscleFatigue($jsonStr)');
    }
  }

  @override
  void didUpdateWidget(MuscleCharacterViewer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.muscleFatigue != oldWidget.muscleFatigue) {
      _applyFatigue(widget.muscleFatigue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: (_) {}, // Capture and consume
      onHorizontalDragUpdate: (_) {},
      onVerticalDragStart: (_) {},
      onVerticalDragUpdate: (_) {},
      child: Stack(
        children: [
          if (Platform.isWindows)
            _winCtrl != null
                ? Listener(
                    onPointerDown: (_) {
                      // Block propagation
                    },
                    child: ww.Webview(_winCtrl!),
                  )
                : const SizedBox()
          else
            wf.WebViewWidget(
              controller: _mobileCtrl!,
              gestureRecognizers: {
                Factory<OneSequenceGestureRecognizer>(
                  () => EagerGestureRecognizer(),
                ),
              },
            ),

          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(
                color: Colors.cyanAccent,
                strokeWidth: 1.5,
              ),
            ),

          if (_errorMessage != null)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  _errorMessage!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white30, fontSize: 10),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
