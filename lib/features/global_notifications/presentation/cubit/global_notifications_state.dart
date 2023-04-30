// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'global_notifications_cubit.dart';

class GlobalNotificationsState extends Equatable {
  final int notificationCount;
  final int messageCount;
  final int digitalKitsCount;
  const GlobalNotificationsState({
    this.notificationCount = 0,
    this.messageCount = 0,
    this.digitalKitsCount = 0,
  });

  @override
  List<Object> get props => [notificationCount, messageCount, digitalKitsCount];

 

  GlobalNotificationsState copyWith({
    int? notificationCount,
    int? messageCount,
      int ? digitalKitsCount,
  }) {
    return GlobalNotificationsState(
      notificationCount: notificationCount ?? this.notificationCount,
      messageCount: messageCount ?? this.messageCount,
      digitalKitsCount: digitalKitsCount ?? this.digitalKitsCount,
    );
  }
}
