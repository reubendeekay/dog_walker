import 'package:cached_network_image/cached_network_image.dart';
import 'package:dog_walker/models/walker_model.dart';
import 'package:dog_walker/providers/admin_provider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WalkerCard extends StatefulWidget {
  const WalkerCard({Key? key, required this.walker}) : super(key: key);
  final WalkerModel walker;

  @override
  State<WalkerCard> createState() => _WalkerCardState();
}

class _WalkerCardState extends State<WalkerCard> {
  late bool isEnable;
  late bool isReserved;

  @override
  void initState() {
    super.initState();
    isEnable = widget.walker.enabled!;
    isReserved = widget.walker.reserved!;
  }

  final id = UniqueKey().toString().replaceAll('[', '').replaceAll(']', '');

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                  radius: 30,
                  backgroundImage: CachedNetworkImageProvider(
                    widget.walker.image!.isEmpty
                        ? 'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541'
                        : widget.walker.image!,
                  )),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(id,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black)),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(widget.walker.name ?? 'Walker Name',
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black)),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 18,
                        ),
                        const SizedBox(
                          width: 2.5,
                        ),
                        Text(widget.walker.ratings!.toStringAsFixed(1),
                            style: const TextStyle(
                                fontSize: 12, color: Colors.black)),
                      ],
                    )
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      const Text('User', style: TextStyle(color: Colors.black)),
                      const SizedBox(
                        width: 5,
                      ),
                      Switch(
                          value: isEnable,
                          onChanged: (val) async {
                            setState(() {
                              isEnable = val;
                            });
                            await Provider.of<AdminProvider>(context,
                                    listen: false)
                                .toggleEnable(
                              val,
                              true,
                              widget.walker.userId!,
                            );
                          })
                    ],
                  ),
                  SizedBox(
                    height: 20,
                    child: Row(
                      children: [
                        const Text('Reservation',
                            style: TextStyle(color: Colors.black)),
                        const SizedBox(
                          width: 5,
                        ),
                        Switch(
                            value: isReserved,
                            onChanged: (val) async {
                              setState(() {
                                isReserved = val;
                              });

                              await Provider.of<AdminProvider>(context,
                                      listen: false)
                                  .toggleReserved(
                                val,
                                widget.walker.userId!,
                              );
                            })
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Text('Availability 6pm-8pm',
              style: TextStyle(color: Colors.black)),
        ],
      ),
    );
  }
}
