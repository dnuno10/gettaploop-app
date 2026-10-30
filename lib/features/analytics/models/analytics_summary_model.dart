import 'link_stat_model.dart';
import 'visit_event_model.dart';

class AnalyticsSummaryModel {
  final int totalVisits;
  final int totalTaps;
  final int totalQrScans;
  final int totalClicks;
  final int totalInteractions;
  final int visitsThisWeek;
  final int visitsLastWeek;
  final int tapsThisPeriod;
  final int tapsLastPeriod;
  final int clicksThisPeriod;
  final int clicksLastPeriod;
  final int interactionsThisPeriod;
  final int interactionsLastPeriod;
  final List<LinkStatModel> linkStats;
  final List<VisitEventModel> recentEvents;
  final List<int> visitsByDay; // last 7 days, index 0 = oldest

  const AnalyticsSummaryModel({
    required this.totalVisits,
    required this.totalTaps,
    required this.totalQrScans,
    required this.totalClicks,
    required this.totalInteractions,
    required this.visitsThisWeek,
    required this.visitsLastWeek,
    required this.tapsThisPeriod,
    required this.tapsLastPeriod,
    required this.clicksThisPeriod,
    required this.clicksLastPeriod,
    required this.interactionsThisPeriod,
    required this.interactionsLastPeriod,
    required this.linkStats,
    required this.recentEvents,
    required this.visitsByDay,
  });

  static double _growthPercent(int current, int previous) {
    if (previous == 0) return current > 0 ? 100 : 0;
    return ((current - previous) / previous) * 100;
  }

  double get weeklyGrowthPercent {
    return _growthPercent(visitsThisWeek, visitsLastWeek);
  }

  bool get isGrowing => visitsThisWeek >= visitsLastWeek;

  double get visitsGrowthPercent =>
      _growthPercent(visitsThisWeek, visitsLastWeek);

  double get tapsGrowthPercent =>
      _growthPercent(tapsThisPeriod, tapsLastPeriod);

  double get clicksGrowthPercent =>
      _growthPercent(clicksThisPeriod, clicksLastPeriod);

  double get interactionsGrowthPercent =>
      _growthPercent(interactionsThisPeriod, interactionsLastPeriod);

  bool get interactionsGrowing =>
      interactionsThisPeriod >= interactionsLastPeriod;

  bool get tapsGrowing => tapsThisPeriod >= tapsLastPeriod;

  bool get clicksGrowing => clicksThisPeriod >= clicksLastPeriod;
}
