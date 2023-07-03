import 'package:app_mental/escalas/promis_answer.dart';
import 'package:app_mental/escalas/question.dart';
import 'package:app_mental/helper/constants.dart';
import 'package:app_mental/model/answers.dart';
import 'package:flutter/material.dart';

import '../Services/questionnaireService.dart';
import '../helper/util.dart';
import '../model/questionnaire_answer.dart';

class AnswerQuestions extends StatefulWidget {
  final int sizeQuestionnaire;
  final String question;
  final List<Answers> answers;
  final int questionIndex;
  final Function answerQuestion;
  final Function resetQuestion;
  final String userEmail;
  final String scale;
  final String questionnaireCode;
  final String questName;
  final Function setQuestionIndex;

  AnswerQuestions(
      {required this.answers,
      required this.sizeQuestionnaire,
      required this.question,
      required this.answerQuestion,
      required this.questionIndex,
      required this.resetQuestion,
      required this.userEmail,
      required this.scale,
      required this.questionnaireCode,
      required this.questName,
      required this.setQuestionIndex});

  @override
  State<AnswerQuestions> createState() => _AnswerQuestionsState();
}

class _AnswerQuestionsState extends State<AnswerQuestions> {
  List<bool> checkboxValueList = [false, false, false, false];
  final textController = TextEditingController();

  changeCheckboxValue(newValue, index) {
    setState(() {
      checkboxValueList[index] = newValue!;
    });
  }

  String getQuestionText() {
    if (widget.questionnaireCode == QuestionnaireCode.assistn2.name) {
      final startSubstance =
          widget.questName.substring(widget.questName.indexOf("(") + 1);
      final substance =
          startSubstance.substring(0, startSubstance.lastIndexOf(")"));
      final questionText = widget.question + " " + substance;
      return questionText;
    } else {
      if (widget.questionnaireCode == QuestionnaireCode.pset.name &&
          widget.scale == "pset_week2") {
        return "Durante sua vida " + widget.question;
      } else {
        return "No último mês " + widget.question;
      }
    }
  }

  goBackToQuestionnaireScreen(BuildContext context) {
    Navigator.of(context).popUntil(ModalRoute.withName('/logged-home'));
    Navigator.of(context).pushNamed("/quests-screen");
  }

  discartChanges(BuildContext context) async {
    QuestionnaireService()
        .discardAllAnswers(
            widget.userEmail, QuestionnaireCode.ccsm.name, widget.scale)
        .then((_) {
      Navigator.of(context).popUntil(ModalRoute.withName('/logged-home'));
      Navigator.of(context).pushNamed("/quests-screen");
    });
  }

  answerLater(BuildContext context) {
    return AlertDialog(
      title: const Text('Responder depois'),
      content: const Text(
          'Deseja salvar suas respostas e terminar de responder mais tarde?'),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancelar'),
            ),
            (widget.questionnaireCode == QuestionnaireCode.ccsm.name)
                ? TextButton(
                    onPressed: () => discartChanges(context),
                    child: const Text('Descartar'),
                  )
                : Container(),
            TextButton(
              onPressed: () => goBackToQuestionnaireScreen(context),
              child: const Text('OK'),
            ),
          ],
        ),
      ],
    );
  }

  sendAllChosenCheckboxes(index) {
    for (int i = 0; i < checkboxValueList.length; i++) {
      if (checkboxValueList[i]) {
        QuestionnaireAnswer questionnaireAnswer = new QuestionnaireAnswer(
            answerId: widget.answers[i].answerId,
            email: widget.userEmail,
            answer: widget.answers[i].answerText,
            score: widget.answers[i].score,
            domain: widget.answers[i].domain,
            code: widget.questionnaireCode,
            questionIndex: widget.questionIndex,
            scale: widget.scale);
        QuestionnaireService().addQuestionnaireAnswer(questionnaireAnswer);
        setState(() {
          checkboxValueList[i] = false;
        });
      }
    }
    QuestionnaireAnswer questionnaireAnswer = new QuestionnaireAnswer(
        answerId: widget.answers[index].answerId,
        email: widget.userEmail,
        answer: widget.answers[index].answerText,
        score: widget.answers[index].score,
        domain: widget.answers[index].domain,
        code: widget.questionnaireCode,
        questionIndex: widget.questionIndex,
        scale: widget.scale);
    QuestionnaireService().addQuestionnaireAnswer(questionnaireAnswer);
    widget.setQuestionIndex(widget.questionIndex + 1);
  }

  sendText() {
    if (textController.text.isEmpty) {
      textController.text = "Continuar";
    }
    QuestionnaireAnswer questionnaireAnswer = new QuestionnaireAnswer(
        answerId: widget.answers[0].answerId,
        email: widget.userEmail,
        answer: textController.text,
        score: textController.text,
        domain: widget.answers[0].domain,
        code: widget.questionnaireCode,
        questionIndex: widget.questionIndex,
        scale: widget.scale);
    QuestionnaireService().addQuestionnaireAnswer(questionnaireAnswer);
    widget.setQuestionIndex(widget.questionIndex + 1);
  }

  List<Widget> getListAnswers() {
    if (widget.scale == "copsoq_week2" && widget.questionIndex == 45) {
      return [
        Column(children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              maxLines: 4,
              controller: textController,
              maxLength: 100,
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: sendText,
              child: Text(
                "Continuar",
                textAlign: TextAlign.center,
              ),
              style: new ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.all(12))),
            ),
          ),
        ]),
      ];
    } else if (isCopsoqAndCheckboxQuestion(
        widget.scale, widget.questionIndex)) {
      return [
        ...(widget.answers.map((answer) {
          int index = widget.answers.indexOf(answer);
          if (index == 4 || index == 5) {
            return OutlinedButton(
              onPressed: () => sendAllChosenCheckboxes(index),
              child: Text(
                answer.answerText,
                textAlign: TextAlign.center,
              ),
              style: new ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.all(12))),
            );
          }
          return AnswerOption(
            () => widget.answerQuestion(
                answer.answerId,
                answer.score,
                answer.domain,
                answer.answerText,
                widget.scale,
                widget.questionnaireCode),
            answer.answerText,
            widget.scale,
            widget.questionIndex,
            checkboxValueList[index],
            changeCheckboxValue,
            index,
          );
        })).toList(),
      ];
    } else {
      return [
        ...(widget.answers.map((answer) {
          return AnswerOption(
            () => widget.answerQuestion(
                answer.answerId,
                answer.score,
                answer.domain,
                answer.answerText,
                widget.scale,
                widget.questionnaireCode),
            answer.answerText,
            widget.scale,
            widget.questionIndex,
            checkboxValueList[0],
            changeCheckboxValue,
            0,
          );
        })).toList(),
      ];
    }
  }

  isAssistn2OrPset() {
    return widget.questionnaireCode == QuestionnaireCode.assistn2.name ||
        widget.questionnaireCode == QuestionnaireCode.pset.name;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      padding: EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color.fromRGBO(244, 244, 244, 1),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * .60,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Text(
                            "Questão ${widget.questionIndex} de ${widget.sizeQuestionnaire}",
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 10),
                          isAssistn2OrPset()
                              ? Question(getQuestionText())
                              : Question(widget.question),
                        ],
                      ),
                    ),
                    Container(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: getListAnswers(),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
            Container(
              child: Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Color.fromRGBO(104, 202, 138, 1)),
                    onPressed: () {
                      widget.resetQuestion();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/icons/questionarios_responder-depois.png",
                          width: 40,
                          height: 40,
                        ),
                        const Text(
                          "Voltar para a questão anterior",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Color.fromRGBO(104, 202, 138, 1)),
                    onPressed: () {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => answerLater(context),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/icons/questionarios_responder-agora.png",
                          width: 40,
                          height: 40,
                        ),
                        const Text('Responder depois',
                            style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
