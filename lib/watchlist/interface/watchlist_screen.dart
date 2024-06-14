import 'package:designli/utils/designli_colors.dart';
import 'package:designli/utils/load_status.dart';
import 'package:designli/watchlist/domain/watchlist_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class WatchlistScreen extends StatefulWidget {
  const WatchlistScreen({super.key});

  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  @override
  Widget build(BuildContext context) {
    final watchlistProvider = Provider.of<WatchlistProvider>(context);
    return Scaffold(
      backgroundColor: DesignliColors.blueBackground,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: DesignliColors.blueBackground,
        title: Text(
          'Designli Trader',
          style: GoogleFonts.lato(
            fontWeight: FontWeight.bold,
            color: DesignliColors.magent,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: ValueListenableBuilder(
            valueListenable: watchlistProvider.progress,
            builder: (context, progress, snapshot) {
              return LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey,
                valueColor: const AlwaysStoppedAnimation<Color>(
                  DesignliColors.magent,
                ),
              );
            },
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ValueListenableBuilder(
          valueListenable: watchlistProvider.channel,
          builder: (context, channel, snapshot) {
            return StreamBuilder(
              stream: channel.stream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: DesignliColors.magent,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else if (!snapshot.hasData) {
                  return Center(
                    child: Text(
                      'No data received',
                      style: GoogleFonts.lato(
                        color: Colors.white,
                      ),
                    ),
                  );
                } else {
                  watchlistProvider.handleData(snapshot.data);
                  return ValueListenableBuilder(
                      valueListenable: watchlistProvider.loadStatus,
                      builder: (context, status, snapshot) {
                        return status == LoadStatus.error
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'The symbol you selected has no information available. Please go back and select another one',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                      ),
                                    ),
                                    InkWell(
                                      borderRadius: BorderRadius.circular(20),
                                      onTap: () {
                                        Get.back();
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.only(top: 50),
                                        decoration: BoxDecoration(
                                          color: DesignliColors.magent,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 20),
                                        child: Text(
                                          'Go back',
                                          style: GoogleFonts.poppins(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : ValueListenableBuilder(
                                valueListenable: watchlistProvider.dataPoints,
                                builder: (context, dataPoints, snapshot) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 20),
                                    margin: EdgeInsets.only(
                                      top: 50,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white.withOpacity(
                                        0.08,
                                      ),
                                    ),
                                    height:
                                        MediaQuery.of(context).size.height / 4,
                                    child: LineChart(
                                      LineChartData(
                                        lineBarsData: [
                                          LineChartBarData(
                                            color: DesignliColors.magent,
                                            spots: dataPoints,
                                            isCurved: true,
                                            barWidth: 2,
                                            belowBarData: BarAreaData(
                                              show: true,
                                            ),
                                            dotData: FlDotData(
                                              // getDotPainter: (p0, p1, p2, p3) {
                                              //   return
                                              // },
                                              show: true,
                                              checkToShowDot: (spot, barData) {
                                                return spot == dataPoints.last;
                                              },
                                            ),
                                            curveSmoothness: 0.05,
                                            showingIndicators: [
                                              dataPoints.length - 1
                                            ],
                                          ),
                                        ],
                                        lineTouchData: LineTouchData(
                                          touchTooltipData:
                                              LineTouchTooltipData(
                                            getTooltipItems: (touchedSpots) {
                                              return touchedSpots.map((spot) {
                                                return LineTooltipItem(
                                                  '${spot.y}',
                                                  TextStyle(
                                                      color: Colors.white),
                                                );
                                              }).toList();
                                            },
                                          ),
                                          handleBuiltInTouches: true,
                                        ),
                                        titlesData: FlTitlesData(
                                          show: false,
                                        ),
                                        gridData: FlGridData(
                                          show: false,
                                        ),
                                        borderData: FlBorderData(show: false),
                                      ),
                                      curve: Curves.easeIn,
                                      duration: Duration(milliseconds: 500),
                                    ),
                                  );
                                },
                              );
                      });
                }
              },
            );
          },
        ),
      ),
    );
  }
}
