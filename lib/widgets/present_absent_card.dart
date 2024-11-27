import 'package:flutter/material.dart';

class PresentAbsentCard extends StatefulWidget {

  final String title;
  final double total;
  final Color bgColor;
  final IconData bIcon;

  const PresentAbsentCard({
    super.key,
    required this.title,
    required this.total,
    required this.bgColor,
    required this.bIcon,
    });

  @override
  State<PresentAbsentCard> createState() => _PresentAbsentCardState();
}

class _PresentAbsentCardState extends State<PresentAbsentCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width*0.38,
      height: MediaQuery.of(context).size.height*0.12,
      decoration: BoxDecoration(
        color: widget.bgColor.withOpacity(0.8),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              height: MediaQuery.of(context).size.width*0.15,
              width: MediaQuery.of(context).size.width*0.15,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)
              ),
              child: Center(
                child: Icon(widget.bIcon,size: 30,),
              ),
            ),

            const SizedBox(
              width: 10,
            ),

            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  Text(widget.title,
                  style: const TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                    fontWeight: FontWeight.w500
                  ),
                  ),
              
                  Text("${widget.total.toStringAsFixed(0)}",
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}