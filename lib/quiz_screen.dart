import 'package:flutter/material.dart';
import 'dart:math';
import 'table_generator_screen.dart';
import 'constants.dart';

class QuestionScreen extends StatefulWidget {
  final int tableNumber;
  final int startingPoint;
  final int endingPoint;

  QuestionScreen({
    required this.tableNumber,
    required this.startingPoint,
    required this.endingPoint,
  });

  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  Random random = Random();
  late int firstNumber;
  late int secondNumber;
  String? message;
  int score = 0;
  late List<int> questionList;
  int currentQuestionIndex = 0;

  @override
  void initState() {
    super.initState();
    // Create a list of all possible second numbers
    questionList = List.generate(
        widget.endingPoint - widget.startingPoint + 1,
            (index) => widget.startingPoint + index);
    // Shuffle the list to randomize the questions
    questionList.shuffle();
    generateQuestion();
  }

  void generateQuestion() {
    if (currentQuestionIndex < questionList.length) {
      setState(() {
        firstNumber = widget.tableNumber;
        secondNumber = questionList[currentQuestionIndex];
        message = null;
      });
    } else {
      setState(() {
        message = 'Quiz Finished! Your final score is $score out of ${questionList.length}.';
      });
    }
  }

  void checkAnswer(int selectedAnswer) {
    if (selectedAnswer == firstNumber * secondNumber) {
      setState(() {
        score++;
        currentQuestionIndex++;
        generateQuestion();
      });
    } else {
      setState(() {
        message = 'You selected wrong option. Right option is ${firstNumber * secondNumber}.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Generate unique options
    Set<int> options = {};
    options.add(firstNumber * secondNumber);

    while (options.length < 4) {
      int option = firstNumber *
          (widget.startingPoint +
              random.nextInt(widget.endingPoint - widget.startingPoint + 1));
      options.add(option);
    }

    List<int> optionsList = options.toList();
    optionsList.shuffle();

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text(
          'Question Screen',
          style: TextStyle(
            fontSize: 22,
            color: Colors.white,
            letterSpacing: 2.5,
            fontWeight: FontWeight.bold,
            shadows: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 2,
                offset: Offset(3, 1),
              ),
            ],
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xff330867),
                Color(0xff30cfd0),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xff30cfd0),
              Color(0xff330867),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: currentQuestionIndex < questionList.length
              ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Questions Remaining: ${questionList.length - currentQuestionIndex}',
                style: kLabelStyle.copyWith(color: Colors.white),
              ),
              SizedBox(height: 30),
              Text(
                '$firstNumber * $secondNumber = ______',
                style: kLabelStyle.copyWith(
                    fontSize: 35, fontWeight: FontWeight.w900),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: optionsList.map((option) {
                  return ElevatedButton(
                    onPressed: () {
                      checkAnswer(option);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      backgroundColor: Colors.orange,
                      textStyle: TextStyle(fontSize: 22),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      '$option',
                      style: kLabelStyle,
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 25),
              if (message != null)
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        message!,
                        style: TextStyle(
                          color: Color(0xffED213A),
                          fontWeight: FontWeight.w900,
                          fontSize: 22,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 20),
                              backgroundColor: Colors.orange,
                              textStyle: kLabelStyle,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: Text(
                              'Generate Table',
                              style: kLabelStyle,
                            ),
                          ),
                          SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                message = null;
                                currentQuestionIndex++;
                                generateQuestion();
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 20),
                              backgroundColor: Colors.green,
                              textStyle: kLabelStyle,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: Text(
                              'Next Question',
                              style: kLabelStyle,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              SizedBox(height: 20),
              Text(
                'Score: $score',
                style: kLabelStyle.copyWith(
                    color: Colors.white, fontSize: 40),
              ),
            ],
          )
              : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  message ??
                      'Quiz Finished! Your final score is $score out of ${questionList.length}.',
                  style: kLabelStyle.copyWith(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    backgroundColor: Colors.orange,
                    textStyle: TextStyle(fontSize: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text('Go to Table Generator',
                      style: kLabelStyle),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
