import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_examples/model/model.dart';
import 'package:flutter_examples/widgets/flutter_backdrop.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:url_launcher/url_launcher.dart';

class ScatterDefault extends StatefulWidget {
  const ScatterDefault(this.sample, {Key key}) : super(key: key);
  final SubItemList sample;

  @override
  _ScatterDefaultState createState() => _ScatterDefaultState(sample);
}

class _ScatterDefaultState extends State<ScatterDefault> {
  _ScatterDefaultState(this.sample);
  final SubItemList sample;

  bool panelOpen;
  final ValueNotifier<bool> frontPanelVisible = ValueNotifier<bool>(true);

  @override
  void initState() {
    panelOpen = frontPanelVisible.value;
    frontPanelVisible.addListener(_subscribeToValueNotifier);
    super.initState();
  }

  void _subscribeToValueNotifier() => panelOpen = frontPanelVisible.value;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didUpdateWidget(ScatterDefault oldWidget) {
    super.didUpdateWidget(oldWidget);
    frontPanelVisible.removeListener(_subscribeToValueNotifier);
    frontPanelVisible.addListener(_subscribeToValueNotifier);
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<SampleListModel>(
        builder: (BuildContext context, _, SampleListModel model) => SafeArea(
              child: Backdrop(
                needCloseButton: false,
                panelVisible: frontPanelVisible,
                sampleListModel: model,
                frontPanelOpenPercentage: 0.28,
                toggleFrontLayer: false,
                appBarAnimatedLeadingMenuIcon: AnimatedIcons.close_menu,
                appBarActions: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Container(
                      height: 40,
                      width: 40,
                      child: IconButton(
                        icon: Image.asset(model.codeViewerIcon,
                            color: Colors.white),
                        onPressed: () {
                          launch(
                              'https://github.com/syncfusion/flutter-examples/blob/master/lib/samples/chart/cartesian_charts/scatter_series/default_scatter_chart.dart');
                        },
                      ),
                    ),
                  ),
                ],
                appBarTitle: AnimatedSwitcher(
                    duration: Duration(milliseconds: 1000),
                    child: Text(sample.title.toString())),
                backLayer: BackPanel(sample),
                frontLayer: FrontPanel(sample),
                sideDrawer: null,
                headerClosingHeight: 350,
                titleVisibleOnPanelClosed: true,
                color: model.cardThemeColor,
                borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12), bottom: Radius.circular(0)),
              ),
            ));
  }
}

class FrontPanel extends StatefulWidget {
//ignore:prefer_const_constructors_in_immutables
  FrontPanel(this.subItemList);
  final SubItemList subItemList;

  @override
  _FrontPanelState createState() => _FrontPanelState(subItemList);
}

class _FrontPanelState extends State<FrontPanel> {
  _FrontPanelState(this.sample);
  final SubItemList sample;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<SampleListModel>(
        rebuildOnChange: true,
        builder: (BuildContext context, _, SampleListModel model) {
          return Scaffold(
            backgroundColor: model.cardThemeColor,
              body: Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 5, 50),
                child: Container(child: getDefaultScatterChart(false)),
              ),
              floatingActionButton: Stack(children: <Widget>[
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(30, 50, 0, 0),
                    child: Container(
                      height: 50,
                      width: 250,
                      child: InkWell(
                        onTap: () => launch(
                            'https://tcdata360.worldbank.org/indicators/ex.grw?country=BRA&indicator=401&countries=IND,CAN&viz=line_chart&years=2013Q2,2016Q2'),
                        child: Row(
                          children: <Widget>[
                            Text('Source: ',
                                style: TextStyle(
                                    fontSize: 16, color: model.textColor)),
                            Text('tcdata360.worldbank.org',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.blue)),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ]));
        });
  }
}

class BackPanel extends StatefulWidget {
 //ignore:prefer_const_constructors_in_immutables
  BackPanel(this.sample);
  final SubItemList sample;

  @override
  _BackPanelState createState() => _BackPanelState(sample);
}

class _BackPanelState extends State<BackPanel> {
  _BackPanelState(this.sample);
  final SubItemList sample;
  final GlobalKey _globalKey = GlobalKey();
  
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
    super.initState();
  }

  void _afterLayout(dynamic _) {
    _getSizesAndPosition();
  }

  void _getSizesAndPosition() {
    final RenderBox renderBoxRed = _globalKey.currentContext.findRenderObject();
    final Size size = renderBoxRed.size;
    final Offset position = renderBoxRed.localToGlobal(Offset.zero);
    const double appbarHeight = 60;
    BackdropState.frontPanelHeight =
        position.dy + (size.height - appbarHeight) + 20;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<SampleListModel>(
      rebuildOnChange: true,
      builder: (BuildContext context, _, SampleListModel model) {
        return Container(
          color: model.backgroundColor,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  sample.title,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28.0,
                      color: Colors.white,
                      letterSpacing: 0.53),
                ),
                Padding(
                  key: _globalKey,
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Text(
                    sample.description,
                    style: const TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 15.0,
                        color: Colors.white,
                        letterSpacing: 0.3,
                        height: 1.5),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

SfCartesianChart getDefaultScatterChart(bool isTileView) {
  return SfCartesianChart(
    plotAreaBorderWidth: 0,
    title: ChartTitle(text: isTileView ? '' : 'Export growth rate'),
    legend: Legend(isVisible: isTileView ? false : true),
    primaryXAxis: DateTimeAxis(
      labelIntersectAction: AxisLabelIntersectAction.multipleRows,
      majorGridLines: MajorGridLines(width: 0),
    ),
    primaryYAxis: NumericAxis(
        labelFormat: '{value}%',
        axisLine: AxisLine(width: 0),
        minorTickLines: MinorTickLines(size: 0)),
    tooltipBehavior: TooltipBehavior(enable: true),
    series: getScatterSeries(isTileView),
  );
}

List<ScatterSeries<_ScatterData, DateTime>> getScatterSeries(bool isTileView) {
  final List<_ScatterData> chartData = <_ScatterData>[
    _ScatterData( DateTime(2006, 1, 1), 0.01, -0.03, 0.10),
    _ScatterData( DateTime(2007, 1, 1), 0.03, -0.02, 0.08),
    _ScatterData( DateTime(2008, 1, 1), -0.06, -0.13, -0.03),
    _ScatterData( DateTime(2009, 1, 1), -0.03, -0.04, 0.04),
    _ScatterData( DateTime(2010, 1, 1), 0.09, 0.07, 0.19),
    _ScatterData( DateTime(2011, 1, 1), 0, 0.04, 0),
    _ScatterData( DateTime(2012, 1, 1), 0.01, -0.01, -0.09),
    _ScatterData( DateTime(2013, 1, 1), 0.05, 0.05, 0.10),
    _ScatterData( DateTime(2014, 1, 1), 0, 0.08, 0.05),
    _ScatterData( DateTime(2015, 1, 1), 0.1, 0.01, -0.04),
    _ScatterData( DateTime(2016, 1, 1), 0.08, 0, 0.02),
  ];
  return <ScatterSeries<_ScatterData, DateTime>>[
    ScatterSeries<_ScatterData, DateTime>(
        enableTooltip: true,
        dataSource: chartData,
        opacity: 0.7,
        xValueMapper: (_ScatterData sales, _) => sales.year,
        yValueMapper: (_ScatterData sales, _) => sales.y,
        markerSettings: MarkerSettings(height: 15, width: 15),
        name: 'Brazil'),
    ScatterSeries<_ScatterData, DateTime>(
        enableTooltip: true,
        opacity: 0.7,
        dataSource: chartData,
        xValueMapper: (_ScatterData sales, _) => sales.year,
        yValueMapper: (_ScatterData sales, _) => sales.y1,
        markerSettings: MarkerSettings(height: 15, width: 15),
        name: 'Canada'),
    ScatterSeries<_ScatterData, DateTime>(
      enableTooltip: true,
      dataSource: chartData,
      color: const Color.fromRGBO(0, 168, 181, 1),
      xValueMapper: (_ScatterData sales, _) => sales.year,
      yValueMapper: (_ScatterData sales, _) => sales.y2,
      name: 'India',
      markerSettings: MarkerSettings(height: 15, width: 15),
    )
  ];
}

class _ScatterData {
  _ScatterData(this.year, this.y, this.y1, this.y2);
  final DateTime year;
  final double y;
  final double y1;
  final double y2;
}
