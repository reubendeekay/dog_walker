import 'package:dog_walker/models/walker_model.dart';
import 'package:dog_walker/providers/location_provider.dart';
import 'package:dog_walker/providers/owner_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({Key? key}) : super(key: key);

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  GoogleMapController? _controller;

  Set<Marker> _markers = <Marker>{};

  void _onMapCreated(GoogleMapController controller) async {
    _controller = controller;

    final walkers = await Provider.of<OwnerProvider>(context, listen: false)
        .getAllWalkers();

    for (WalkerModel walker in walkers) {
      _markers.add(
        Marker(
          markerId: MarkerId(
            walker.userId!,
          ),
          position: LatLng(walker.lat!, walker.long!),
        ),
      );
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final loc =
        Provider.of<LocationProvider>(context, listen: false).locationData!;
    return GoogleMap(
      onMapCreated: _onMapCreated,
      markers: _markers,
      zoomControlsEnabled: false,
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      initialCameraPosition: CameraPosition(
          target: LatLng(loc.latitude!, loc.longitude!), zoom: 15),
    );
  }
}
