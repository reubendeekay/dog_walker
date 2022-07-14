import 'package:dog_walker/providers/location_provider.dart';
import 'package:dog_walker/screens/owner/dashboard/widgets/walker_tile.dart';
import 'package:dog_walker/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class OwnerDashboard extends StatefulWidget {
  const OwnerDashboard({Key? key}) : super(key: key);

  @override
  State<OwnerDashboard> createState() => _OwnerDashboardState();
}

class _OwnerDashboardState extends State<OwnerDashboard> {
  GoogleMapController? _controller;

  Set<Marker> _markers = <Marker>{};

  @override
  Widget build(BuildContext context) {
    final loc =
        Provider.of<LocationProvider>(context, listen: false).locationData!;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Padding(
          padding: EdgeInsets.only(bottom: 15),
          child: TextField(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
              hintText: 'Search Walker',
              hintStyle: TextStyle(color: Colors.grey),
            ),
          ),
        ),
        actions: const [
          Icon(Icons.timelapse_sharp),
          SizedBox(
            width: 10,
          ),
          Icon(Icons.favorite),
          SizedBox(
            width: 10,
          ),
          Icon(Icons.filter_alt),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: size.height * 0.35,
            child: GoogleMap(
              // onMapCreated: _onMapCreated,
              markers: _markers,
              zoomControlsEnabled: false,
              myLocationEnabled: true,

              myLocationButtonEnabled: true,
              initialCameraPosition: CameraPosition(
                  target: LatLng(loc.latitude!, loc.longitude!), zoom: 15),
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                ListView(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    ...List.generate(
                      10,
                      (index) => WalkerTile(),
                    ),
                  ],
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 15,
                  child: CustomButton(
                    text: 'Verify Walker',
                    onPressed: () {},
                    color: Colors.blue[900],
                    textColor: Colors.white,
                    margin: 50,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
