import 'package:attendenz/constants/colors.dart';
import 'package:attendenz/models/subjectCategory.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/widgets.dart';

class Chart extends StatefulWidget {

  final List<Subject> absentCategoryTotals;
  final List<Subject> presentCategoryTotals;

  const Chart({
    super.key,
    required this.absentCategoryTotals,
    required this.presentCategoryTotals,
    });

  @override
  State<Chart> createState() => _ChartState();
}



class _ChartState extends State<Chart> {

  double percentage = 0;


  
  

  // sections data

  List<PieChartSectionData> getSections(){
    return [
      PieChartSectionData(
        color: absentColor,
        value: widget.absentCategoryTotals.length.toDouble(),
        showTitle: false,
        radius: 60
      ),

      PieChartSectionData(
        color: presentColor,
        value: widget.presentCategoryTotals.length.toDouble(),
        showTitle: false,
        radius: 60
      )
    ];
  }

  @override
  Widget build(BuildContext context) {

    double totalAbsents = widget.absentCategoryTotals.length.toDouble();
    double totalPresents = widget.presentCategoryTotals.length.toDouble();
    
    percentage = (totalAbsents)/(totalPresents + totalAbsents) * 100;

    final PieChartData pieChartData = PieChartData(
      sectionsSpace: 0,
      centerSpaceRadius: 40,
      startDegreeOffset: -90,
      sections: getSections(),
      borderData: FlBorderData(show: false)
    );

    return Padding(
      padding: const EdgeInsets.only(top: 30, bottom: 30),
      child: Container(
        height: 220,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 216, 210, 210),
          borderRadius: BorderRadius.circular(16)
        ),
      
        child: Stack(
          alignment: Alignment.center,
          children: [
            PieChart(pieChartData),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Absents",style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),),
                Text("${percentage.toStringAsFixed(2)}%")
              ],
            ),
            
          ],
        )
      ),
    );
  }
}