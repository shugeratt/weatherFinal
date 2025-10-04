import 'package:flutter/material.dart';
import 'dart:ui';
import '../datasourse/domin/domin.dart';
import '../datasourse/get_data/get_data.dart';

extension StringExtension on String {
  String get capitalize => isNotEmpty ? this[0].toUpperCase() + substring(1).toLowerCase() : this;
}

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final TextEditingController _cityController = TextEditingController(text: 'london');
  WeatherModel? _weather;
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  Future<void> _fetchWeather() async {
    if (_cityController.text.isEmpty) return;
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      _weather = await getdata(_cityController.text);
    } catch (e) {
      _error = e.toString();
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double widthEnforce = screenWidth * 0.05;
    double screenHeight = MediaQuery.of(context).size.height;
    double heightEnforce = screenHeight * 0.03;

    return Scaffold(
      appBar: AppBar(title: Text("WeatherG"),backgroundColor: Colors.orangeAccent,),
      body: Stack(
        children: [
          // Background image
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/1.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Blur effect
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
            child: Container(
              color: Colors.black.withOpacity(0.3),  // overlay تیره برای بهتر دیده شدن متن
            ),
          ),
          // Main content
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _error != null
              ? Center(child: Text(_error!))
              : _weather == null
              ? const Center(child: Text('داده‌ای موجود نیست'))
              : Container(
            padding: EdgeInsets.all(widthEnforce),
            child: Column(
              children: [
                TextField(
                  controller: _cityController,
                  decoration: const InputDecoration(
                    hintText: "Enter your city name",
                    filled: true,
                    suffixIcon: Icon(Icons.search),
                  ),
                  onSubmitted: (_) => _fetchWeather(),
                ),
                Padding(
                  padding: EdgeInsets.only(top: heightEnforce),
                  child: const Text(""),
                ),
                Text('${_weather!.main.temp.toInt()}°', style: const TextStyle(fontSize: 50, color: Colors.white)),
                Text(_weather!.weather[0].description.capitalize, style: const TextStyle(color: Colors.white)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('H: ${_weather!.main.tempMax.toInt()}°', style: const TextStyle(color: Colors.white)),
                    const SizedBox(width: 20),
                    Text('L: ${_weather!.main.tempMin.toInt()}°', style: const TextStyle(color: Colors.white))
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: heightEnforce),
                  child: SizedBox(
                    height: 100,
                    width: double.infinity,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 7,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 100,
                          width: 100,
                          color: Colors.blue[100],
                          child: const Card(
                            child: Column(
                              children: [
                                Text('Day'),
                                Icon(Icons.wb_sunny_outlined),
                                Text('Data'),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: heightEnforce),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Wind: ${_weather!.wind.speed} m/s', style: const TextStyle(color: Colors.white)),
                      Text('Humidity: ${_weather!.main.humidity}%', style: const TextStyle(color: Colors.white)),
                      Text('Pressure: ${_weather!.main.pressure} hPa', style: const TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: heightEnforce * 3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Sunrise: ${_weather!.sys.sunrise}', style: const TextStyle(color: Colors.white)),
                      const SizedBox(width: 10),
                      Text('Sunset: ${_weather!.sys.sunset}', style: const TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
                Image.network(
                  'https://openweathermap.org/img/wn/${_weather!.weather[0].icon}.png',
                  height: 100,
                  width: 100,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}