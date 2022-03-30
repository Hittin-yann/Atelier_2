import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/events/event_details.dart';
import '../data/events_collection.dart';


class Event extends StatefulWidget {
  const Event({Key? key}) : super(key: key);

  static String get route => "/allEvents";

  @override
  State<Event> createState() => _EventState();
}

class _EventState extends State<Event> {
  @override
  Widget build(BuildContext context) {
    return Consumer<EventsCollection>(
      builder: (context, eventCollection, child) {
        return FutureBuilder(
          future: eventCollection.getEvents(),
          builder: (context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              return Center(
                child: ListView.builder(
                  itemCount: snapshot.data.length,
                  padding: const EdgeInsets.only(top: 15.0),
                  itemBuilder: (context, index) {
                    return Card(
                      color: Colors.lightGreen[300],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             Center(
                              child: Text(
                                snapshot.data[index].titre,
                                style: const TextStyle(
                                    fontSize: 19, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ),
                           Text(
                              'Le '+snapshot.data[index].date.toString(),
                              style: const TextStyle(fontSize: 17),
                            ),
                             Text(
                             'Lieu: '+snapshot.data[index].lieu,
                              style: const TextStyle(fontSize: 17),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Ajouter le '+snapshot.data[index].createdAt.toString(),
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            ButtonBar(
                              alignment: MainAxisAlignment.start,
                              children: [
                                TextButton(
                                  child: const Text('voir plus'),
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, EventDetails.route);
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                    /*  ListTile(
                      title: Text(snapshot.data[index].titre),
                      subtitle: Text(snapshot.data[index].lieu),
                    /*   leading: const Icon(
                        Icons.person,
                        color: Colors.deepPurple,
                      ), */
                      trailing: TextButton(
                        child: const Text('voir plus'),
                        onPressed: () {
                          Navigator.pushNamed(context, EventDetails.route);
                        },
                      ),
                    ); */
                  },
                ),
              );
            } else {
              return Container(
                padding: const EdgeInsets.all(50),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        );
      },
    );
  }
}