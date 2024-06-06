import 'package:find_hospital/core/constant/color.dart';
import 'package:find_hospital/core/constant/routes.dart';
import 'package:flutter/material.dart';

import '../../data/services/find_hospital.dart';
import '../widget/custom_button.dart';

class FindHospitalScreen extends StatefulWidget {
  const FindHospitalScreen({super.key});

  @override
  State<FindHospitalScreen> createState() => _FindHospitalScreenState();
}

class _FindHospitalScreenState extends State<FindHospitalScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          foregroundColor: ColorManager.black,
          backgroundColor: ColorManager.red,
          title: const Text(
            "Find Hospital Screen",
            style: TextStyle(
                fontStyle: FontStyle.italic, fontWeight: FontWeight.w500),
          )),
      endDrawer: const Drawer(),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),
          CustomButton(title: "Get Nearest Hospital", onPressed: () {}),
          const SizedBox(height: 20),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Card(
              child: ListTile(
                onTap: () {
                  Navigator.pushNamed(context, RouteManager.details);
                },
                title: const Text("Hospital Title"),
                subtitle: const Text("Hospital Address"),
                trailing: const Icon(Icons.chevron_right),
                leading: const Icon(Icons.healing),
              ),
            ),
            Card(
              child: ListTile(
                onTap: () {},
                title: const Text("Hospital Title"),
                subtitle: const Text("Hospital Address"),
                trailing: const Icon(Icons.chevron_right),
                leading: const Icon(Icons.healing),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
