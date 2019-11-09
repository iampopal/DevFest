import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devfest/data/assets.dart';
import 'package:devfest/data/database.dart';
import 'package:devfest/data/sizes.dart';
import 'package:devfest/model/agenda.dart';
import 'package:devfest/widget/agenda.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

enum AgendaType { General, Web, Ai, Android, Flutter, Cloud, NONE }

class AgendaPage extends StatefulWidget {
  AgendaPage({Key key}) : super(key: key);

  @override
  _AgendaPageState createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage> {
  bool isWeb = false,
      isAi = false,
      isCloud = false,
      isAndroid = false,
      isFlutter = false;

  bool isAgendaEnable(AgendaType agendaType) {
    switch (agendaType) {
      case AgendaType.Ai:
        return isAi;
      case AgendaType.Web:
        return isWeb;
      case AgendaType.Cloud:
        return isCloud;
      case AgendaType.Flutter:
        return isFlutter;
      case AgendaType.Android:
        return isAndroid;
      default:
        return true;
    }
  }

  enableAgenda(AgendaType agendaType) {
    switch (agendaType) {
      case AgendaType.Ai:
        isAi = !isAi;
        break;

      case AgendaType.Web:
        isWeb = !isWeb;
        break;

      case AgendaType.Cloud:
        isCloud = !isCloud;
        break;

      case AgendaType.Flutter:
        isFlutter = !isFlutter;
        break;

      case AgendaType.Android:
        isAndroid = !isAndroid;
        break;

      default:
        break;
    }
  }

  final agendaType = Agenda(
    dateTime: Timestamp.fromDate(DateTime.now()),
    title: "DevFest Key Notes",
    person: "Javid Mowahid",
  );

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Database.firebase().collection("agenda").snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        List<Agenda> agendaList = snapshot.data.documents
            .map((data) => Agenda.fromFirestore(data))
            .toList();

        return _buildAgendaGroups(context, agendaList);
      },
    );
  }

  _buildAgendaGroups(BuildContext context, List<Agenda> agendaList) {
    final List<Agenda> generalList = [],
        androidList = [],
        aiList = [],
        flutterList = [],
        cloudList = [],
        webList = [];

    for (final iAgenda in agendaList) {
      switch (Agenda.agendaType(iAgenda)) {
        case AgendaType.Android:
          androidList.add(iAgenda);
          break;
        case AgendaType.Ai:
          aiList.add(iAgenda);
          break;
        case AgendaType.Flutter:
          flutterList.add(iAgenda);
          break;
        case AgendaType.Cloud:
          cloudList.add(iAgenda);
          break;
        case AgendaType.Web:
          webList.add(iAgenda);
          break;
        default:
          generalList.add(iAgenda);
      }
    }

    return ListView(
      padding: EdgeInsets.all(21),
      children: <Widget>[
        _buildList(
          context: context,
          agendas: generalList,
          agendaType: AgendaType.General,
          primaryColor: Theme.of(context).accentColor,
          name: "",
          svgAsset: Assets.svg.web,
        ),
        _buildList(
          context: context,
          agendas: androidList,
          agendaType: AgendaType.Android,
          primaryColor: Colors.green,
          name: "Android",
          svgAsset: Assets.svg.android,
        ),
        _buildList(
          context: context,
          agendas: aiList,
          agendaType: AgendaType.Ai,
          primaryColor: Colors.red,
          name: "Artificial Intelligence",
          svgAsset: Assets.svg.ai,
        ),
        _buildList(
          context: context,
          agendas: flutterList,
          agendaType: AgendaType.Flutter,
          primaryColor: Colors.lightBlue[400],
          name: "Flutter",
          svgAsset: Assets.svg.flutter,
        ),
        _buildList(
          context: context,
          agendas: cloudList,
          agendaType: AgendaType.Cloud,
          primaryColor: Colors.blue,
          name: "Google Cloud",
          svgAsset: Assets.svg.cloud,
        ),
        _buildList(
          context: context,
          agendas: webList,
          agendaType: AgendaType.Web,
          primaryColor: Colors.amber,
          name: "Web",
          svgAsset: Assets.svg.web,
        ),
      ],
    );
  }

  _buildList({
    BuildContext context,
    List<Agenda> agendas,
    AgendaType agendaType,
    Color primaryColor,
    String name,
    String svgAsset,
  }) {
    return Container(
      padding: EdgeInsets.only(bottom: 12),
      child: Stack(
        children: <Widget>[
          _buildListAgenda(
            agendaType: agendaType,
            context: context,
            agendas: agendas,
            primaryColor: primaryColor,
            svgAsset: svgAsset,
          ),
          Visibility(
            visible: agendaType != AgendaType.General,
            child: _buildTitleAgenda(
              context: context,
              name: name,
              primaryColor: primaryColor,
              agendaType: agendaType,
              svgAsset: svgAsset,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyAgenda(String svgAsset, Color accentColor) {
    return Opacity(
      opacity: 0.3,
      child: Container(
        width: double.infinity,
        height: 100,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset(
                svgAsset,
                width: 50,
                color: accentColor,
              ),
              Text(
                "Stay tuned...",
                style: Theme.of(context).textTheme.button.copyWith(
                      color: accentColor,
                      fontWeight: FontWeight.normal,
                    ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _buildListAgenda({
    AgendaType agendaType,
    BuildContext context,
    List<Agenda> agendas,
    Color primaryColor,
    String svgAsset,
  }) {
    bool isEmpty = agendas.length == 0;

    return Visibility(
      maintainAnimation: true,
      maintainState: true,
      visible: agendaType == AgendaType.General || isAgendaEnable(agendaType),
      child: Container(
        padding:
            EdgeInsets.only(top: agendaType == AgendaType.General ? 0 : 30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Sizes.cardRound),
          color: Theme.of(context).cardColor,
          border: Border.all(color: Theme.of(context).dividerColor),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12.0),
          child: isEmpty
              ? _buildEmptyAgenda(svgAsset, primaryColor)
              : Column(
                  children: List.generate(agendas.length, (i) {
                    return AgendaWidtet(
                      agenda: agendas[i],
                      accentColor: primaryColor,
                    );
                  }),
                ),
        ),
      ),
    );
  }

  _buildTitleAgenda(
      {BuildContext context,
      String name,
      Color primaryColor,
      AgendaType agendaType,
      String svgAsset}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          setState(() {
            enableAgenda(agendaType);
          });
        });
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(Sizes.cardRound),
            ),
            border: Border.all(color: Theme.of(context).dividerColor),
            color: Theme.of(context).cardColor),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: SvgPicture.asset(
                        svgAsset,
                        width: 19,
                        color: primaryColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 2, left: 4),
                      child: Text(
                        name,
                        style: Theme.of(context)
                            .textTheme
                            .button
                            .apply(color: primaryColor),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.topCenter,
                child: RotationTransition(
                  turns: AlwaysStoppedAnimation(
                      (isAgendaEnable(agendaType) ? 180 : 0) / 360),
                  child: SvgPicture.asset(
                    Assets.svg.expand_arrow,
                    width: 21,
                    color: primaryColor,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
