import '../model/produto.dart';
import '../model/categoria.dart';
//import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
class ProdutosViewModel extends ChangeNotifier {
  final List<Produto> _produtos = [];

  final List<Produto> _carrinho = [];

  List<Produto> get carrinho => List.unmodifiable(_carrinho);
  List<Produto> get produtos => List.unmodifiable(_produtos);

  // Adiciona um produto à lista de produtos e notifica os ouvintes
  void adicionarProduto(Produto produto) {
    _produtos.add(produto);
    notifyListeners();
  }

  //Adiciona ao carrinho e retorna uma mensagem para exibir na snackbar
  String adicionarAoCarrinho(Produto produto) {
    _carrinho.add(produto);
    return '${produto.nome} adicionado ao carrinho!';
  }
}