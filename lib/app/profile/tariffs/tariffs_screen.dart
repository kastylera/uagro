import 'package:agro/app/components/block_page_screen.dart';
import 'package:agro/app/profile/tariffs/tariffs_controller.dart';
import 'package:agro/generated/assets.dart';
import 'package:agro/model/tariff/tariff.dart';
import 'package:agro/ui/buttons/b_style.dart';
import 'package:agro/ui/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class TariffsScreen extends StatefulWidget {
  const TariffsScreen({super.key});

  @override
  State<TariffsScreen> createState() {
    return TariffsScreenState();
  }
}

class TariffsScreenState extends State<TariffsScreen>
    with TickerProviderStateMixin {
  TariffsController tariffsController = Get.find();
  late PageController _pageViewController;
  int _currentPageIndex = 0;
  bool buyButtonVisible = false;

  @override
  void initState() {
    tariffsController.initPage(context: context, set: setState);
    super.initState();
    _pageViewController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DateTime dateToCheck = DateTime.now();
    DateTime startDate = DateTime(2024, 7, 1);
    DateTime endDate = DateTime(2024, 7, 7);
    bool isPremiumSale = isDateBetween(dateToCheck, startDate, endDate);

    return BlockPageScreen(
        headerSize: 20,
        headerColor: AppColors.black,
        topbarColor: AppColors.white,
        header: 'Тарифи',
        isBack: true,
        theme:
            SystemUiOverlayStyle.dark.copyWith(statusBarColor: AppColors.white),
        onPressedReturn: () {
          tariffsController.onBack(context);
        },
        child: Column(
          children: [
            Expanded(
                child: PageView(
              controller: _pageViewController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPageIndex = page;
                  buyButtonVisible = getBuyButtonVisible(page);
                });
              },
              children: <Widget>[
                Center(
                    child: Image.asset(
                  Assets.tariffBeslim,
                  fit: BoxFit.fitWidth,
                  width: MediaQuery.of(context).size.width,
                )),
                Center(
                  child: Image.asset(
                    isPremiumSale
                        ? Assets.tariffPremiumSale
                        : Assets.tariffPremium,
                    fit: BoxFit.fitWidth,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
                Center(
                  child: Image.asset(
                    Assets.tariffVip,
                    fit: BoxFit.fitWidth,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
              ],
            )),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildPageIndicator(),
            ),
            const SizedBox(height: 20),
            SizedBox(
                height: 60,
                child: buyButtonVisible
                    ? bStyle(
                        text: "Придбати пакет",
                        c: context,
                        colorText: AppColors.white,
                        vertical: 15,
                        onPressed: () {
                          tariffsController.onBuyTariff(_currentPageIndex == 1 ? "Premium" : "Vip");
                        })
                    : const SizedBox()),
            const SizedBox(height: 30)
          ],
        ));
  }

  Widget _indicator(bool isActive) {
    return SizedBox(
      height: 10,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.symmetric(horizontal: 4.0),
        height: isActive ? 10 : 8.0,
        width: isActive ? 12 : 8.0,
        decoration: BoxDecoration(
          boxShadow: [
            isActive
                ? BoxShadow(
                    color: AppColors.mainGreen.withOpacity(0.72),
                    blurRadius: 4.0,
                    spreadRadius: 1.0,
                    offset: const Offset(
                      0.0,
                      0.0,
                    ),
                  )
                : const BoxShadow(
                    color: Colors.transparent,
                  )
          ],
          shape: BoxShape.circle,
          color: isActive ? AppColors.mainGreen : AppColors.grey2,
        ),
      ),
    );
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < 3; i++) {
      list.add(i == _currentPageIndex ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  bool getBuyButtonVisible(int index) {
    switch (index) {
      case 0:
        return false;
      case 1:
        return tariffsController.tariff?.isPremium != true;
      case 2:
        return tariffsController.tariff?.isVip != true;
    }
    return true;
  }
}

bool isDateBetween(DateTime date, DateTime startDate, DateTime endDate) {
  // Ensure that the startDate is before the endDate
  if (startDate.isAfter(endDate)) {
    throw ArgumentError('Start date must be before end date');
  }

  return (date.isAfter(startDate) || date.isAtSameMomentAs(startDate)) &&
      (date.isBefore(endDate) || date.isAtSameMomentAs(endDate));
}
