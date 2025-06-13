class ProdutoModel {
  int? id;
  String nome;
  String unidade;
  double qtdEstoque;
  double precoVenda;
  int status;
  double? custo;
  String? codigoBarra;
  DateTime? ultimaAlteracao;
  int excluido;

  ProdutoModel({
    this.id,
    required this.nome,
    required this.unidade,
    required this.qtdEstoque,
    required this.precoVenda,
    required this.status,
    this.custo,
    this.codigoBarra,
    this.ultimaAlteracao,
    this.excluido = 0,
  });

  factory ProdutoModel.fromJson(Map<String, dynamic> json) {
    return ProdutoModel(
      id: json['id'] != null ? int.tryParse(json['id'].toString()) : null,
      nome: json['nome']?.toString() ?? '',
      unidade: json['unidade']?.toString() ?? 'UN', // valor padrão
      qtdEstoque: double.tryParse(json['qtdEstoque']?.toString() ?? '0') ?? 0.0,
      precoVenda: double.tryParse(json['precoVenda']?.toString() ?? '0') ?? 0.0,
      status: int.tryParse(json['status']?.toString() ?? '0') ?? 0,
      custo: json['custo'] != null ? (json['custo'] as num).toDouble() : null,
      codigoBarra: json['codigoBarra']?.toString(),
      ultimaAlteracao: json['ultimaAlteracao'] != null ? DateTime.parse(json['ultimaAlteracao']) : null,
      excluido: json['excluido'] is int ? json['excluido'] : int.tryParse(json['excluido'].toString()) ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'unidade': unidade,
      'qtdEstoque': qtdEstoque,
      'precoVenda': precoVenda,
      'status': status,
      'custo': custo,
      'codigoBarra': codigoBarra,
      'ultimaAlteracao': ultimaAlteracao?.toIso8601String(),
      'excluido': excluido,
    };
  }
}
