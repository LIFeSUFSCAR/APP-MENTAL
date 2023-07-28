import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../constants.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
            backgroundColor: kTextColorGreen,
            shadowColor: Colors.transparent,
            leading: BackButton(
              color: Colors.white,
              onPressed: () => {Navigator.pop(context)},
            ),
            title: FittedBox(child: Text("Sobre o aplicativo"))),
        body: Scrollbar(
            child: SingleChildScrollView(
                child: Column(
          children: [
            Html(
                data: "<p><b><u>Título do projeto:</u> Desenvolvimento participativo do " +
                    "APP Mental: uma intervenção digital baseada em evidências e centrada " +
                    "no sujeito, voltada para o autocuidado e suporte em saúde mental dos " +
                    "profissionais de saúde da atenção primária do SUS</b></p>" +
                    "<p><b><u>Financiamento:</u></b> Fundação de Amparo à Pesquisa do Estado de São Paulo - FAPESP. Processo no. 2021/08694-8</p>"
                        "<p><b><u>Realização:</u></b><br />" +
                    "Responsável pela equipe de saúde e coordenação do projeto: Jair Borges Barbosa Neto - Departamento de Medicina da UFSCar e Programa de Pós-Graduação em Gestão da Clínica - PPGGC/UFSCar<br />" +
                    "Responsável pela equipe de computação: Vânia Paula de Almeida Neris - Departamento de Computação da UFSCar e Programa de Pós-Graduação em Ciência da Computação - PPGCC/UFSCar<br />" +
                    "<p><b><u>Apoio:</u></b><br/>" +
                    "<i>Pró Reitoria de Extensão da UFSCar.</i> Parte dos materiais apresentados " +
                    "foram produzidos na atividade Comunicação social e saúde mental: " +
                    "comunicando com base na ciência (23112.022118/2020-89), entre maio e dezembro de 2021</p>" +
                    "<p><i>Daitan Labs Soluções em Tecnologia S/A</i> - apoiou o desenvolvimento do projeto piloto, " +
                    "realizando mentoração técnica nas etapas de implementação da solução e testes em critérios computacionais." +
                    " Profissionais envolvidos: Daitan Helder Jorge Huet Santos Cochofel, João Pedro São Gregório Silva" +
                    "<p><b><u>Equipe Saúde:</u></b><br/>" +
                    "Jair Borges Barbosa Neto - Coordenador do projeto<br/>" +
                    "Larissa Campagna Martini<br/>" +
                    "Karina Toledo da Silva Antonialli<br/>" +
                    "Esther Angélica Luiz Ferreira<br/>" +
                    "Juliana de Almeida Prado<br/>" +
                    "Mario Francisco Pereira Juruena<br/>" +
                    "Abraão Golfet de Souza <br/>" +
                    "Aline Augusto de Carvalho<br/>" +
                    "Ana Júlia Nociti Lopes Fernandes<br/>" +
                    "Maitê Menegazzo Allegretti Barbosa<br/>" +
                    "Rafaela Carla Piotto Rodrigues<br/>" +
                    "Leticia Crecca<br/>" +
                    "Fernanda Castilho Leite Fassina<br/>" +
                    "Marileide Gonçalves da Cruz<br/>" +
                    "Ana Elizabeth Mariante Corbellini<br/>" +
                    "Israel Roberto de Rienzo<br/>" +
                    "Camila Casé da Costa<br/>" +
                    "Ingrid Rios Sousa<br/>" +
                    "Victor Daciole Benedini<br/>" +
                    "Milena Sandri Ilhesca<br/>" +
                    "Gabriel Romeiro Olher<br/>" +
                    "Vitória Andrade Krebsky<br/>" +
                    "Gabriel Henrique da Silva Santana<br/>" +
                    "Vitória Caroline dos Santos Ferreira<br/>" +
                    "Thainara Pereira da Silva<br/>" +
                    "Raiane Silva Sousa <br/>" +
                    "Nayane Bonfim Rodrigues <br/>" +
                    "Letícia Sayuri Takahashi Novais</p>" +
                    "<p><b><u>Design:</u></b><br/>" +
                    "Abraão Golfet de Souza<br/>" +
                    "Raíssa Sansaloni</p>" +
                    "<p><b><u>Equipe Computação:</u></b><br/>" +
                    "Vania Paula de Almeida Neris<br/>" +
                    "Gustavo Lopes Dominguete<br/>" +
                    "Vivian Genaro Motti<br/>" +
                    "Luis Gustavo Rotoly Lima<br/>" +
                    "Isabella da Costa Pires<br/>" +
                    "Bruno Leonel Nunes<br/>" +
                    "Júlia Almeida<br/>" +
                    "Lucas Heidy Tuguimoto Garcia</p>" +
                    "<p><b><u>Equipe Estatística:</u></b><br/>" +
                    "Anderson Luiz Ara Souza<br/>" +
                    "Hélio Rubens de Carvalho Nunes</p>" +
                    "<p>Este projeto é financiado pela FAPESP (proc.2021/08694-8), CNPq e PROEX UFSCar. As opiniões, hipóteses, conclusões ou recomendações expressas neste material são de responsabilidade do(s) autor(es) e não necessariamente refletem a visão da FAPESP, CNPq e PROEX UFSCar.</p>"),
            Column(
              children: [
                Image.asset(
                  "assets/images/medicina.jpeg",
                  width: 161,
                  height: 100,
                ),
                Image.asset(
                  "assets/images/LogoDC.png",
                  width: 161,
                  height: 107,
                ),
                Image.asset(
                  "assets/images/Logomarca_UFSCAR.png",
                  width: 161,
                  height: 117,
                ),
                Image.asset(
                  "assets/images/fapesp.png.webp",
                  width: 161,
                  height: 91,
                ),
              ],
            )
          ],
        ))));
  }
}
