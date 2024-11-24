
// Это пример работы с синтаксисом Dart
// Шпаргалка. Но она не особо пригодится


import 'package:dart_application_1/dart_application_1.dart' as dart_application_1;
import 'package:dart_application_1/hey.dart';// show hey hide hey3d;

enum DoorCommand{open, close, prepare}

// class Student{
//   void hello(){
//     print("hello vv");
//   }
// }



void main(List<String> arguments) {


  int a = 2;

  var b = 3;
  
  double c = 4.5;

  var d = "4.7";

   String t = "fgf fhtf";

   String conc = t.substring(1,4) + t[6];
   
dynamic dyn = "kjkkj";

   dyn = 18;

   var dd = double.parse(d);

   var st = dd.toString;

   print(b + c);
   print('$b $c');
print(t[6]);
print(conc);


    List<int> arr = [4,5,7,7, 7];
    var arr2 = <int>[1,2,3];

   print(arr.length);
   arr2.addAll(arr);
  // for (var i in arr2) if (arr2.elementAt[i]==6) arr2[i]=6;    
   arr2[5]=6;
    var arr3 = <int>[0,...arr2, 99];

print(arr3);

   var trunc =Set.from(arr3);
  
  Map<int,String> mmm = {
    1:"asd",
  
  };
   var mm = <int,String>{
1:"klk",
};

print(trunc);



var dc =DoorCommand.open;

switch (dc) {
  prepare:
  case DoorCommand.prepare:
       print("prepare");
       break;
  case DoorCommand.open:
   print("open");
       continue prepare;
  case DoorCommand.close:
   print("close");
    continue prepare;
  default:
  print("not door");
}



// // void hey(Student st){
//   void hey(Student? st){
// // st.hello();
// st?.hello();  // if (st !=0) {st.hello()} 
// }

//   //  var vasya = Student();
//       // vasya = Null;
//       Student? vasya = Student();
//       vasya = null;
//         hey(vasya);



//  void hey2(String str){
//     print('Hey, $str');  
// }

//   hey2('Vasya');

//  void hey3(String name, int age, [String? bith]){
//     print('Hey, $name with  $age and bithday at $bith');  
// }
  


//   hey3('Vasya', 22);

//    void hey3d(String name, int age, [String bith = 'may']){
//     print('Hey, $name with  $age and bithday at $bith');  
// }
  

//   hey3d('Vasya', 22);

//  void hey4({ String? name, 
//              int age=21, 
//             required String bith}){
//     print('Hey, $name with  $age and bithday at $bith');  
// }


//   hey4(age: 22, bith: 'may');



int add(int a, int b) => a+b;

 

//synchro generator
 Iterable<int> myGenerator() sync* {
    yield 11;
    yield 2;
    yield 333;
 }

var result = <int>[];
for(var i in myGenerator()){
  result.add(i);
}
  print(result);

//asynchro gen 
 Stream<int> myGenerator2() async* {
    yield 4;
    yield 5;
    yield 66;
 }


Stream<int> seq = myGenerator2();
  seq.listen(print);

  print('Hello world: ${dart_application_1.calculate()}!');

Student? vasya = Student();
      // vasya = null;
         hey(vasya);

}

