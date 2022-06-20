import 'package:flutter/material.dart';
import 'package:calculator/button.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}
class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var userQuestion = '';
  var userAnswer = '';

  final List<String> buttons = [
    'C','DEL','%','/',
    '7','8','9','*',
    '4','5','6','-',
    '1','2','3','+',
    'ANS','0','.','=',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black38,
      body: Column(
        children: <Widget>[
          Expanded(
            child:  Container(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[

                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            color: Colors.black38,
                            padding: const EdgeInsets.all(20),
                            alignment: Alignment.centerLeft,
                            child: Text(userQuestion,
                              style: const TextStyle(
                                  color: Colors.white,fontSize: 28),
                            ),
                          ),
                        )

                    ),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            color: Colors.black12,
                            padding: const EdgeInsets.all(20),
                            alignment: Alignment.centerRight,
                            child: Text(userAnswer,
                              style: const TextStyle(
                                  color: Colors.white,fontSize: 28),),
                          ),
                        )

                    ),
                  ]


              ),


            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
                child: GridView.builder(itemCount: buttons.length ,gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4), itemBuilder: (BuildContext context,int index){
                  if(index==0){

                    return MyBotton(
                      buttonTapped: (){
                        setState(() {
                          userQuestion='';
                          userAnswer='';
                        });
                      },
                      buttonText: buttons[index],
                      color: Colors.green,
                      textColor: Colors.white ,
                    );
                  }else if(index== 1){
                    return MyBotton(
                      buttonTapped: () {
                        setState(() {
                          userQuestion = userQuestion.substring(0,userQuestion.length-1);
                        });
                      },
                      buttonText: buttons[index],
                      color: Colors.red,
                      textColor: Colors.white ,
                    );
                  }else if(index== buttons.length-1){
                    return MyBotton(
                      buttonTapped: () {
                        setState(() {
                          equelPressed();
                        });
                      },
                      buttonText: buttons[index],
                      color: isOperator(buttons[index]) ?Colors.deepPurple : Colors.deepPurple [50],
                      textColor: isOperator(buttons[index]) ?Colors.white : Colors.deepPurple  ,
                    );
                  }else{
                    return MyBotton(
                      buttonTapped: (){
                        setState(() {
                          userQuestion += buttons[index];
                        });
                      },
                      buttonText: buttons[index],
                      color: isOperator(buttons[index]) ?Colors.deepPurple : Colors.deepPurple [50],
                      textColor:isOperator(buttons[index]) ?Colors.white : Colors.deepPurple ,
                    );
                  }
                })
            ),
          )
        ],
      ),

    );
  }
  bool isOperator(String x){
    if(x=='%' || x=='/' || x=='-'||x=='='||x=='+'||x=='*'){
      return true;
    }
    return false;
  }
  void equelPressed(){
    String finalQuestion = userQuestion;
    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    userAnswer = eval.toString();
  }
}

