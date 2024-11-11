import 'package:flutter/material.dart';

class LidarScreen extends StatefulWidget {
  const LidarScreen({super.key});

  @override
  _LidarScreenState createState() => _LidarScreenState();
}

class _LidarScreenState extends State<LidarScreen> {
  int _totalSensors = 0; // Total movement sensors count
  final List<SensorData> _sensorHistory = []; // List to hold sensor history

  @override
  void initState() {
    super.initState();
    _simulateSensorData(); // Populate history with simulated data
  }

  void _simulateSensorData() {
    // Simulate adding some sensor data to the history
    for (int i = 1; i <= 20; i++) {
      _totalSensors += 1;
      _sensorHistory.add(SensorData(
        id: i,
        numberDetected: _totalSensors,
        timestamp: DateTime.now().subtract(Duration(minutes: i * 5)).toString(),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lidar Sensor Monitoring'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20.0),
            // Display Total Movement Sensors
            Card(
              color: Colors.lightBlue[50],
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    const Icon(Icons.storage, size: 24.0),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Total Movement Sensors',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '$_totalSensors',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Display Sensor History with scroll and 10 items visible
            Card(
              color: Colors.lightGreen[100],
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Sensor History',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 300, // Fixed height to show 10 items with scrolling
                      child: ListView.builder(
                        itemCount: _sensorHistory.length,
                        itemBuilder: (context, index) {
                          final data = _sensorHistory[index];
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
                                Text('Total Motion Detected: ${data.numberDetected}'),
                                const SizedBox(height: 5),
                                Text('Timestamp: ${data.timestamp}'),
                                const Divider(), // Divider for visual separation
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

// Updated SensorData class to match `lidar_statuses` table structure
class SensorData {
  final int id;
  final int numberDetected;
  final String timestamp;

  SensorData({
    required this.id,
    required this.numberDetected,
    required this.timestamp,
  });
}
