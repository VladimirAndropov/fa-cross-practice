import 'package:dart_application_1/dart_application_1.dart' as dart_application_1;
enum DoorCommand{open, close, prepare}

class Student{
  void hello(){
    print("hello vv!");
  }
}
void main(List<String> arguments) {
  var a = 5;
  int b = 5;
  String c = "text";
  double d = 4.5;
  dynamic e = "assasasas";
  e = 45;
  print(a);
  print('text $b $c $d $e ');
  List<int> list = [1,2,3,3,3,3];
  var list2 = <int>[1,2,3];
  int len = list2.length;
  print(len);
  list[2]=5;
  print(list);
  var list3 = <int>[0,...list,99];
  list3.addAll(list);
  list3.add(0);
  print(list3);
  Map<String, int> map = {
    "first": 222
  };
  var map2 = <int,String>{
    222:"first" 
  };

  var dc = DoorCommand.open;

  switch(dc){
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
  void hey(Student? st){
    st?.hello();
  }

  // var vasya = Student();
  Student? vasya = Student();

  vasya = null;
  hey(vasya);

  void hey3(String name, int age, [String? bith]){
    print("Hey, $name with $age and bithday at $bith");
  }
  hey3('Vasya',22);

  void hey3d(String name, int age, [String bith = 'may']){
    print('Hey, $name with $age and bithday at $bith');
  }
  hey3d('Vasya',22);

  void hey4d({String? name, int age = 21, required String bith}){
    print('Hey, $name with $age and bithday at $bith');
  }
  hey4d(age: 22, bith: 'may');

  int add(int a, int b)=> a+b;
  print('Hello world: ${dart_application_1.calculate()}!');

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


  Stream<int>  myGenerator2() async* {
    yield 11;
    yield 2;
    yield 333;
  }

  Stream<int> seq = myGenerator2();
  seq.listen(print);





}
