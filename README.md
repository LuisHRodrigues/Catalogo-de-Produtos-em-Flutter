# Catálogo de Produtos

Aplicativo Flutter para cadastrar produtos, exibi-los em um catálogo e adicioná-los a um carrinho de compras. Os dados ficam apenas em memória: ao fechar o app, tudo é perdido.

## Funcionalidades

- **Catálogo:** lista de produtos com ícone da categoria, nome e preço.
- **Cadastro de produto:** formulário com nome, preço e categoria, com validação.
- **Carrinho:** o ícone no canto superior direito da AppBar mostra a quantidade de itens. Ao clicar, abre um card logo abaixo dele com os itens adicionados (rolável na vertical) e o total.
- **Comprar:** tocar no item ou no botão "Comprar" adiciona o produto ao carrinho e exibe uma SnackBar de confirmação.

### Categorias

| Categoria   | Ícone                         |
|-------------|-------------------------------|
| Alimentos   | `Icons.fastfood`              |
| Bebidas     | `Icons.local_drink`           |
| Limpeza     | `Icons.cleaning_services`     |
| Eletrônicos | `Icons.devices`               |

### Regras de validação

- **Nome:** obrigatório (não pode ser vazio ou só espaços).
- **Preço:** número maior que zero. Aceita vírgula ou ponto como separador decimal.
- **Categoria:** obrigatória.

## Arquitetura

O projeto segue o padrão **MVVM** usando apenas recursos nativos do Flutter (`ChangeNotifier` e `ListenableBuilder`), sem pacotes externos de gerenciamento de estado. Um único `ProdutosViewModel` é criado no `main` e passado por construtor às telas.

```
lib/
├── main.dart                         # Ponto de entrada e MaterialApp (ProdutosApp)
├── model/
│   ├── categoria.dart                # Enum Categoria
│   └── produto.dart                  # Classe Produto (nome, preço, categoria)
├── view/
│   ├── apresentacao.dart             # Extension de Categoria: ícone e formatação de preço
│   ├── lista_produto_page.dart       # Tela principal: catálogo, ícone do carrinho, FAB de cadastro
│   ├── carrinho_card.dart            # Card suspenso com os itens do carrinho e o total
│   └── cadastrar_produto_page.dart   # Tela do formulário de cadastro
└── viewmodels/
    ├── produtos_view_model.dart      # Estado global: lista de produtos e carrinho
    └── cadastro_view_model.dart      # Validação e regra de salvar o cadastro
```

### Camadas

- **Model:** `Produto` e `Categoria` são dados puros, sem dependência de UI. A formatação de ícone e preço fica na `extension` de `view/apresentacao.dart`.
- **ViewModel:**
  - `ProdutosViewModel` guarda as listas de produtos e do carrinho. Expõe-nas como listas imutáveis e chama `notifyListeners()` ao alterá-las.
  - `CadastroViewModel` guarda a categoria selecionada, valida os campos e, se tudo estiver válido, cria o `Produto` e o entrega ao `ProdutosViewModel`.
- **View:** os widgets só desenham o estado e delegam ações aos ViewModels. A tela principal é um `StatefulWidget` apenas para controlar se o card do carrinho está aberto.

### Fluxo

1. `main()` cria o `ProdutosViewModel` e inicia `ProdutosApp`.
2. `ListaProdutosPage` observa o ViewModel e reconstrói a lista e o contador do carrinho quando ele muda.
3. O botão `+` abre `CadastrarProdutoPage`. Ao salvar com sucesso, o produto entra no catálogo e a tela é fechada.
4. "Comprar" chama `adicionarAoCarrinho`, que atualiza o contador e o `CarrinhoCard`.

## Tecnologias

- Dart `^3.12.2`
- Flutter com Material 3 (cor base `#2F4A99`)
- Dependências: `cupertino_icons`
- Dev: `flutter_test`, `flutter_lints`

## Como executar

Pré-requisito: [Flutter SDK](https://docs.flutter.dev/get-started/install) instalado.

```bash
flutter pub get
flutter run            # escolha o dispositivo ou emulador
flutter run -d chrome  # para rodar na web
```

O repositório tem as plataformas Android e Web configuradas.
