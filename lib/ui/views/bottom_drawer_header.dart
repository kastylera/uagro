import 'package:agro/ui/theme/colors.dart';
import 'package:flutter/material.dart';
    
class BottomDrawerHeader extends StatelessWidget {

  const BottomDrawerHeader({ Key? key }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Container(
            decoration: BoxDecoration(
                color: AppColors.grey2,
                borderRadius: BorderRadius.circular(100)),
            height: 4,
            width: 50));
  }
}