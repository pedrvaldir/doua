class DoaTime {
  fakeDelay() async {
    return await Future.delayed(const Duration(seconds: 5), () {});
  }
}

class Enum {
  static final String dbPathAssets = "assets/data/";

  static final int versaoDbInicial = 6;

  static final String localhost = "http://192.168.30.103:5000/";


  static final String ambiente = " - Desenvolvimento";

  static String wsPath() {
    /**LOCALHOST**/
    // String path  = localhost;

    /**DESENV**/
    String path = "desenv";
    /**HOMOLOG**/
    // String path  = homolog;
    /**PRODUCAO**/
    // String path  = producao;

    return path;
  }

  //Maquina/SalvarMaquinaAvariaJson

//  static PATH_SERVER() {
//    /**DESENV e LOCAL**/
//   // return new StringBuffer("http://").append(ServidorBI.SelecionarServidor().getDomServer()).append("/Sites/CamposDealer/CamposDealerDesenv/WS/arquivos/").toString();
//
//  }
}

class EndPoints {
  //tutoriais
  static final String getOnboarding = "api/v1/tutoriais";

  //Ações
  static final String getAcoes = "api/v1/acoes";

  //Comentario
  static final String postComentario = "api/v1/comentarios/acoes/";
  static final String comentario = "/comentarios";
  static final String getComentario = "/api/v1/comentarios/acao/";

  //Localizações
  static final String getLocals = "api/v1/localizacoes";

  //Localizações
  static final String postAcoes = "api/v1/acoes";
}
