import 'package:flutter/material.dart';
import 'package:pethelper/const.dart';
import 'package:pethelper/SettingSave.dart';
import 'package:pethelper/model/pet.dart';
import 'dart:ui' as ui;
import 'dart:collection';
import 'package:table_calendar/table_calendar.dart';
import 'package:pethelper/model/Calendar.dart';
import 'package:pethelper/api/Calendarapi.dart';
import 'package:pethelper/SettingSave.dart';

class Event {
  final int id;
  final String title;
  final String petid;
  bool isChecked;
  Event(
      {required this.id,
      required this.title,
      required this.petid,
      required this.isChecked});

  String toString() => this.title;
}

class calendarPage extends StatefulWidget {
  const calendarPage({Key? key, required this.image, required this.list})
      : super(key: key);
  final List<Pet1> list;
  final String image;
  @override
  _calendarPageState createState() =>
      _calendarPageState(image: this.image, list: this.list);
}

class _calendarPageState extends State<calendarPage> {
  String listChoiceid = "-1";
  String listChoice = "None pet selected";

  final List<Pet1> list;
  late Map<DateTime, List<Event>> selectedEvents;
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
//_____________________________________________________________________________
  int repeatFlg = 0;
  List<String> repeatLabels = ["Non Repeat",  "Weekly", "Biweekly"];
//_____________________________________________________________________________

//_____________________________________________________________________________
  late Map<DateTime, List<Event>> _events;
//_____________________________________________________________________________

  TextEditingController _eventController = TextEditingController();

  @override
  void initState() {
    selectedEvents = {};
    _events = {};
    super.initState();
    geteventslist();
  }

  List<Event> _getEventsFromDay(DateTime date) {
    List<Event> sort = [];
    for (int i = 0; i < (allEvents[date] ?? []).length; i++) {
      if ((allEvents[date] ?? [])[i].petid == listChoiceid) {
        sort.add((allEvents[date] ?? [])[i]);
      }
    }
    return sort;
  }

  @override
  void dispose() {
    _eventController.dispose();
    super.dispose();
  }

  final String image;

  _calendarPageState({
    Key? key,
    required this.image,
    required this.list,
  });

  Widget ConstructCalendarPage() {
    //____________________________________
    List<String> pet_name = ["None pet selected"];
    List<String> pet_weight = ["0"];
    List<String> pet_type = ["Unknown"];
    List<String> pet_id = [
      "-1",
    ];
    for (int i = 0; i < list.length; i++) {
      pet_name.add(list[i].pet_name);
      pet_weight.add(list[i].pet_weight);
      pet_type.add(list[i].pet_type);
      pet_id.add(list[i].id.toString());
    }
    //------------------------------------

    Widget createCalendar() {
      return TableCalendar(
        focusedDay: selectedDay,
        firstDay: DateTime(1990),
        lastDay: DateTime(2050),
        calendarFormat: format,
        onFormatChanged: (CalendarFormat _format) {
          setState(() {
            format = _format;
          });
        },
        startingDayOfWeek: StartingDayOfWeek.sunday,
        daysOfWeekVisible: true,

        //Day Changed
        onDaySelected: (DateTime selectDay, DateTime focusDay) {
          setState(() {
            selectedDay = selectDay;
            focusedDay = focusDay;
          });
        },
        selectedDayPredicate: (DateTime date) {
          return isSameDay(selectedDay, date);
        },
        eventLoader: _getEventsFromDay,
        calendarStyle: CalendarStyle(
          defaultTextStyle: (darkMode)
              ? const TextStyle(color: Color.fromARGB(255, 255, 255, 255))
              : const TextStyle(color: Color.fromARGB(255, 87, 87, 87)),
          weekendTextStyle:
              const TextStyle(color: Color.fromARGB(255, 230, 12, 12)),
          isTodayHighlighted: true,
          selectedDecoration: BoxDecoration(
            color: Colors.redAccent,
            shape: BoxShape.circle,
          ),
          selectedTextStyle: TextStyle(color: Colors.white),
          todayDecoration: BoxDecoration(
            color: Colors.red.shade200,
            shape: BoxShape.circle,
          ),
          defaultDecoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
          weekendDecoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
        ),
        headerStyle: HeaderStyle(
          formatButtonVisible: true,
          titleCentered: true,
          formatButtonShowsNext: false,
          formatButtonDecoration: BoxDecoration(
            color: Colors.red,
          ),
          formatButtonTextStyle: TextStyle(
            color: Colors.white,
          ),
        ),
      );
    }

    return Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [
            0.0,
            0.3,
          ],
          colors: [
            Color.fromARGB(255, 192, 36, 41),
            Color.fromARGB(255, 221, 65, 65),
          ],
        )),
        child: Scaffold(

            //_____________________________________________________________________________
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () => showDialog(
                  context: context,
                  builder: (context) {
                    return StatefulBuilder(
                        builder: (context, StateSetter setState) {
                      return AlertDialog(
                        title: Text("Add Event"),
                        content: TextFormField(
                          controller: _eventController,
                        ),
                        actions: [
                          TextButton(
                            child: Text(
                              repeatLabels[repeatFlg],
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.red,
                              ),
                            ),
                            onPressed: () => {
                              repeatFlg++,
                              if (repeatFlg > 2) repeatFlg = 0,
                              setState(() {})
                            },
                          ),
                          TextButton(
                            child: Text(
                              "Cancel",
                              style: TextStyle(fontSize: 13, color: Colors.red),
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                          TextButton(
                            child: Text(
                              "Ok",
                              style: TextStyle(fontSize: 13, color: Colors.red),
                            ),
                            onPressed: () {
                              setState(() {});
                              if (_eventController.text.isEmpty) {
                                Navigator.pop(context);
                                return;
                              }
                              //Add Event
                              if (repeatFlg == 0) {
                                addEvent(
                                    selectedDay); //Add Event on the selected date
                                Navigator.pop(context);
                              } else if (repeatFlg == 1) {
                                //Weekly
                                DateTime result = DateTime(selectedDay.year,
                                        selectedDay.month + 1, 1)
                                    .add(Duration(
                                        days:
                                            -1)); //Get the end of the date of month
                                for (int i = selectedDay.day;
                                    i <= result.day;
                                    i += 7) {
                                  DateTime dateTime = DateTime(
                                      selectedDay.year, selectedDay.month, i);
                                  addEvent(dateTime);
                                }
                                Navigator.pop(context);
                              } else if (repeatFlg == 2) {
                                //Biweekly
                                DateTime result = DateTime(selectedDay.year,
                                        selectedDay.month + 1, 1)
                                    .add(Duration(
                                        days:
                                            -1)); //Get the end of the date of month
                                for (int i = selectedDay.day;
                                    i <= result.day;
                                    i += 14) {
                                  DateTime dateTime = DateTime(
                                      selectedDay.year, selectedDay.month, i);
                                  addEvent(dateTime);
                                }
                                Navigator.pop(context);
                              }
                              Navigator.pop(context);
                              _eventController.clear();
                              return;
                            },
                          ),
                        ],
                      );
                    });
                  }).then((value) {
                //rework when AleertDialog close
                setState(() {});
              }),
              label: Text("Add Event"),
              icon: Icon(Icons.add),
              backgroundColor: a5,
            ),
            //_____________________________________________________________________________

            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.arrow_back),
                color: Colors.white,
              ),
              actions: <Widget>[
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.refresh,
                    color: (darkMode)
                        ? Color.fromARGB(255, 255, 255, 255)
                        : Color.fromARGB(255, 39, 31, 24),
                  ),
                ),
              ],
              title: Text(
                'Calendar',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize:
                        MediaQuery.of(context).size.width * 0.07 * fontSize,
                    foreground: Paint()),
              ),
              centerTitle: true,
            ),
            body: ListView(children: [
              Stack(children: [
                Container(
                    height: MediaQuery.of(context).size.height - 82.0,
                    width: MediaQuery.of(context).size.width,
                    color: Color.fromARGB(0, 0, 0, 0)),
                Positioned(
                    //background
                    top: 75.0,
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(45.0),
                              topRight: Radius.circular(45.0),
                            ),
                            color: (darkMode) ? darkxsolid : Colors.white),
                        height: MediaQuery.of(context).size.height - 100.0,
                        width: MediaQuery.of(context).size.width)),
                Positioned(
                    top: MediaQuery.of(context).size.height * 0.1,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.52,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          //border: Border.all()
                          ),
                      child: createCalendar(),
                    )),
                Positioned(
                    top: MediaQuery.of(context).size.height * 0.62,
                    child: Container(
                      decoration: BoxDecoration(
                          //border: Border.all()
                          ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "To Do ",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 30,
                                      color: (darkMode)
                                          ? Colors.white
                                          : Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.2),
                                DropdownButton<String>(
                                  value: listChoice,
                                  icon: const Icon(Icons.arrow_downward),
                                  iconSize: 24,
                                  elevation: 16,
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 119, 119, 119),
                                  ),
                                  underline: Container(
                                    height: 2,
                                    color: a3,
                                  ),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      listChoice = newValue!;
                                      if (listChoice == "None pet selected") {
                                        listChoiceid = "-1";
                                      } else {
                                        for (int i = 0; i < list.length; i++) {
                                          if (listChoice == list[i].pet_name) {
                                            listChoiceid =
                                                list[i].id.toString();
                                          }
                                        }
                                      }
                                    });
                                  },
                                  items: pet_name.map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                            Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.13,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    //border: Border.all()
                                    ),
                                child: ListView(
                                  children: <Widget>[
                                    ..._getEventsFromDay(selectedDay).map(
                                      (Event event) => CheckboxListTile(
                                        activeColor: Colors.red,
                                        title: Text(
                                          event.title,
                                        ),
                                        controlAffinity:
                                            ListTileControlAffinity.leading,
                                        // value: _flag,
                                        value: event.isChecked,
                                        // Event delete
                                        secondary: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              deleteEvent(event.id.toString());
                                              allEvents[selectedDay]
                                                  ?.removeWhere(
                                                (element) =>
                                                    element.hashCode ==
                                                    event.hashCode,
                                              );
                                            });
                                          },
                                          icon: Icon(Icons.close),
                                          //deleteEvent
                                        ),
                                        onChanged: (bool? value) {
                                          setState(() {
                                            event.isChecked = value!;
                                            print(event.isChecked);
                                            if (event.isChecked) {
                                              undonetodone(event.id.toString());
                                            } else {
                                              donetoundone(event.id.toString());
                                            }
                                          });
                                        },
                                      ),
                                    )
                                  ],
                                ))
                          ]),
                    )),
              ])
            ])));
  }

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter: ColorBlindMode(colorblindMode),
      child: ConstructCalendarPage(),
    );
  }

  void addEvent(DateTime dateTime) {
    if (listChoiceid == -1) {
    } else {
      createEvent(listChoiceid, dateTime.toString().split(' ')[0],
          _eventController.text, id);
      geteventslist();
    }
  }

  void initializeEvent(
      DateTime dateTime, String text, String petid, String id, String check) {
    if (allEvents[dateTime] != null) {
      allEvents[dateTime]?.add(Event(
          id: int.parse(id),
          title: text,
          petid: petid,
          isChecked: stringToBool(check)));
    } else {
      allEvents[dateTime] = [
        Event(
            id: int.parse(id),
            title: text,
            petid: petid,
            isChecked: stringToBool(check))
      ];
    }
  }

  geteventslist() async {
    allEvents = LinkedHashMap<DateTime, List<Event>>(
      equals: isSameDay,
      hashCode: (key) {
        return key.day * 1000000 + key.month * 10000 + key.year;
      },
    );
    List<Calendar1> pulledevents = await getEvents();
    for (int i = 0; i < pulledevents.length; i++) {
      initializeEvent(
          DateTime.parse(pulledevents[i].date + " 00:00:00.000"),
          pulledevents[i].title,
          pulledevents[i].pet,
          pulledevents[i].id,
          pulledevents[i].isChecked);
    }
  }

  bool stringToBool(String check) {
    if (check == "Not Done") {
      return false;
    } else {
      return true;
    }
  }
}
