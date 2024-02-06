import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BottomSheetForMapScreen extends StatefulWidget {
  const BottomSheetForMapScreen({
    super.key,
  });

  @override
  State<BottomSheetForMapScreen> createState() =>
      _BottomSheetForMapScreenState();
}

class _BottomSheetForMapScreenState extends State<BottomSheetForMapScreen> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20.h,
      width: 100.w,
      child: Column(
        children: [
          const Expanded(flex: 1, child: SizedBox()),
          const Expanded(flex: 3, child: Text('Come si chiama questo posto?')),
          const Expanded(flex: 5, child: TextField()),
          Expanded(
            flex: 3,
            child: InkWell(
                onTap: () {
                  context.pop(); // Uses the context provided to the builder
                },
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Salva'),
                )),
          ),
          const Expanded(flex: 2, child: SizedBox()),
        ],
      ),
    );
  }
}
