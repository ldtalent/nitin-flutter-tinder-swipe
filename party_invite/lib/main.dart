import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Party Invite',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {	        
        '/': (context) => PartyInvite(),	        
        '/invites': (context) => InvitePage(), 	      
      },
    );
  }
}

List<String> lst = List<String>();


class PartyInvite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        actions: <Widget>[
          GestureDetector(
              onTap: (){
                  Navigator.pushNamed(context, '/invites', arguments: lst);	
              },
              child: Container(
              padding: EdgeInsets.all(16),
              child: Icon(Icons.content_paste, color: Colors.black,)
            ),
          ),
        ],
        title: Center(
          child: Text(
            'Party Invite', 
            style: TextStyle(
              fontFamily: 'cursive', 
              fontSize: 32, 
              color: Colors.black,
            ),
          )
        ),
      ),
      body: MyBody(),
    );
  }
}

List<String> items = <String>[
  'Adam',
  'Eve',
  'Robert',
  'Taylor',
  'Micheal',
  'Rick',
  'Morty',
  'Ted',
  'Marshall',
  'Barney',
  'Swarley',
  'Robin',
  'Dora',
  'Sandy',
];

typedef func = void Function(int index);


class MyBody extends StatefulWidget {
  @override
  _MyBodyState createState() => _MyBodyState();
}

class _MyBodyState extends State<MyBody> {

  void call(int index){
    setState(() {
      items.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Person(name: '${items[index]}', idx: index, cb: call);
    },
    );
  }
}


class Person extends StatelessWidget {

  Person({this.name, this.cb, this.idx});
  final String name;
  final func cb;
  final int idx;

  

  @override
  Widget build(BuildContext context) {

    //RandomColor _randomColor = RandomColor();

    //Color _color = _randomColor.randomColor(colorBrightness: ColorBrightness.light);
    return Container(
      //decoration: BoxDecoration(color: _color),
      child: Dismissible(
        key: Key(name),
        background: Container(
          color: Colors.green,
          padding: EdgeInsets.symmetric(horizontal: 10),
          alignment: AlignmentDirectional.centerStart,
          child: Icon(Icons.check_box),
        ),

        secondaryBackground: Container(
          color: Colors.redAccent,
          padding: EdgeInsets.symmetric(horizontal: 10),
          alignment: AlignmentDirectional.centerEnd,
          child: Icon(Icons.backspace),
        ),
        
        onDismissed: (DismissDirection d){
          if(d == DismissDirection.startToEnd){
            //print("Add");
            cb(idx);
            lst.add(name);
            print(lst);
          }
          else{
            cb(idx);
            //print("Delete");
          }
        }, 
        child: ListTile(
          leading: CircleAvatar(child: Text(name[0]),),
          title: Text(name, style: TextStyle(fontWeight: FontWeight.w800)),
      )),
    );
  }
}


class InvitePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Center(
          child: Text(
            'Party Invite', 
            style: TextStyle(
              fontFamily: 'cursive', 
              fontSize: 32, 
              color: Colors.black,
            ),
          )
        ),
      ),
      body: MyInvites(),
    );
  }
}


class MyInvites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> args = ModalRoute.of(context).settings.arguments;
    print(args);
    return ListView.builder(
      itemCount: args.length,
      itemBuilder: (context, index) {
        
        return ListTile(
          title: Text(args[index]),
          leading: CircleAvatar(child: Text(args[index][0]),),
        );
    },
    );;
  }
}