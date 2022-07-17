import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dog_walker/models/walker_model.dart';
import 'package:dog_walker/screens/admin/widgets/walker_card.dart';
import 'package:flutter/material.dart';

class AllWalkers extends StatelessWidget {
  const AllWalkers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('DogWalker').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No walkers found'));
          }

          return ListView(
            children: [
              const SizedBox(
                height: 10,
              ),
              ...List.generate(
                snapshot.data!.docs.length,
                (index) => WalkerCard(
                  walker:
                      WalkerModel.fromJson(snapshot.data!.docs[index].data()),
                ),
              ),
            ],
          );
        });
  }
}
