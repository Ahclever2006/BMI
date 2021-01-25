import 'package:BMI_App/result_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:localize_and_translate/localize_and_translate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await translator.init(
    localeDefault: LocalizationDefaultType.device,
    languagesList: <String>['ar', 'en'],
    assetsDirectory: 'Assets/lang/',
    apiKeyGoogle: '<Key>', // NOT YET TESTED
  );

  runApp(
    LocalizedApp(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
      localizationsDelegates: translator.delegates, // Android + iOS Delegates
      locale: translator.locale, // Active locale
      supportedLocales: translator.locals(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentSliderValue = 180;
  int _weight = 60;
  int _age = 27;

  bool malechecked;

  Color inActiveColor = Color.fromARGB(255, 39, 40, 54);
  Color inActiveColorMale = Color.fromARGB(255, 39, 40, 54);
  Color inActiveColorFemale = Color.fromARGB(255, 39, 40, 54);

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      await translator.init(
        localeDefault: LocalizationDefaultType.device,
        languagesList: <String>['ar', 'en'],
        assetsDirectory: 'Assets/lang/',
        apiKeyGoogle: '<Key>', // NOT YET TESTED
      );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 28, 29, 41),
        title: Center(
          child: Text(
            'BMI Calculator',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 171, 173, 181)),
          ),
        ),
      ),
      body: Container(
          padding: EdgeInsets.all(10),
          height: double.infinity,
          width: double.infinity,
          color: Color.fromARGB(255, 28, 29, 41),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            malechecked = true;
                            if (malechecked == true) {
                              inActiveColorMale = Colors.grey[800];
                              inActiveColorFemale =
                                  Color.fromARGB(255, 39, 40, 54);
                            }
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: inActiveColorMale,
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                FontAwesomeIcons.mars,
                                color: Colors.white,
                                size: 70,
                              ),
                              Text(
                                translator.translate('GenderMale'),
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Color.fromARGB(255, 171, 173, 181)),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            malechecked = false;
                            if (malechecked == false) {
                              inActiveColorFemale = Colors.grey[800];
                              inActiveColorMale =
                                  Color.fromARGB(255, 39, 40, 54);
                            }
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: inActiveColorFemale,
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                FontAwesomeIcons.venus,
                                color: Colors.white,
                                size: 70,
                              ),
                              Text(
                                translator.translate('GenderFemale'),
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Color.fromARGB(255, 171, 173, 181)),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(
                        color: inActiveColor,
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              translator.translate('Height'),
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 171, 173, 181)),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Text(
                                  '$_currentSliderValue',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 60,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  ' cm',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color:
                                          Color.fromARGB(255, 171, 173, 181)),
                                ),
                              ],
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width - 40,
                              child: SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                  inactiveTrackColor: Color(0xFF8D8E98),
                                  activeTrackColor: Colors.white,
                                  thumbColor: Color(0xFFEB1555),
                                  overlayColor: Color(0x29EB1555),
                                  thumbShape: RoundSliderThumbShape(
                                      enabledThumbRadius: 15.0),
                                  overlayShape: RoundSliderOverlayShape(
                                      overlayRadius: 30.0),
                                ),
                                child: Slider(
                                  value: _currentSliderValue
                                      .toDouble(), // this will be the current value or the starting value
                                  min: 120, // this will be the minimum value
                                  max: 220, // maximu, value
                                  divisions: 100,

                                  onChanged: (double value) {
                                    // this method took double parameter which will be the new value while moving the slider
                                    setState(() {
                                      _currentSliderValue = value
                                          .toInt(); // we use set state so when we move the slider the new value change the value of slider so the slider move
                                    });
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: inActiveColor,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              translator.translate('Weight'),
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 171, 173, 181)),
                            ),
                            Text(
                              '$_weight',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 60,
                                  fontWeight: FontWeight.bold),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                RawMaterialButton(
                                  elevation: 0.0,
                                  child: Icon(
                                    FontAwesomeIcons.minus,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _weight--;
                                    });
                                  },
                                  constraints: BoxConstraints.tightFor(
                                    width: 56.0,
                                    height: 56.0,
                                  ),
                                  shape: CircleBorder(),
                                  fillColor: Color.fromARGB(255, 171, 173, 181),
                                ),
                                RawMaterialButton(
                                  elevation: 0.0,
                                  child: Icon(
                                    FontAwesomeIcons.plus,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _weight++;
                                    });
                                  },
                                  constraints: BoxConstraints.tightFor(
                                    width: 56.0,
                                    height: 56.0,
                                  ),
                                  shape: CircleBorder(),
                                  fillColor: Color.fromARGB(255, 171, 173, 181),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: inActiveColor,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              translator.translate('Age'),
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 171, 173, 181)),
                            ),
                            Text(
                              '$_age',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 60,
                                  fontWeight: FontWeight.bold),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                RawMaterialButton(
                                  elevation: 0.0,
                                  child: Icon(
                                    FontAwesomeIcons.minus,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _age--;
                                    });
                                  },
                                  constraints: BoxConstraints.tightFor(
                                    width: 56.0,
                                    height: 56.0,
                                  ),
                                  shape: CircleBorder(),
                                  fillColor: Color.fromARGB(255, 171, 173, 181),
                                ),
                                RawMaterialButton(
                                  elevation: 0.0,
                                  child: Icon(
                                    FontAwesomeIcons.plus,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _age++;
                                    });
                                  },
                                  constraints: BoxConstraints.tightFor(
                                    width: 56.0,
                                    height: 56.0,
                                  ),
                                  shape: CircleBorder(),
                                  fillColor: Color.fromARGB(255, 171, 173, 181),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 70,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: FlatButton(
                        child: Text(
                          translator.translate('Calculate'),
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (ctx) {
                            return ResultScreen(
                              height: _currentSliderValue,
                              weight: _weight,
                            );
                          }));
                        },
                        color: Colors.pink,
                      ),
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
