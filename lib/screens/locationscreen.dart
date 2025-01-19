// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';

// class Locationscreen extends StatefulWidget {
//   final bool showPermissionDialog;

//   Locationscreen({required this.showPermissionDialog});

//   @override
//   _LocationscreenState createState() => _LocationscreenState();
// }

// class _LocationscreenState extends State<Locationscreen> {
//   @override
//   void initState() {
//     super.initState();
//     // Check if we need to show the location permission dialog
//     if (widget.showPermissionDialog) {
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         _checkAndRequestLocationPermission();
//       });
//     }
//   }

//   Future<void> _checkAndRequestLocationPermission() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     // Check if location services are enabled
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       _showLocationServiceDialog();
//       return;
//     }

//     // Check for location permissions
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         _showPermissionDeniedDialog();
//         return;
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       _showPermissionDeniedForeverDialog();
//       return;
//     }

//     if (permission == LocationPermission.whileInUse ||
//         permission == LocationPermission.always) {
//       Position position = await Geolocator.getCurrentPosition();
//       print('User location: ${position.latitude}, ${position.longitude}');
//     }
//   }

//   void _showLocationServiceDialog() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Enable Location Services'),
//         content: Text('Please enable location services to use this feature.'),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             child: Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () {
//               Geolocator.openLocationSettings();
//               Navigator.pop(context);
//             },
//             child: Text('Settings'),
//           ),
//         ],
//       ),
//     );
//   }

//   void _showPermissionDeniedDialog() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Location Permission Denied'),
//         content: Text(
//             'We need location permission to provide location-based services.'),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             child: Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }

//   void _showPermissionDeniedForeverDialog() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Location Permission Denied Forever'),
//         content:
//             Text('Please enable location permission from the app settings.'),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             child: Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () {
//               Geolocator.openAppSettings();
//               Navigator.pop(context);
//             },
//             child: Text('Settings'),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Home Page')),
//       body: Center(
//         child: Text('Welcome to the Home Page!'),
//       ),
//     );
//   }
// }
