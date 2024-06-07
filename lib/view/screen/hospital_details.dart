import 'package:flutter/material.dart';
import '../../core/constant/color.dart';
import '../../data/models/hospital_model.dart';

class HospitalDetailScreen extends StatelessWidget {
  const HospitalDetailScreen({super.key, this.hospital});
  final PlaceInfo? hospital;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hospital Info"),
        backgroundColor: ColorManager.red,
        titleSpacing: 0,
      ),
      body: Center(
        child: Column(
          children: [
            Card(
              child: ListTile(
                title: Text(hospital?.name ?? ""),
                subtitle: Text(hospital?.compoundCode ?? ""),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      hospital?.rating.toString() ?? "",
                    ),
                    Text(hospital?.businessStatus ?? ""),
                  ],
                ),
                leading: const Icon(Icons.favorite_border),
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
