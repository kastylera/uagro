import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:agro/load/load_screen.dart';

class FooterLoad extends StatelessWidget {
  const FooterLoad({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomFooter(
      builder: (BuildContext c, LoadStatus? mode) {
        return mode == LoadStatus.loading ? const Padding(padding: EdgeInsets.only(bottom: 20), child: AppCircularProgressIndicator(size: 70)) : const Center();
      },
    );
  }
}
