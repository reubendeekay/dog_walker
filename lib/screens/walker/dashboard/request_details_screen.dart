import 'package:dog_walker/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class RequestDetailsScreen extends StatelessWidget {
  const RequestDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: Column(
      children: [
        SizedBox(
          height: size.height * 0.2 + kToolbarHeight,
          width: double.infinity,
          child: Image.network(
            'https://post.medicalnewstoday.com/wp-content/uploads/sites/3/2020/02/322868_1100-1100x628.jpg',
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: const [
                  Text(
                    'Milo',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Text('Arrive at 7pm on 28th June')
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: const [
                  Text(
                    '\$51.00',
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  Text(
                    '2hrs',
                  ),
                ],
              ),
              const Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                    '3480 Champlaing Street\n H3N2V4',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
        const Divider(
          thickness: 1,
        ),
        const Center(
          child: Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text(
              'Show this QR code on being asked!!',
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Center(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            margin: const EdgeInsets.all(20.0),
            color: Colors.white,
            child: PrettyQr(
              typeNumber: 3,
              size: 200,
              data: 'https://www.google.ru',
              errorCorrectLevel: QrErrorCorrectLevel.M,
              roundEdges: false,
            ),
          ),
        ),
        const Spacer(),
        CustomButton(
          onPressed: () {},
          text: 'CONTINUE',
          textColor: Colors.white,
        ),
        const SizedBox(
          height: 15,
        )
      ],
    ));
  }
}
