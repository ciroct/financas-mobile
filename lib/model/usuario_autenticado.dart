class UsuarioAutenticado {
  String nome;
  Set<String> perfis;
  String token;
  int contaId;

  UsuarioAutenticado(
      {required this.nome,
      required this.perfis,
      required this.token,
      required this.contaId});

  factory UsuarioAutenticado.fromJson(Map<String, dynamic> json) {
    Set<String> perfis = {...json['profile']};
    return UsuarioAutenticado(
        nome: json['username'],
        perfis: perfis,
        token: json['token'],
        contaId: json['contaId']);
  }

  Map<String, dynamic> toJson() =>
      {'login': nome, 'perfis': perfis, 'token': token, 'contaId': contaId};

  @override
  String toString() => '{ $nome, $perfis, $token, $contaId }';
}
