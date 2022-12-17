import 'package:flutter/material.dart';

import 'stepper.dart';

void main() {
  runApp(IconStepperDemo());
}

class IconStepperDemo extends StatefulWidget {
  @override
  _IconStepperDemo createState() => _IconStepperDemo();
}

class _IconStepperDemo extends State<IconStepperDemo> {
  // THE FOLLOWING TWO VARIABLES ARE REQUIRED TO CONTROL THE STEPPER.
  int activeStep = 0; // Initial step set to 5.

  int upperBound = 6; // upperBound MUST BE total number of icons minus 1.

  Color active = Colors.yellow;
  Color finished = Colors.green;
  Color remain = Colors.grey;

  static Map<String,int> completedTasks = {};

  List<Icon> allIcons = [
    Icon(Icons.supervised_user_circle),
    Icon(Icons.flag),
    Icon(Icons.access_alarm),
    Icon(Icons.add_alert),
  ];


  @override
  void initState() {
    super.initState();
    for (int i = 0 ;i<allIcons.length;i++){
      completedTasks[i.toString()] = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('IconStepper Example'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              IconStepper(
                subTitles: ["asdfasdfasdf","asf","asdfasf","asfasdfasdf"],
                completedTasks: completedTasks,
 
                stepperAnimateInMiddle: true,
                icons: allIcons,
                stepsCompletedStatusMap: completeStatusMap,
                activeStepColor: active,
                activeStepBorderColor: active,
                // activeStep property set to activeStep variable defined above.
                stepColor: remain,
                activeStep: activeStep,

                // This ensures step-tapping updates the activeStep. 
                onStepReached: (index) {
                  setState(() {
                    activeStep = index;
                  });
                },
              ),
              header(),
              Expanded(
                child: FittedBox(
                  child: Center(
                    child: Text('$activeStep'),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  previousButton(),
                  nextButton(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void completeStatusMap(int i){
    setState((){
      completedTasks[i.toString()] = 1;
    });
  }

  /// Returns the next button.
  Widget nextButton() {
    return ElevatedButton(
      onPressed: () {
        // if completed then..
        completeStatusMap(activeStep);
        // Increment activeStep, when the next button is tapped. However, check for upper bound.
        if (activeStep < upperBound) {
          setState(() {
            activeStep++;
          });
        }
      },
      child: Text('Next'),
    );
  }

  /// Returns the previous button.
  Widget previousButton() {
    return ElevatedButton(
      onPressed: () {
        // Decrement activeStep, when the previous button is tapped. However, check for lower bound i.e., must be greater than 0.
        if (activeStep > 0) {
          setState(() {
            activeStep--;
          });
        }
      },
      child: Text('Prev'),
    );
  }

  /// Returns the header wrapping the header text.
  Widget header() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              headerText(),
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Returns the header text based on the activeStep.
  String headerText() {
    switch (activeStep) {
      case 1:
        return 'Preface';

      case 2:
        return 'Table of Contents';

      case 3:
        return 'About the Author';

      case 4:
        return 'Publisher Information';

      case 5:
        return 'Reviews';

      case 6:
        return 'Chapters #1';

      default:
        return 'Introduction';
    }
  }
}