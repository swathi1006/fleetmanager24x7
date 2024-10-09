import 'package:mongo_dart/mongo_dart.dart';

String loggedInUserId = '';
String loggedInDriverId='';
String loggedInName='';


Db? db;
DbCollection? collection_drivers;
DbCollection? collection_temp_vehicles;
DbCollection? collection_vehicles;
DbCollection? collection_trips;
DbCollection? collection_scratch;
DbCollection? collection_workshop;
DbCollection? collection_issues;
DbCollection? collection_charts;
DbCollection? collection_attendance;//new collection

List<Map<String, dynamic>> globalTrips = [];