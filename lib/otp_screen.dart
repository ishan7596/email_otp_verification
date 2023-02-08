import 'package:email_otp/email_otp.dart';
import 'package:emailotp/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home.dart';


class Otp extends StatelessWidget {
  const Otp({
    Key? key,
    required this.otpController,
  }) : super(key: key);
  final TextEditingController otpController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 50,
      child: TextFormField(
        controller: otpController,
        keyboardType: TextInputType.number,
        style: Theme.of(context).textTheme.headlineLarge,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly
        ],
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
          if (value.isEmpty) {
            FocusScope.of(context).previousFocus();
          }
        },
        decoration: const InputDecoration(
          hintText: ('0'),
        ),
        onSaved: (value) {},
      ),
    );
  }
}

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key, required this.myauth}) : super(key: key);
  final EmailOTP myauth;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController otp1Controller = TextEditingController();
  TextEditingController otp2Controller = TextEditingController();
  TextEditingController otp3Controller = TextEditingController();
  TextEditingController otp4Controller = TextEditingController();
  TextEditingController otp5Controller = TextEditingController();
  TextEditingController otp6Controller = TextEditingController();

  String otpController = "123456";

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
              opacity: 0.6,
              fit: BoxFit.cover,
              image: AssetImage("assets/plant.jpg")),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
             Text(
              "Enter PIN",
              style: GoogleFonts.montserrat(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade900),
            ),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Otp(
                  otpController: otp1Controller,
                ),
                Otp(
                  otpController: otp2Controller,
                ),
                Otp(
                  otpController: otp3Controller,
                ),
                Otp(
                  otpController: otp4Controller,
                ),
                Otp(
                  otpController: otp5Controller,
                ),
                Otp(
                  otpController: otp6Controller,
                ),
              ],
            ),


            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                if (await widget.myauth.verifyOTP(
                        otp: otp1Controller.text +
                            otp2Controller.text +
                            otp3Controller.text +
                            otp4Controller.text+otp5Controller.text +otp6Controller.text)  ==
                    true) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("OTP is verified"),
                  ));
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) {
                        return RegisterPage();
                      }));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Invalid OTP"),
                  ));
                }
              },
              child:  Text(
                "Confirm",
                style: GoogleFonts.montserrat(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade900),
              ),
            ),
            const SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}
