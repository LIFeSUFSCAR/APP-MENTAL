import 'package:app_mental/Shared/Widgets/AppDrawer.dart';
import 'package:app_mental/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class TutorialScreen extends StatelessWidget {
  const TutorialScreen({Key? key}) : super(key: key);

  _goBackPage(BuildContext context) {
    Navigator.of(context).popUntil(ModalRoute.withName('/logged-home'));
    Navigator.of(context).pushNamed("/logged-home");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.green,
          shadowColor: Colors.transparent,
          title: Text("Tutorial"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => _goBackPage(context),
          ),
        ),
        body: Flex(direction: Axis.vertical, children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Scrollbar(
                child: SingleChildScrollView(
                    child: Html(
                        data: "<p><b>APP Mental - Instruções sobre o uso do aplicativo</b></p>" +
                            "<p>Nas próximas 16 semanas, você participará da pesquisa" +
                            " <i>“Desenvolvimento participativo do APP Mental: uma intervenção" +
                            " digital baseada em evidências e centrada no sujeito," +
                            " voltada para o autocuidado e suporte em saúde mental dos profissionais" +
                            " de saúde da atenção primária do SUS”.</i> </p>" +
                            "<p>Nas 12 primeiras semanas, você poderá interagir com o aplicativo: APP Mental (Avaliação, Promoção e Prevenção em Saúde Mental).</p>" +
                            "<p>Nas últimas 4 semanas, você não mais estará usando o aplicativo; você será convidado a participar de dois encontros (virtuais) com os pesquisadores para falar de sua experiência.</p>" +
                            "<p>A seguir Apresentaremos os recursos de cada uma das funcionalidades do APP Mental:</p>"
                                "<br/><p><b>Questionários</b></p>" +
                            "<p>Durante o uso do APP Mental, semanalmente, você terá a oportunidade de responder a questionários de avaliação da saúde mental. A ideia é que seja algo que contribua para sua saúde. Faça no seu ritmo! Em alguns momentos, você poderá não estar disposto a responder; não tem problema! Você pode interromper e retomar o questionário quando quiser. Iremos pedir que você responda a alguns questionários mais de uma vez, para saber se está acontecendo alguma mudança na sua saúde mental. Se você demorar a responder, pode ser que alguns questionários não mais fiquem disponíveis para a sua resposta.</p>" +
                            "<p>Os questionários, em sua maioria, são compostos por questões de múltipla escolha, relacionadas à sua saúde mental, é importante que você tente encontrar a resposta que mais se aproxima do que está acontecendo com você.</p>" +
                            "<p>Os questionários não fazem diagnóstico de transtornos mentais, mas podem dar indícios de sofrimento mental. Acompanharemos as suas respostas e entraremos em contato com você para conversarmos sobre elas caso seja necessário (somente a equipe da pesquisa terá acesso às suas respostas, que são confidenciais e sigilosas). Sempre que finalizar o preenchimento do questionário você receberá uma devolutiva, com uma breve interpretação destes, mas que não substituem a avaliação do profissional de referência.</p>"
                                "<p>As devolutivas serão enviadas após o preenchimento dos questionários, sempre acompanhadas de ícones:</p>" +
                            "<p> - Sintomas leves ou ausentes. Não significa que você não precise de ajuda.</p>" +
                            "<p> - Sintomas moderados. O APP vai sugerir algum apoio</p>" +
                            "<p> - Sintomas graves. Seu profissional de referência entrará em contato.</p>" +
                            "<p>Os questionários e as suas respostas poderão ser acessados na área “Questionários”, na tela inicial do aplicativo. Ela tem três abas distintas: “A responder”, “Avaliação semanal” e “Avaliação Geral”:</p>" +
                            "<p> - Na aba “a responder” você encontrará os questionários que podem ser respondidos por você na semana.</p>" +
                            "<p> - Na aba “avaliação semanal” você terá uma lista dos questionários que foram respondidos na semana.</p>" +
                            "<p> - Na aba “avaliação geral” você terá acesso aos gráficos gerados a partir das respostas fornecidas por você aos questionários. Esses gráficos serão atualizados automaticamente sempre que você responder aos questionários.</p>" +
                            "<p>As informações sobre sua saúde mental e sua opinião sobre esse processo de responder a esses questionários são muito importantes! </p>" +
                            "<br/><p><b>Diário livre</b></p>" +
                            "<p>Outro recurso que está disponível é o diário. Nele você pode fazer os registros que quiser, no momento que sentir necessidade. Esses registros podem ser feitos por áudio ou texto.</p>" +
                            "<p>A equipe do APP Mental não terá acesso a esses materiais, ou seja, seus registros no diário não serão armazenados em bancos de dados. Este é um recurso para você! </p>" +
                            "<p>Vale ressaltar que os arquivos de áudio podem ficar armazenados no seu celular, então caso não queira que estes registros fiquem acessíveis a outras pessoas que têm acesso ao seu aparelho celular, é importante incluir algum recurso de bloqueio do aparelho com senha. </p>" +
                            "<br/><p><b>Materiais educativos</b></p>" +
                            "<p>Você terá à sua disponibilidade diversos materiais de caráter educativo, abordando a promoção e prevenção em saúde. Você pode acessá-lo quando quiser. Nossa sugestão é acessar um dos materiais de 2 a 3 vezes por semana. Não se esqueça que o nosso intuito é de que seja algo que contribua com sua qualidade de vida, por isso, faça na frequência que julgar possível dentro de sua rotina. </p>" +
                            "<p>Você poderá, também, avaliar esses materiais com uma nota de zero a cinco ou deixar algum comentário por escrito. Para fazer essa avaliação está disponível um ícone no canto superior direito da tela de cada material educativo.</p> "
                                "<p>Ícone para avaliação dos materiais - basta clicar no ícone para avaliar.</p>" +
                            "<p>Sua devolutiva é muito importante para aprimorarmos o conteúdo do aplicativo!</p>" +
                            "<br/><p><b>Contatos</b></p>" +
                            "<p>Durante o período da pesquisa, podem surgir momentos em que você precise de alguma orientação ou acolhimento. Caso isso aconteça, você poderá acionar seu profissional de referência por meio do recurso do chat, disponível no APP Mental. </p>" +
                            "<p><b>Contatos de emergência</b></p>" +
                            "<p>Nesta área deixamos o contato do Centro de Valorização da Vida - 188, caso você queira ligar para conversar com eles. </p>" +
                            "<p>Você pode também colocar o contato de quem você quiser, como um contato de emergência para caso você queira ter um acesso rápido.</p>" +
                            "<p><b>Chat</b></p>" +
                            "<p>Nesta área do aplicativo você terá o acesso a um chat com um profissional de referência e a um pesquisador responsável, você poderá receber e enviar mensagens através deste recurso. </p>" +
                            "<p>Ressalta-se que a pesquisa não possui caráter de serviço de urgência / emergência. Neste sentido, seu/sua profissional de referência responderá o seu contato o mais breve possível. Caso haja a necessidade de pronto atendimento, procure a Unidade de Pronto Atendimento mais próxima. </p>" +
                            "<p><i><u>Recuperação de login e senha:</u></i> Caso você esqueça, ou queira modificar a sua senha, poderá, a qualquer momento, clicar em “esqueci minha senha” na área de login do aplicativo, que um novo email será enviado para que a senha seja redefinida.</p>" +
                            "<p><b>Seja bem-vindo(a) ao APP Mental!</b></p>")),
              ),
            ),
          ),
        ]));
  }
}
