import 'package:flutter/material.dart';

import '../model/produto.dart';
import '../viewmodels/produtos_view_model.dart';
import 'apresentacao.dart';
import 'cadastrar_produto_page.dart';


class ListaProdutosPage extends StatelessWidget {
  const ListaProdutosPage({super.key, required this.viewModel});

  final ProdutosViewModel viewModel;

  void _comprar(BuildContext context, Produto produto) {
    final mensagem = viewModel.adicionarAoCarrinho(produto);
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(mensagem)));
  }

  @override
  Widget build(BuildContext context) {
    final cores = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Catálogo de Produtos'),
        backgroundColor: cores.primary,
        foregroundColor: cores.onPrimary,
      ),
      body: ListenableBuilder(
        listenable: viewModel,
        builder: (context, _) {
          final produtos = viewModel.produtos;
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: produtos.length,
            itemBuilder: (context, index) {
              final produto = produtos[index];
              return Card(
                child: ListTile(
                  onTap: () => _comprar(context, produto),
                  leading: CircleAvatar(
                    backgroundColor: cores.primaryContainer,
                    foregroundColor: cores.onPrimaryContainer,
                    child: Icon(produto.categoria.getIcone()),
                  ),
                  title: Text(produto.nome),
                  subtitle: Text(
                    'R\$ ${produto.preco.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: cores.primary,
                    ),
                  ),
                  trailing: ElevatedButton(
                    onPressed: () => _comprar(context, produto),
                    child: const Text('Comprar'),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Cadastrar produto',
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CadastrarProdutoPage(produtosViewModel: viewModel),
          ),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}