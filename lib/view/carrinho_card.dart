import 'package:flutter/material.dart';

import '../viewmodels/produtos_view_model.dart';
import 'apresentacao.dart';

class CarrinhoCard extends StatelessWidget {
  const CarrinhoCard({super.key, required this.viewModel});

  final ProdutosViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final cores = Theme.of(context).colorScheme;

    return Card(
      elevation: 6,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 320, maxHeight: 320),
        child: ListenableBuilder(
          listenable: viewModel,
          builder: (context, _) {
            final itens = viewModel.carrinho;
            if (itens.isEmpty) {
              return const Padding(
                padding: EdgeInsets.all(16),
                child: Text('Seu carrinho está vazio.'),
              );
            }
            final total = itens.fold<double>(0, (soma, p) => soma + p.preco);
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: itens.length,
                    itemBuilder: (context, index) {
                      final produto = itens[index];
                      return ListTile(
                        dense: true,
                        leading: CircleAvatar(
                          backgroundColor: cores.primaryContainer,
                          foregroundColor: cores.onPrimaryContainer,
                          child: Icon(produto.categoria.getIcone()),
                        ),
                        title: Text(produto.nome),
                        subtitle: Text(produto.getPrecoFormatado()),
                      );
                    },
                  ),
                ),
                const Divider(height: 1),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total'),
                      Text(
                        'R\$ ${total.toStringAsFixed(2).replaceAll('.', ',')}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
