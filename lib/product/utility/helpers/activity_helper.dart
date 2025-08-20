import 'package:flutter/material.dart';
import 'package:gen/gen.dart'; // ActivityType

IconData ActivityIcon(ActivityType t) {
  switch (t) {
    case ActivityType.call:
      return Icons.phone_in_talk_rounded;
    case ActivityType.meeting:
      return Icons.event_available_rounded;
    case ActivityType.email:
      return Icons.mail_outline_rounded;
  }
}
