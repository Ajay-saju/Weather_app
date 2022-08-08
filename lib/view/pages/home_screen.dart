import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weater_app/controller/weather_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final weatherController = Get.put(WeatetController());
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                    'asset/images/Milky-Way-Night-Sky-Mountains-HD-Mobile-Wallpaper.jpg'))),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  weatherController.data!.city.name,
                  style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 4,
                          color: Colors.white)),
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    Text(
                      '${(weatherController.data!.list[0].main.temp - 273).toString().substring(0, 2)}\u00B0',
                      style: GoogleFonts.abel(
                          textStyle: const TextStyle(
                              fontSize: 100,
                              color: Color.fromARGB(
                                100,
                                244,
                                241,
                                241,
                              ),
                              fontWeight: FontWeight.bold,
                              letterSpacing: 4)),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: RotatedBox(
                        quarterTurns: 1,
                        child: RichText(
                          text: TextSpan(
                            text: weatherController
                                .data!.list[0].weather[0].description
                                .toString(),
                            style: GoogleFonts.abel(
                                textStyle: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 4)),
                            children: const [
                              WidgetSpan(
                                child: RotatedBox(
                                    quarterTurns: -1, child: Text('😃')),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                  height: 75,
                  width: 250,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color.fromARGB(100, 246, 239, 239),
                        style: BorderStyle.solid,
                        width: 1.5),
                    color: const Color.fromARGB(49, 244, 240, 240),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                      bottomLeft: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ContainerWidget(
                        content: "Humidity",
                        vlaue:
                            '${weatherController.data!.list[0].main.humidity.toString()}\u0025',
                      ),
                      ContainerWidget(
                          vlaue:
                              '${weatherController.data!.list[0].visibility.toString().substring(0, 2)}Km',
                          content: 'Visibility'),
                      ContainerWidget(
                          vlaue:
                              '${weatherController.data!.list[0].main.seaLevel.toString()}steps',
                          content: 'Sea Level'),
                      TextButton(
                          onPressed: () {
                            weatherController.getWeather();
                          },
                          child: const Icon(
                            Icons.refresh_rounded,
                            size: 40,
                            color: Color.fromARGB(180, 247, 245, 245),
                          ))
                    ],
                  ),
                ),
                const SizedBox(height: 60)
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: CircleAvatar(
        backgroundColor: Colors.cyan,
        radius: 30,
        child: InkWell(
            onTap: () {
              locatonSettings();
            },
            child: const Icon(
              Icons.location_on,
              size: 35,
              color: Colors.black,
            )),
      ),
    );
  }

  locatonSettings()async {
    Future<Position> _determinePosition() async {
      bool serviceEnabled;
      LocationPermission permission;

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return Future.error('Location services are disabled.');
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Future.error('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      return await Geolocator.getCurrentPosition();
    }

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print('================================================================================================');
    print(position.toString());
  }
}

class ContainerWidget extends StatelessWidget {
  final String vlaue;
  final String content;
  const ContainerWidget({
    Key? key,
    required this.vlaue,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 16,
        ),
        Text(
          vlaue,
          style: GoogleFonts.archivo(textStyle: newMethod()),
        ),
        Text(
          content,
          style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
              color: const Color.fromARGB(150, 251, 251, 249)),
        )
      ],
    );
  }

  TextStyle newMethod() {
    return const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        // letterSpacing: 4,
        color: Color.fromARGB(200, 251, 248, 248));
  }
}
