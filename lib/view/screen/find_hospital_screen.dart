import 'package:find_hospital/core/constant/color.dart';
import 'package:flutter/material.dart';

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
          backgroundColor: ColorManager.red,
          title: const Text(
            "Find Hospital Screen",
            style: TextStyle(
                fontStyle: FontStyle.italic, fontWeight: FontWeight.w500),
          )),
      body: Center(
        child: Column(
          children: [
            Card(
              child: ListTile(
                onTap: () {
                  Navigator.pushNamed(context, '/hospitalDetails');
                },
                title: const Text("Hospital Title"),
                subtitle: const Text("Hospital Address"),
                trailing: const Icon(Icons.chevron_right),
                leading: const Icon(Icons.healing),
              ),
            ),
            // Card(
            //   child: ListTile(
            //     onTap: () {},
            //     title: const Text("Hospital Title"),
            //     subtitle: const Text("Hospital Address"),
            //     trailing: const Icon(Icons.chevron_right),
            //     leading: const Icon(Icons.healing),
            //   ),
            // ),
            // Card(
            //   child: ListTile(
            //     onTap: () {},
            //     title: const Text("Hospital Title"),
            //     subtitle: const Text("Hospital Address"),
            //     trailing: const Icon(Icons.chevron_right),
            //     leading: const Icon(Icons.healing),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
