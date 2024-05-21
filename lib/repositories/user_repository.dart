// import 'dart:async';
// import 'dart:io';

// import 'package:dio/dio.dart';
// import 'package:gigit/src/api/client_api.dart';
// import 'package:gigit/src/entities/application.dart';
// import 'package:gigit/src/entities/availability.dart';
// import 'package:gigit/src/entities/book_gig.dart';
// import 'package:gigit/src/entities/budget.dart';
// import 'package:gigit/src/entities/conversation.dart';
// import 'package:gigit/src/entities/dio_exceptions.dart';
// import 'package:gigit/src/entities/edit_muso.dart';
// import 'package:gigit/src/entities/edit_venue.dart';
// import 'package:gigit/src/entities/experience.dart';
// import 'package:gigit/src/entities/genres.dart';
// import 'package:gigit/src/entities/gig.dart';
// import 'package:gigit/src/entities/gig_event.dart';
// import 'package:gigit/src/entities/gig_request.dart';
// import 'package:gigit/src/entities/gig_response.dart';
// import 'package:gigit/src/entities/media.dart';
// import 'package:gigit/src/entities/message.dart';
// import 'package:gigit/src/entities/muso.dart';
// import 'package:gigit/src/entities/paged_data.dart';
// import 'package:gigit/src/entities/profile.dart';
// import 'package:gigit/src/entities/role.dart';
// import 'package:gigit/src/entities/unread_count.dart';
// import 'package:gigit/src/entities/venue.dart';
// import 'package:gigit/src/presentation/extensions/entity_extensions.dart';
// import 'package:gigit/src/storage/user_data_storage.dart';
// import 'package:loggy/loggy.dart';

// class UserRepository with UiLoggy {
//   final ClientAPI clientAPI;
//   final UserDataStorage tokenStorage;

//   UserRepository(this.clientAPI, this.tokenStorage);

//   Future<Profile> getMe() async {
//     try {
//       final response = await clientAPI.getMe();
//       final data = Profile.fromJson(response.data);
//       tokenStorage.setRole(data.getRole());
//       tokenStorage.setTimezone(data.timeZone);
//       return data;
//     } on DioException catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       if (errorMessage == "unable to get user profile for unknown role") {
//         throw UnknownRole();
//       }
//       throw errorMessage;
//     }
//   }

//   Future<void> setRole(String userId) async {
//     try {
//       final role = await tokenStorage.getRole();
//       final response = await clientAPI.setRole(userId, role!);
//       final data = Profile.fromJson(response.data);
//       tokenStorage.setRole(role);
//       tokenStorage.setTimezone(data.timeZone);
//     } on DioException catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       throw errorMessage;
//     }
//   }

//   Future<Profile> updateMuso(EditMuso profile) async {
//     try {
//       final response = await clientAPI.updateMuso(profile);
//       final data = Profile.fromJson(response.data);
//       tokenStorage.setTimezone(data.timeZone);
//       return data;
//     } on DioException catch (e) {
//       loggy.error(e.toString());
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       throw errorMessage;
//     }
//   }

//   Future<Profile> updateVenue(EditVenue profile) async {
//     try {
//       final response = await clientAPI.updateVenue(profile);
//       final data = Profile.fromJson(response.data);
//       tokenStorage.setTimezone(data.timeZone);
//       return data;
//     } on DioException catch (e) {
//       loggy.error(e.toString());
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       throw errorMessage;
//     }
//   }

//   Future<Profile> updateAvatar(File avatar, {String? musoId}) async {
//     try {
//       final response = await clientAPI.updateAvatar(avatar, musoId: musoId);
//       final data = Profile.fromJson(response.data);
//       return data;
//     } on DioException catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       throw errorMessage;
//     }
//   }

//   Future<Profile> updateAvatarCompessed(MultipartFile avatar,
//       {String? musoId}) async {
//     try {
//       final response =
//           await clientAPI.updateAvatarAsData(avatar, musoId: musoId);
//       final data = Profile.fromJson(response.data);
//       return data;
//     } on DioException catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       throw errorMessage;
//     }
//   }

//   Future<Profile> updateBackgroundCompessed(MultipartFile background,
//       {String? musoId}) async {
//     try {
//       final response =
//           await clientAPI.updateBackgroundAsData(background, musoId: musoId);
//       final data = Profile.fromJson(response.data);
//       return data;
//     } on DioException catch (e) {
//       loggy.error(e.toString());
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       throw errorMessage;
//     }
//   }

//   Future<Profile> updateBackground(File background, {String? musoId}) async {
//     try {
//       final response =
//           await clientAPI.updateBackground(background, musoId: musoId);
//       final data = Profile.fromJson(response.data);
//       return data;
//     } on DioException catch (e) {
//       loggy.error(e.toString());
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       throw errorMessage;
//     }
//   }

//   Future<List<Media>> uploadMedia(File file, {String? musoId}) async {
//     try {
//       final response = await clientAPI.uploadMedia(file, musoId: musoId);
//       final data = List<Media>.from(
//           (response.data['files'] as List?)?.map((e) => Media.fromJson(e)) ??
//               List.empty());
//       return data;
//     } on DioException catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       throw errorMessage;
//     }
//   }

//   Future<void> deleteMedia(String id) async {
//     try {
//       await clientAPI.deleteMedia(id);
//     } on DioException catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       throw errorMessage;
//     }
//   }

//   Future<Role> getRole() async {
//     var role = await tokenStorage.getRole();
//     if (role == null) {
//       final profile = await getMe();
//       role = profile.getRole();
//     }
//     return role;
//   }

//   Future<void> storageRole(Role role) async {
//     await tokenStorage.setRole(role);
//   }

//   Future<List<Gig>> getGigs() async {
//     try {
//       var role = await tokenStorage.getRole();
//       final response = role == Role.agent
//           ? await clientAPI.getAgentGigs()
//           : await clientAPI.getGigs();
//       final data =
//           List<Gig>.from((response.data as List).map((e) => Gig.fromJson(e)));
//       return data;
//     } on DioException catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       throw errorMessage;
//     }
//   }

//   Future<List<Conversation>> getConversations() async {
//     try {
//       var role = await tokenStorage.getRole();
//       final response = role == Role.agent
//           ? await clientAPI.getAgentConversations()
//           : await clientAPI.getConversations();
//       final data = List<Conversation>.from(
//           (response.data as List).map((e) => Conversation.fromJson(e)));
//       return data;
//     } on DioException catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       throw errorMessage;
//     }
//   }

//   Future<List<Conversation>> getArchivedConversations() async {
//     try {
//       var role = await tokenStorage.getRole();
//       final response = role == Role.agent
//           ? await clientAPI.getAgentArchivedConversation()
//           : await clientAPI.getArchivedConversation();
//       final data = List<Conversation>.from(
//           (response.data as List).map((e) => Conversation.fromJson(e)));
//       return data;
//     } on DioException catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       throw errorMessage;
//     }
//   }

//   Future<List<Message>> getMessages(String conversationId) async {
//     try {
//       final response = await clientAPI.getMessages(conversationId);
//       final data = List<Message>.from(
//           (response.data as List).map((e) => Message.fromJson(e)));
//       return data;
//     } on DioException catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       throw errorMessage;
//     }
//   }

//   Future<Conversation> getConversationById(String conversationId) async {
//     try {
//       final response = await clientAPI.getConversationById(conversationId);
//       final data = Conversation.fromJson(response.data);
//       return data;
//     } on DioException catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       throw errorMessage;
//     }
//   }

//   Future<Message> sendMessages(
//       String conversationId, String addresseeId, String message) async {
//     try {
//       final response =
//           await clientAPI.sendMessage(conversationId, addresseeId, message);
//       final data = Message.fromJson(response.data);
//       return data;
//     } on DioException catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       throw errorMessage;
//     }
//   }

//   Future<Conversation> changeState(
//       String conversationId, GigEvent event) async {
//     try {
//       final response = await clientAPI.changeState(conversationId, event);
//       final data = Conversation.fromJson(response.data);
//       return data;
//     } on DioException catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       throw errorMessage;
//     }
//   }

//   Future<Gig> getGitById(String gigId) async {
//     try {
//       final response = await clientAPI.getGigById(gigId);
//       final data = Gig.fromJson(response.data);
//       return data;
//     } on DioException catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       throw errorMessage;
//     }
//   }

//   Future<Gig> updatePrice(String conversationId, int oldPrice, int newPrice,
//       int commissionFee) async {
//     try {
//       final response = await clientAPI.updatePrice(
//           conversationId, oldPrice, newPrice, commissionFee);
//       final data = Gig.fromJson(response.data);
//       return data;
//     } on DioException catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       throw errorMessage;
//     }
//   }

//   Future<Gig> requestOvertime(String conversationId, int duration, int price) async {
//     try {
//       final response = await clientAPI.requstOvertime(
//           conversationId, duration, price);
//       final data = Gig.fromJson(response.data);
//       return data;
//     } on DioException catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       throw errorMessage;
//     }
//   }

//   Future<List<UnreadCount>> getUnread() async {
//     try {
//       final response = await clientAPI.getUnread();
//       final data = List<UnreadCount>.from(
//           (response.data as List?)?.map((e) => UnreadCount.fromJson(e)) ??
//               List.empty());
//       return data;
//     } on DioException catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       throw errorMessage;
//     }
//   }

//   Future<List<Media>> getMedia(String userId) async {
//     try {
//       final response = await clientAPI.getMedia(userId);
//       final data = List<Media>.from(
//           (response.data['files'] as List?)?.map((e) => Media.fromJson(e)) ??
//               List.empty());
//       return data;
//     } on DioException catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       throw errorMessage;
//     }
//   }

//   Future<String> updateFcmToken(String token, String deviceType) async {
//     try {
//       final response = await clientAPI.updateFcmToken(token, deviceType);
//       final data = response.data.toString();
//       return data;
//     } on DioException catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       throw errorMessage;
//     }
//   }

//   Future<void> deleteFcmToken(String deviceType) async {
//     try {
//       await clientAPI.deleteFcmToken(deviceType);
//     } on DioException catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       loggy.error(errorMessage);
//     }
//   }

//   Future<String> musoExpressAccount() async {
//     try {
//       final response = await clientAPI.musoExpressAccount();
//       final data = response.data.toString();
//       return data;
//     } on DioException catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       throw errorMessage;
//     }
//   }

//   Future<bool?> getIsPayoutSetup() async {
//     try {
//       final role = await getRole();
//       final userId = await tokenStorage.getUserId();
//       if (role == Role.muso) {
//         final response = await clientAPI.getIsPayoutSetup(userId!);
//         final bool data = response.data;
//         return data;
//       } else {
//         return null;
//       }
//     } on DioException catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       throw errorMessage;
//     }
//   }

//   Future<String> payNow(String gigId) async {
//     try {
//       final response = await clientAPI.payNow(gigId);
//       final data = response.data.toString();
//       return data;
//     } on DioException catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       throw errorMessage;
//     }
//   }

//   Future<String> payOvertime(String gigId) async {
//     try {
//       final response = await clientAPI.payOvertime(gigId);
//       final data = response.data.toString();
//       return data;
//     } on DioException catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       throw errorMessage;
//     }
//   }

//   Future<String> configurePayLater(String conversationId) async {
//     try {
//       final response = await clientAPI.payLater(conversationId);
//       final data = response.data.toString();
//       return data;
//     } on DioException catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       throw errorMessage;
//     }
//   }

//   Future<Venue> getVenue(String venueId) async {
//     try {
//       final response = await clientAPI.getVenue(venueId);
//       final data = Venue.fromJson(response.data);
//       return data;
//     } on DioException catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       throw errorMessage;
//     }
//   }

//    Future<Muso> getMuso(String musoId) async {
//     try {
//       final response = await clientAPI.getMuso(musoId);
//       final data = Muso.fromJson(response.data);
//       return data;
//     } on DioException catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       throw errorMessage;
//     }
//   }

//   Future<List<Availability>> setAvailability(
//       List<Availability> availability, String? userId) async {
//     try {
//       final response =
//           await clientAPI.setWeeklyAvailability(userId!, availability);
//       final data = List<Availability>.from(
//           (response.data as List?)?.map((e) => Availability.fromJson(e)) ??
//               List.empty());
//       return data;
//     } on DioException catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       throw errorMessage;
//     }
//   }

//   Future<Muso> updateArtist(String musoId, EditMuso muso) async {
//     try {
//       final response = await clientAPI.updateArtist(musoId, muso);
//       final data = Muso.fromJson(response.data);
//       tokenStorage.setTimezone(data.timeZone);
//       return data;
//     } on DioException catch (e) {
//       loggy.error(e.toString());
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       throw errorMessage;
//     }
//   }

//   Future<Muso> createArtist() async {
//     try {
//       final response = await clientAPI.createArtist();
//       final data = Muso.fromJson(response.data);
//       tokenStorage.setTimezone(data.timeZone);
//       return data;
//     } on DioException catch (e) {
//       loggy.error(e.toString());
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       throw errorMessage;
//     }
//   }

//   Future<void> deleteArtist(String musoId) async {
//     try {
//       await clientAPI.deleteArtist(musoId);
//     } on DioException catch (e) {
//       loggy.error(e.toString());
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       throw errorMessage;
//     }
//   }

//   Future<PagedData<List<GigApplication>>> getGigRequests(
//       {String? from,
//       String? to,
//       List<Genres>? genre,
//       List<ActTypes>? actSize,
//       List<Budget>? budget,
//       String? musoId,
//       bool? myResponse,
//       int? skip,
//       int? limit,
//       String? eventsType}) async {
//     try {
//       final response = await clientAPI.getGigRequests(
//           from: from,
//           to: to,
//           genre: genre?.map((e) => e.label).join(','),
//           actSize: actSize?.map((e) => e.code).join(','),
//           budget: budget?.map((e) => e.value).join(','),
//           musoId: musoId,
//           myResponse: myResponse,
//           skip: skip,
//           limit: limit,
//           eventsType: eventsType);
//       final data = List<GigApplication>.from(
//           (response.data['gig_requests'] as List?)
//                   ?.map((e) => GigApplication.fromJson(e)) ??
//               List.empty());
//       final int total = response.data['total'];
//       return PagedData(data, total);
//     } on DioException catch (e) {
//       loggy.error(e.toString());
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       throw errorMessage;
//     }
//   }

//   Future<GigApplication> getGigRequest(String id) async {
//     try {
//       final response = await clientAPI.getGigRequest(id);
//       final data = GigApplication.fromJson(response.data);
//       return data;
//     } on DioException catch (e) {
//       loggy.error(e.toString());
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       throw errorMessage;
//     }
//   }

//   Future<GigResponse> applyGigRequest(String musoId, String requestId) async {
//     try {
//       final response = await clientAPI.applyRequest(musoId, requestId);
//       final data = GigResponse.fromJson(response.data);
//       return data;
//     } on DioException catch (e) {
//       loggy.error(e.toString());
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       throw errorMessage;
//     }
//   }

//   Future<GigApplication> postNewRequest(GigRequest request) async {
//     try {
//       final response = await clientAPI.postNewRequest(request);
//       final data = GigApplication.fromJson(response.data);
//       return data;
//     } on DioException catch (e) {
//       loggy.error(e.toString());
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       throw errorMessage;
//     }
//   }

//   Future<void> deleteRequest(String id) async {
//     try {
//       await clientAPI.deleteRequest(id);
//     } on DioException catch (e) {
//       loggy.error(e.toString());
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       throw errorMessage;
//     }
//   }

//    Future<void> deleteResponse(String id, String musoId) async {
//     try {
//       await clientAPI.deleteResponse(id, musoId);
//     } on DioException catch (e) {
//       loggy.error(e.toString());
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       throw errorMessage;
//     }
//   }

//   Future<List<GigResponse>> getResponses(String id) async {
//     try {
//       final response = await clientAPI.getResponses(id);
//       final data = List<GigResponse>.from(
//           (response.data as List?)?.map((e) => GigResponse.fromJson(e)) ??
//               List.empty());
//       return data;
//     } on DioException catch (e) {
//       loggy.error(e.toString());
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       throw errorMessage;
//     }
//   }

//   Future<Gig> bookGig(BookGig gig) async {
//     try {
//       final response = await clientAPI.bookGig(gig);
//       final data = Gig.fromJson(response.data['Gig']);
//       return data;
//     } on DioException catch (e) {
//       loggy.error(e.toString());
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       throw errorMessage;
//     }
//   }

//   Future<void> deleteAccount(String userId) async {
//     try {
//       await clientAPI.deleteAccount(userId);
//     } on DioException catch (e) {
//       loggy.error(e.toString());
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       throw errorMessage;
//     }
//   }
// }
