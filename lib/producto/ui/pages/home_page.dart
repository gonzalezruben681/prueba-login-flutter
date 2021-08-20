import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_flutter/login/bloc/login/login_bloc.dart';
import 'package:login_flutter/producto/bloc/producto/producto_bloc.dart';
import 'package:login_flutter/producto/models/models.dart';
import 'package:login_flutter/producto/ui/widgets/widgets.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return new Future(() => false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Productos'),
          leading: IconButton(
            icon: Icon(Icons.login_outlined),
            onPressed: () {
              BlocProvider.of<LoginBloc>(context).add(LoginOut());
              //  Navigator.pushReplacementNamed(context, 'login');
            },
          ),
        ),
        body: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoggedOut) {
              //  Navigator.pushNamed(context, 'login');
              Navigator.pushReplacementNamed(context, 'login');
            }
          },
          child: BlocBuilder<ProductoBloc, ProductoState>(
            bloc: BlocProvider.of<ProductoBloc>(context)..add(GetEvent()),
            builder: (context, state) {
              if (state is ProductoLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is ProductoLoaded) {
                return _listaProductos(state.producto);
              } else {
                return Center(child: Text('Error al cargar los elementos'));
              }
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            /*  Navigator.pushNamed(context, 'product'); */
          },
        ),
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
