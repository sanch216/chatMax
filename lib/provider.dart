import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'data/repositories/chat_repository_impl.dart';
import 'data/sources/chat_remote_data_source.dart';
import 'domain/repositories/chat_repository.dart';

final chatRepositoryProvider = Provider<ChatRepository>((ref) {
  return ChatRepositoryImpl(ChatRemoteDataSource());
});