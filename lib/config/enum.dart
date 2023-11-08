import 'package:hive/hive.dart';

// part 'enum.g.dart';
//
enum BalanceType { main, invest }

enum FrequencyType { everyMonth, every2Months, every3Months, every6Months, every12Months }
enum MethodWithdrawalFunds { bankTransfer, crypto, savedRequisites }
enum MyAccountWalletsScreenType { select, wallet }
enum RequisitesScreenType { select, requisites }
enum RequisitesType { bank, crypto, transfer }
enum IdentifyingDocumentType { nie, passport, driverLicense }
enum IdentifyingDocumentUploadType { firstDoc, backDoc, faceDoc }

// @HiveType(typeId: 5)
// enum GoalsLifeType {
//   @HiveField(0)
//   family,
//   @HiveField(1)
//   friends,
//   @HiveField(2)
//   happiness,
//   @HiveField(3)
//   wealth,
//   @HiveField(4)
//   selfDevelopment,
//   @HiveField(5)
//   knowledge
// }
//
// @HiveType(typeId: 6)
// enum RoleType {
//   @HiveField(0)
//   user,
//   @HiveField(1)
//   admin
// }

// enum PredictionTodayPageType { yesterday, today, tomorrow, week, mo }
//
// enum SubscriptionType { lite1Moon, lite3Moon, lite6Moon }
//
// enum CompatibilityInfoPage { romantic, friendly }
//
// enum ZodiacType { aquarius, pisces, aries, taurus, gemini, cancer, leo, virgo, libra, scorpio, sagittarius, capricorn }
//
// enum CompatibilityRelationshipLevel { high, average }
//
// enum CompatibilityType { mainValues, emotionalCompatibility, interestsInteraction }
//
// enum SubscribeType { weekly, month, year, weeklyAstrologer, monthAstrologer, yearAstrologer, monthPromo }
