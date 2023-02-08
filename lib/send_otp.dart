import 'package:email_otp/email_otp.dart';
import 'package:emailotp/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController email = TextEditingController();
  EmailOTP myauth = EmailOTP();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery
            .of(context)
            .size
            .height,
        width: MediaQuery
            .of(context)
            .size
            .width,
        decoration: const BoxDecoration(
          image: DecorationImage(
              opacity: 0.7,
              fit: BoxFit.cover,
              image: AssetImage("assets/plant.jpg")),
        ),
        child: Padding(
          padding: const EdgeInsets.all(17.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text("Enter your Email for OTP",
                  style: GoogleFonts.montserrat(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade900),),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: email,
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w400, fontSize: 17,),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(

                  label: Text("E-MAIL", style:GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold, fontSize: 17,color: Colors.green.shade900),
                    ),

                  suffixIcon: IconButton(
                      onPressed: () async {
                        myauth.setConfig(
                            appEmail: "contact@hdevcoder.com",
                            appName: "Email OTP",
                            userEmail: email.text,
                            otpLength: 6,
                            otpType: OTPType.digitsOnly);
                        if (await myauth.sendOTP() == true) {
                          ScaffoldMessenger.of(context).showSnackBar(
                             const SnackBar(
                              content: Text("OTP has been sent"),
                            ),
                          );
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      OtpScreen(
                                        myauth: myauth,
                                      )));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Oops, OTP send failed!!"),
                            ),
                          );
                        }
                      },
                      icon:
                      const Icon(Icons.send_rounded, color: Colors.green)),
                  // hintText: "Email Address",
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                ),
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
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
