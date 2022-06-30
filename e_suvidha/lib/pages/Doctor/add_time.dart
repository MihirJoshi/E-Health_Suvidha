import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_suvidha/models/doctor_model.dart';
import 'package:e_suvidha/widgets/custom_button.dart';
import 'package:e_suvidha/widgets/timer_header_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddTime extends StatefulWidget {
  const AddTime({Key? key}) : super(key: key);

  @override
  State<AddTime> createState() => _AddTimeState();
}

class _AddTimeState extends State<AddTime> {
  final _firestore = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();

  TimeOfDay selectedTime = TimeOfDay.now();
  TimeOfDay selectedTime1 = TimeOfDay.now();
  TimeOfDay selectedTime2 = TimeOfDay.now();
  TimeOfDay selectedTime3 = TimeOfDay.now();
  TimeOfDay selectedTime4 = TimeOfDay.now();

  String date = "";
  DateTime selectedDate = DateTime.now();

  TextEditingController _controller = TextEditingController();
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  TextEditingController _controller3 = TextEditingController();
  TextEditingController _controller4 = TextEditingController();

  User? user = FirebaseAuth.instance.currentUser;
  DoctorModel doctor = DoctorModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('doctors')
        .doc(user!.uid)
        .get()
        .then((value) {
      this.doctor = DoctorModel.fromMap(value.data());

      setState(() {});
    });
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 0));
    return true;
  }

  //update doctor function

  CollectionReference doctors =
      FirebaseFirestore.instance.collection('doctors');

  Future<void> updateDoctor(id, name, last, t1, t2, t3, t4, t5) {
    print("Doctor Updated!!!!!!");
    print(doctor.uid);
    print(doctor.first);
    return doctors
        .doc(id)
        .update({
          'name': name,
          'last': last,
          't1': t1,
          't2': t2,
          't3': t3,
          't4': t4,
          't5': t5,
        })
        .then((value) => print("User Updated"))
        .catchError((error) =>
            Fluttertoast.showToast(msg: "Failed to update user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    var new_name = doctor.first;
    var new_last = doctor.last;
    var new_speciality = doctor.special;

    TextEditingController nameController =
        TextEditingController(text: "$new_name");

    TextEditingController lastController =
        TextEditingController(text: "$new_last");

    TextEditingController specialityController =
        TextEditingController(text: "$new_speciality");

    _controller.text =
        "${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')} ${selectedTime.period.toString().split('.')[1]}";
    _controller1.text =
        "${selectedTime1.hour.toString().padLeft(2, '0')}:${selectedTime1.minute.toString().padLeft(2, '0')} ${selectedTime1.period.toString().split('.')[1]}";
    _controller2.text =
        "${selectedTime2.hour.toString().padLeft(2, '0')}:${selectedTime2.minute.toString().padLeft(2, '0')} ${selectedTime2.period.toString().split('.')[1]}";
    _controller3.text =
        "${selectedTime3.hour.toString().padLeft(2, '0')}:${selectedTime3.minute.toString().padLeft(2, '0')} ${selectedTime3.period.toString().split('.')[1]}";
    _controller4.text =
        "${selectedTime4.hour.toString().padLeft(2, '0')}:${selectedTime4.minute.toString().padLeft(2, '0')} ${selectedTime4.period.toString().split('.')[1]}";
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 150,
                child: TimerHeaderWidget(150, true, "Add Timer Screen"),
              ),
              Form(
                key: _formKey,
                child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  future: FirebaseFirestore.instance
                      .collection('doctors')
                      .doc(user!.uid)
                      .get(),
                  builder: (_, snapshot) {
                    if (snapshot.hasError) {
                      print('Something Went Wrong');
                    }

                    var data = snapshot.data?.data();
                    var id = data?['uid'];
                    var name = data?['first'];
                    var last = data?['last'];
                    var email = data?['email'];
                    return Column(
                      children: [
                        TextFormField(
                          controller: nameController,
                          decoration: const InputDecoration(
                              icon: Icon(Icons.person),
                              hintText: "Name",
                              labelText: "Doctor Name"),
                          readOnly: true,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: lastController,
                          decoration: const InputDecoration(
                              icon: Icon(Icons.person),
                              hintText: "Last Name",
                              labelText: "Doctor Last Name"),
                          readOnly: true,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: specialityController,
                          decoration: const InputDecoration(
                              icon: Icon(Icons.person),
                              hintText: "Speciality",
                              labelText: "Doctor Speciality"),
                          readOnly: true,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            icon: Icon(Icons.person),
                            hintText: 'click here to select time Slot 1',
                            labelText: 'Select time Slot 1*',
                          ),
                          readOnly: true,
                          controller: _controller,
                          onTap: () {
                            _selectTime(context);
                            print(_controller);
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            icon: Icon(Icons.person),
                            hintText: 'click here to select time Slot 2',
                            labelText: 'Select time Slot 2*',
                          ),
                          readOnly: true,
                          controller: _controller1,
                          onTap: () {
                            _selectTime1(context);
                            print(_controller1);
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            icon: Icon(Icons.person),
                            hintText: 'click here to select time Slot 3',
                            labelText: 'Select time Slot 3*',
                          ),
                          readOnly: true,
                          controller: _controller2,
                          onTap: () {
                            _selectTime2(context);
                            print(_controller2);
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            icon: Icon(Icons.person),
                            hintText: 'click here to select time Slot 4',
                            labelText: 'Select time Slot 4*',
                          ),
                          readOnly: true,
                          controller: _controller3,
                          onTap: () {
                            _selectTime3(context);
                            print(_controller3);
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            icon: Icon(Icons.person),
                            hintText: 'click here to select time Slot 5',
                            labelText: 'Select time Slot 5*',
                          ),
                          readOnly: true,
                          controller: _controller4,
                          onTap: () {
                            _selectTime4(context);
                            print(_controller4);
                          },
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        AuthButton(
                          onTap: () {
                            updateDoctor(
                                id,
                                name,
                                last,
                                _controller.text,
                                _controller1.text,
                                _controller2.text,
                                _controller3.text,
                                _controller4.text);

                            Fluttertoast.showToast(msg: "Uploaded !!!!!!! ");
                          },
                          text: 'Upload',
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );

    if (timeOfDay != null && timeOfDay != selectedTime) {
      setState(() {
        selectedTime = timeOfDay;
        print(timeOfDay);
      });
    }
  }

  _selectTime1(BuildContext context) async {
    final TimeOfDay? timeOfDay1 = await showTimePicker(
      context: context,
      initialTime: selectedTime1,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay1 != null && timeOfDay1 != selectedTime1) {
      setState(() {
        selectedTime1 = timeOfDay1;
        print(timeOfDay1);
      });
    }
  }

  _selectTime2(BuildContext context) async {
    final TimeOfDay? timeOfDay2 = await showTimePicker(
      context: context,
      initialTime: selectedTime2,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay2 != null && timeOfDay2 != selectedTime2) {
      setState(() {
        selectedTime2 = timeOfDay2;
        print(timeOfDay2);
      });
    }
  }

  _selectTime3(BuildContext context) async {
    final TimeOfDay? timeOfDay3 = await showTimePicker(
      context: context,
      initialTime: selectedTime3,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay3 != null && timeOfDay3 != selectedTime3) {
      setState(() {
        selectedTime3 = timeOfDay3;
        print(timeOfDay3);
      });
    }
  }

  _selectTime4(BuildContext context) async {
    final TimeOfDay? timeOfDay4 = await showTimePicker(
      context: context,
      initialTime: selectedTime4,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay4 != null && timeOfDay4 != selectedTime4) {
      setState(() {
        selectedTime4 = timeOfDay4;
        print(timeOfDay4);
      });
    }
  }
}
