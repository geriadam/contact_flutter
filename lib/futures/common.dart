import 'dart:async';

import 'package:contact_flutter/futures/database.dart';
import 'package:contact_flutter/models/base/event_object.dart';
import 'package:contact_flutter/models/contact.dart';
import 'package:contact_flutter/utils/constants.dart';

Future<EventObject> getContacts() async {
  EventObject eventObject;
  eventObject = await getContactsUsingDB();
  return eventObject;
}

Future<EventObject> getLogs() async {
  EventObject eventObject;
  eventObject = await getLogsUsingDB();
  return eventObject;
}

Future<EventObject> getDeletedContacts() async {
  EventObject eventObject;
  eventObject = await getDeletedContactsUsingDB();
  return eventObject;
}

Future<EventObject> saveContact(Contact contact) async {
  EventObject eventObject;
  eventObject = await saveContactUsingDB(contact);
  return eventObject;
}

Future<EventObject> removeContact(Contact contact) async {
  EventObject eventObject;
  eventObject = await removeContactUsingDB(contact);
  return eventObject;
}

Future<EventObject> updateContact(Contact contact) async {
  EventObject eventObject;
  eventObject = await updateContactUsingDB(contact);
  return eventObject;
}

Future<EventObject> searchContactsAvailable(String searchQuery) async {
  EventObject eventObject;
  eventObject = await searchContactsUsingDB(searchQuery);
  return eventObject;
}