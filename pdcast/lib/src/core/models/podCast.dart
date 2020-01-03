class PodCast {
  // atributos
  String id;
  String nome;
  String autor;
  String pathAudio;
  String pathICon;
  String categoria;
  String resumo;
  String dataCriacao;

  // construtor
  PodCast(
      {this.id,
      this.nome,
      this.autor,
      this.pathAudio,
      this.pathICon,
      this.categoria,
      this.resumo,
      this.dataCriacao
  });

  PodCast.fromMap(Map snapshot, String id)
      : id = id ?? '',
        nome = snapshot['nome'] ?? '',
        autor = snapshot['autor'] ?? '',
        pathAudio = snapshot['pathAudio'] ?? '',
        pathICon = snapshot['pathICon'] ?? '',
        categoria = snapshot['categoria'] ?? '',
        resumo = snapshot['resumo'] ?? '',
        dataCriacao = snapshot['dataCriacao'] ?? '';

  toJson() {
    return {
      "nome": nome,
      "autor": autor,
      "pathAudio": pathAudio,
      "pathICon": pathICon,
      "categoria": categoria,
      "resumo": resumo,
      "dataCriacao": dataCriacao,
    };
  }

}
