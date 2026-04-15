// import 'package:flutter/material.dart';
//
// ThemeData darkMode = ThemeData(
//   colorScheme: ColorScheme.dark(
//     primary: const Color(0xff563f1a),
//     secondary: const Color(0xff564f4f),
//     tertiary: Colors.white70,
//     inversePrimary: Colors.grey.shade900,
//   ),
// );
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/repositories/chat_repository_impl.dart';
import '../data/sources/chat_remote_data_source.dart';
import '../domain/repositories/chat_repository.dart';
import 'all_members_state_notifier.dart';

final chatRepositoryProvider = Provider<ChatRepository>((ref) {
  return ChatRepositoryImpl(ChatRemoteDataSource());
});

final communityChatProvider =
    StateNotifierProvider<
      CommunityChatNotifier,
      AsyncValue<List<QueryDocumentSnapshot>>
    >((ref) {
      final repo = ref.watch(chatRepositoryProvider);
      return CommunityChatNotifier(repo);
    });
