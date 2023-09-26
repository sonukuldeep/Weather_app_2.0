import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather2/bloc/weather_bloc_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Text textComponent(String text, FontWeight weight, double size) {
      return Text(
        text,
        style:
            TextStyle(color: Colors.white, fontWeight: weight, fontSize: size),
      );
    }

    Row rowComponent(String image, String text_1, String text_2) {
      return Row(
        children: [
          Image.asset(
            image,
            scale: 8,
          ),
          const SizedBox(
            height: 5,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              textComponent(text_1, FontWeight.w300, 16),
              const SizedBox(
                height: 3,
              ),
              textComponent(text_2, FontWeight.w700, 16)
            ],
          )
        ],
      );
    }

    String getImage(int code) {
      switch (code) {
        case >= 200 && < 300:
          return 'assets/1.png';
        case >= 300 && < 400:
          return 'assets/2.png';
        case >= 500 && < 600:
          return 'assets/3.png';
        case >= 600 && < 700:
          return 'assets/4.png';
        case >= 700 && < 800:
          return 'assets/5.png';
        case == 800:
          return 'assets/6.png';
        case > 800 && <= 804:
          return 'assets/7.png';
        default:
          return 'assets/1.png';
      }
    }

    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          systemOverlayStyle:
              const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
        ),
        body: Padding(
            padding:
                const EdgeInsets.fromLTRB(40, 1.2 * kToolbarHeight, 40, 20),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  Align(
                    alignment: const AlignmentDirectional(8.5, -0.3),
                    child: Container(
                      height: 300,
                      width: 300,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.deepPurple),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-8.5, -0.3),
                    child: Container(
                      height: 300,
                      width: 300,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Color(0xFF673A87)),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(0, -1.8),
                    child: Container(
                      height: 300,
                      width: 300,
                      decoration: const BoxDecoration(color: Color(0xFFFFAB40)),
                    ),
                  ),
                  // this is where blur magic happens
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
                    child: Container(
                      decoration:
                          const BoxDecoration(color: Colors.transparent),
                    ),
                  ),
                  BlocBuilder<WeatherBlocBloc, WeatherBlocState>(
                    builder: (context, state) {
                      if (state is WeatherBlocSuccess) {
                        return SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              textComponent('📍 ${state.weather.areaName}',
                                  FontWeight.w300, 16),

                              textComponent(
                                  'Good Morning', FontWeight.bold, 25),
                              Expanded(
                                child: Center(
                                  child: Image.asset(
                                    getImage(
                                        state.weather.weatherConditionCode!),
                                  ),
                                ),
                              ),
                              Center(
                                child: textComponent(
                                    '${state.weather.temperature?.celsius?.toInt()} °C',
                                    FontWeight.w600,
                                    55),
                              ),
                              Center(
                                child: textComponent(
                                    '${state.weather.weatherMain?.toUpperCase()}',
                                    FontWeight.w500,
                                    25),
                              ),
                              const SizedBox(height: 5),
                              Center(
                                child: textComponent(
                                    DateFormat('EEEE dd •')
                                        .add_jm()
                                        .format(state.weather.date!),
                                    FontWeight.w300,
                                    16),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              // first row
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  rowComponent(
                                      'assets/11.png',
                                      'Sunrise',
                                      DateFormat()
                                          .add_jm()
                                          .format(state.weather.date!)),
                                  rowComponent(
                                      'assets/12.png',
                                      'Sunset',
                                      DateFormat()
                                          .add_jm()
                                          .format(state.weather.date!)),
                                ],
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.0),
                                child: Divider(
                                  color: Colors.grey,
                                ),
                              ),
                              // 2nd row
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  rowComponent('assets/13.png', 'Temp Max',
                                      '${state.weather.tempMax?.celsius?.toInt()} °C'),
                                  rowComponent('assets/14.png', 'Temp Min',
                                      '${state.weather.tempMin?.celsius?.toInt()} °C'),
                                ],
                              ),
                            ],
                          ),
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  )
                ],
              ),
            )));
  }
}
