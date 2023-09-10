import 'package:flutter/material.dart';

import '../../firebase_services.dart';

class CreateNewBoyWidget extends StatefulWidget {
  const CreateNewBoyWidget({Key? key}) : super(key: key);

  @override
  State<CreateNewBoyWidget> createState() => _CreateNewBoyWidgetState();
}

class _CreateNewBoyWidgetState extends State<CreateNewBoyWidget> {
  final FirebaseService _services = FirebaseService();
  var emailText = TextEditingController();
  var passwordText = TextEditingController();

  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      width: MediaQuery.of(context).size.width,
      height: 80,
      child: Row(
        children: [
          Visibility(
            visible: _visible ? false : true,
            child: Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Container(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _visible = true;
                    });
                  },
                  child: const Text(
                    "Create New Delivery Boy",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            visible: _visible,
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Container(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 200,
                        height: 30,
                        child: TextField(
                          controller: emailText,
                          decoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: "Email ID",
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.only(left: 20),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: 200,
                        height: 30,
                        child: TextField(
                          controller: passwordText,
                          decoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: "Password",
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.only(left: 20),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (emailText.text.isEmpty) {
                            _services.showMyDialog(
                              context: context,
                              title: "Email ID",
                              message: "Email ID not entered",
                            );
                            return;
                          }

                          if (passwordText.text.isEmpty) {
                            _services.showMyDialog(
                              context: context,
                              title: "Password",
                              message: "Password not entered",
                            );
                            return;
                          }

                          if (passwordText.text.length < 6) {
                            // minimum 6 characters
                            _services.showMyDialog(
                              context: context,
                              title: "Password",
                              message: "Minimum 6 characters",
                            );
                            return;
                          }

                          _services.showProgressDialog(context);

                          _services
                              .saveDeliveryBoys(
                            emailText.text,
                            passwordText.text,
                          )
                              .whenComplete(() {
                            emailText.clear();
                            passwordText.clear();
                            _services.dismissProgressDialog(context);
                            _services.showMyDialog(
                              context: context,
                              title: "Save Delivery Boy",
                              message: "Saved Successfully",
                            );
                          });
                        },
                        child: const Text(
                          "Save",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}















/*import 'package:flutter/material.dart';

import '../../firebase_services.dart';

class CreateNewBoyWidget extends StatefulWidget {
  const CreateNewBoyWidget({super.key});

  @override
  State<CreateNewBoyWidget> createState() => _CreateNewBoyWidgetState();
}

class _CreateNewBoyWidgetState extends State<CreateNewBoyWidget> {

  final FirebaseService _services = FirebaseService();
  var emailText = TextEditingController();
   var passwordText = TextEditingController();

  bool _visible = false;

  @override
  Widget build(BuildContext context) {

    ArsProgressDialog progressDialog = ArsProgressDialog (
      context, 
      blur; 2,
      backgroundColor: Color(0xFF84C225).withOpacity(.3), 
      animationDuration: Duration(milliseconds: 500)
      );

    return Container(
                   color: Colors.grey, 
                   width: MediaQuery.of(context).size.width, 
                   height: 80,
                  child: Row(
                    children: [
                      Visibility(
                        visible: _visible ? false : true,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Container(
                            child:  ElevatedButton(
                                    // color: Colors.black54
                                    onPressed: () {
                                      setState(() {
                                        _visible = true;
                                      });
                                    }, 
                                    child: const Text("Create New Delivery Boy", 
                                    style: TextStyle(color: Colors.white),),
                                    ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: _visible,
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: Container(
                              child: Row(
                                children: [
                                SizedBox(
                                  width: 200,
                                  height: 30,
                                  child: TextField(
                                    controller: emailText,
                                    decoration:const InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.black, width: 1
                                        )
                                      ),
                                      filled: true, 
                                      fillColor: Colors.white, 
                                      hintText: "Email ID", 
                                      border: OutlineInputBorder(), 
                                      contentPadding: EdgeInsets.only(left: 20),
                                    ) ,
                                  ), 
                                  ),
                                  const SizedBox(width: 10,),
                      
                                SizedBox(
                                  width: 200,
                                  height: 30,
                                  child: TextField(
                                    controller: passwordText,
                                    decoration:const InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.black, width: 1
                                        )
                                      ),
                                      filled: true, 
                                      fillColor: Colors.white, 
                                      hintText: "Password", 
                                      border: OutlineInputBorder(), 
                                      contentPadding: EdgeInsets.only(left: 20),
                                    ) ,
                                  ), 
                                  ),
                                 const SizedBox(width: 10,),
                                
                                 ElevatedButton(
                                  // color: Colors.black54
                                  onPressed: () {
                                    if(emailText.text.isEmpty){
                                      return _services.showMyDialog(
                                        context: context, 
                                        title: "Email ID", 
                                        message: "Email ID not entered"
                                      );
                                    }

                                    if(passwordText.text.isEmpty){
                                      return _services.showMyDialog(
                                        context: context, 
                                        title: "Password", 
                                        message: "Password not entered"
                                      );
                                    }

                                    if(passwordText.text.length<6){
                                      // minimum 6 characters
                                      return _services.showMyDialog(
                                        context: context, 
                                        title: "Password", 
                                        message: "Minimum 6 characters"
                                      );
                                    }
                                    progressDialog.show();
                                    _services.saveDeliveryBoys(emailText.text, passwordText.text).whenComplete((){
                                      emailText.clear(); 
                                      passwordText.clear();
                                      progressDialog.dismiss();
                                      _services.showMyDialog(
                                        context: context, 
                                        title: "Save Delivery Boy", 
                                        message: "Saved Successifully"

                                      );
                                    });
                                  }, 
                                  child: const Text("Save", 
                                  style: TextStyle(color: Colors.white),),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
  }
}*/