import 'package:flutter/material.dart';
import 'package:githubtest/provider/event_provider.dart';
import 'package:githubtest/service/event_service.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<ApiService>(
          create: (_) => ApiService(baseUrl: 'http://jsonplaceholder.typicode.com/todos'),
        ),
        ChangeNotifierProxyProvider<ApiService, EventProvider>(
          create: (_) => EventProvider(apiService: Provider.of<ApiService>(_, listen: false)),
          update: (_, apiService, eventProvider) => eventProvider!..apiService = apiService,
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Event App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final eventProvider = Provider.of<EventProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Event App'),
      ),
      body: FutureBuilder(
        future: eventProvider.fetchAndSetEvents(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Consumer<EventProvider>(
            builder: (context, eventProvider, child) {
              final events = eventProvider.events;
              return ListView.builder(
                itemCount: events.length,
                itemBuilder: (context, index) {
                  final event = events[index];
                  return ListTile(
                    title: Text(event.title),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
