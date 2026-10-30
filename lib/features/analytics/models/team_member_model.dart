class TeamMemberLinkStat {
  final String label;
  final String platform;
  final int clicks;

  const TeamMemberLinkStat({
    required this.label,
    required this.platform,
    required this.clicks,
  });
}

class TeamMemberModel {
  final String id;
  final List<String> cardIds;
  final String name;
  final String email;
  final String jobTitle;
  final String role;
  final String? avatarUrl;
  final int taps;
  final int qrScans;
  final int leads;
  final int profileViews;
  final int contactsSaved;
  final int conversions;
  final int totalClicks;
  final List<int> viewsByDay;
  final List<int> tapsByDay;
  final List<int> clicksByDay;
  final List<TeamMemberLinkStat> linkStats;

  const TeamMemberModel({
    required this.id,
    this.cardIds = const [],
    required this.name,
    this.email = '',
    required this.jobTitle,
    this.role = 'default',
    this.avatarUrl,
    required this.taps,
    this.qrScans = 0,
    this.leads = 0,
    required this.profileViews,
    required this.contactsSaved,
    this.conversions = 0,
    this.totalClicks = 0,
    this.viewsByDay = const [],
    this.tapsByDay = const [],
    this.clicksByDay = const [],
    this.linkStats = const [],
  });

  factory TeamMemberModel.fromJson(Map<String, dynamic> json) {
    return TeamMemberModel(
      id: json['id'] as String,
      cardIds: const [],
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      jobTitle: json['job_title'] as String? ?? '',
      role: json['role'] as String? ?? 'default',
      avatarUrl: json['photo_url'] as String?,
      taps: (json['taps'] as num?)?.toInt() ?? 0,
      qrScans: (json['qr_scans'] as num?)?.toInt() ?? 0,
      leads: (json['leads'] as num?)?.toInt() ?? 0,
      profileViews: (json['profile_views'] as num?)?.toInt() ?? 0,
      contactsSaved: (json['contacts_saved'] as num?)?.toInt() ?? 0,
      conversions: (json['conversions'] as num?)?.toInt() ?? 0,
      totalClicks: (json['total_clicks'] as num?)?.toInt() ?? 0,
    );
  }

  double get conversionRate =>
      taps == 0 ? 0 : (conversions / taps).clamp(0.0, 1.0);

  double get leadRate => profileViews == 0 ? 0 : (leads / profileViews);

  bool get isAdmin => role == 'admin';

  /// AI-generated insight for this member.
  String get aiInsight {
    if (conversionRate >= 0.15) {
      return 'Has the best conversion rate on the team.';
    }
    if (taps >= 60) {
      return 'High volume of taps. Focus on conversion.';
    }
    if (contactsSaved >= 20) {
      return 'Many saved contacts — good in-person closing.';
    }
    return 'Room to improve by enabling more networks on the card.';
  }

  String get behaviorSummary {
    if (totalClicks >= leads && leads > 0) {
      return 'Generates high intent: their clicks are already driving real leads.';
    }
    if (profileViews > 0 && totalClicks == 0) {
      return 'Has visibility, but needs to convert visits into interaction.';
    }
    if (taps > profileViews / 2 && profileViews > 0) {
      return 'Excels at in-person contact and direct activation.';
    }
    return aiInsight;
  }
}
