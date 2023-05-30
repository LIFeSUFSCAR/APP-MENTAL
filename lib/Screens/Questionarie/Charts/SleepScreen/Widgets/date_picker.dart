import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../Services/sleepService.dart';
import '../../../../../helper/constants.dart';

class DatePicker extends StatefulWidget {
  final Function setSleepData;
  final List<DateTime> questionnaireAnswerDates;
  final int lastDayAnswered;

  DatePicker(
      {required this.setSleepData,
      required this.questionnaireAnswerDates,
      required this.lastDayAnswered});

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  TextEditingController dateController = TextEditingController();

  pickDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: widget.questionnaireAnswerDates[widget.lastDayAnswered - 1],
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      selectableDayPredicate: (DateTime day) =>
          widget.questionnaireAnswerDates.contains(day),
    );
    if (pickedDate != null) {
      SleepService()
          .getSleepQuestionnaireAnswersApp(Constants.myEmail,
              DateFormat("yyyy-MM-dd").format(pickedDate).toString())
          .then((value) {
        setState(() {
          widget.setSleepData(value);
          dateController.text =
              DateFormat("dd/MM/yyyy").format(pickedDate).toString();
        });
      });
    }
  }

  goOneDayFoward() {
    if (dateController.text != "" &&
        DateFormat("dd/MM/yyyy").format(
                widget.questionnaireAnswerDates[widget.lastDayAnswered - 1]) !=
            dateController.text) {
      for (int i = 0; i < widget.questionnaireAnswerDates.length; i++) {
        if (dateController.text ==
            DateFormat("dd/MM/yyyy")
                .format(widget.questionnaireAnswerDates[i])) {
          SleepService()
              .getSleepQuestionnaireAnswersApp(
                  Constants.myEmail,
                  DateFormat("yyyy-MM-dd")
                      .format(widget.questionnaireAnswerDates[i + 1])
                      .toString())
              .then((value) {
            setState(() {
              widget.setSleepData(value);
              dateController.text = DateFormat("dd/MM/yyyy")
                  .format(widget.questionnaireAnswerDates[i + 1])
                  .toString();
            });
            return;
          });
        }
      }
    }
  }

  goOneDayBack() {
    if (dateController.text != "" &&
        DateFormat("dd/MM/yyyy").format(widget.questionnaireAnswerDates[0]) !=
            dateController.text) {
      for (int i = 0; i < widget.questionnaireAnswerDates.length; i++) {
        if (dateController.text ==
            DateFormat("dd/MM/yyyy")
                .format(widget.questionnaireAnswerDates[i])) {
          SleepService()
              .getSleepQuestionnaireAnswersApp(
                  Constants.myEmail,
                  DateFormat("yyyy-MM-dd")
                      .format(widget.questionnaireAnswerDates[i - 1])
                      .toString())
              .then((value) {
            setState(() {
              widget.setSleepData(value);
              dateController.text = DateFormat("dd/MM/yyyy")
                  .format(widget.questionnaireAnswerDates[i - 1])
                  .toString();
            });
            return;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: goOneDayBack,
          child: Icon(Icons.arrow_back),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.6,
          height: 35,
          child: TextField(
            onTap: () => pickDate(context),
            controller: dateController,
            readOnly: true,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 1),
                ),
                icon: Icon(Icons.calendar_today, color: Colors.blue),
                labelText: "Selecione a data"),
          ),
        ),
        TextButton(
          onPressed: goOneDayFoward,
          child: Icon(Icons.arrow_forward),
        ),
      ],
    );
  }
}
