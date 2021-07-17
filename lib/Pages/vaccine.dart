import 'package:flutter/material.dart';
import 'package:pa3/Pages/menu.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:pa3/Pages/countryV_model.dart';
import 'package:pa3/Pages/func.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';


Future<CountryVList> fetchCoronaV() async {
  String url = "https://raw.githubusercontent.com/owid/covid-19-data/master/public/data/vaccinations/vaccinations.json";
  final response = await http.get(url);

  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    //print(data);
    return CountryVList.fromJson(data);
  } else { throw Exception('Failed to load country(V)');}
}



String dateK;

class Vaccine extends StatelessWidget{
  final Map<String, String> arguments;
  Vaccine({Key key, @required this.arguments}) : super(key: key);

  void sortList(List<Country> list){
    list.sort((a, b) => (b.data[b.data.length-1].totalV == null ? 0:b.data[b.data.length-1].totalV).compareTo((a.data[a.data.length-1].totalV == null ? 0:a.data[a.data.length-1].totalV)));
  }


  @override
  Widget build(BuildContext context) {
    ChartProvider chart = Provider.of<ChartProvider>(context);
    TableProvider table = Provider.of<TableProvider>(context);
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container( //FIRST BOX
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 3,
                ),
                borderRadius: BorderRadius.all(Radius.circular(10.0),),
              ),
              padding: const EdgeInsets.all(10.0),
              width: 350,
              child: FutureBuilder<CountryVList>(
                future: fetchCoronaV(),
                builder: (context, snapshot){
                  if (snapshot.hasData) {
                    //String date;
                    final Func f = Func();
                    int totalVacc = 0;
                    int fullVacc = 0;
                    int dailyVacc = 0;
                    int dateIndex;

                    List<Country> countryList = snapshot.data.countries;

                    for(int c = 0; c < countryList.length; c++){
                      if(countryList[c].country == "South Korea"){
                        dateK = countryList[c].data[countryList[c].data.length-1].date;
                        dateIndex = c;

                      }
                    }
                    for(int c = 0; c < countryList.length; c++){
                      int index;
                      index = countryList[c].data.indexWhere((d) => d.date == dateK);
                      int len = countryList[c].data.length;

                      totalVacc += f.funcCountTotal(countryList[c], index, len, 0);
                      fullVacc += f.funcCountFully(countryList[c], index, len, 0);
                      dailyVacc += f.funcCountDaily(countryList[c], index, len, 0);

                    }
                    String totalStr = totalVacc.toString();
                    String fullStr = fullVacc.toString();
                    String dailyStr = dailyVacc.toString();

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('Total Vacc.'),
                                SizedBox(height: 5.0,),
                                Text(totalStr +' people'),
                                SizedBox(height: 5.0,),
                                Text('Total fully Vacc.'),
                                SizedBox(height: 5.0,),
                                Text(fullStr+' people'),],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text('Parsed latest date'),
                                SizedBox(height: 5.0,),
                                Text(dateK),
                                SizedBox(height: 5.0,),
                                Text('Daily Vacc.'),
                                SizedBox(height: 5.0,),
                                Text(dailyStr+' people'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                  else if(snapshot.hasError){
                    return Text("${snapshot.error}");
                  }
                  return CircularProgressIndicator();
                  },
              ),
            ),
            Container( //SECOND BOX
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 3,
                ),
                borderRadius: BorderRadius.all(Radius.circular(10.0),),
              ),
              width: 350,
              height: 300,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () => chart.changeState(1),
                        child: Text("Graph1",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () => chart.changeState(2),
                        child: Text("Graph2",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () => chart.changeState(3),
                        child: Text("Graph3",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () => chart.changeState(4),
                        child: Text("Graph4",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 3,
                    color: Colors.grey,
                  ),
                  Consumer<ChartProvider>(
                      builder: (context, counter, child) => FutureBuilder<CountryVList>(
                        future: fetchCoronaV(),
                        builder: (context, snapshot){
                          double interval = 1;
                          if (snapshot.hasData) {
                            List<Country> countryList = snapshot.data.countries;
                            //var spots = <FlSpot>[];
                            List<String> dateStr = [];
                            List<double> num = [];
                            String tmpStr;
                            double tmpVal;
                            int index;
                            int len;
                            int dateIndex;
                            double min;
                            Func f = new Func();


                            for(int c = 0; c < countryList.length; c++){
                              if(countryList[c].country == "South Korea"){
                                dateIndex = c;
                              }
                            }

                            if(chart.state == 1 || chart.state == 2){
                              dateStr.clear();
                              num.clear();
                              var spots = <FlSpot>[];
                              for(int h = 7; h > 0; h--){
                                tmpStr = countryList[dateIndex].data[countryList[dateIndex].data.length - h].date;

                                tmpVal = 0;
                                for(int t = 0; t < countryList.length; t++){
                                  index = countryList[t].data.indexWhere((d) => d.date == tmpStr);
                                  len = countryList[t].data.length;
                                  if(chart.state == 1){ //7days, total val
                                    tmpVal += f.funcCountTotal(countryList[t], index, len, 1)/1000000000;

                                  }
                                  else if (chart.state == 2){// 7days, daily val
                                    tmpVal += f.funcCountDaily(countryList[t], index, len, 1)/1000000000;

                                  }
                                }

                                dateStr.add(tmpStr);
                                num.add(tmpVal);
                              }
                              min = num[0];
                              for(int k = 0; k < 7; k++){
                                if(min>num[k]) min = num[k];
                                spots.add(FlSpot(k.toDouble(), num[k]));
                              }
                              if(chart.state == 1) interval = 0.2;
                              else interval = 0.0025;

                              //chart.changeState(1);

                              return SizedBox(
                                    width: 300,
                                    height: 200,
                                    child: LineChart(
                                      LineChartData(
                                        lineTouchData: LineTouchData(enabled: false),
                                        lineBarsData: [
                                          LineChartBarData(
                                            colors: [
                                              Colors.blueAccent,],
                                        spots: spots,
                                        isCurved: false,
                                        //isStrokeCapRound: false,
                                        barWidth: 5,
                                        belowBarData: BarAreaData(
                                          show: false,
                                        ),
                                        dotData: FlDotData(
                                          show: true,
                                          getDotPainter: (spot, percent, barData, index) =>
                                              FlDotCirclePainter(radius: 5,
                                                  color: Colors.blueAccent.withOpacity(0.5)),
                                        ),
                                      ),
                                    ],
                                        minY: min-interval,
                                    titlesData: FlTitlesData(
                                      bottomTitles: SideTitles(
                                        showTitles: true,
                                        interval: 1,
                                        getTitles: (value) {
                                          List<String> strL = dateStr[value.toInt()].split('-');
                                          String str = strL[1]+'-'+strL[2];
                                          return str;
                                          },
                                        getTextStyles: (value) => const TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10,
                                        ),
                                        //margin: 16,
                                        ),
                                      leftTitles: SideTitles(
                                        showTitles: true,
                                        interval: interval,
                                        reservedSize: 30,
                                        getTitles: (double value) {
                                          String tmpS = value.toStringAsFixed(2)+"B";
                                          return tmpS;
                                          },
                                        getTextStyles: (value) => const TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10,
                                        ),
                                            //margin: 16,
                                      ),
                                    ),
                                    gridData: FlGridData(
                                        show: true,
                                        drawHorizontalLine: true,
                                        horizontalInterval: interval,
                                        checkToShowHorizontalLine: (value) {
                                          return true;
                                        }),
                                    borderData: FlBorderData(
                                      show: true,
                                      border: const Border(
                                        left: BorderSide(color: Colors.grey),
                                        bottom: BorderSide(color: Colors.grey),
                                        top: BorderSide(color: Colors.transparent),
                                        right: BorderSide(color: Colors.transparent),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }

                            else{
                              dateStr.clear();
                              num.clear();
                              var spots = <FlSpot>[];
                              for(int h = 28; h > 0; h--){
                                tmpStr = countryList[dateIndex].data[countryList[dateIndex].data.length - h].date;
                                tmpVal = 0;
                                for(int t = 0; t < countryList.length; t++){
                                  index = countryList[t].data.indexWhere((d) => d.date == tmpStr);
                                  len = countryList[t].data.length;
                                  if(chart.state == 3){
                                    tmpVal += f.funcCountTotal(countryList[t], index, len, 1)/1000000000;
                                  }
                                  else if (chart.state == 4){
                                    tmpVal += f.funcCountDaily(countryList[t], index, len, 1)/1000000000;
                                  }
                                }
                                dateStr.add(tmpStr);
                                num.add(tmpVal.toDouble());
                              }
                              min = num[0];
                              for(int k = 0; k < 28; k++){
                                if(min>num[k]) min = num[k];
                                spots.add(FlSpot(k.toDouble(), num[k]));
                              }
                              if(chart.state == 3) interval = 0.5;
                              else interval = 0.005;

                              //chart.changeState(1);

                              return SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: SizedBox(
                                  width: 300,
                                  height: 200,
                                  child: LineChart(
                                      LineChartData(
                                        lineTouchData: LineTouchData(enabled: false),
                                        lineBarsData: [
                                          LineChartBarData(
                                            colors: [
                                              Colors.blueAccent,
                                            ],
                                            spots: spots,
                                            isCurved: false,
                                            //isStrokeCapRound: true,
                                            barWidth: 5,
                                            belowBarData: BarAreaData(
                                              show: false,
                                            ),
                                            dotData: FlDotData(
                                              show: true,
                                              getDotPainter: (spot, percent, barData, index) =>
                                                  FlDotCirclePainter(radius: 5,
                                                      color: Colors.blueAccent.withOpacity(0.5)),
                                            ),
                                          ),
                                        ],
                                        minY: min-interval,
                                        titlesData: FlTitlesData(
                                          bottomTitles: SideTitles(
                                            showTitles: true,
                                            interval: 9,
                                            getTitles: (value) {
                                              List<String> strL = dateStr[value.toInt()].split('-');
                                              String str = strL[1]+'-'+strL[2];
                                              return str;
                                            },
                                            getTextStyles: (value) =>
                                            const TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold,fontSize: 10,),
                                            //margin: 16,
                                          ),
                                          leftTitles: SideTitles(
                                            showTitles: true,
                                            interval: interval,
                                            reservedSize: 30,
                                            getTitles: (double value) {
                                              String tmpS = value.toStringAsFixed(2)+"B";
                                              //'${value + 0.5}'
                                              return tmpS;
                                            },
                                            getTextStyles: (value) =>
                                            const TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold,fontSize: 10,),
                                            //margin: 16,
                                          ),
                                        ),
                                        gridData: FlGridData(
                                            show: true,
                                            drawHorizontalLine: true,
                                            horizontalInterval: interval,
                                            checkToShowHorizontalLine: (value) {
                                              return true;
                                            }),
                                        borderData: FlBorderData(
                                          show: true,
                                          border: const Border(
                                            left: BorderSide(color: Colors.grey),
                                            bottom: BorderSide(color: Colors.grey),
                                            top: BorderSide(color: Colors.transparent),
                                            right: BorderSide(color: Colors.transparent),
                                          ),
                                        ),
                                      ),
                                  ),
                              ),
                              );
                            }

                          }
                          else if(snapshot.hasError){
                            return Text("${snapshot.error}");
                          }
                          return CircularProgressIndicator();
                        },
                      ),


                    ),

                ],
              ),
            ),
            Container( //THRID BOX
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 3,
                ),
                borderRadius: BorderRadius.all(Radius.circular(10.0),),
              ),
              width: 350,
              height: 240,
              //height: 250,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () => table.changeState(1),
                        child: Text("Country_name",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () => table.changeState(2),
                        child: Text("Total_vacc",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 3,
                    color: Colors.grey,
                  ),

                  Expanded(child: Consumer<TableProvider>(
                    builder: (context, counter, child) => FutureBuilder<CountryVList>(
                      future: fetchCoronaV(),
                      builder: (context, snapshot){
                        if (snapshot.hasData) {
                          if(table.state == 1){ sortList(snapshot.data.countries);}
                          List<int> idxList = [];
                          int idx, len;
                          for(int i = 0; i<7; i++){
                            idx = snapshot.data.countries[i].data.indexWhere((d) => d.date == dateK);
                            int len = snapshot.data.countries[i].data.length;
                            if(idx < 0){ idx = len-1; }
                            idxList.add(idx);
                          }

                          return ListView(
                            padding: EdgeInsets.zero,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            children: [
                                HeaderTile(),
                                TableTile(snapshot.data.countries[0], idxList[0]),
                                TableTile(snapshot.data.countries[1], idxList[1]),
                                TableTile(snapshot.data.countries[2], idxList[2]),
                                TableTile(snapshot.data.countries[3], idxList[3]),
                                TableTile(snapshot.data.countries[4], idxList[4]),
                                TableTile(snapshot.data.countries[5], idxList[5]),
                                TableTile(snapshot.data.countries[6], idxList[6]),
                              ],
                          );
                        }
                        else if(snapshot.hasError){
                          return Text("${snapshot.error}");
                        }
                        return CircularProgressIndicator();
                      },
                    ),
                  ),
                  ),

                ],
              ),
              ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          chart.changeState(1);
          Navigator.push( context,
            MaterialPageRoute(
                builder: (context) => Menu(arguments: {"id": arguments["id"], "page": "Vaccine", })
            ),
          );
        },
        child: Icon(Icons.list),
      ),
    );
  }
}

class ChartProvider with ChangeNotifier{
  int _cnt;
  int state = 1;
  get cnt => _cnt;
  ChartProvider();
  void changeState(int k){
    switch(k){
      case 1:
        state = 1;
        break;
      case 2:
        state = 2;
        break;
      case 3:
        state = 3;
        break;
      default:
        state = 4;
        break;
    }
    notifyListeners();
  }
}


class TableProvider with ChangeNotifier{
  int _cnt;
  int state = 0;
  get cnt => _cnt;
  TableProvider();
  void changeState(int k){
    if(k == 1){
      state = 0;
    }
    else{
      state = 1;
    }
    notifyListeners();
  }
}

class HeaderTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Container(
        width: 330,
        height: 14,
        child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Country",
          style: TextStyle(
            fontSize: 14,
          ),),
          Text("Total",
            style: TextStyle(
              fontSize: 14,
            ),),
          Text("Fully",
            style: TextStyle(
              fontSize: 14,
            ),),
          Text("Daily",
            style: TextStyle(
              fontSize: 14,
            ),),
        ],
      ),
      ),
    );
  }
}

class TableTile extends StatelessWidget {
  Country _country;
  int _idx;
  TableTile(this._country, this._idx);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Container(
        width: 330,
        height: 15,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(_country.country,
              style: TextStyle(
                fontSize: 13,
              ),),
            Text(_country.data[_idx].totalV.toString(),
              style: TextStyle(
                fontSize: 13,
              ),),
            Text(_country.data[_idx].peopleFullV.toString(),
              style: TextStyle(
                fontSize: 13,
              ),),
            Text(_country.data[_idx].dailyV.toString(),
              style: TextStyle(
                fontSize: 13,
              ),),
          ],
        ),
      ),
    );
  }
}

class TableRow extends StatelessWidget {
  Country _country;
  int _idx;
  TableRow(this._country, this._idx);

  @override
  Widget build(BuildContext context) {
    return Consumer<TableProvider>(
      builder: (context, value, child) => Container(
        child: ListTile(
          title: Container(
            width: 330,
            height: 15,
            child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(_country.country,
                style: TextStyle(
                  fontSize: 13,
                ),),
              Text(_country.data[_idx].totalV.toString(),
                style: TextStyle(
                  fontSize: 13,
                ),),
              Text(_country.data[_idx].peopleFullV.toString(),
                style: TextStyle(
                  fontSize: 13,
                ),),
              Text(_country.data[_idx].dailyV.toString(),
                style: TextStyle(
                  fontSize: 13,
                ),),
            ],
          ),
          ),
        ),
      ),
    );
  }
}
