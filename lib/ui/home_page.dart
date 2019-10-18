import 'package:flutter/material.dart';
import 'package:z_contact/helpers/contact_helper.dart';
import 'package:z_contact/ui/contact_page.dart';
import 'dart:io';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  ContactHelper helper = ContactHelper();

  List<Contact> contacts = List();

  @override
  void initState() {
    super.initState();
    print('ENTROU AQUI iniState');
    // helper.deleteContact(1);
    // helper.deleteContact(2);
    // helper.deleteContact(3);
    // Contact c = Contact();
    // c.name = "HENRIQUE 5";
    // c.email = "Henrique@ggggg";
    // c.phone = "319999999";
    // c.img = null;
    // helper.saveContact(c);

    _getAllContacts();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contatos'),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //Nao precisa passar parametro para contact page pq estamos criando um contato
          //Ou seja, eh opcional
          _showContactPage();
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          return _contactCard(context, index);
        },
      ),
    );
  }

  Widget _contactCard(BuildContext context, int index) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            children: <Widget>[
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: contacts[index].img != null ? 
                        FileImage(File(contacts[index].img)) :
                          AssetImage('images/person.png')
                  ), 
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      contacts[index].name ?? '',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      contacts[index].email ?? '',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      contacts[index].phone ?? '',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        //print('ENTROU AQUI');
        _showOptions(context, index);
        //_showContactPage(contact: contacts[index]);
      },
    );
  }

  void _showOptions(BuildContext context, int index) {
    showModalBottomSheet(
      context: context, 
      builder: (context) {
        return BottomSheet(
          onClosing: () {},
          builder: (context) {
            return Container (
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: 
                      FlatButton(
                        child: Text(
                          'Ligar', 
                          style: TextStyle(color: Colors.red, fontSize: 20),
                        ),
                        onPressed: () {
                          
                        },
                      ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: 
                      FlatButton(
                        child: Text(
                          'Editar', 
                          style: TextStyle(color: Colors.red, fontSize: 20),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          _showContactPage(contact: contacts[index]);
                        },
                      ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: 
                      FlatButton(
                        child: Text(
                          'Excluir', 
                          style: TextStyle(color: Colors.red, fontSize: 20),
                        ),
                        onPressed: () {
                          helper.deleteContact(contacts[index].id);
                          setState(() {
                            contacts.removeAt(index);
                            Navigator.pop(context);
                          });
                        },
                      ),
                  ),
                ],
              ),
            );
          },

        );
      }
    );
  }

  void _showContactPage({Contact contact}) async {
    print('ENTROU AQUI _showContactPage');
    final recContact = await Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => ContactPage(contact: contact,))
    );

      // print('---------recContact----------');
      // print(recContact);
      // print('-------------------');
      // print('-----TESTEAAAA--------------');

      // print(recContact != null);
    // if(true) {
    // }

    if(recContact != null){
      if(contact != null){
        await helper.updateContact(recContact);
      } else {
        await helper.saveContact(recContact);
      }
      _getAllContacts();
    }

    //Pegando todos contatos novamente
    print('---------contacts----------');
    print(contacts);
    // print(contacts);
    _getAllContacts();

  }

  void _getAllContacts() {
    helper.getAllContacts().then((list) {
      setState(() {
        contacts = list;
      });
    });    
  }




}

