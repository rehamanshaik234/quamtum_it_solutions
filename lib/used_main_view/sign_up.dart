import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:passwordfield/passwordfield.dart';
import 'package:quamtum_it_solutions/used_main_view/login_page.dart';

import '../firebase-auth/firebase_login_gmail_password.dart';
import '../show-messages/show_message.dart';
class SignUp extends StatefulWidget {
   bool checkBox=false;
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  late TextEditingController name=TextEditingController();
  late TextEditingController email=TextEditingController();
  late TextEditingController password=TextEditingController();
  late TextEditingController phoneNumber=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32,horizontal: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 200,
                    width: 120,
                    child: Image.asset('assets/medicine.jpeg',fit: BoxFit.cover,),),
                ],
              ),
              Text('Sign Up',style: TextStyle(color: CupertinoColors.black,
                  fontSize: 25,fontWeight: FontWeight.bold),),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.person,color: Colors.blue,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.7,
                    child: TextField(
                      controller: name,
                      decoration: InputDecoration(
                        hintText: 'John deo',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.email,color: Colors.blue,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.7,
                    child: TextField(
                      controller: email,
                      decoration: InputDecoration(
                        hintText: 'johndeo@gmail.com',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child:  IntlPhoneField(
                  controller: phoneNumber,
                  decoration: InputDecoration(
                    hintText: 'Phone Number',
                  ),
                  initialCountryCode: 'IN',
                  onCountryChanged: (country) {
                    print('Country changed to: ' + country.name);
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.lock_open_outlined,color: Colors.red,),
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: Container(
                      width: MediaQuery.of(context).size.width*0.7,
                      child: PasswordField(
                        color: Colors.blue,
                        passwordConstraint: r'.*[@$#.*].*',
                        inputDecoration: PasswordDecoration(
                            hintStyle: TextStyle(color: Colors.grey)
                        ),
                        hintText: 'Password',
                        controller: password,
                        errorMessage:
                        'must contain special character either . * @ # \$',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(value: widget.checkBox, onChanged: (bool? value) {
                    setState(() {
                      widget.checkBox=!widget.checkBox;
                    });
                  },activeColor: Colors.blue,overlayColor: MaterialStatePropertyAll<Color>(Colors.white),
                    side: BorderSide(color: Colors.blue,width: 2),
                  ),
                  Text('I agree with',style: TextStyle(color: Colors.black,fontSize: 14),),
                  SizedBox(
                    width: 8,
                  ),
                  Text('Terms & Conditions',style: TextStyle(color: Colors.blue,fontSize: 16,fontWeight:
                  FontWeight.w500),)

                ],
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      width: MediaQuery.of(context).size.width*0.7,
                      height: 40,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                      child: ElevatedButton(onPressed: (){
                        if(name.text.isEmpty){
                          ShowMessage.displayMessage('Enter Name', context,Colors.red);
                        }
                        else if(email.text.isEmpty){
                          ShowMessage.displayMessage('Enter Email', context,Colors.red);
                        }
                        else if(!email.text.endsWith('@gmail.com')){
                          ShowMessage.displayMessage('Invalid email', context,Colors.red);
                        }
                        else if(phoneNumber.text.isEmpty){
                          ShowMessage.displayMessage('Enter Phone Number', context,Colors.red);
                        }
                        else if(password.text.isEmpty){
                          ShowMessage.displayMessage('Enter Password', context,Colors.red);
                        }
                        else if(!widget.checkBox){
                          ShowMessage.displayMessage('Accept Terms&Conditions', context,Colors.red);
                        }
                        else if(name.text.isNotEmpty&&phoneNumber.text.isNotEmpty&&email.text.isNotEmpty&&password.text.isNotEmpty&&widget.checkBox){
                          FirebaseAuthentication.SignUpWithGmail(email.text, password.text, context);
                        }
                      },child: Text('Sign Up',style: TextStyle(
                          color: Colors.white,fontSize: 20
                      ),),style: ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.blue)),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: 32,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already have an account?',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400),),
                  SizedBox(
                    width: 8,
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> Login()));

                    },
                    child: Text(
                      'Sign In',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w600,fontSize: 16),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
