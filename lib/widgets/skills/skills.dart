import 'package:flutter/material.dart';

class skillSection extends StatefulWidget {
  const skillSection({super.key});

  @override
  State<skillSection> createState() => _skillSectionState();
}

class _skillSectionState extends State<skillSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/logos/cpp.webp',height: 45),
              SizedBox(height: 8,),
              Text('C++',style: TextStyle(
                color: Color.fromARGB(255, 24, 30, 62),
                fontFamily: 'Alata',
                fontSize: 18,
                fontWeight: FontWeight.w300,
              ),)
            ],
          ),),
          Expanded(child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/logos/django.webp',height: 45),
              SizedBox(height: 8,),
              Text('Django',style: TextStyle(
                color: Color.fromARGB(255, 24, 30, 62),
                fontFamily: 'Alata',
                fontSize: 18,
                fontWeight: FontWeight.w300,
              ),)
            ],
          ),),
          Expanded(child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/logos/Dart.webp',height: 45),
              SizedBox(height: 8,),
              Text('Dart',style: TextStyle(
                color: Color.fromARGB(255, 24, 30, 62),
                fontFamily: 'Alata',
                fontSize: 18,
                fontWeight: FontWeight.w300,
              ),)
            ],
          ),),
          Expanded(child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/logos/flutter.webp',height: 45),
              SizedBox(height: 8,),
              Text('Flutter',style: TextStyle(
                color: Color.fromARGB(255, 24, 30, 62),
                fontFamily: 'Alata',
                fontSize: 18,
                fontWeight: FontWeight.w300,
              ),)
            ],
          ),),
          Expanded(child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/logos/Java.webp',height: 45),
              SizedBox(height: 8,),
              Text('Java',style: TextStyle(
                color: Color.fromARGB(255, 24, 30, 62),
                fontFamily: 'Alata',
                fontSize: 18,
                fontWeight: FontWeight.w300,
              ),)
            ],
          ),),
          Expanded(child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/logos/js.webp',height: 45),
              SizedBox(height: 8,),
              Text('JavaScript',style: TextStyle(
                color: Color.fromARGB(255, 24, 30, 62),
                fontFamily: 'Alata',
                fontSize: 18,
                fontWeight: FontWeight.w300,
              ),)
            ],
          ),),
          Expanded(child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/logos/html.webp',height: 45),
              SizedBox(height: 8,),
              Text('HTML5',style: TextStyle(
                color: Color.fromARGB(255, 24, 30, 62),
                fontFamily: 'Alata',
                fontSize: 18,
                fontWeight: FontWeight.w300,
              ),)
            ],
          ),),
          Expanded(child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/logos/ae.webp',height: 45),
              SizedBox(height: 8,),
              Text('After FX',style: TextStyle(
                color: Color.fromARGB(255, 24, 30, 62),
                fontFamily: 'Alata',
                fontSize: 18,
                fontWeight: FontWeight.w300,
              ),)
            ],
          ),),
          Expanded(child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/logos/pp.webp',height: 45),
              SizedBox(height: 8,),
              Text('PremPro',style: TextStyle(
                color: Color.fromARGB(255, 24, 30, 62),
                fontFamily: 'Alata',
                fontSize: 18,
                fontWeight: FontWeight.w300,
              ),)
            ],
          ),),
          Expanded(child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/logos/blender.webp',height: 45),
              SizedBox(height: 8,),
              Text('Blender',style: TextStyle(
                color: Color.fromARGB(255, 24, 30, 62),
                fontFamily: 'Alata',
                fontSize: 18,
                fontWeight: FontWeight.w300,
              ),)
            ],
          ),),
          Expanded(child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/logos/python.webp',height: 45),
              SizedBox(height: 8,),
              Text('Python',style: TextStyle(
                color: Color.fromARGB(255, 24, 30, 62),
                fontFamily: 'Alata',
                fontSize: 18,
                fontWeight: FontWeight.w300,
              ),)
            ],
          ),),
        ],
      ),
    );
  }
}