import 'dart:convert';
import 'package:apidemotest/models/user.dart';
import 'package:apidemotest/models/user_dob.dart';
import 'package:apidemotest/models/user_location.dart';
import 'package:apidemotest/models/user_name.dart';
import 'package:http/http.dart' as http;

class UserApi {
  static Future<List<User>> fetchUsers() async {
    // print('Fetching users..........');
    const url = 'https://randomuser.me/api/?results=50';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    final results = json['results'] as List<dynamic>;
    final users = results.map((e) {
      
      final name = UserName(
        title: e['name']['title'],
        first: e['name']['first'],
        last: e['name']['last'],
      );
      final date = e['dob']['date'];

      final dob = UserDob(date: DateTime.parse(date), age: e['dob']['age']);

      final coordinates = LocationCoordinates(
          latitude: e['location']['coordinates']['latitude'],
          longitude: e['location']['coordinates']['longitude']);

      final street = LocationStreet(
          number: e['location']['street']['number'],
          name: e['location']['street']['name']);

      final timezone = LocationTimezone(
          description: e['location']['timezone']['description'],
          offset: e['location']['timezone']['offset']);

      final location = UserLocation(
          city: e['location']['city'],
          state: e['location']['state'],
          country: e['location']['country'],
          postcode: e['location']['postcode'].toString(),
          coordinates: coordinates,
          street: street,
          timezone: timezone);

      return User(
        gender: e['gender'],
        email: e['email'],
        phone: e['phone'],
        nat: e['nat'],
        name: name,
        dob: dob,
        location: location,
      );
    }).toList();
    return users;
  }
}
