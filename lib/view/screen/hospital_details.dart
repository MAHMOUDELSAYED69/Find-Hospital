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
            _buildHospitalInfoCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildHospitalInfoCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const Icon(Icons.favorite_border),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(hospital?.name ?? ""),
                Text(hospital?.compoundCode ?? ""),
              ],
            ),
            const Spacer(),
            Column(
              children: [
                const Text("Rating"),
                Text(
                  hospital?.rating.toString() ?? "",
                  style: const TextStyle(
                      color: ColorManager.red, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
