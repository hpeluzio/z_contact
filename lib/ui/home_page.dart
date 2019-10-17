import 'package:flutter/material.dart';
import 'package:z_contact/helpers/contact_helper.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  ContactHelper helper = ContactHelper();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Contact c = Contact();
    c.name = "HENRIQUE 2";
    c.email = "Henrique@asdasd";
    c.phone = "123123123";
    c.img = "imgteste";

    helper.saveContact(c);

    helper.getAllContacts().then((list) {
      print(list);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}