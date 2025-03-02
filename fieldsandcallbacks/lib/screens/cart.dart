import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  
  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: [
        ListTile(
            leading: Image(image: AssetImage('assets/img/guitar.jpg.auto.webp'),
            width: 80,
            height: 200,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.error);
            },
          ),
            title: Text("Gibson SG"),
            subtitle: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis non lacus magna."),
            trailing: IconButton(onPressed: () {
              print("Delete item");
            }, icon: Icon(Icons.delete)),
          ),
          Divider(height: 0,),
        Card(
          child: ListTile(
            leading: Image(image: AssetImage('assets/img/guitar.jpg.auto.webp'),
            width: 80,
            height: 200,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.error);
            },
          ),
            title: Text("Gibson SG"),
            subtitle: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis non lacus magna."),
            trailing: IconButton(onPressed: () {
              print("Delete item");
            }, icon: Icon(Icons.delete)),
          ),
        ),
        Card(
          child: ListTile(
            leading: CircleAvatar(child: Text("G"),),
            title: Text("Gibson SG"),
            subtitle: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis non lacus magna."),
            trailing: Icon(Icons.delete),
          ),
        ),
        Card(
          child: ListTile(
            leading: CircleAvatar(child: Text("G"),),
            title: Text("Gibson SG"),
            subtitle: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis non lacus magna."),
            trailing: Icon(Icons.delete),
          ),
        ),
        Card(
          child: ListTile(
            leading: CircleAvatar(child: Text("G"),),
            title: Text("Gibson SG"),
            subtitle: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis non lacus magna."),
            trailing: Icon(Icons.delete),
          ),
        ),
        Card(
          child: ListTile(
            leading: CircleAvatar(child: Text("G"),),
            title: Text("Instalacion alambrado"),
            subtitle: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis non lacus magna."),
            trailing: Icon(Icons.delete),
          ),
        ),
        // card con progressbar
        Card(
          child: Container(
            padding: const EdgeInsets.all(8),
            color: Colors.teal[200],
            child: LinearProgressIndicator(
                    value: 0.5,
                    color: Colors.blue,
               ),
          )
        ),
      ],
    );
  }
  
}