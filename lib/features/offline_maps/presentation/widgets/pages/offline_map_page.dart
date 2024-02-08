import 'package:flutter/material.dart';
import 'package:pointz/common/presentation/widgets/scaffolds/main_scaffold.dart';
import 'package:pointz/common/presentation/widgets/scaffolds/opaque_scaffold.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class OfflineMapPage extends StatefulWidget {
  const OfflineMapPage({super.key});

  @override
  State<OfflineMapPage> createState() => _OfflineMapPageState();
}

class _OfflineMapPageState extends State<OfflineMapPage> {
  @override
  Widget build(BuildContext context) {
    return OpaqueScaffold(
        isOffline: true,
        leading: IconButton(
          icon: const Icon(Icons.location_on_sharp),
          onPressed: () {},
        ),
        body: Container(
          height: 100.h,
        ));
  }
}
