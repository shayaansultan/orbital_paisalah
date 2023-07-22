import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

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
            PieChart(
              dataMap: {
                'Food': 10,
                'Entertainment': 30,
                'Shopping': 20,
                'Transport':20,
                'Housing':10,
                'Investments/Saving':10,

              },
              chartType: ChartType.disc,
              colorList: [Colors.green, Colors.blue, Colors.red, Colors.pinkAccent,
                Colors.purple, Colors.brown],
              animationDuration: Duration(milliseconds: 800),
              chartRadius: MediaQuery.of(context).size.width / 2.7,
              initialAngleInDegree: 0,
              chartLegendSpacing: 32.0,
              chartValuesOptions: ChartValuesOptions(
                showChartValuesInPercentage: true,
                showChartValuesOutside: true,
                decimalPlaces: 1,
              ),
              centerText: 'Pie Chart',
              legendOptions: LegendOptions(
                showLegendsInRow: false,
                legendPosition: LegendPosition.bottom,
                showLegends: true,
              ),
            ),

          ],
        ),
      ),
    );
  }
}
