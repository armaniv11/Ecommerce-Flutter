import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';

class TrackingList extends StatelessWidget {
  final int activestep;
  final List<Icon> icons;
  final double lineLength;
  const TrackingList(
      {Key? key,
      required this.activestep,
      required this.icons,
      this.lineLength = 40})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.08,
      width: size.width,
      // decoration: BoxDecoration(color: Colors.yellow),
      child: IconStepper(
        lineDotRadius: 2,
        lineLength: lineLength,
        lineColor: Colors.yellow[900],
        activeStepBorderPadding: 0,
        activeStepColor: Colors.green,
        activeStepBorderWidth: 2,
        activeStepBorderColor: Colors.grey,
        scrollingDisabled: true,
        stepColor: Colors.grey[400],
        enableStepTapping: false,
        enableNextPreviousButtons: false,
        icons: icons,

        // activeStep property set to activeStep variable defined above.
        activeStep: activestep,

        // This ensures step-tapping updates the activeStep.
        // onStepReached: (index) {
        //   setState(() {
        //     activeStep = index;
        //   });
        // },
      ),
    );
  }
}
