import 'package:flutter/material.dart';

import '../model/produto.dart';
import '../viewmodels/produtos_view_model.dart';
import 'apresentacao.dart';
import 'cadastrar_produto_page.dart';
import 'carrinho_card.dart';

class ListaProdutosPage extends StatefulWidget {
  const ListaProdutosPage({super.key, required this.viewModel});

  final ProdutosViewModel viewModel;

  @override
  State<ListaProdutosPage> createState() => _ListaProdutosPageState();
}

class _ListaProdutosPageState extends State<ListaProdutosPage> {
  ProdutosViewModel get viewModel => widget.viewModel;
  bool _carrinhoAberto = false;

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
        actions: [
          ListenableBuilder(
            listenable: viewModel,
            builder: (context, _) => IconButton(
              tooltip: 'Carrinho',
              onPressed: () =>
                  setState(() => _carrinhoAberto = !_carrinhoAberto),
              icon: Badge(
                isLabelVisible: viewModel.carrinho.isNotEmpty,
                label: Text('${viewModel.carrinho.length}'),
                child: const Icon(Icons.shopping_cart),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          _buildLista(context, cores),
          if (_carrinhoAberto)
            Positioned(
              top: 0,
              right: 8,
              child: CarrinhoCard(viewModel: viewModel),
            ),
        ],
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

  Widget _buildLista(BuildContext context, ColorScheme cores) {
    return ListenableBuilder(
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
    );
  }
}
