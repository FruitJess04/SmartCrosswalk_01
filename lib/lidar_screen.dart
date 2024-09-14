import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class LidarScreen extends StatefulWidget {
  const LidarScreen({super.key});

  @override
  _LidarScreenState createState() => _LidarScreenState();
}

class _LidarScreenState extends State<LidarScreen> {
  int _selectedSensor = 1;
  List<int> _sensorData = [10, 20, 30, 40, 50, 60, 70]; // Example data

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lidar Sensor Monitoring'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              'Select Lidar Sensor',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            DropdownButton<int>(
              value: _selectedSensor,
              items: const [
                DropdownMenuItem(value: 1, child: Text('Lidar Sensor 1')),
                DropdownMenuItem(value: 2, child: Text('Lidar Sensor 2')),
                DropdownMenuItem(value: 3, child: Text('Lidar Sensor 3')),
                DropdownMenuItem(value: 4, child: Text('Lidar Sensor 4')),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedSensor = value!;
                  _sensorData = _getSensorData(_selectedSensor);
                });
              },
            ),
            const SizedBox(height: 20.0),
            Text(
              'Lidar Sensor $_selectedSensor Data',
              style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20.0),
            Expanded(
              child: LineChart(
                LineChartData(
                  gridData: const FlGridData(show: true),
                  titlesData: const FlTitlesData(show: true),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(color: const Color(0xff37434d), width: 1),
                  ),
                  minX: 0,
                  maxX: 6,
                  minY: 0,
                  maxY: 70,
                  lineBarsData: [
                    LineChartBarData(
                      spots: _sensorData
                          .asMap()
                          .entries
                          .map((e) => FlSpot(e.key.toDouble(), e.value.toDouble()))
                          .toList(),
                      isCurved: true,
                      color:Colors.blue,
                      barWidth: 5,
                      isStrokeCapRound: true,
                      dotData: const FlDotData(show: false),
                      belowBarData: BarAreaData(show: false),
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

  List<int> _getSensorData(int sensor) {
    // Replace this with your actual data fetching logic
    switch (sensor) {
      case 1:
        return [10, 20, 30, 40, 50, 60, 70];
      case 2:
        return [70, 60, 50, 40, 30, 20, 10];
      case 3:
        return [10, 30, 50, 70, 50, 30, 10];
      case 4:
        return [70, 50, 30, 10, 30, 50, 70];
      default:
        return [10, 20, 30, 40, 50, 60, 70];
    }
  }
}
