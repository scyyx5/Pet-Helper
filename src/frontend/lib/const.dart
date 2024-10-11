import 'package:flutter/material.dart';

String net = "https://pethelper.bham.team:8000";
//String net = "http://10.0.2.2:8000";
String and = "http://127.0.0.1:8000";

//Red
const a1 = Color.fromARGB(255, 3, 7, 30);
const a2 = Color.fromARGB(255, 55, 6, 23);
const a3 = Color.fromARGB(255, 106, 4, 14);
const a4 = Color.fromARGB(255, 157, 2, 7);
const a5 = Color.fromARGB(255, 208, 0, 0);
const a6 = Color.fromARGB(255, 220, 46, 2);
const a7 = Color.fromARGB(255, 232, 91, 4);
const a8 = Color.fromARGB(255, 244, 141, 6);
const a9 = Color.fromARGB(255, 250, 165, 7);
const a10 = Color.fromARGB(255, 255, 185, 8);

//Green
const b1 = Color.fromARGB(255, 3, 102, 102);
const b2 = Color.fromARGB(255, 20, 116, 111);
const b3 = Color.fromARGB(255, 36, 130, 119);
const b4 = Color.fromARGB(255, 53, 143, 128);
const b5 = Color.fromARGB(255, 70, 157, 137);
const b6 = Color.fromARGB(255, 86, 171, 146);
const b7 = Color.fromARGB(255, 103, 185, 153);
const b8 = Color.fromARGB(255, 120, 198, 163);
const b9 = Color.fromARGB(255, 136, 212, 171);
const b10 = Color.fromARGB(255, 153, 226, 180);

//Blue
const c1 = Color.fromARGB(255, 3, 5, 94);
const c2 = Color.fromARGB(255, 2, 61, 138);
const c3 = Color.fromARGB(255, 0, 118, 182);
const c4 = Color.fromARGB(255, 0, 149, 199);
const c5 = Color.fromARGB(255, 0, 180, 216);
const c6 = Color.fromARGB(255, 72, 202, 228);
const c7 = Color.fromARGB(255, 144, 225, 239);
const c8 = Color.fromARGB(255, 173, 232, 244);
const c9 = Color.fromARGB(255, 202, 240, 248);

//purple
const d1 = Color.fromARGB(255, 247, 37, 132);
const d2 = Color.fromARGB(255, 181, 23, 157);
const d3 = Color.fromARGB(255, 113, 9, 183);
const d4 = Color.fromARGB(255, 87, 11, 173);
const d5 = Color.fromARGB(255, 72, 12, 168);
const d6 = Color.fromARGB(255, 57, 12, 163);
const d7 = Color.fromARGB(255, 62, 55, 201);
const d8 = Color.fromARGB(255, 67, 98, 238);
const d9 = Color.fromARGB(255, 72, 150, 239);
const d10 = Color.fromARGB(255, 76, 202, 240);

//light purple
const e1 = Color.fromARGB(255, 249, 12, 115);
const e2 = Color.fromARGB(255, 216, 10, 99);
const e3 = Color.fromARGB(255, 182, 8, 83);
const e4 = Color.fromARGB(255, 149, 6, 70);
const e5 = Color.fromARGB(255, 115, 4, 56);
const e6 = Color.fromARGB(255, 82, 2, 41);
const e7 = Color.fromARGB(255, 48, 0, 26);

const f1 = Color.fromARGB(255, 204, 204, 204);
const f2 = Color.fromARGB(255, 255, 255, 255);
const whitex = Color.fromARGB(213, 255, 255, 255);
const darkx = Color.fromARGB(255, 39, 39, 39);
const darkxsolid = Color.fromARGB(255, 27, 27, 27);

ColorFilter ColorBlindMode(String mode) {
  if (mode == "None") {
    return None;
  } else if (mode == "Protanopia") {
    return Protanopia;
  } else if (mode == "Protanomaly") {
    return Protanomaly;
  } else if (mode == "Deuteranopia") {
    return Deuteranopia;
  } else if (mode == "Deuteranomaly") {
    return Deuteranomaly;
  } else if (mode == "Tritanopia") {
    return Tritanopia;
  } else if (mode == "Tritanomaly") {
    return Tritanomaly;
  } else {
    return Achromatopsia;
  }
}

const ColorFilter None = ColorFilter.matrix([
  1,
  0,
  0,
  0,
  0,
  0,
  1,
  0,
  0,
  0,
  0,
  0,
  1,
  0,
  0,
  0,
  0,
  0,
  1,
  0,
]);
const ColorFilter Protanopia = ColorFilter.matrix([
  0.567,
  0.433,
  0,
  0,
  0,
  0.558,
  0.442,
  0,
  0,
  0,
  0,
  0.242,
  0.758,
  0,
  0,
  0,
  0,
  0,
  1,
  0,
]);
const ColorFilter Protanomaly = ColorFilter.matrix([
  0.817,
  0.183,
  0,
  0,
  0,
  0.333,
  0.667,
  0,
  0,
  0,
  0,
  0.125,
  0.875,
  0,
  0,
  0,
  0,
  0,
  1,
  0,
]);
const ColorFilter Deuteranopia = ColorFilter.matrix([
  0.625,
  0.375,
  0,
  0,
  0,
  0.7,
  0.3,
  0,
  0,
  0,
  0,
  0.3,
  0.7,
  0,
  0,
  0,
  0,
  0,
  1,
  0,
]);
const ColorFilter Deuteranomaly = ColorFilter.matrix([
  0.8,
  0.2,
  0,
  0,
  0,
  0.258,
  0.742,
  0,
  0,
  0,
  0,
  0.142,
  0.858,
  0,
  0,
  0,
  0,
  0,
  1,
  0,
]);
const ColorFilter Tritanopia = ColorFilter.matrix([
  0.95,
  0.05,
  0,
  0,
  0,
  0,
  0.433,
  0.567,
  0,
  0,
  0,
  0.475,
  0.525,
  0,
  0,
  0,
  0,
  0,
  1,
  0,
]);
const ColorFilter Tritanomaly = ColorFilter.matrix([
  0.967,
  0.033,
  0,
  0,
  0,
  0,
  0.733,
  0.267,
  0,
  0,
  0,
  0.183,
  0.817,
  0,
  0,
  0,
  0,
  0,
  1,
  0,
]);
const ColorFilter Achromatopsia = ColorFilter.matrix([
  0.299,
  0.587,
  0.114,
  0,
  0,
  0.299,
  0.587,
  0.114,
  0,
  0,
  0.299,
  0.587,
  0.114,
  0,
  0,
  0,
  0,
  0,
  1,
  0,
]);
