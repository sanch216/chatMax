import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ChatRepository {
  Stream<QuerySnapshot> getCommunityMessages();

  Future<void> sendCommunityMessage(String message);

  Future<void> deleteMessage(String messageId, String receiveId);

  Future<void> deleteCommunityMessage(String messageId);
}
