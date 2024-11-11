import 'package:flutter/material.dart';

class BatteryScreen extends StatelessWidget {
  const BatteryScreen({super.key});

  final double current = 2.0; // Assumed current in amperes (A)

  // Sample battery status data based on `BatteryStatuses` structure
  final List<BatteryStatus> batteryHistory = const [
    BatteryStatus(id: 1, voltage: 12, timestamp: '2024-11-11 12:00:00'),
    BatteryStatus(id: 2, voltage: 11, timestamp: '2024-11-11 11:00:00'),
    BatteryStatus(id: 3, voltage: 10, timestamp: '2024-11-11 10:00:00'),
    BatteryStatus(id: 4, voltage: 12, timestamp: '2024-11-11 09:00:00'),
    // Add more entries as needed
  ];

  // Function to calculate watts used per hour
  double calculateWattsPerHour(double voltage, double current) {
    return voltage * current;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Battery Monitoring'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20.0),

            // Battery Voltage History with Watts Used Per Hour
            Card(
              color: Colors.lightGreen[100],
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Voltage History',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 300, // Fixed height for scrolling
                      child: ListView.builder(
                        itemCount: batteryHistory.length,
                        itemBuilder: (context, index) {
                          final data = batteryHistory[index];
                          // Calculate watts per hour for each entry
                          final wattsPerHour = calculateWattsPerHour(data.voltage.toDouble(), current);
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'ID: ${data.id}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text('Voltage: ${data.voltage} V'),
                                Text('Watts per Hour: ${wattsPerHour.toStringAsFixed(2)} W'),
                                const SizedBox(height: 5),
                                Text('Timestamp: ${data.timestamp}'),
                                const Divider(), // Divider for clarity
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// BatteryStatus class to match `BatteryStatuses` table structure with a constant constructor
class BatteryStatus {
  final int id;
  final int voltage;
  final String timestamp;

  // Adding `const` to make this constructor constant
  const BatteryStatus({
    required this.id,
    required this.voltage,
    required this.timestamp,
  });
}
