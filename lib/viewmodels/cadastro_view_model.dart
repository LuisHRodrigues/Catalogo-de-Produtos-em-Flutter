import 'package:flutter/material.dart';
import '../model/categoria.dart';
import '../viewmodels/produtos_view_model.dart';
import '../model/produto.dart';

class CadastroViewModel extends ChangeNotifier {
  CadastroViewModel(this._produtosViewModel);

  final ProdutosViewModel _produtosViewModel;

  Categoria? _categoriaSelecionada;
  bool _tentouSalvar = false;

  Categoria? get categoriaSelecionada => _categoriaSelecionada;

  String? get erroCategoria =>
      (_tentouSalvar && _categoriaSelecionada == null) ? 'Selecione uma categoria' : null;

  void selecionarCategoria(Categoria? categoria) {
    _categoriaSelecionada = categoria;
    notifyListeners();
  }

  double? _lerPreco(String? texto) =>
      double.tryParse((texto ?? '').trim().replaceAll(',', '.'));

  String? validarNome(String? valor) =>
      (valor == null || valor.trim().isEmpty) ? 'Informe o nome do produto' : null;

  String? validarPreco(String? valor) {
    final preco = _lerPreco(valor);
    return (preco == null || preco <= 0) ? 'Informe um preço válido' : null;
  }

  bool salvarProduto({required String nome, required String preco}){
    _tentouSalvar = true;
    final valido = validarNome(nome) == null && validarPreco(preco) == null && _categoriaSelecionada != null;

    if (!valido){
      notifyListeners();
      return false;
    }

    _produtosViewModel.adicionarProduto(
      Produto(
        nome: nome.trim(),
        preco: _lerPreco(preco)!,
        categoria: _categoriaSelecionada!,
      )
    );
    return true;
  }
}
