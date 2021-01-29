import 'package:contact_flutter/common_widgets/avatar.dart';
import 'package:contact_flutter/models/deleted_contact.dart';
import 'package:contact_flutter/utils/constants.dart';
import 'package:contact_flutter/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DeletedContactDetails extends StatefulWidget {
  final DeletedContact deletedContact;

  DeletedContactDetails(this.deletedContact);

  @override
  createState() => new DeletedContactDetailsPageState(deletedContact);
}

class DeletedContactDetailsPageState extends State<DeletedContactDetails> {
  final globalKey = new GlobalKey<ScaffoldState>();

  RectTween _createRectTween(Rect begin, Rect end) {
    return new MaterialRectCenterArcTween(begin: begin, end: end);
  }

  final DeletedContact deletedContact;

  DeletedContactDetailsPageState(this.deletedContact);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: globalKey,
      appBar: new AppBar(
        centerTitle: true,
        textTheme: new TextTheme(
            title: new TextStyle(
              color: Colors.white,
              fontSize: 22.0,
            )),
        iconTheme: new IconThemeData(color: Colors.white),
        title: new Text(
          Texts.CONTACT_DETAILS,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: _deletedContactDetails(),
    );
  }

  Widget _deletedContactDetails() {
    return ListView(
      children: <Widget>[
        new SizedBox(
          child: new Hero(
            createRectTween: _createRectTween,
            tag: deletedContact.id,
            child: new Avatar(
              contactImage: deletedContact.contactImage,
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          height: 200.0,
        ),
        listTile(deletedContact.name, Icons.account_circle, Texts.NAME),
        listTile(deletedContact.phone, Icons.phone, Texts.PHONE),
        listTile(deletedContact.email, Icons.email, Texts.EMAIL),
        listTile(deletedContact.address, Icons.location_on, Texts.ADDRESS),
        new Row(
          children: <Widget>[
            new Flexible(
              child: listTile(
                  deletedContact.latitude, Icons.my_location, Texts.LATITUDE),
              fit: FlexFit.tight,
            ),
            new Flexible(
              child: listTile(
                  deletedContact.longitude, Icons.my_location, Texts.LONGITUDE),
              fit: FlexFit.tight,
            ),
          ],
        )
      ],
    );
  }

  Widget listTile(String text, IconData icon, String tileCase) {
    return new GestureDetector(
      onTap: () {
        switch (tileCase) {
          case Texts.NAME:
            break;
          case Texts.PHONE:
            _launch("tel:" + deletedContact.phone);
            break;
          case Texts.EMAIL:
            _launch("mailto:${deletedContact.email}?");
            break;
          case Texts.ADDRESS:
            _launch(googleMapUrl(
                deletedContact.latitude, deletedContact.longitude));
            break;
          case Texts.LATITUDE:
            _launch(googleMapUrl(
                deletedContact.latitude, deletedContact.longitude));
            break;
          case Texts.LONGITUDE:
            _launch(googleMapUrl(
                deletedContact.latitude, deletedContact.longitude));
            break;
        }
      },
      child: new Column(
        children: <Widget>[
          new ListTile(
            title: new Text(
              text,
              style: new TextStyle(
                color: Colors.green[400],
                fontSize: 20.0,
              ),
            ),
            leading: new Icon(
              icon,
              color: Colors.green[400],
            ),
          ),
          new Container(
            height: 0.3,
            color: Colors.green[400],
          )
        ],
      ),
    );
  }

  void _launch(String launchThis) async {
    try {
      if (await canLaunch(launchThis)) {
        await launch(launchThis);
      } else {
        print("Unable to launch $launchThis");
//        throw 'Could not launch $url';
      }
    } catch (e) {
      print(e.toString());
    }
  }
}