import 'package:flutter/material.dart';

import 'viewmodels/produtos_view_model.dart';
import 'view/lista_produto_page.dart';

void main() => runApp(ProdutosApp(viewModel: ProdutosViewModel()));

class ProdutosApp extends StatelessWidget {
  const ProdutosApp({super.key, required this.viewModel});

  final ProdutosViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catálogo de Produtos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF2F4A99),
      ),
      home: ListaProdutosPage(viewModel: viewModel),
    );
  }
}
