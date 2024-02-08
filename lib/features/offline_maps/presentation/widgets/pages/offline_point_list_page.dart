import 'package:flutter/material.dart';
import 'package:pointz/common/presentation/widgets/scaffolds/main_scaffold.dart';
import 'package:pointz/common/presentation/widgets/scaffolds/opaque_scaffold.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class OfflinePointsListPage extends StatefulWidget {
  const OfflinePointsListPage({super.key});

  @override
  State<OfflinePointsListPage> createState() => _OfflineMapPageState();
}

class _OfflineMapPageState extends State<OfflinePointsListPage> {
  @override
  Widget build(BuildContext context) {
    return OpaqueScaffold(
        leading: IconButton(
          icon: const Icon(Icons.location_on_sharp),
          onPressed: () {},
        ),
        body: Container(
          height: 100.h,
        ));
  }
}
