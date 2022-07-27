import 'package:dog_walker/providers/location_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class AddOnMap extends StatefulWidget {
  static const routeName = '/add-on-map';

  const AddOnMap({Key? key, this.onChanged, this.addressChanged})
      : super(key: key);
  final Function(LatLng loc)? onChanged;
  final Function(UserLocation add)? addressChanged;
  @override
  _AddOnMapState createState() => _AddOnMapState();
}

class _AddOnMapState extends State<AddOnMap> {
  GoogleMapController? mapController;

  @override
  Widget build(BuildContext context) {
    final _locationData =
        Provider.of<LocationProvider>(context, listen: false).locationData;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Location'),
      ),
      body: SafeArea(
        child: GoogleMap(
          onTap: (value) {
            showDialog(
                context: context,
                builder: (ctx) => SingleChildScrollView(
                      child: AlertDialog(
                        title: const Text('Confirm the location'),
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Address',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            FutureBuilder<UserLocation>(
                                future: Provider.of<LocationProvider>(context,
                                        listen: false)
                                    .getLocationDetails(value),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  }
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((timeStamp) {
                                    setState(() {
                                      widget.addressChanged!(snapshot.data!);
                                    });
                                  });

                                  return Text(
                                    '${snapshot.data!.address!}, ${snapshot.data!.state!}, ${snapshot.data!.country!}',
                                  );
                                })
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              if (widget.onChanged != null) {
                                widget.onChanged!(value);
                              } else if (widget.addressChanged != null) {}
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            },
                            child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: const Text('Yes')),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 20),
                                child: const Text('No')),
                          ),
                        ],
                      ),
                    ));
          },
          compassEnabled: true,
          myLocationEnabled: true,
          zoomGesturesEnabled: true,
          myLocationButtonEnabled: true,
          initialCameraPosition: CameraPosition(
              target:
                  LatLng(_locationData!.latitude!, _locationData.longitude!),
              zoom: 16),
        ),
      ),
    );
  }
}
