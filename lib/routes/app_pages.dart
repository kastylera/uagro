// import 'package:alef_app/app/app_screen.dart';
// import 'package:alef_app/app/components/app_binding.dart';
// import 'package:alef_app/app/home/history_transaction/components/history_transaction_binding.dart';
// import 'package:alef_app/app/investing/create_investing/components/create_investing_binding.dart';
// import 'package:alef_app/app/investing/create_investing/create_investing_screen.dart';
// import 'package:alef_app/app/replenishment/replenishment_bank/components/replenishment_bank_binding.dart';
// import 'package:alef_app/app/replenishment/replenishment_crypto/replenishment_crypto_screen.dart';
// import 'package:alef_app/app/setting/account_currency/components/account_currency_binding.dart';
// import 'package:alef_app/app/setting/affiliate_program/components/affiliate_program_binding.dart';
// import 'package:alef_app/app/setting/change_email/components/change_email_binding.dart';
// import 'package:alef_app/app/setting/change_number/components/change_number_binding.dart';
// import 'package:alef_app/app/setting/info/info_screen.dart';
// import 'package:alef_app/app/setting/my_account_wallets/components/my_account_wallets_binding.dart';
// import 'package:alef_app/app/setting/my_account_wallets/create_wallet/components/create_wallet_binding.dart';
// import 'package:alef_app/app/setting/regular_output/components/regular_output_binding.dart';
// import 'package:alef_app/app/setting/regular_output/regular_output_create/components/regular_output_create_binding.dart';
// import 'package:alef_app/app/setting/regular_output/regular_output_create/regular_output_create_screen.dart';
// import 'package:alef_app/app/setting/regular_output/regular_output_screen.dart';
// import 'package:alef_app/app/setting/requisites/components/requisites_binding.dart';
// import 'package:alef_app/app/setting/requisites/create_requisites/components/create_requisites_binding.dart';
// import 'package:alef_app/app/withdrawal/components/withdrawal_binding.dart';
// import 'package:alef_app/start/auth/login_with_email/login_with_email_screen.dart';
// import 'package:alef_app/start/auth/login_with_number/login_with_number_screen.dart';
// import 'package:alef_app/start/auth/register/components/register_binding.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:get/get_navigation/src/routes/get_route.dart';
//
// import '../app/home/history_transaction/history_transaction_screen.dart';
// import '../app/replenishment/replenishment_bank/replenishment_bank_screen.dart';
// import '../app/replenishment/replenishment_crypto/components/replenishment_crypto_binding.dart';
// import '../app/setting/account_currency/account_currency_screen.dart';
// import '../app/setting/affiliate_program/affiliate_program_screen.dart';
// import '../app/setting/change_email/change_email_screen.dart';
// import '../app/setting/change_number/change_number_screen.dart';
// import '../app/setting/info/components/info_binding.dart';
// import '../app/setting/info/info_details/components/info_details_binding.dart';
// import '../app/setting/info/info_details/info_details_screen.dart';
// import '../app/setting/my_account_wallets/create_wallet/create_wallet_screen.dart';
// import '../app/setting/my_account_wallets/my_account_wallets_screen.dart';
// import '../app/setting/requisites/create_requisites/create_requisites_screen.dart';
// import '../app/setting/requisites/requisites_screen.dart';
// import '../app/setting/setting_personal/components/setting_personal_binding.dart';
// import '../app/setting/setting_personal/setting_personal_screen.dart';
// import '../app/transfer/components/transfer_binding.dart';
// import '../app/transfer/transfer_screen.dart';
// import '../app/withdrawal/withdrawal_screen.dart';
import 'package:agro/app/home/review/review_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:agro/auth/auth_register_ok/auth_register_ok_screen.dart';
import 'package:agro/auth/auth_register_ok/components/auth_register_ok_binding.dart';
import 'package:agro/auth/components/auth_binding.dart';

import '../app/app_screen.dart';
import '../app/components/app_binding.dart';
import '../app/home/order/components/order_binding.dart';
import '../app/home/order/order_screen.dart';
import '../app/home/review/components/review_binding.dart';
import '../auth/auth_confirmation/auth_confirmation_screen.dart';
import '../auth/auth_confirmation/components/auth_confirmation_binding.dart';
import '../auth/auth_screen.dart';

// import '../start/auth/login_with_email/components/login_with_email_binding.dart';
// import '../start/auth/login_with_number/components/login_with_number_binding.dart';
// import '../start/auth/register/register_screen.dart';
// import '../start/components/start_binding.dart';
// import '../start/start_screen.dart';

part './app_routes.dart';

abstract class AppPages {
  static pages({required BuildContext context}) => [
        GetPage(name: Routes.auth, page: () => const AuthScreen(), binding: AuthBinding()),
        GetPage(name: Routes.authConfirm, page: () => const AuthConfirmScreen(), binding: AuthConfirmationBinding()),
        GetPage(name: Routes.app, page: () => const AppScreen(), binding: AppBinding()),
        GetPage(name: Routes.authRegisterOk, page: () => const AuthRegisterOkScreen(), binding: AuthRegisterOkBinding()),
        GetPage(name: Routes.orderInfo, page: () => const OrderScreen(), binding: OrderBinding()),
        GetPage(name: Routes.review, page: () => const ReviewScreen(), binding: ReviewBinding()),
        // GetPage(name: Routes.loginWithNumber, page: () => const LoginWithNumberScreen(), binding: LoginWithNumberBinding()),
        // GetPage(name: Routes.loginWithEmail, page: () => const LoginWithEmailScreen(), binding: LoginWithEmailBinding()),
        // GetPage(name: Routes.register, page: () => const RegisterScreen(), binding: RegisterBinding()),
        // GetPage(name: Routes.app, page: () => const AppScreen(), binding: AppBinding()),
        // GetPage(name: Routes.infoDetails, page: () => const InfoDetailsScreen(), binding: InfoDetailsBinding()),
        // GetPage(name: Routes.settingPersonal, page: () => const SettingPersonalScreen(), binding: SettingPersonalBinding()),
        // GetPage(name: Routes.accountCurrency, page: () => const AccountCurrencyScreen(), binding: AccountCurrencyBinding()),
        // GetPage(name: Routes.changeEmail, page: () => const ChangeEmailScreen(), binding: ChangeEmailBinding()),
        // GetPage(name: Routes.changeNumber, page: () => const ChangeNumberScreen(), binding: ChangeNumberBinding()),
        // GetPage(name: Routes.historyTransaction, page: () => const HistoryTransactionScreen(), binding: HistoryTransactionBinding()),
        // GetPage(name: Routes.regularOutput, page: () => const RegularOutputScreen(), binding: RegularOutputBinding()),
        // GetPage(name: Routes.requisites, page: () => const RequisitesScreen(), binding: RequisitesBinding()),
        // GetPage(name: Routes.affiliateProgram, page: () => const AffiliateProgramScreen(), binding: AffiliateProgramBinding()),
        // GetPage(name: Routes.myAccountWallets, page: () => const MyAccountWalletsScreen(), binding: MyAccountWalletsBinding()),
        // GetPage(name: Routes.createWallet, page: () => const CreateWalletScreen(), binding: CreateWalletBinding()),
        // GetPage(name: Routes.regularOutputCreate, page: () => const RegularOutputCreateScreen(), binding: RegularOutputCreateBinding()),
        // GetPage(name: Routes.replenishmentBank, page: () => const ReplenishmentBankScreen(), binding: ReplenishmentBankBinding()),
        // GetPage(name: Routes.replenishmentCrypto, page: () => const ReplenishmentCryptoScreen(), binding: ReplenishmentCryptoBinding()),
        // GetPage(name: Routes.createInvesting, page: () => const CreateInvestingScreen(), binding: CreateInvestingBinding()),
        // GetPage(name: Routes.createRequisites, page: () => const CreateRequisitesScreen(), binding: CreateRequisitesBinding()),
        // GetPage(name: Routes.withdrawal, page: () => const WithdrawalScreen(), binding: WithdrawalBinding()),
        // GetPage(name: Routes.settingInfo, page: () => const InfoScreen(), binding: InfoBinding()),
        // GetPage(name: Routes.transfer, page: () => const TransferScreen(), binding: TransferBinding())
      ];
}
