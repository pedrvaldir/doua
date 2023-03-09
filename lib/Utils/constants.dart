

class DoaTime {
  fakeDelay ()async {
     return await Future.delayed(const Duration(seconds: 5), () {});
  }
}
class Enum {
  static final String dbPathAssets = "assets/data/";

  static final int versaoDbInicial = 6;


  static final String localhost =
      "http://192.168.30.103:5000/";

  static final String desenv =
      "https://fruitsproject.herokuapp.com/";

  static final String homolog =
      "https://fruitsproject.herokuapp.com/";

  static final String producao =
      "https://fruitsproject.herokuapp.com/";

  static final String ambiente = " - Desenvolvimento";

  static String wsPath() {

    /**LOCALHOST**/
   // String path  = localhost;


    /**DESENV**/
    String path = desenv;
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
  static final String getOnboarding ="api/v1/tutoriais";

  //tutoriais
  static final String getAcoes ="api/v1/acoes";

  //User
  static final String postRegisterUser ="api/v1/user";

  //Fruit
  static final String getLocals ="api/v1/localizacoes";

  //Checklist
  static final String postChecklist ="api/v1/checklist";
  static final String getCheckList ="/checklist";

  //Receipting
  static final String postReceipt ="api/v1/receipting";
  static final String deleteReceipt ="api/v1/receipting";
  static final String getReceipt ="api/v1/receipting";
  static final String getReceiptAll ="api/v1/receipting?per_page=300";

  //Img
  static final String postImg ="api/v1/picture/upload";
  static final String getPictures100 ="pictures/100/100";
  static final String getPictures800 ="pictures/800/800";

  //Invoice
  static final String postInvoice ="api/v1/invoice/upload/";

  //User
  static final String postUser ="auth/login";
  static final String postRegisterMobile = "api/v1/mobile/user";

  //Token
  static final String getToken ="auth/mobile-token";

}
