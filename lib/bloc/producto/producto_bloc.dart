import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:login_flutter/models/models.dart';
import 'package:login_flutter/repositories/repositories.dart';
//import 'package:login_flutter/service/ApiService.dart';

part 'producto_event.dart';
part 'producto_state.dart';

class ProductoBloc extends Bloc<ProductoEvent, ProductoState> {
  ProductoRepository productoRepository;
  ProductoBloc({required this.productoRepository}) : super(ProductoInitial());

  @override
  Stream<ProductoState> mapEventToState(ProductoEvent event) async* {
    if (event is GetEvent) {
      try {
        yield ProductoLoading();
        //await Future.delayed(const Duration(seconds: 1));
        //  final data = await APIWeb().load(ProductoRepository.getProductos());
        final data = await productoRepository.getProductos();
        yield ProductoLoaded(data);
      } catch (er) {
        yield ProductoError(er.toString());
      }
    }
  }
}
