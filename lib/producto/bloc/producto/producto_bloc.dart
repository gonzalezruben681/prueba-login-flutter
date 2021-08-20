import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:login_flutter/producto/models/models.dart';
import 'package:login_flutter/producto/repositories/repositories.dart';

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
        final data = await productoRepository.getProductos();
        yield ProductoLoaded(data);
      } catch (er) {
        yield ProductoError(er.toString());
      }
    }
  }
}
