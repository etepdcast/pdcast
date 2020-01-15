class PodCast {
  // atributos
  String id;
  String nome;
  String idAutor;
  String nomeAutor;
  String pathFile;
  String categoria;
  String resumo;
  String dataCriacao;

  // construtor
  PodCast(
      {this.id,
      this.nome,
      this.idAutor,
      this.nomeAutor,
      this.pathFile,
      this.categoria,
      this.resumo,
      this.dataCriacao
  });

  PodCast.fromMap(Map snapshot, String id)
      : id = id ?? '',
        nome = snapshot['nome'] ?? '',
        idAutor = snapshot['idAutor'] ?? '',
        nomeAutor = snapshot['nomeAutor'] ?? '',
        pathFile = snapshot['pathFile'] ?? '',
        categoria = snapshot['categoria'] ?? '',
        resumo = snapshot['resumo'] ?? '',
        dataCriacao = snapshot['dataCriacao'] ?? '';

  toJson() {
    return {
      "nome": nome,
      "idAutor": idAutor,
      "nomeAutor": nomeAutor,
      "pathFile": pathFile,
      "categoria": categoria,
      "resumo": resumo,
      "dataCriacao": dataCriacao,
    };
  }

}
