import '../repositories/cliente_repository.dart';
import '../repositories/produto_repository.dart';
import '../repositories/usuario_repository.dart';
import '../models/cliente_model.dart';
import '../models/produto_model.dart';
import '../models/usuario_model.dart';
import '../models/pedido_model.dart';
import 'api_service.dart';

class SincronizacaoService {
  final ApiService api;

  SincronizacaoService(this.api);

  Future<void> sincronizarUsuarios(UsuarioRepository repo) async {
    final dados = await api.fetchList('usuarios');
    for (var json in dados) {
      final usuario = UsuarioModel.fromJson(json);
      await repo.insert(usuario);
    }
  }

  Future<void> sincronizarClientes(ClienteRepository repo) async {
    final dados = await api.fetchList('clientes');
    for (var json in dados) {
      final cliente = ClienteModel.fromJson(json);
      await repo.insert(cliente);
    }
  }

  Future<void> sincronizarProdutos(ProdutoRepository repo) async {
    final dados = await api.fetchList('produtos');
    for (var json in dados) {
      final produto = ProdutoModel.fromJson(json);
      await repo.insert(produto);
    }
  }

  Future<void> enviarUsuarios(List<UsuarioModel> usuarios) async {
    await api.postList('usuarios', usuarios.map((u) => u.toJson()).toList());
  }

  Future<void> enviarClientes(List<ClienteModel> clientes) async {
    await api.postList('clientes', clientes.map((c) => c.toJson()).toList());
  }

  Future<void> enviarProdutos(List<ProdutoModel> produtos) async {
    await api.postList('produtos', produtos.map((p) => p.toJson()).toList());
  }

  Future<void> enviarPedidos(List<PedidoModel> pedidos) async {
    await api.postList('pedidos', pedidos.map((p) => p.toJson()).toList());
  }

  Future<void> excluirRemotamente(String endpoint, int id) async {
    await api.deleteById(endpoint, id);
  }
}
