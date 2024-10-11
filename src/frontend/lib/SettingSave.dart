import 'package:pethelper/Miscs/myPetScreenMiscs/calendarPage.dart';
import 'package:pethelper/model/Calendar.dart';
import 'dart:collection';
import 'package:table_calendar/table_calendar.dart';

bool darkMode = StringtoBool(int.parse(darkModeString));
bool contrastMode = StringtoBool(int.parse(contrastModeString));
double fontSize = frontStringtoInt(fontSizeString);
bool walk = StringtoBool(int.parse(walkString));
bool feed = StringtoBool(int.parse(feedString));

String id = "-1";

String token = "None";
//default value
String darkModeString = "0";
//default value
String contrastModeString = "0";
//default value
String fontSizeString = "m";
//default value
String walkString = "0";
//default value
String feedString = "0";
//default value
String colorblindMode = "None";

double frontStringtoInt(String font) {
  if (font == "s") {
    return 0.8;
  } else if (font == "m") {
    return 1;
  } else
    return 1.2;
}

bool StringtoBool(int dark) {
  if (dark == 1) {
    return true;
  } else {
    return false;
  }
}

String booltoString(bool bool) {
  if (bool) {
    return ("1");
  } else {
    return ("0");
  }
}

LinkedHashMap<DateTime, List<Event>> allEvents =
    LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: (key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  },
);
