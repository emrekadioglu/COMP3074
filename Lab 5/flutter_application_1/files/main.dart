import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';

void main() => runApp(const GpsApp());

class GpsApp extends StatelessWidget {
  const GpsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GPS Location',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.teal,
        useMaterial3: true,
      ),
      home: const LocationScreen(),
    );
  }
}

enum LocStatus { idle, loading, ready, serviceOff, denied, deniedForever, error }

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  LocStatus _status = LocStatus.idle;
  Position? _position;
  String _error = '';
  bool _live = false;
  StreamSubscription<Position>? _sub;

  static const _settings = LocationSettings(
    accuracy: LocationAccuracy.best, // uses GPS
    distanceFilter: 0,
  );

  @override
  void initState() {
    super.initState();
    _getOnce();
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  /// Checks GPS service + runtime permission. Returns true if we may read location.
  Future<bool> _ensureReady() async {
    // 1. Is the device GPS / location service switched on?
    if (!await Geolocator.isLocationServiceEnabled()) {
      setState(() => _status = LocStatus.serviceOff);
      return false;
    }

    // 2. Runtime permission
    var perm = await Geolocator.checkPermission();
    if (perm == LocationPermission.denied) {
      perm = await Geolocator.requestPermission();
    }
    if (perm == LocationPermission.denied) {
      setState(() => _status = LocStatus.denied);
      return false;
    }
    if (perm == LocationPermission.deniedForever) {
      setState(() => _status = LocStatus.deniedForever);
      return false;
    }
    return true;
  }

  Future<void> _getOnce() async {
    setState(() => _status = LocStatus.loading);
    try {
      if (!await _ensureReady()) return;
      final pos = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.best,
          timeLimit: Duration(seconds: 30),
        ),
      );
      setState(() {
        _position = pos;
        _status = LocStatus.ready;
      });
    } on TimeoutException {
      setState(() {
        _status = LocStatus.error;
        _error = 'GPS fix timed out. Go outdoors or near a window and retry.';
      });
    } catch (e) {
      setState(() {
        _status = LocStatus.error;
        _error = e.toString();
      });
    }
  }

  Future<void> _toggleLive() async {
    if (_live) {
      await _sub?.cancel();
      setState(() => _live = false);
      return;
    }
    if (!await _ensureReady()) return;
    _sub = Geolocator.getPositionStream(locationSettings: _settings).listen(
      (pos) => setState(() {
        _position = pos;
        _status = LocStatus.ready;
      }),
      onError: (e) => setState(() {
        _status = LocStatus.error;
        _error = e.toString();
        _live = false;
      }),
    );
    setState(() => _live = true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GPS Location'), centerTitle: true),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Expanded(child: Center(child: SingleChildScrollView(child: _body()))),
              Row(
                children: [
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: _status == LocStatus.loading ? null : _getOnce,
                      icon: const Icon(Icons.my_location),
                      label: const Text('Get Location'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _toggleLive,
                      icon: Icon(_live ? Icons.stop : Icons.play_arrow),
                      label: Text(_live ? 'Stop Live' : 'Live Updates'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _body() {
    switch (_status) {
      case LocStatus.idle:
      case LocStatus.loading:
        return const Column(mainAxisSize: MainAxisSize.min, children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('Getting GPS location...'),
        ]);
      case LocStatus.serviceOff:
        return _message(Icons.location_off, 'Location (GPS) is turned off.',
            'Turn on location in device settings.', 'Open Location Settings',
            Geolocator.openLocationSettings);
      case LocStatus.denied:
        return _message(Icons.lock, 'Location permission denied.',
            'The app needs location permission to show your coordinates.',
            'Try Again', _getOnce);
      case LocStatus.deniedForever:
        return _message(Icons.block, 'Permission permanently denied.',
            'Enable Location for this app from App Settings.',
            'Open App Settings', Geolocator.openAppSettings);
      case LocStatus.error:
        return _message(Icons.error_outline, 'Something went wrong',
            _error, 'Retry', _getOnce);
      case LocStatus.ready:
        final p = _position!;
        return Column(mainAxisSize: MainAxisSize.min, children: [
          const Icon(Icons.location_on, size: 72, color: Colors.teal),
          const SizedBox(height: 16),
          _coordCard('Latitude', p.latitude.toStringAsFixed(6)),
          _coordCard('Longitude', p.longitude.toStringAsFixed(6)),
          const SizedBox(height: 8),
          Text('Accuracy: ±${p.accuracy.toStringAsFixed(1)} m'),
          Text('Altitude: ${p.altitude.toStringAsFixed(1)} m'),
          Text('Updated: ${p.timestamp.toLocal().toString().split('.').first}'),
          if (_live)
            const Padding(
              padding: EdgeInsets.only(top: 8),
              child: Chip(label: Text('Live updates ON')),
            ),
        ]);
    }
  }

  Widget _coordCard(String label, String value) {
    return Card(
      child: ListTile(
        title: Text(label),
        subtitle: Text(value,
            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
        trailing: IconButton(
          icon: const Icon(Icons.copy),
          onPressed: () {
            Clipboard.setData(ClipboardData(text: value));
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('$label copied')),
            );
          },
        ),
      ),
    );
  }

  Widget _message(IconData icon, String title, String body, String action,
      Future<dynamic> Function() onTap) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Icon(icon, size: 64, color: Colors.redAccent),
      const SizedBox(height: 12),
      Text(title, style: Theme.of(context).textTheme.titleLarge),
      const SizedBox(height: 8),
      Text(body, textAlign: TextAlign.center),
      const SizedBox(height: 16),
      FilledButton(onPressed: () => onTap(), child: Text(action)),
    ]);
  }
}
