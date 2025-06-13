class UsuarioModel {
  int? id;
  String nome;
  String senha;
  DateTime? ultimaAlteracao;

  UsuarioModel({
    this.id,
    required this.nome,
    required this.senha,
    this.ultimaAlteracao,
  });

  factory UsuarioModel.fromJson(Map<String, dynamic> json) {
    return UsuarioModel(
      id: json['id'],
      nome: json['nome'],
      senha: json['senha'],
      ultimaAlteracao:
          json['ultimaAlteracao'] != null
              ? DateTime.parse(json['ultimaAlteracao'])
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'senha': senha,
      'ultimaAlteracao': ultimaAlteracao?.toIso8601String(),
    };
  }
}