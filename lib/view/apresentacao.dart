import 'package:flutter/material.dart';
import '../model/categoria.dart';

extension CategoriaIcone on Categoria {
  IconData getIcone() {
    switch (this) {
      case Categoria.alimentos:
        return Icons.fastfood;
      case Categoria.bebidas:
        return Icons.local_drink;
      case Categoria.limpeza:
        return Icons.cleaning_services;
      case Categoria.eletronicos:
        return Icons.devices;
    }
  }

  String formatarPreco(double preco) {
    return 'R\$ ${preco.toStringAsFixed(2).replaceAll('.', ',')}';
  }
}
