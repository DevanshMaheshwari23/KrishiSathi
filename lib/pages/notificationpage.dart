import 'package:krishi_sathi/component/RoundedBox.dart';
import 'package:krishi_sathi/pages/predictionpage.dart';
import 'package:krishi_sathi/services/language_service.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final LanguageService _languageService = LanguageService();

  // Sample notifications
  final List<NotificationItem> _notifications = [
    NotificationItem(
      icon: Iconsax.tree,
      title: "Your Prediction Is Ready",
      subtitle: "Check your predicted crop",
      time: DateTime.now().subtract(const Duration(minutes: 5)),
      route: '/predictionpage',
    ),
    NotificationItem(
      icon: Iconsax.bookmark,
      title: "New Fertilizer Recommendation",
      subtitle: "Check out our new fertilizer recommendations",
      time: DateTime.now().subtract(const Duration(hours: 2)),
      route: '/fertilizerInfo',
    ),
    NotificationItem(
      icon: Iconsax.sun_fog,
      title: "Weather Alert",
      subtitle: "Rain expected in your area tomorrow",
      time: DateTime.now().subtract(const Duration(days: 1)),
      route: null,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _languageService.languageChangeNotifier.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
        backgroundColor: const Color(0xFF5F8D4E),
        centerTitle: true,
        title: Text(
          _languageService.notifications,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: _notifications.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Iconsax.notification,
                      size: 80, color: Color(0xFFCFE8A9)),
                  const SizedBox(height: 16),
                  Text(
                    _languageService.isEnglish
                        ? "No notifications yet"
                        : "अभी तक कोई सूचना नहीं",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF8B4513),
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: _notifications.length,
              itemBuilder: (context, index) {
                final notification = _notifications[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RoundedBox(
                    child: ListTile(
                      leading: Icon(notification.icon,
                          color: const Color(0xFF5F8D4E)),
                      title: Text(
                        _languageService.isEnglish
                            ? notification.title
                            : _translateNotificationTitle(notification.title),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF8B4513),
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _languageService.isEnglish
                                ? notification.subtitle
                                : _translateNotificationSubtitle(
                                    notification.subtitle),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _formatTime(notification.time),
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      trailing: const Icon(Iconsax.arrow_circle_right,
                          color: Color(0xFF5F8D4E)),
                      onTap: () {
                        if (notification.route == '/predictionpage') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PredictionPage(),
                            ),
                          );
                        } else if (notification.route != null) {
                          Navigator.pushNamed(context, notification.route!);
                        }
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }

  String _translateNotificationTitle(String title) {
    switch (title) {
      case "Your Prediction Is Ready":
        return "आपकी भविष्यवाणी तैयार है";
      case "New Fertilizer Recommendation":
        return "नई उर्वरक अनुशंसा";
      case "Weather Alert":
        return "मौसम चेतावनी";
      default:
        return title;
    }
  }

  String _translateNotificationSubtitle(String subtitle) {
    switch (subtitle) {
      case "Check your predicted crop":
        return "अपनी भविष्यवाणी की गई फसल की जांच करें";
      case "Check out our new fertilizer recommendations":
        return "हमारी नई उर्वरक अनुशंसाओं को देखें";
      case "Rain expected in your area tomorrow":
        return "कल आपके क्षेत्र में बारिश की उम्मीद है";
      default:
        return subtitle;
    }
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inMinutes < 60) {
      return "${difference.inMinutes} ${_languageService.isEnglish ? 'minutes ago' : 'मिनट पहले'}";
    } else if (difference.inHours < 24) {
      return "${difference.inHours} ${_languageService.isEnglish ? 'hours ago' : 'घंटे पहले'}";
    } else {
      return "${difference.inDays} ${_languageService.isEnglish ? 'days ago' : 'दिन पहले'}";
    }
  }
}

class NotificationItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final DateTime time;
  final String? route;

  NotificationItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.time,
    this.route,
  });
}
