import 'package:gen/gen.dart';

enum ActivityType { call, meeting, email }

ActivityType activityTypeFromString(String s) {
  switch (s.toLowerCase()) {
    case 'call':
      return ActivityType.call;
    case 'meeting':
      return ActivityType.meeting;
    default:
      return ActivityType.email;
  }
}

class Activity {
  final int id;
  final ActivityType type;
  final String title;
  final DateTime when;

  Activity({
    required this.id,
    required this.type,
    required this.title,
    required this.when,
  });

  factory Activity.fromJson(Map<String, dynamic> j) => Activity(
        id: j['id'] as int,
        type: activityTypeFromString(j['type'] as String),
        title: j['title'] as String,
        when: DateTime.parse(j['when'] as String),
      );
}

class Note {
  final int id;
  final String text;
  final DateTime createdAt;

  Note({required this.id, required this.text, required this.createdAt});

  factory Note.fromJson(Map<String, dynamic> j) => Note(
        id: j['id'] as int,
        text: j['text'] as String,
        createdAt: DateTime.parse(j['created_at'] as String),
      );
}

class CustomerDetail {
  final Customer customer;
  final List<Activity> activities;
  final List<Note> notes;

  CustomerDetail({
    required this.customer,
    required this.activities,
    required this.notes,
  });

  factory CustomerDetail.fromJson(Map<String, dynamic> j) => CustomerDetail(
        customer: Customer.fromJson(j['customer'] as Map<String, dynamic>),
        activities: (j['activities'] as List)
            .cast<Map<String, dynamic>>()
            .map(Activity.fromJson)
            .toList(),
        notes: (j['notes'] as List)
            .cast<Map<String, dynamic>>()
            .map(Note.fromJson)
            .toList(),
      );
}
