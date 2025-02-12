import 'package:common_data/session.dart';
import 'package:common_data/speaker.dart';
import 'package:common_data/sponsor.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'timeline_item.freezed.dart';

@freezed
class TimelineItem with _$TimelineItem {
  const factory TimelineItem.event({
    required String title,
    required DateTime startsAt,
    required DateTime endsAt,
  }) = TimelineItemEvent;

  const factory TimelineItem.session({
    required String id,
    required String title,
    required String description,
    required DateTime startsAt,
    required DateTime endsAt,
    required bool isLightningTalk,
    required SessionVenue venue,
    required List<Speaker> speakers,
    required List<Sponsor> sponsors,
  }) = TimelineItemSession;
}
