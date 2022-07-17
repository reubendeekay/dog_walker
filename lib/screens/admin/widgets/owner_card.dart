import 'package:cached_network_image/cached_network_image.dart';
import 'package:dog_walker/models/owner_model.dart';
import 'package:dog_walker/models/walker_model.dart';
import 'package:dog_walker/providers/admin_provider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OwnerCard extends StatefulWidget {
  const OwnerCard({Key? key, required this.owner}) : super(key: key);
  final OwnerModel owner;

  @override
  State<OwnerCard> createState() => _OwnerCardState();
}

class _OwnerCardState extends State<OwnerCard> {
  late bool isEnable;

  @override
  void initState() {
    super.initState();
    isEnable = widget.owner.enabled!;
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
                    widget.owner.image!.isEmpty
                        ? 'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541'
                        : widget.owner.image!,
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
                    Text(widget.owner.name ?? 'Walker Name',
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
                        Text(widget.owner.age!,
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
                              false,
                              widget.owner.userId!,
                            );
                          })
                    ],
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(widget.owner.address!, style: TextStyle(color: Colors.black)),
        ],
      ),
    );
  }
}
