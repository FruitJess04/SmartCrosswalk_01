import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final List<Map<String, String>> _allNotifications = [
    {'message': 'Sensor 1 malfunction detected', 'date': '2024-07-18', 'time': '14:30', 'status': 'warning'}
  ];

  List<Map<String, String>> _filteredNotifications = [];

  @override
  void initState() {
    super.initState();
    _filteredNotifications = _allNotifications;
  }

  void _filterNotifications(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredNotifications = _allNotifications;
      } else {
        _filteredNotifications = _allNotifications
            .where((notification) =>
                notification['message']!.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  Color _getNotificationColor(String status) {
    switch (status) {
      case 'critical':
        return Colors.red; // For devices that are broken
      case 'warning':
        return const Color.fromARGB(255, 252, 247, 104); // For warnings
      case 'working':
        return Colors.green; // For devices that are working properly
      default:
        return Colors.white; // Default color for other statuses
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: const Color.fromARGB(255, 83, 180, 228),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onChanged: _filterNotifications,
              decoration: const InputDecoration(
                labelText: 'Search Notifications',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _filteredNotifications.add({
                    'message': 'Lidar Sensor is Not Working',
                    'date': '2024-07-19', // Default date
                    'time': '12:00', // Default time
                    'status': 'warning', // Default status
                  });
                });
              },
              child: const Text('Add Notification'),
            ),
            const SizedBox(height: 20.0),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredNotifications.length,
                itemBuilder: (context, index) {
                  final notification = _filteredNotifications[index];
                  return Container(
                    color: _getNotificationColor(notification['status']!),
                    child: ListTile(
                      title: Text(notification['message']!),
                      subtitle: Text(
                          'Date: ${notification['date']} Time: ${notification['time']}'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
