// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/weather_provider.dart';
// import 'package:weather_app/pages/home_page.dart';
import 'package:weather_app/services/weather_services.dart';

import '../models/weather_model.dart';

// ignore: must_be_immutable
class SearchPage extends StatelessWidget {
  String? cityName;
  VoidCallback? updateUi;

  SearchPage({Key? key, required this.updateUi}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Search A City',
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: TextField(
              onChanged: (data) {
                cityName = data;
              },
              onSubmitted: (data) async {
                cityName = data;
                WeatherService service = WeatherService();
                WeatherModel? weather =
                    await service.getWeatehr(cityNamy: cityName!);
                Provider.of<WeatherProvider>(context, listen: false)
                    .weatherData = weather;
                Provider.of<WeatherProvider>(context, listen: false).cityName =
                    cityName;
                Navigator.pop(context);
              },
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                label: const Text('Search'),
                suffixIcon: GestureDetector(
                  onTap: () async {
                    WeatherService service = WeatherService();
                    WeatherModel? weather =
                        await service.getWeatehr(cityNamy: cityName!);
                    Provider.of<WeatherProvider>(context, listen: false)
                        .weatherData = weather;
                    Provider.of<WeatherProvider>(context, listen: false)
                        .cityName = cityName;
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.search,
                    size: 30,
                  ),
                ),
                border: const OutlineInputBorder(),
                hintText: 'Enter Your City Sir',
              ),
            ),
          ),
        ));
  }
}
