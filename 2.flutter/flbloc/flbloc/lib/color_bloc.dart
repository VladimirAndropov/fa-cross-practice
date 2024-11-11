import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ColorEvent {
}
class RedColor extends ColorEvent {}
class GreenColor extends ColorEvent {}

class ColorBloc extends Bloc<ColorEvent, int> {
  ColorBloc() : super(0xFF4C36F4) {
    on<GreenColor>((event, emit) => emit(0xFF00FF00));
     on<RedColor>((event, emit) => emit(0xFFFF0000));

  }
  
  }