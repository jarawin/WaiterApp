import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:waiter_app/providers/customerProvider.dart';
import 'package:waiter_app/utils/colors.dart';
import 'package:waiter_app/utils/config.dart';
import 'package:waiter_app/utils/dimensions.dart';
import 'package:waiter_app/widgets/big_text.dart';

class CustomerLoginPage extends StatefulWidget {
  const CustomerLoginPage({Key? key}) : super(key: key);

  @override
  _CustomerLoginPageState createState() => _CustomerLoginPageState();
}

class _CustomerLoginPageState extends State<CustomerLoginPage> {
  final String _baseUrl = Config.URL_BASE;
  String phone = '';
  String otp = '';
  String ref = '';
  int quotaSentOTP = 0;
  DateTime? lastSentOTP;
  int waitingTime = 0;
  bool hasSentOTP = false;
  bool isLoading = false;
  bool isRequestingOtp = false;
  bool isConfirmingOtp = false;

  CustomerProvider customerProvider = CustomerProvider();

  void resetState() {
    setState(() {
      otp = '';
      ref = '';
      quotaSentOTP = 0;
      lastSentOTP = null;
      waitingTime = 0;
      hasSentOTP = false;
      isLoading = false;
      isRequestingOtp = false;
      isConfirmingOtp = false;
    });
  }

  showSnackBar(String message) {
    FocusScope.of(context).unfocus();
    ScaffoldMessenger.of(context).removeCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {},
        ),
      ),
    );
  }

  bool isPhoneNumberValid() {
    return RegExp(r"^\d{10}$").hasMatch(phone);
  }

  bool isOtpValid() {
    return RegExp(r"^\d{6}$").hasMatch(otp);
  }

  Future<void> requestOtp() async {
    if (!isPhoneNumberValid()) {
      showSnackBar("Invalid phone number");
      return;
    }

    setState(() {
      isRequestingOtp = true;
      isLoading = true;
    });

    try {
      var response = await http.post(
        Uri.parse('http://localhost:5390/otp/request'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'phone': phone}),
      );


      var data = jsonDecode(response.body);

      if (response.statusCode != 200) {
        setState(() {
          isLoading = false;
          isRequestingOtp = false;
        });

        showSnackBar("Error: ${data['message']}");
      } else {
        setState(() {
          ref = data['ref'];
          quotaSentOTP = data['quotaSentOTP'];
          lastSentOTP = DateTime.parse(data['lastSentOTP']);
          waitingTime = 300 - DateTime.now().difference(lastSentOTP!).inSeconds;
          hasSentOTP = true;
          isLoading = false;
        });

        Timer.periodic(const Duration(seconds: 1), (timer) {
          setState(() {
            waitingTime--;
          });
          if (waitingTime == 0) {
            timer.cancel();
            resetState();
          }
        });
      }
    } catch (error) {
      setState(() {
        isLoading = false;
        isRequestingOtp = false;
      });

      showSnackBar("Error: ${error.toString()}");
    }
  }

  Future<void> confirmOtp() async {
    if (!isOtpValid()) {
      showSnackBar("Invalid OTP");
      return;
    }

    setState(() {
      isConfirmingOtp = true;
      isLoading = true;
    });

    try {
      var response = await http.post(
        Uri.parse('http://localhost:5390/otp/confirm'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'otp': otp,
          'ref': ref,
        }),
      );

      var data = jsonDecode(response.body);
      customerProvider.login(data['userId'], data['phone']);

      setState(() {
        quotaSentOTP = 0;
        lastSentOTP = null;
        waitingTime = 0;
        hasSentOTP = false;
        isLoading = false;
      });

      showSnackBar("Success: ${data['message']}");

      Navigator.pushNamed(context, '/home');

    } catch (error) {
      setState(() {
        isLoading = false;
        isConfirmingOtp = false;
      });

      showSnackBar("Error: ${error.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: Dimensions.screenHeight * 0.05),
              SizedBox(
                height: Dimensions.screenHeight * 0.25,
                child: Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 80.0,
                    child: Image.network("$_baseUrl/images/waiter_app.png"),
                  ),
                ),
              ),

              Container(
                margin: const EdgeInsets.only(bottom: 5, left: 5),
                  child: BigText(text: "Welcome", size: 50, color: Colors.black87)
              ),
              Container(
                  margin: const EdgeInsets.only(bottom: 30, left: 5),
                  child: BigText(text: "Easy login with your phone number", color: Colors.black54)
              ),

              Container(
                margin:  EdgeInsets.only(left: Dimensions.height20, right: Dimensions.height20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 7,
                      blurRadius: 10,
                      offset: const Offset(1, 10), // changes position of shadow
                    ),
                  ],
                ),
                child: TextField(
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: 'Phone Number',
                    prefixIcon: const Icon(Icons.phone, color: AppColors.mainColor),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dimensions.radius30),
                      borderSide: const BorderSide(color: Colors.white, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dimensions.radius30),
                      borderSide: const BorderSide(color: Colors.white, width: 1.0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dimensions.radius30),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      phone = value;
                    });
                  },
                ),
              ),

              const SizedBox(height: 20),

              if (!hasSentOTP)
                GestureDetector(
                  onTap: phone.isEmpty || isLoading ? null : requestOtp,
                  child: Container(
                    margin: EdgeInsets.only(left: Dimensions.screenWidth/4.5, right: Dimensions.screenWidth/4.5, top: Dimensions.height20),
                    height: Dimensions.screenHeight/15,

                    decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.circular(Dimensions.radius30),
                    ),
                    child: isLoading || isRequestingOtp
                          ? const CircularProgressIndicator(color: Colors.white,) : Center(child: BigText(text: "Request OTP", color: Colors.white, size: Dimensions.font20)),
                  ),
                ),

              if (hasSentOTP)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin:  EdgeInsets.only(left: Dimensions.height20, right: Dimensions.height20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(Dimensions.radius30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 7,
                            blurRadius: 10,
                            offset: const Offset(1, 10), // changes position of shadow
                          ),
                        ],
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'OTP',
                          prefixIcon: const Icon(Icons.key, color: AppColors.mainColor),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(Dimensions.radius30),
                            borderSide: const BorderSide(color: Colors.white, width: 1.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(Dimensions.radius30),
                            borderSide: const BorderSide(color: Colors.white, width: 1.0),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(Dimensions.radius30),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            otp = value;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      alignment: Alignment.topRight,
                      child: Text(
                          'Waiting for confirm in $waitingTime seconds (Ref: $ref)', style: const TextStyle(color: AppColors.textColor)),
                    ),
                    const SizedBox(height: 20),

                    GestureDetector(
                      onTap: otp.isEmpty || isLoading || isConfirmingOtp ? null : confirmOtp,
                      child: Container(
                        margin: EdgeInsets.only(left: Dimensions.screenWidth/4.5, right: Dimensions.screenWidth/4.5, top: Dimensions.height20),
                        height: Dimensions.screenHeight/15,

                        decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius: BorderRadius.circular(Dimensions.radius30),
                        ),
                        child: isLoading || isConfirmingOtp
                            ? const CircularProgressIndicator(color: Colors.white,) : Center(child: BigText(text: "Confirm OTP", color: Colors.white, size: Dimensions.font20)),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
