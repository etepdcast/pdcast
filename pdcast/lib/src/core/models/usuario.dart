class Usuario {
  // atributos
  String id;
  String nome;
  String email;
  String serie;
  String turma;
  bool ativo;
  bool professor;
  String dataCadastro;

  // construtor
  Usuario(
      {this.id,
      this.nome,
      this.email,
      this.serie,
      this.turma,
      this.ativo,
      this.dataCadastro,
      this.professor});

  Usuario.fromMap(Map snapshot, String id)
      : id = id ?? '',
        nome = snapshot['nome'] ?? '',
        email = snapshot['email'] ?? '',
        serie = snapshot['serie'] ?? '',
        turma = snapshot['turma'] ?? '',
        ativo = snapshot['ativo'] ?? '',
        dataCadastro = snapshot['dataCadastro'] ?? '',
        professor = snapshot['professor'] ?? '';

  toJson() {
    return {
      "nome": nome,
      "email": email,
      "serie": serie,
      "turma": turma,
      "ativo": ativo,
      "dataCadastro": dataCadastro,
      "professor": professor,
    };
  }
}
