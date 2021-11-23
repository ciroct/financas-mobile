class UsuarioDTO {
  String login;
  String senha;

  UsuarioDTO({required this.login, required this.senha});

  factory UsuarioDTO.fromJson(Map<String, dynamic> json) {
    return UsuarioDTO(login: json['login'], senha: json['senha']);
  }

  Map<String, dynamic> toJson() => {
        'login': login,
        'senha': senha,
      };
}
