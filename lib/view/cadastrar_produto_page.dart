import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../model/categoria.dart';
import '../viewmodels/cadastro_view_model.dart';
import '../viewmodels/produtos_view_model.dart';
import 'apresentacao.dart';

/// View da tela de cadastro. A validação e a regra de salvar ficam no ViewModel.
class CadastrarProdutoPage extends StatefulWidget {
  const CadastrarProdutoPage({super.key, required this.produtosViewModel});

  final ProdutosViewModel produtosViewModel;

  @override
  State<CadastrarProdutoPage> createState() => _CadastrarProdutoPageState();
}

class _CadastrarProdutoPageState extends State<CadastrarProdutoPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _precoController = TextEditingController();
  late final CadastroViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = CadastroViewModel(widget.produtosViewModel);
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _precoController.dispose();
    _viewModel.dispose();
    super.dispose();
  }

  void _confirmar() {
    final formularioOk = _formKey.currentState!.validate();
    final salvo = _viewModel.salvarProduto(
      nome: _nomeController.text,
      preco: _precoController.text,
    );
    if (formularioOk && salvo) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final cores = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Produto'),
        backgroundColor: cores.primary,
        foregroundColor: cores.onPrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 8),
              TextFormField(
                controller: _nomeController,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  labelText: 'Nome do produto',
                  border: OutlineInputBorder(),
                ),
                validator: _viewModel.validarNome,
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _precoController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
                ],
                decoration: const InputDecoration(
                  labelText: 'Preço',
                  prefixText: 'R\$ ',
                  border: OutlineInputBorder(),
                ),
                validator: _viewModel.validarPreco,
              ),
              const SizedBox(height: 24),
              ListenableBuilder(
                listenable: _viewModel,
                builder: (context, _) {
                  return InputDecorator(
                    decoration: InputDecoration(
                      labelText: 'Categoria',
                      border: const OutlineInputBorder(),
                      errorText: _viewModel.erroCategoria,
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<Categoria>(
                        value: _viewModel.categoriaSelecionada,
                        isExpanded: true,
                        isDense: true,
                        hint: const Text('Selecione'),
                        items: Categoria.values
                            .map(
                              (c) => DropdownMenuItem<Categoria>(
                                value: c,
                                child: Row(
                                  children: [
                                    Icon(c.getIcone(), size: 20),
                                    const SizedBox(width: 12),
                                    Text(c.nome),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: _viewModel.selecionarCategoria,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 32),
              FilledButton(
                onPressed: _confirmar,
                child: const Text('Cadastrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
