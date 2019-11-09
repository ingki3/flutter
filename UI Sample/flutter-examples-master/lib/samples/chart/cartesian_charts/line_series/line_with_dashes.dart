import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_examples/model/model.dart';
import 'package:flutter_examples/widgets/flutter_backdrop.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:url_launcher/url_launcher.dart';

class LineDashed extends StatefulWidget {
  const LineDashed(this.sample, {Key key}) : super(key: key);
  final SubItemList sample;

  @override
  _LineDashedState createState() => _LineDashedState(sample);
}

class _LineDashedState extends State<LineDashed> {
   _LineDashedState(this.sample);
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
  void didUpdateWidget(LineDashed oldWidget) {
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
                frontPanelOpenPercentage: 0.35,
                appBarAnimatedLeadingMenuIcon: AnimatedIcons.close_menu,
                appBarActions: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                    child: Container(
                      height: 40,
                      width: 40,
                      child: IconButton(
                        icon: Image.asset(model.codeViewerIcon,
                            color: Colors.white),
                        onPressed: () {
                          launch(
                              'https://github.com/syncfusion/flutter-examples/blob/master/lib/samples/chart/cartesian_charts/line_series/line_with_dashes.dart');
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                    child: Container(
                      height: 40,
                      width: 40,
                      child: IconButton(
                        icon: Image.asset(model.informationIcon,
                            color: Colors.white),
                        onPressed: () {
                          if (frontPanelVisible.value)
                            frontPanelVisible.value = false;
                          else
                            frontPanelVisible.value = true;
                        },
                      ),
                    ),
                  ),
                ],
                appBarTitle: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 1000),
                    child: Text(sample.title.toString())),
                backLayer: BackPanel(sample),
                frontLayer: FrontPanel(sample),
                sideDrawer: null,
                color: model.cardThemeColor,
                headerClosingHeight: 350,
                titleVisibleOnPanelClosed: true,
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
            child: Container(child: getDashedLineChart(false)),
          ));
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

SfCartesianChart getDashedLineChart(bool isTileView) {
  return SfCartesianChart(
    plotAreaBorderWidth: 0,
    title: ChartTitle(
        text: isTileView ? '' : 'Capital investment as a share of exports'),
    legend: Legend(
        isVisible: isTileView ? false : true,
        overflowMode: LegendItemOverflowMode.wrap),
    primaryXAxis: NumericAxis(
        edgeLabelPlacement: EdgeLabelPlacement.shift,
        majorGridLines: MajorGridLines(width: 0),
        interval: 2),
    primaryYAxis: NumericAxis(
        minimum: 3,
        maximum: 21,
        interval: isTileView ? 6 : 3,
        labelFormat: '{value}%',
        axisLine: AxisLine(width: 0),
        majorTickLines: MajorTickLines(color: Colors.transparent)),
    series: getLineSeries(isTileView),
    tooltipBehavior: TooltipBehavior(enable: true),
  );
}

List<LineSeries<_ChartData, num>> getLineSeries(bool isTileView) {
  final List<_ChartData> chartData = <_ChartData>[
    _ChartData(2010, 6.6, 9.0, 15.1, 18.8),
    _ChartData(2011, 6.3, 9.3, 15.5, 18.5),
    _ChartData(2012, 6.7, 10.2, 14.5, 17.6),
    _ChartData(2013, 6.7, 10.2, 13.9, 16.1),
    _ChartData(2014, 6.4, 10.9, 13, 17.2),
    _ChartData(2015, 6.8, 9.3, 13.4, 18.9),
    _ChartData(2016, 7.7, 10.1, 14.2, 19.4),
  ];
  return <LineSeries<_ChartData, num>>[
    LineSeries<_ChartData, num>(
        animationDuration: 2500,
        enableTooltip: true,
        dashArray:<double>[15, 3, 3, 3],
        dataSource: chartData,
        xValueMapper: (_ChartData sales, _) => sales.x,
        yValueMapper: (_ChartData sales, _) => sales.y,
        width: 2,
        name: 'Singapore',
        markerSettings: MarkerSettings(isVisible: true)),
    LineSeries<_ChartData, num>(
        animationDuration: 2500,
        enableTooltip: true,
        dataSource: chartData,
        dashArray: <double>[15, 3, 3, 3],
        width: 2,
        name: 'Saudi Arabia',
        xValueMapper: (_ChartData sales, _) => sales.x,
        yValueMapper: (_ChartData sales, _) => sales.y2,
        markerSettings: MarkerSettings(isVisible: true)),
    LineSeries<_ChartData, num>(
        animationDuration: 2500,
        enableTooltip: true,
        dataSource: chartData,
        width: 2,
        dashArray: <double>[15, 3, 3, 3],
        name: 'Spain',
        xValueMapper: (_ChartData sales, _) => sales.x,
        yValueMapper: (_ChartData sales, _) => sales.y3,
        markerSettings: MarkerSettings(isVisible: true)),
    LineSeries<_ChartData, num>(
        animationDuration: 2500,
        enableTooltip: true,
        dataSource: chartData,
        width: 2,
        dashArray: <double>[15, 3, 3, 3],
        name: 'Portugal',
        xValueMapper: (_ChartData sales, _) => sales.x,
        yValueMapper: (_ChartData sales, _) => sales.y4,
        markerSettings: MarkerSettings(isVisible: true)),
  ];
}

class _ChartData {
  _ChartData(this.x, this.y, this.y2, this.y3, this.y4);
  final double x;
  final double y;
  final double y2;
  final double y3;
  final double y4;
}
