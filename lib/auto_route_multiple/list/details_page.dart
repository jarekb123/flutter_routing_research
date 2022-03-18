import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({
    Key? key,
    @pathParam required this.id,
  }) : super(key: key);

  final int id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('DetailsPage (id: $id)'),
      ),
    );
  }
}
