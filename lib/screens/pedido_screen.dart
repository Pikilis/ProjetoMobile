import 'package:flutter/material.dart';
import '../models/pedido_model.dart';
import '../models/pedido_item_model.dart';
import '../models/pedido_pagamento_model.dart';
import '../repositories/pedido_repository.dart';
import '../widgets/app_drawer.dart';

class PedidoScreen extends StatefulWidget {
  const PedidoScreen({super.key});

  @override
  State<PedidoScreen> createState() => _PedidoScreenState();
}

class _PedidoScreenState extends State<PedidoScreen> {
  final _repo = PedidoRepository();

  final _idCliente = TextEditingController();
  final _idUsuario = TextEditingController();
  final _valorItem = TextEditingController();
  final _valorPagamento = TextEditingController();

  final List<PedidoItemModel> _itens = [];
  final List<PedidoPagamentoModel> _pagamentos = [];

  double get totalItens =>
      _itens.fold(0.0, (sum, item) => sum + item.totalItem);
  double get totalPagamentos =>
      _pagamentos.fold(0.0, (sum, pag) => sum + pag.valor);

  void _adicionarItem() {
    final valor = double.tryParse(_valorItem.text) ?? 0.0;
    if (valor > 0) {
      setState(() {
        _itens.add(
          PedidoItemModel(
            idPedido: 0,
            idProduto: 0,
            quantidade: 1,
            totalItem: valor,
          ),
        );
        _valorItem.clear();
      });
    }
  }

  void _adicionarPagamento() {
    final valor = double.tryParse(_valorPagamento.text) ?? 0.0;
    if (valor > 0) {
      setState(() {
        _pagamentos.add(PedidoPagamentoModel(idPedido: 0, valor: valor));
        _valorPagamento.clear();
      });
    }
  }

  void _salvarPedido() async {
    if (_itens.isEmpty || _pagamentos.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Adicione itens e pagamentos')),
      );
      return;
    }

    if (totalItens != totalPagamentos) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Total de pagamentos deve bater com total dos itens'),
        ),
      );
      return;
    }

    final pedido = PedidoModel(
      idCliente: int.parse(_idCliente.text),
      idUsuario: int.parse(_idUsuario.text),
      totalPedido: totalItens,
      itens: _itens,
      pagamentos: _pagamentos,
    );

    await _repo.insert(pedido);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Pedido salvo com sucesso')));
    setState(() {
      _itens.clear();
      _pagamentos.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pedido')),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: _idCliente,
              decoration: const InputDecoration(labelText: 'ID Cliente'),
            ),
            TextField(
              controller: _idUsuario,
              decoration: const InputDecoration(labelText: 'ID Usuário'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _valorItem,
              decoration: const InputDecoration(labelText: 'Valor Item'),
            ),
            ElevatedButton(
              onPressed: _adicionarItem,
              child: const Text('Adicionar Item'),
            ),
            TextField(
              controller: _valorPagamento,
              decoration: const InputDecoration(labelText: 'Valor Pagamento'),
            ),
            ElevatedButton(
              onPressed: _adicionarPagamento,
              child: const Text('Adicionar Pagamento'),
            ),
            const Divider(),
            Text('Total Itens: $totalItens'),
            Text('Total Pagamentos: $totalPagamentos'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _salvarPedido,
              child: const Text('Salvar Pedido'),
            ),
          ],
        ),
      ),
    );
  }
}
