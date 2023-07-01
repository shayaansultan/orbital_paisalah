import 'package:flutter/material.dart';

class PieChartCard extends StatefulWidget {
  const PieChartCard({Key? key}) : super(key: key);

  @override
  _PieChartCardState createState() => _PieChartCardState();
}

class _PieChartCardState extends State<PieChartCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 21, 41, 76),
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.8),
            blurRadius: 8.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pie Chart',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            // SizedBox(height: 8.0),
            Divider(
              color: Colors.white,
              thickness: 1,
            ),

            //ADD PIE CHART STUFF HERE
          ],
        ),
      ),
    );
  }
}
