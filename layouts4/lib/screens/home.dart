import 'package:flutter/material.dart';
import 'product_item.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {


  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: const EdgeInsets.all(20),
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: [
        ProductItem(),
        Container(
        padding: const EdgeInsets.all(8),
        color: Colors.teal[200],
        child: const Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis non lacus magna. Mauris at hendrerit elit. Etiam vehicula accumsan placerat. Nulla at diam id nunc laoreet blandit sed nec nisl. Integer finibus massa molestie elit pellentesque, vitae accumsan risus porta. In aliquam ante non felis accumsan imperdiet. Etiam quis vulputate arcu, at pulvinar diam. '),
      ),
        Container(
      padding: const EdgeInsets.all(8),
      color: Colors.teal[200],
      child: const Text('Heed not the rabble'),
    ),
    Container(
      padding: const EdgeInsets.all(8),
      color: Colors.teal[300],
      child: const Text('Sound of screams but the'),
    ),
    Container(
      padding: const EdgeInsets.all(8),
      color: Colors.teal[400],
      child: const Text('Who scream'),
    ),
    Container(
      padding: const EdgeInsets.all(8),
      color: Colors.teal[500],
      child: const Text('Revolution is coming...'),
    ),
    Container(
      padding: const EdgeInsets.all(8),
      color: Colors.teal[600],
      child: const Text('Revolution, they...'),
    ),
    Container(
      padding: const EdgeInsets.all(8),
      color: Colors.teal[300],
      child: const Text('Sound of screams but the'),
    ),
    Container(
      padding: const EdgeInsets.all(8),
      color: Colors.teal[400],
      child: const Text('Who scream'),
    ),
    Container(
      padding: const EdgeInsets.all(8),
      color: Colors.teal[500],
      child: const Text('Revolution is coming...'),
    ),
    Container(
      padding: const EdgeInsets.all(8),
      color: Colors.teal[600],
      child: const Text('Revolution, they...'),
    ),
      ],
    );
  }
  
}