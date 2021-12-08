import 'package:flutter/material.dart';
import 'package:flutter_responsive/responsive_helper.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pushpak'),
      ),
      body: SafeArea(
        child: ResponsiveWidget(
          mobile: Column(
            children: [
              buildSliderBanner(),
              buildIntroText(),
            ],
          ),
          tab: Row(
            children: [
              buildSliderBanner(),
              SizedBox(
                width: 24,
              ),
              Expanded(child: buildIntroText()),
            ],
          ),
        ),
        // child: LayoutBuilder(
        //   builder: (context, constraints) {
        //     if (constraints.maxWidth < 768) {
        //       return Column(
        //         children: [
        //           buildSliderBanner(),
        //           buildIntroText(),
        //         ],
        //       );
        //     } else {
        //       return Row(
        //         children: [
        //           buildSliderBanner(),
        //           SizedBox(
        //             width: 24,
        //           ),
        //           Expanded(child: buildIntroText()),
        //         ],
        //       );
        //     }
        //   },
        // ),
      ),
    );
  }

  Text buildIntroText() {
    return Text(
      'Hey there, \n\nCodeX is an Aadadas Adasdwa Dadwad Adweadadadada adadaddddddddddddddddddddddddddddddd',
      style: TextStyle(fontSize: 22),
    );
  }

  Container buildSliderBanner() {
    return Container(
      width: 320,
      height: 180,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.red,
            Colors.pink,
          ],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
