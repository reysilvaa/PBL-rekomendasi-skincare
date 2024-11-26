// lib/time_based_content.dart

import 'package:flutter/material.dart';

class TimeBasedContent {
  static void updateTimeBasedContent(
      DateTime currentTime,
      Function(String) setGreeting,
      Function(String) setMessage,
      Function(Color) setStartColor,
      Function(Color) setEndColor,
      Function(String) setWeatherIcon) {
    final hour = currentTime.hour;

    if (hour >= 5 && hour < 12) {
      setGreeting('Good Morning');
      setMessage(
          "Start your day with proper skincare.\nDon't forget your sunscreen!");
      setStartColor(const Color(0xFF4B7BEC));
      setEndColor(const Color(0xFF3867D6));
      setWeatherIcon('assets/morning_sun.png');
    } else if (hour >= 12 && hour < 17) {
      setGreeting('Good Afternoon');
      setMessage(
          "Time to reapply your sunscreen!\nStay protected under the sun.");
      setStartColor(const Color(0xFF26de81));
      setEndColor(const Color(0xFF20bf6b));
      setWeatherIcon('assets/sun.png');
    } else if (hour >= 17 && hour < 20) {
      setGreeting('Good Evening');
      setMessage(
          "Don't forget to clean your face\nand apply your evening skincare.");
      setStartColor(const Color(0xFFa55eea));
      setEndColor(const Color(0xFF8854d0));
      setWeatherIcon('assets/evening.png');
    } else {
      setGreeting('Good Night');
      setMessage(
          "Time for your night routine!\nLet your skin repair while you sleep.");
      setStartColor(const Color(0xFF2d3436));
      setEndColor(const Color(0xFF636e72));
      setWeatherIcon('assets/moon.gif');
    }
  }
}
