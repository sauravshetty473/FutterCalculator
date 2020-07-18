import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; //MediaQuery.of(context).size.height * 0.50,
import 'package:flutter/painting.dart';

import 'normie.dart';

void main() => runApp(Calculator());

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  var s = "";
  bool move = false;
  bool erase = false;
  bool dynstogg = true;
  bool neveradded = true;
  bool dont = false;
  bool apple = false;
  bool newtoggle = false;

  bool equitoggle = false;
  bool clear = false;
  bool chree = true;
  bool num = false;
  bool dot = false;
  bool bypass = false;
  bool error = false;

  double lastres;

  void dotc() {
    dot = true;
  }

  String dummy;

  List funky = ["/", "*", "+"];
  double result = 0;
  String current;
  String dyns = "";
  var list = List(); //= new List();

  bool character = false;
  bool number = true;
  bool func = false;

  void numbers(String s) {
    if (error) {
      error = false;
    }
    if (chree &&
        num &&
        dot) /////////////////////////////////////////////////////////////
    {
      setdot();
    }
    num = true; /////////////////////////////////////////////////////////////

    if (equitoggle) {
      eqyclear();
      equitoggle = false;
    }
    setState(() {
      if (dynstogg) {
        dyns = "";
        dynstogg = false;
      }

      this.s += s;
      current = this.s;
      dyns += s;
      character = true;
      newtoggle = true;
      print(dyns);
      // listsolve(1);
    });
  }

  int functions(String s) {
    if (newtoggle || equitoggle) {
      if (character && (s == "+" || s == "-" || s == "*" || s == "/")) {
        if (equitoggle) {
          eqyclear();
          list.add(lastres);
          list.add(s);
          this.s = lastres.toString();
          this.s += s;

          equitoggle = false;

          return 0;
        }

        chree = true;
        num = false;
        setState(() {
          neveradded = false;
          if (!apple && !dont) {
            list.add(double.parse(dyns));
            dont = false;
          } else {
            list[list.length - 1] = dyns;
            apple = false;
          }

          character = false;
          this.s += s;
          list.add(s);
          dynstogg = true;

          print(list);
        });
      } else {
        list.add(double.parse(dyns));
        setState(() {
          if (neveradded) {
            if (dyns != "") {
              list.add(double.parse(dyns));

              neveradded = false;
            }
          }

          switch (s) {
            case "back":
              apple = true;
              if (list[list.length - 1] ==
                  ".") ///////////////////////////////////////////////////////
              {
                num = true;
                chree = true;
              }

              if (this.s.length > 0) {
                if (list[list.length - 1] == "+" ||
                    list[list.length - 1] == "-" ||
                    list[list.length - 1] == "/" ||
                    list[list.length - 1] == "*") {
                  list.removeLast();
                  dyns = list[list.length - 1].toString();
                  dont = true;
                } else {
                  dummy = list[list.length - 1].toString();

                  if (dummy.length > 1) {
                    dummy = dummy.substring(0, dummy.length - 1);
                    list[list.length - 1] = double.parse(dummy);
                    dyns = dummy;
                  } else {
                    if (list.length > 1) {
                      list.removeLast();
                    } else {
                      list = List();
                      dyns = "";
                      dummy = "";
                      newtoggle = false;
                      print("done");
                      neveradded = true;
                    }
                  }
                }

                this.s = this.s.substring(0, this.s.length - 1);
              } else {
                this.s = "";
              }

              break;
            case "=":
              clear = false;

              try {
                listclear();
              } catch (e) {
                error = true;
              }

              print(list);
              newtoggle = false;

              equitoggle = true;
              move = true;
              lastres = result;
              break;
          }

          // return Text(s, style: TextStyle(fontSize: 40),);
        });
      }
    }
    return 0;
  }

  void setdot() //////////////////////////////////////////////////
  {
    dyns += ".";
    s += ".";
    dot = false;
    setState(() {});
//  var f = int.parse(dyns);

    chree = false;
  }

  void eqyclear() {
    move = false;
    erase = false;
    dynstogg = true;
    neveradded = true;
    dont = false;
    apple = false;
    newtoggle = false;

    equitoggle = false;
    clear = false;
    chree = true;
    num = false;
    dot = false;
    bypass = false;

    this.s = "";
    dyns = "";
    list = List();
    result = 0;
    newtoggle = false;
    setState(() {
      move = false;
      clear = true;
    });
    // clear =false;
  }

  void listclear() {
    if (list[list.length - 1].runtimeType != int &&
        list[list.length - 1].runtimeType != double) {
      list.removeLast();
    }
    var f = list.lastIndexWhere((value) => value == "-");
    if (f != -1) {
      list[f] = "+";
      list[f + 1] = -list[f + 1];

      listclear();
    } else {
      listsolve(1);
    }
  }

  void listsolve(int i) {
    if (i == 1) {
      var f = list.indexWhere((value) => value == "/");
      if (f != -1) {
        var temp = list[f - 1] / list[f + 1];
        list[f - 1] = temp;
        list.removeAt(f);
        list.removeAt(f);
        listsolve(1);
      } else {
        listsolve(2);
      }
    } else if (i == 2) {
      var f = list.indexWhere((value) => value == "*");
      if (f != -1) {
        var g = list[f - 1] * list[f + 1];

        list[f - 1] = g;

        list.removeAt(f);

        list.removeAt(f);

        listsolve(2);
      } else {
        listsolve(3);
      }
    } else if (i == 3) {
      int num = 0;
      if (list.length != 1) {
        while (num <= list.length - 1) {
          print(result);
          this.result += list[num];
          num += 2;
        }
      } else {
        print("yes");
        print(result);
        this.result = list[0] / 1;
      }

      list = [this.result];
    }
  }

  void animate() {}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: Color(0xffffffff),
            body: Column(
              children: <Widget>[
                Expanded(
                  child: Container(
                      width: double.infinity,
                      color: Colors.black,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          // to expand it

                          AnimatedDefaultTextStyle(
                            child: Text(
                              s,
                              style: TextStyle(color: Colors.deepOrange),
                            ),
                            duration: Duration(milliseconds: 200),
                            style: TextStyle(fontSize: move ? 20 : 45),
                          ),

                          Container(
                            child: AnimatedDefaultTextStyle(
                              child: Text(
                                error
                                    ? "result out of bounds"
                                    : result.round() == result
                                        ? result.round().toString()
                                        : result.toStringAsFixed(3) ==
                                                result.toString()
                                            ? result.toStringAsExponential()
                                            : result.toString(),
                                style: TextStyle(color: Colors.deepOrange),
                              ),
                              duration: !clear
                                  ? Duration(milliseconds: 200)
                                  : Duration(milliseconds: 0),
                              style: TextStyle(fontSize: move ? 45 : 20),
                            ),
                          ),
                        ],
                      )),
                ),
                Normal(numbers, functions, animate, eqyclear, dotc),
              ],
            )));
  }
}
