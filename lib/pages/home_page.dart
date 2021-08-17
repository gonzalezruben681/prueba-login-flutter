import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_flutter/bloc/producto/producto_bloc.dart';

import 'package:login_flutter/models/models.dart';
import 'package:login_flutter/widgets/widgets.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Productos'),
        leading: IconButton(
          icon: Icon(Icons.login_outlined),
          onPressed: () {
            //authService.logout();
            Navigator.pushReplacementNamed(context, 'login');
          },
        ),
      ),
      body: BlocBuilder<ProductoBloc, ProductoState>(
        bloc: BlocProvider.of<ProductoBloc>(context)..add(GetEvent()),
        builder: (context, state) {
          if (state is ProductoLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ProductoLoaded) {
            return _listaProductos(state.producto);
          } else {
            return Text('Error de conexión');
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          /*   productsService.selectedProduct =
              new Product(disponible: false, titulo: '', valor: 0);
          Navigator.pushNamed(context, 'product'); */
        },
      ),
    );
  }

  Widget _listaProductos(List<Product> productos) => ListView.builder(
      itemCount: productos.length,
      itemBuilder: (BuildContext context, int index) => GestureDetector(
            onTap: () {
              // productos.selectedProduct = productos.products[index].copy();
              //  Navigator.pushNamed(context, 'product');
            },
            child: ProductCard(
              product: productos[index],
            ),
          ));
}
