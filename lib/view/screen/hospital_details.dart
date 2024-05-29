import 'package:flutter/material.dart';
import '../../core/constant/color.dart';

class HospitalDetailScreen extends StatelessWidget {
  const HospitalDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hospital Info"),
        backgroundColor: ColorManager.red,
        titleSpacing: 0,
      ),
      body: const Center(
        child: Column(
          children: [
            Card(
              child: ListTile(
                title: Text("Hospital Title"),
                subtitle: Text("Hospital Address"),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Hospital Rating",
                    ),
                    Text("Time, Distance"),
                  ],
                ),
                leading: Icon(Icons.favorite_border),
              ),
            )
            //       Text("Hospital Title"),
            //       Text("Hospital Address"),
            //       Text("Hospital Rating"),
            //       Text("Hospital Type"),
            //       Text("Distance"),
            //       Text("Time"),
            //       Text("Favourite"),
          ],
        ),
      ),
    );
  }
}
