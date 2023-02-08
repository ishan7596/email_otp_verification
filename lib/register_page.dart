import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'home.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  DateTime date = DateTime.now();
  late String _firstName, _middleName, _lastName, _dob, _email, _mobile;
  TextEditingController fName = TextEditingController();
  TextEditingController lName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController bDate = TextEditingController();
  TextEditingController mNo = TextEditingController();
  String? _selectedGender;
  bool passwordVisible = false;
  bool passwordVisiblee = false;

  List<DropdownMenuItem<String>> _dropDownMenuItems = [
    DropdownMenuItem(
      child: Text("Male",style: GoogleFonts.montserrat(color: Colors.black54,fontSize: 20,fontWeight: FontWeight.bold)),
      value: "Male",
    ),
    DropdownMenuItem(
      child: Text("Female",style: GoogleFonts.montserrat(color: Colors.black54,fontSize: 20,fontWeight: FontWeight.bold)),
      value: "Female",
    ),
    DropdownMenuItem(
      child: Text("Other",style: GoogleFonts.montserrat(color: Colors.black54,fontSize: 20,fontWeight: FontWeight.bold)),
      value: "Other",
    ),
  ];
  File? imageFile;

  var picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
                opacity: 0.7,
                fit: BoxFit.cover,
                image: AssetImage("assets/plant.jpg")),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      CircleAvatar(
                          backgroundImage: AssetImage("assets/12345.jpg"),
                          maxRadius: 50,
                          child: imageFile == null
                              ? InkWell(
                            borderRadius: BorderRadius.circular(50),
                                  onTap: () async {
                                    await pickImageFromGallery();
                                  },
                                )
                              : CircleAvatar(
                                  backgroundImage: FileImage(imageFile!),
                                  maxRadius: 50,
                                )),
                      TextFormField(
                        controller: fName,
                        style: GoogleFonts.montserrat(
                            color: Colors.black54,
                            fontSize: 20,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.bold),
                        decoration: InputDecoration(labelText: "First Name"),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your first name";
                          }
                          return null;
                        },
                        onSaved: (value) => _firstName = value!,
                      ),
                      TextFormField(
                        controller: lName,
                        style: GoogleFonts.montserrat(
                            color: Colors.black54,
                            fontSize: 20,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.bold),
                        decoration: InputDecoration(labelText: "Last Name"),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your last name";
                          }
                          return null;
                        },
                        onSaved: (value) => _lastName = value!,
                      ),
                      DropdownButtonFormField(
                        // elevation: 100,
                        dropdownColor: Colors.white70,

                        borderRadius: BorderRadius.circular(30),
                        style: GoogleFonts.montserrat(
                            color: Colors.black54,
                            fontSize: 20,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.bold),
                        decoration:const  InputDecoration(
                          label: Text(
                            "Gender",
                          ),
                        ),
                        value: _selectedGender,

                        items: _dropDownMenuItems,
                        onChanged: (value) {
                          setState(() {
                            _selectedGender = value! as String?;
                          });
                        },
                      ),
                      TextFormField(
                        controller: bDate,
                        readOnly: true,
                        onTap: () {
                          _openDatePicker();
                        },
                        style: GoogleFonts.montserrat(
                            color: Colors.black54,
                            fontSize: 20,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.bold),
                        decoration: const InputDecoration(
                          labelText: "Birth Date",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your Birthdate";
                          }
                          return null;
                        },
                        onSaved: (value) => _email = value!,
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: mNo,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        style: GoogleFonts.montserrat(
                            color: Colors.black54,
                            fontSize: 20,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.bold),
                        decoration: InputDecoration(labelText: "Mobile No."),
                        validator: (value) {
                          if (value!.length != 10) {
                            return "Please enter your valid mobile number";
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: email,
                        style: GoogleFonts.montserrat(
                            color: Colors.black54,
                            fontSize: 20,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.bold),
                        decoration: InputDecoration(labelText: "Email"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          } else if (RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value) ==
                              false) {
                            return 'Please enter Valid E-mail!!';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) => _email = value!,
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          } else if (value.length < 8) {
                            return 'Please Enter Minimum 8 character!!';
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.text,
                        obscureText: !passwordVisiblee,
                        style: GoogleFonts.montserrat(
                            color: Colors.black54,
                            fontSize: 20,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          labelText: "Enter Password",
                          suffixIcon: IconButton(
                            icon: Icon(
                              passwordVisiblee
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.black54,
                            ),
                            onPressed: () {
                              setState(() {
                                passwordVisiblee = !passwordVisiblee;
                              });
                            },
                          ),
                        ),
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          } else if (value.length < 8) {
                            return 'Please Enter Minimum 8 character!!';
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.text,
                        obscureText: !passwordVisible,
                        style: GoogleFonts.montserrat(
                            color: Colors.black54,
                            fontSize: 20,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          labelText: "Confirm Password",
                          suffixIcon: IconButton(
                            icon: Icon(
                              passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.black54,
                            ),
                            onPressed: () {
                              setState(() {
                                passwordVisible = !passwordVisible;
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 7),
                      Row(
                        children: [
                          SizedBox(width: 100),
                          MaterialButton(
                            height: 50.0,
                            minWidth: 150.0,
                            color: Colors.green.shade900,
                            textColor: Colors.white,
                            child: Text(
                              "Register ",
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            onPressed: () => {
                              if (_formKey.currentState!.validate())
                                {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Home(),
                                    ),
                                  ),
                                }
                            },
                            splashColor: Colors.white30,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  pickImageFromGallery() async {
    var pickFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageFile = File(pickFile!.path);
    });
  }

  void _openDatePicker() async {
    final DateFormat now = DateFormat('dd/MM/yyyy');
    var d = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime(1950),
        lastDate: DateTime.now());
    setState(() {
      bDate.text = now.format(d!);
    });
  }
}
