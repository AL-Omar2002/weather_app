import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/pages/search_page.dart';
import 'package:weather_app/providers/weather_provider.dart';
import '../models/weather_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeatherModel? weatherData;

  void updateUi() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    weatherData = Provider.of<WeatherProvider>(context).weatherData;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SearchPage(updateUi: updateUi);
              }));
            },
            icon: const Icon(Icons.search),
          ),
        ],
        title: const Text('Weather App'),
      ),
      body: weatherData == null
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    'No Weather Data Yet😔',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  Text(
                    'Searching Now👀',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
            )
          : Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: [
                  weatherData!.getThemeColor()[700]!,
                  weatherData!.getThemeColor(),
                  weatherData!.getThemeColor()[400]!,
                  weatherData!.getThemeColor()[200]!,
                  weatherData!.getThemeColor()[100]!,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )),
              child: Column(
                children: [
                  const Spacer(flex: 2),
                  Text(
                    Provider.of<WeatherProvider>(context).cityName!,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    // print(DateTime.now().hour.toString() + ":" + DateTime.now().minute.toString());
                    'Updated At: ${DateTime.now().hour}:${DateTime.now().minute}',
                    style: const TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  const Spacer(flex: 1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(weatherData!.getImage()),
                      Text(
                        weatherData!.avgTemp.toInt().toString(),
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Column(
                        children: [
                          Text('max Temp: ${weatherData!.maxTemp.toInt()}'),
                          Text('min Temp: ${weatherData!.minTemp.toInt()}'),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(flex: 1),
                  Text(
                    weatherData!.weatherStateName,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(flex: 6),
                ],
              )),
    );
  }
}
