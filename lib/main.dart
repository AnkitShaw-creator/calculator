import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

import 'buttons.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}


class HomePage extends StatefulWidget{
  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage>{

  final List<String> buttonList =[
    'C', 'DEl', '%', '/',
    '9', '8',   '7', '*',
    '6', '5',   '4', '-',
    '3', '2',   '1', '+',
    '0', '.', 'ANS', '=',
  ];
  var userQuestion='';
  var userAnswer='';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(height: 60,),
                  Container(
                      padding: EdgeInsets.all(30),
                      alignment: Alignment.centerLeft,
                      child: Text(userQuestion,style: TextStyle(fontSize: 18),)
                  ),
                  Container(
                      padding: EdgeInsets.all(30),
                      alignment: Alignment.centerRight,
                      child: Text(userAnswer,style: TextStyle(fontSize: 24)),
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            flex: 2,
            child: Container(
              child: GridView.builder(
                itemCount: buttonList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 1.1,
                  ),
                  itemBuilder: (BuildContext context, int index){

                  //cancel button
                    if(index == 0){
                      return Buttons(
                        buttonTapped: (){
                          setState(() {
                            userQuestion='';
                            userAnswer='';
                          });
                        },
                          color:Colors.green,
                          textColor: Colors.white,
                          buttonText:buttonList[index]
                      );
                    }
                    // DEL button
                    else if(index == 1){
                      return Buttons(
                          buttonTapped: (){
                            setState(() {
                              userQuestion=userQuestion.substring(0,userQuestion.length-1);
                            });
                          },
                          color:Colors.red,
                          textColor: Colors.white,
                          buttonText:buttonList[index]
                      );
                    }
                    //equal button
                    else if(index == 1){
                      return Buttons(
                          buttonTapped: (){
                            setState(() {
                              userAnswer=evaluate();
                            });
                          },
                          color:Colors.deepPurple,
                          textColor: Colors.white,
                          buttonText:buttonList[index]
                      );
                    }

                    else{
                      return Buttons(
                        buttonTapped: (){
                          setState(() {
                            if(index != buttonList.length-1)
                              userQuestion += buttonList[index];
                            else {
                                  userAnswer = evaluate();
                                  userQuestion='';
                                }
                              });
                        },
                          color:isOperator(buttonList[index])?Colors.deepPurple[900]:Colors.deepPurple[50],
                          textColor: isOperator(buttonList[index])?Colors.white:Colors.deepPurple,
                          buttonText:buttonList[index]
                      );
                    }

                  })
            ),
          ),
        ],
      ),
    );
  }

  bool isOperator(String s){
    return (s=='*'|| s=='/'|| s=='%'|| s=='-'|| s=='+'|| s=='=')? true: false;
  }

  String evaluate() {
    String finalQuestion = userQuestion;
    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    return eval.toString();
  }
}

