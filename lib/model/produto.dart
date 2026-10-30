import 'categoria.dart';

class Produto {
  final String nome;
  final double preco;
  final Categoria categoria;

  Produto({
    required this.nome,
    required this.preco,
    required this.categoria,
  });

  String getPrecoFormatado() {
    return 'R\$ ${preco.toStringAsFixed(2).replaceAll('.', ',')}';
  }

}