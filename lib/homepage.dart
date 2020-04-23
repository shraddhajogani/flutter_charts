import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  final Widget child;

  HomePage({Key key, this.child}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Series: list of type that we have to find

  List<charts.Series<Task, String>> _seriesPieData;
  // Define data generation part
  _generateData() {
    // call this function and then define the data
    var pieData = [
      //Add data which displayed in a screen
      new Task('CPU0 usage', 23.4, Colors.green),
      new Task('CPU1 Usage', 27.83, Colors.red),
      new Task('CPU2 Usage', 27.1, Colors.yellow),
      new Task('CPU3 Usage', 27.47, Colors.blue),
      new Task('ALL CPU Usage', 27.83, Colors.red),
    ];
// Now we have data above also create the series now to ensure that this piedata is added into the series
    // So for that use generate data method
    // Inside this we add detais of the graph
    _seriesPieData.add(
      //add chart series
      charts.Series(
          // Define property here data is piedata
          data: pieData,
          domainFn: (Task task, _) => task.task, // X and Y axis
          measureFn: (Task task, _) => task
              .taskvalue, //Property that we use in project  what do we want in X and Y
          colorFn: (Task task, _) =>
              charts.ColorUtil.fromDartColor(task.colorval),
          id: 'CPU Performance of Board',
          labelAccessorFn: (Task row, _) =>
              '${row.taskvalue}' // values inside the graph
          ),
    );
  }

// Until here this is just data we have created but not added to the application
  @override
  void initState() {

    // TODO :implement initState
    super.initState();
    //Initialized the data here
    _seriesPieData = List<
        charts
            .Series<Task, String>>(); // we will use the same data and same list
    // Create a seriespiedata which is series and then we have to generate the data
    // Create function to generate all the data wrt to charts
    _generateData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 1,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blueGrey,
            bottom: TabBar(
              indicatorColor: Colors.blueGrey.shade300,
              tabs: [
               //Tab(
                 //icon: Icon(FontAwesomeIcons.solidChartBar),
                //),
                Tab(icon: Icon(FontAwesomeIcons.chartPie)),
                //Tab(icon: Icon(FontAwesomeIcons.chartLine)),
              ],
            ),
            title: Text('Flutter Charts'),
          ),
          body: TabBarView(
            // Here  We will add the data in App
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Text(
                          'cpu performance of NXP Board',
                          style: TextStyle(
                              fontSize: 24.0, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Expanded(
                          child: charts.PieChart(
                            _seriesPieData,
                            // type of chart  added seriespiechartdata=represent the data
                            animate: true,
                            animationDuration: Duration(seconds: 5),
                            // This function for the animation of the data
                            // TODO To get the text details on a graph and to control the radius of circle add below functions
                            behaviors: [
                              new charts.DatumLegend(
                                outsideJustification:
                                    charts.OutsideJustification.endDrawArea,
                                horizontalFirst: false,
                                desiredMaxRows: 2,
                                cellPadding: new EdgeInsets.only(
                                    right: 4.0, bottom: 4.0),
                                entryTextStyle: charts.TextStyleSpec(
                                    color: charts
                                        .MaterialPalette.purple.shadeDefault,
                                    fontFamily: 'Georgia',
                                    fontSize: 11),
                              ),
                            ],
                            defaultRenderer: new charts.ArcRendererConfig(
                              arcWidth: 100,
                              arcRendererDecorators: [
                                new charts.ArcLabelDecorator(
                                    labelPosition:
                                        charts.ArcLabelPosition.inside // values will be inside the graph
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Create Data Container for pie chart
// 1. Create Class called Task
// 2. Add parameters into class
// 3. Task itself , task value and color value

class Task {
  String task;
  double taskvalue;
  Color colorval;

  // Add Constructor
  Task(this.task, this.taskvalue, this.colorval);
}
// After data container is created we need to define data points which is actual dtaa points before that understand what is series
// Series : Collection of individual data points
// Define the series and the data point and connect series with the data point
// Understand how it displayed on a graph
