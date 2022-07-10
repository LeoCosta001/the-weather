import 'package:flutter/material.dart';

class NextHoursDetailPage extends StatefulWidget {
  const NextHoursDetailPage({Key? key}) : super(key: key);

  @override
  State<NextHoursDetailPage> createState() => _NextHoursDetailPageState();
}

class _NextHoursDetailPageState extends State<NextHoursDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/weathers_bg/sunset-01.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Colors.black.withOpacity(0.6),
                  Colors.black.withOpacity(0.5),
                  Colors.black.withOpacity(0.2),
                  Colors.black.withOpacity(0.0),
                ],
              ),
            ),
          ),
          title: Row(
            children: const [
              Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(Icons.room),
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    'Next hours detail',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: OrientationBuilder(builder: (context, orientation) {
          final isPortrait = orientation == Orientation.portrait;

          return Text(
            'page 2',
            style:
                TextStyle(fontSize: 20, color: Theme.of(context).primaryColor),
          );
        }),
      ),
    );
  }
}
