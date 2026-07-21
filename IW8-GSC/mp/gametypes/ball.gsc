/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\ball.gsc
***********************************************/

main() {
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  var_0[0] = scripts\mp\utility\game::getgametype();
  var_0[1] = "_encstr_8218041DF5FA";
  scripts\mp\gameobjects::main(var_0);

  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread scripts\mp\utility\game::reinitializematchrulesonmigration();
  } else {
    scripts\mp\utility\game::registerscorelimitdvar(scripts\mp\utility\game::getgametype(), 20);
    scripts\mp\utility\game::registertimelimitdvar(scripts\mp\utility\game::getgametype(), 5);
    scripts\mp\utility\game::registerroundlimitdvar(scripts\mp\utility\game::getgametype(), 2);
    scripts\mp\utility\game::registerroundswitchdvar(scripts\mp\utility\game::getgametype(), 1, 0, 1);
    scripts\mp\utility\game::registerwinlimitdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registernumlivesdvar(scripts\mp\utility\game::getgametype(), 0);
  }

  level.carrierarmor = 100;
  updategametypedvars();
  level.teambased = 1;
  level.objectivebased = 0;
  level.disablebuddyspawn = 1;
  level.onprecachegametype = ::onprecachegametype;
  level.onstartgametype = ::onstartgametype;
  level.onplayerconnect = ::onplayerconnect;
  level.getspawnpoint = ::getspawnpoint;
  level.onplayerkilled = ::onplayerkilled;
  level.modeonspawnplayer = ::onspawnplayer;
  level.spawnnodetype = "_encstr_82860E5B83AF98161B36BE9B380BEE37";
  level.ballreset = 1;
  level.scorefrozenuntil = 0;
  level.ballpickupscorefrozen = 0;
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_A77707BFE8E01992AF";

  if(getdvarint("_encstr_B2020AE1F36BF74429D93F01"))
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_8A19042AB017" + game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"];

  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8BA20C24BBED0B3DB942D51BD77B"] = "_encstr_9134115D8DFAB798A6D7E4CACDE00BEE9B2B8C";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_88240EDAEFA3F1200738E071754F209A"] = "_encstr_9B260FA238815F69B827BE8729782DBBBD";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_9B260FA238815F69B827BE8729782DBBBD"] = "_encstr_9B260FA238815F69B827BE8729782DBBBD";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8EF410059E306533A830A79D117462B74338"] = "_encstr_8EF410059E306533A830A79D117462B74338";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_BD3911408A55A3BE8B085ED80FFFE35F7D93E8"] = "_encstr_BD3911408A55A3BE8B085ED80FFFE35F7D93E8";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8DC2116E3209D30EFEF26BBE1B5E23F677CDCD"] = "_encstr_8DC2116E3209D30EFEF26BBE1B5E23F677CDCD";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_922612DBA87F5D19372B13C66F175FF0E6F7ABC8"] = "_encstr_922612DBA87F5D19372B13C66F175FF0E6F7ABC8";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_ABD5120870982D838E0717BA4217C606EF603A3A"] = "_encstr_ABD5120870982D838E0717BA4217C606EF603A3A";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B6780E1C2C37CDF5D8B75B8363B2E8CA"] = "_encstr_8FC80E33C9D256E6C8D897FA0E0BDCE6";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_ACC211A359872B261B2D8B57032ED10B0B3099"] = "_encstr_ACC211A359872B261B2D8B57032ED10B0B3099";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8C92102F855A6B7EF443F8F80F0C138FA26F"] = "_encstr_8C92102F855A6B7EF443F8F80F0C138FA26F";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AB1C118D35C0B517587123FA1BB0BBAA388D05"] = "_encstr_AB1C118D35C0B517587123FA1BB0BBAA388D05";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_99F6102CC6B15EFA19C9DEE659BE0DC236CC"] = "_encstr_950D0E894BBA6DF03FCF483FA8878FF9";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_867F11D248353FD06951D2C76D9011736F609A"] = "_encstr_BAF011A12C1B99DDB0F2EB66272DACCD8CC6BC";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_95240C659372588E43623137DE6C"] = "_encstr_9B0B0C8D0BC11DAB39CAD7BDC4A9";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_93420C4255FBEA5D408FD1FD2A62"] = "_encstr_9B0B0C8D0BC11DAB39CAD7BDC4A9";
}

initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("_encstr_844814DCC639F5132C36C6AFE61BDB4E95680B93E45E", getmatchrulesdata("_encstr_BA11090A67D1131CABF0B8", "_encstr_83CE0BDC36B7C956A18527C95E"));
  setdynamicdvar("_encstr_8E78146ED89CBEC4B0B1367D6E1BED4E2B450D397BEE", getmatchrulesdata("_encstr_BA11090A67D1131CABF0B8", "_encstr_92B70BE68D7BE4CA8A0D9CEDEE"));
  setdynamicdvar("_encstr_A32318E64BF2018029C8D13F1B6163FB512D806D83D797FB98CB", getmatchrulesdata("_encstr_BA11090A67D1131CABF0B8", "_encstr_A6AD0FC29F8BCF59D2178B7F48072360BB"));
  setdynamicdvar("_encstr_ABAB168AE6BDA9024908C30783C3F992590B168749DF524D", getmatchrulesdata("_encstr_BA11090A67D1131CABF0B8", "_encstr_BED20DFF5AD20733D13F80C927F429"));
  setdynamicdvar("_encstr_8D30226E1B397D26C28D36AF38ED9BCDACDCCD96EDCD4956CDB24786F6B9325A3AB4DECD", getmatchrulesdata("_encstr_870D0F89161B36A1B7D6D6DBCD882CD1C2", "_encstr_B665199BA72B470D6BAFCBD728594A431023E03FB548EF70D45D68"));
  setdynamicdvar("_encstr_8D9E1DCDD8277D89C236C6BEC1ED9BCD2BE6B92DDEDCA4B2DC59E845D26BB2", getmatchrulesdata("_encstr_870D0F89161B36A1B7D6D6DBCD882CD1C2", "_encstr_8DD414B01F581A5F76BB4A1220DE97D230C16C218340"));
  setdynamicdvar("_encstr_B6541AF8EF12B69D42557190EAAAFFFB4D43C0B02FFB89755B3CFD0E", getmatchrulesdata("_encstr_AA0E0AC857A2833B80E68D1F", "_encstr_AF3F11AE30F788BD866368D8E7575B8A40125B"));
  setdynamicdvar("_encstr_8E3D1737C69CFA98B0D8D8AFD2918D952595CD2B1D452D5B59", getmatchrulesdata("_encstr_AA0E0AC857A2833B80E68D1F", "_encstr_83FA0E968C63594A9537B2A38A96D6CA"));
  setdynamicdvar("_encstr_818411F74B22B9F9EFA2C1CFAA1017B02013F7", 0);
}

onprecachegametype() {}

onstartgametype() {
  var_0 = scripts\mp\utility\game::inovertime();
  var_1 = game["_encstr_976315179550E2533320C2B9481503DF48419C61E3082F"] == 0;
  var_2 = scripts\mp\utility\game::istimetobeatvalid();

  if(var_0) {
    if(var_1) {
      setomnvar("_encstr_BDDF21D55AFA93DEAEB919F5D04B9BE8FABDCEB2C9E42DC8CAFAB0A3D10BB15BAC39B9", 1);
      setomnvar("_encstr_BD3721E0DA99B5B88F0E55C010274071714270F8C36ADB91A7176DC5F63F0829A73BA0", 1);
    } else if(var_2) {
      setomnvar("_encstr_BDDF21D55AFA93DEAEB919F5D04B9BE8FABDCEB2C9E42DC8CAFAB0A3D10BB15BAC39B9", scripts\engine\utility::ter_op(game["_encstr_A5D40F8ED2DACA51F62456C2D14556586B"] == game["_encstr_991C0AB9ED5B57161FE89B83"], 2, 3));
      setomnvar("_encstr_BD3721E0DA99B5B88F0E55C010274071714270F8C36ADB91A7176DC5F63F0829A73BA0", scripts\engine\utility::ter_op(game["_encstr_A5D40F8ED2DACA51F62456C2D14556586B"] == game["_encstr_B6A70A23CA6659DC91CAE4DC"], 2, 3));
    } else {
      setomnvar("_encstr_BDDF21D55AFA93DEAEB919F5D04B9BE8FABDCEB2C9E42DC8CAFAB0A3D10BB15BAC39B9", 4);
      setomnvar("_encstr_BD3721E0DA99B5B88F0E55C010274071714270F8C36ADB91A7176DC5F63F0829A73BA0", 4);
    }
  }

  if(!isDefined(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"]))
    game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"] = 0;

  if(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"]) {
    var_3 = game["_encstr_991C0AB9ED5B57161FE89B83"];
    var_4 = game["_encstr_B6A70A23CA6659DC91CAE4DC"];
    game["_encstr_991C0AB9ED5B57161FE89B83"] = var_4;
    game["_encstr_B6A70A23CA6659DC91CAE4DC"] = var_3;
  }

  foreach(var_6 in level.teamnamelist) {
    scripts\mp\utility\game::setobjectivetext(var_6, &"_encstr_8C1B10DFF1ACADD859536B57A6472471B429");

    if(level.splitscreen)
      scripts\mp\utility\game::setobjectivescoretext(var_6, &"_encstr_8C1B10DFF1ACADD859536B57A6472471B429");
    else
      scripts\mp\utility\game::setobjectivescoretext(var_6, &"_encstr_931F16B88EB8937D442FB1D1BFC79553C4A5083E5680C5E5");

    scripts\mp\utility\game::setobjectivehinttext(var_6, &"_encstr_8E0B15907A1395C753D8E17151A5FDADA3ECAF9B99DB7F");
  }

  setclientnamemode("_encstr_B6900C7BCDABC8AF2722B158FA17");
  _encstr_A275229BB19C2DC18EDCF2B61C97D90BDA59D1CB1C56B997F6899AF5C4B0D8C67176378D::ball_default_origins();
  level thread run_ball();

  if(level.possessionresetcondition != 0)
    _encstr_A275229BB19C2DC18EDCF2B61C97D90BDA59D1CB1C56B997F6899AF5C4B0D8C67176378D::initballtimer();
}

updategametypedvars() {
  _encstr_97EA20CDB1E44B1C3AB95EB583F2D9B05B95A3F2E056B9CBD8BDB66BF673B8D9CDB1::updatecommongametypedvars();
  level.scorecarry = scripts\mp\utility\dvars::dvarintvalue("_encstr_83CE0BDC36B7C956A18527C95E", 2, 1, 9);
  level.scorethrow = scripts\mp\utility\dvars::dvarintvalue("_encstr_92B70BE68D7BE4CA8A0D9CEDEE", 1, 1, 9);
  level.satellitecount = scripts\mp\utility\dvars::dvarintvalue("_encstr_A6AD0FC29F8BCF59D2178B7F48072360BB", 1, 1, 5);
  level.practicemode = scripts\mp\utility\dvars::dvarintvalue("_encstr_BED20DFF5AD20733D13F80C927F429", 0, 0, 1);
  level.possessionresetcondition = scripts\mp\utility\dvars::dvarintvalue("_encstr_B665199BA72B470D6BAFCBD728594A431023E03FB548EF70D45D68", 0, 0, 2);
  level.possessionresettime = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_8DD414B01F581A5F76BB4A1220DE97D230C16C218340", 0, 0, 150);
  level.idleresettime = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_83FA0E968C63594A9537B2A38A96D6CA", 15, 0, 60);
  level.showenemycarrier = scripts\mp\utility\dvars::dvarintvalue("_encstr_AF3F11AE30F788BD866368D8E7575B8A40125B", 5, 0, 6);
}

ball_goal_useobject() {
  foreach(var_2, var_1 in level.ball_goals) {
    var_1.trigger = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_1.origin - (0, 0, var_1.radius), 0, var_1.radius, var_1.radius * 2);
    var_1.useobject = scripts\mp\gameobjects::createuseobject(var_2, var_1.trigger, [], (0, 0, var_1.radius * 2.1));
    var_1.useobject.goal = var_1;
    var_1.useobject scripts\mp\gameobjects::setobjectivestatusicons("_encstr_ADE9169F974911BF3A3A750FBABCAB4305A14CAF2AF07ADA", "_encstr_825C14FB02F737705C6E114F8AC598FD535971606ADB");
    var_1.useobject scripts\mp\gameobjects::setvisibleteam("_encstr_9A19040BCDBC");
    var_1.useobject scripts\mp\gameobjects::allowuse("_encstr_88BF06FD784A6393");
    var_1.useobject scripts\mp\gameobjects::setkeyobject(level.balls);
    var_1.useobject scripts\mp\gameobjects::setusetime(0);
    var_1.useobject scripts\mp\gameobjects::cancontestclaim(1);
    var_1.useobject.onuse = ::ball_carrier_touched_goal;
    var_1.useobject.canuseobject = ::ball_goal_can_use;
    var_1.useobject.oncontested = ::ball_goal_contested;
    var_1.useobject.onuncontested = ::ball_goal_uncontested;
    var_1.killcament = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1.origin + (0, 0, 20));
    var_1.killcament setscriptmoverkillcam("_encstr_AB440A3180D0C0109B17550B");
  }
}

ball_get_path_dist(var_0, var_1) {
  if(scripts\mp\spawnlogic::ispathdataavailable()) {
    var_2 = getpathdist(var_0, var_1, 999999);

    if(isDefined(var_2) && var_2 >= 0)
      return var_2;
  }

  return distance(var_0, var_1);
}

ball_goal_fx() {
  foreach(var_2, var_1 in level.ball_goals) {
    var_1.score_fx["_encstr_ACFC091AE8AB2FCBE15119"] = spawnfx(scripts\engine\utility::getfx("_encstr_9A0D1D585F7509B7E7E87F99D6E7A3ABFBF04ECDE2C3491EE6616998477069"), var_1.origin, (1, 0, 0));
    var_1.score_fx["_encstr_88BF06FD784A6393"] = spawnfx(scripts\engine\utility::getfx("_encstr_954D1A26B08D1BD7D9B758B1BE851B47D2672C8E5919D7CA732BDAF2"), var_1.origin, (1, 0, 0));
  }

  level thread ball_play_fx_joined_team();

  foreach(var_4 in level.players)
  ball_goal_fx_for_player(var_4);

  thread goal_watch_game_ended();
}

onplayerconnect(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  thread onplayerspawned(var_0);

  if(istrue(level.practicemode) && var_0 ishost()) {
    var_0 thread _encstr_A275229BB19C2DC18EDCF2B61C97D90BDA59D1CB1C56B997F6899AF5C4B0D8C67176378D::practicenotify();
    var_0 thread _encstr_A275229BB19C2DC18EDCF2B61C97D90BDA59D1CB1C56B997F6899AF5C4B0D8C67176378D::moveballtoplayer();
  }
}

onplayerspawned(var_0) {
  var_0 waittill("_encstr_BA350853C128FB939DB9");
  var_0 scripts\mp\utility\stats::setextrascore0(0);

  if(isDefined(var_0.pers["_encstr_95F70BD1EDBA1B1A46DBBB376E"]))
    var_0 scripts\mp\utility\stats::setextrascore0(var_0.pers["_encstr_95F70BD1EDBA1B1A46DBBB376E"]);

  var_0 scripts\mp\utility\stats::setextrascore1(0);

  if(isDefined(var_0.pers["_encstr_8B980B9996591B19D9DE168D9B"]))
    var_0 scripts\mp\utility\stats::setextrascore1(var_0.pers["_encstr_8B980B9996591B19D9DE168D9B"]);
}

initspawns() {
  scripts\mp\spawnlogic::setactivespawnlogic("_encstr_A777073FE8E01992AF", "_encstr_829A0D0F1AF8FB5ED127855073F940");
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::addstartspawnpoints("_encstr_8C371B71B8B78113CD1A1970F3A6E7D85F51097909E7EB277283D0604B");
  scripts\mp\spawnlogic::addstartspawnpoints("_encstr_AF111931F8F7C1538D5A5930B3E627189F91C3BB534F2BB136A338");
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
  var_0 = scripts\mp\spawnlogic::getspawnpointarray(level.spawnnodetype);
  var_1 = scripts\mp\spawnlogic::getspawnpointarray(level.spawnnodetype + "_encstr_8D380B2052DA4F68EEEB78F887");
  var_2 = assignteamspawns(var_0);
  var_3 = assignteamspawns(var_1);
  scripts\mp\spawnlogic::registerspawnpoints("_encstr_9A8507BA4040188D08", var_2["_encstr_9A8507BA4040188D08"]);
  scripts\mp\spawnlogic::registerspawnpoints("_encstr_9A8507BA4040188D08", var_3["_encstr_9A8507BA4040188D08"], 1);
  scripts\mp\spawnlogic::registerspawnpoints("_encstr_8E8405EA382B2A", var_2["_encstr_8E8405EA382B2A"]);
  scripts\mp\spawnlogic::registerspawnpoints("_encstr_8E8405EA382B2A", var_3["_encstr_8E8405EA382B2A"], 1);
}

assignteamspawns(var_0) {
  var_1 = [];
  var_1["_encstr_9A8507BA4040188D08"] = [];
  var_1["_encstr_8E8405EA382B2A"] = [];

  if(!isDefined(level.maxspawndisttohomebase)) {
    level.maxspawndisttohomebase = [];
    level.maxspawndisttohomebase["_encstr_9A8507BA4040188D08"] = 0;
    level.maxspawndisttohomebase["_encstr_8E8405EA382B2A"] = 0;
  }

  var_2 = level.ball_goals["_encstr_9A8507BA4040188D08"].origin;
  var_3 = level.ball_goals["_encstr_8E8405EA382B2A"].origin;

  foreach(var_5 in var_0) {
    var_6 = getspawnpointdist(var_5, var_2);
    var_7 = getspawnpointdist(var_5, var_3);
    var_5.disttohomebase = [];
    var_5.disttohomebase["_encstr_9A8507BA4040188D08"] = var_6;
    var_5.disttohomebase["_encstr_8E8405EA382B2A"] = var_7;
    var_8 = max(var_6, var_7);
    var_9 = min(var_6, var_7);

    if(abs(var_8 - var_9) / var_8 < 0.2) {
      var_1["_encstr_9A8507BA4040188D08"][var_1["_encstr_9A8507BA4040188D08"].size] = var_5;
      var_1["_encstr_8E8405EA382B2A"][var_1["_encstr_8E8405EA382B2A"].size] = var_5;
    } else if(var_7 < var_6)
      var_1["_encstr_8E8405EA382B2A"][var_1["_encstr_8E8405EA382B2A"].size] = var_5;
    else
      var_1["_encstr_9A8507BA4040188D08"][var_1["_encstr_9A8507BA4040188D08"].size] = var_5;

    if(var_6 > level.maxspawndisttohomebase["_encstr_9A8507BA4040188D08"])
      level.maxspawndisttohomebase["_encstr_9A8507BA4040188D08"] = var_6;

    if(var_7 > level.maxspawndisttohomebase["_encstr_8E8405EA382B2A"])
      level.maxspawndisttohomebase["_encstr_8E8405EA382B2A"] = var_7;
  }

  return var_1;
}

getspawnpointdist(var_0, var_1) {
  var_2 = getpathdist(var_0.origin, var_1, 16000);

  if(var_2 < 0)
    var_2 = distance(var_0.origin, var_1);

  return var_2;
}

getspawnpoint() {
  var_0 = self.pers["_encstr_8AEF05472BC2D6"];

  if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    if(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"])
      var_0 = scripts\mp\utility\game::getotherteam(var_0)[0];

    var_1 = scripts\mp\spawnlogic::getspawnpointarray(level.spawnnodetype + "_encstr_BA4C02DF" + var_0 + "_encstr_B4810709B378B9F3F5");
    var_2 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var_1);
  } else {
    var_1 = scripts\mp\spawnlogic::getteamspawnpoints(var_0);
    var_3 = scripts\mp\spawnlogic::getteamfallbackspawnpoints(var_0);
    var_4 = [];
    var_5["_encstr_A7AE0DE987EA8D512992F9D73F1110"] = var_0;
    var_5["_encstr_BA2F125B0B1E222DB98E8AB742B75B95122C6E95"] = level.maxspawndisttohomebase[var_0];
    var_2 = undefined;
  }

  return var_2;
}

run_ball() {
  level.ball_starts = [];
  level.balls = [];
  level.ballbases = [];
  ball_create_team_goal("_encstr_9A8507BA4040188D08");
  ball_create_team_goal("_encstr_8E8405EA382B2A");
  level thread ball_connect_watch();
  _encstr_A275229BB19C2DC18EDCF2B61C97D90BDA59D1CB1C56B997F6899AF5C4B0D8C67176378D::ball_init_map_min_max();
  _encstr_A275229BB19C2DC18EDCF2B61C97D90BDA59D1CB1C56B997F6899AF5C4B0D8C67176378D::ball_create_ball_starts();

  for(var_0 = 0; var_0 < level.satellitecount; var_0++)
    _encstr_A275229BB19C2DC18EDCF2B61C97D90BDA59D1CB1C56B997F6899AF5C4B0D8C67176378D::ball_spawn(var_0);

  ball_goal_useobject();
  ball_goal_fx();
  initspawns();
  thread removeuplinkgoal();
  thread placeuplinkgoal();
  level.ball = level.balls[0];
}

ball_find_ground(var_0) {
  var_1 = self.origin + (0, 0, 32);
  var_2 = self.origin + (0, 0, -1000);
  var_3 = scripts\engine\trace::create_contents(1, 1, 1, 1, 0, 1, 1);
  var_4 = [];
  var_5 = scripts\engine\trace::ray_trace(var_1, var_2, var_4, var_3);
  self.ground_origin = var_5["_encstr_BD260953AA97E3F014279D"];
  return var_5["_encstr_A53009A25003666B9818C6"] != 0 && var_5["_encstr_A53009A25003666B9818C6"] != 1;
}

ball_create_team_goal(var_0) {
  var_1 = var_0;

  if(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"])
    var_1 = scripts\mp\utility\game::getotherteam(var_1)[0];

  var_2 = scripts\engine\utility::getStruct("_encstr_B1BA0B96A7FA7A07642238922F" + var_1, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(isDefined(var_2)) {
    var_2 = checkpostshipgoalplacement(var_2, var_0);
    var_2 ball_find_ground();
  } else {
    var_2 = spawnStruct();

    switch (level.script) {
      default:
        break;
    }

    if(!isDefined(var_2.origin))
      var_2.origin = level.default_goal_origins[var_0];

    var_2 ball_find_ground();
  }

  if(istrue(scripts\cp_mp\utility\game_utility::isrealismenabled()))
    var_2.origin = var_2.ground_origin + (0, 0, 130);
  else
    var_2.origin = var_2.ground_origin + (0, 0, 130);

  var_2.radius = 60;
  var_2.team = var_0;
  var_2.ball_in_goal = 0;
  var_2.highestspawndistratio = 0;
  level.ball_goals[var_0] = var_2;
}

checkpostshipgoalplacement(var_0, var_1) {
  if(level.mapname == "_encstr_B87F0EB06AB7C53DD5F36F98A0A86C33") {
    if(!game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"] && var_1 == "_encstr_8E8405EA382B2A")
      var_0.origin = (-2039, -1464, 123);
    else if(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"] && var_1 == "_encstr_9A8507BA4040188D08")
      var_0.origin = (-2039, -1464, 123);
  }

  if(level.mapname == "_encstr_B2860A4A938957DBAB1DED3D") {
    if(!game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"] && var_1 == "_encstr_8E8405EA382B2A")
      var_0.origin = (2752, 1429, 988);
    else if(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"] && var_1 == "_encstr_9A8507BA4040188D08")
      var_0.origin = (2752, 1429, 988);

    if(!game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"] && var_1 == "_encstr_9A8507BA4040188D08")
      var_0.origin = (-1866, 1698, 988);
    else if(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"] && var_1 == "_encstr_8E8405EA382B2A")
      var_0.origin = (-1866, 1698, 988);
  }

  return var_0;
}

ball_connect_watch() {
  for(;;) {
    level waittill("_encstr_AA940A6CB7DC9B2B6C3ACA91", var_0);
    var_0 thread _encstr_A275229BB19C2DC18EDCF2B61C97D90BDA59D1CB1C56B997F6899AF5C4B0D8C67176378D::ball_player_on_connect();
  }
}

ball_physics_touch_goal() {
  var_0 = self.visuals[0];
  self endon("_encstr_B8FE09888F7B6BBFAA6DDD");
  self endon("_encstr_AD740E37543ADFAB708788F84BBDA129");
  self endon("_encstr_95E2110ED0CBDCD2D8E6AF3396E6A5DCD05646");

  if(scripts\mp\utility\game::getgametype() != "_encstr_85EF050CB150E7")
    ball_touch_goal_watch(var_0);
}

ball_pass_touch_goal() {
  var_0 = self.visuals[0];
  self endon("_encstr_B8FE09888F7B6BBFAA6DDD");

  if(scripts\mp\utility\game::getgametype() != "_encstr_85EF050CB150E7")
    ball_touch_goal_watch(var_0);
}

ball_touch_goal_watch(var_0) {
  self endon("_encstr_B8FE09888F7B6BBFAA6DDD");
  self endon("_encstr_AD740E37543ADFAB708788F84BBDA129");
  self endon("_encstr_95E2110ED0CBDCD2D8E6AF3396E6A5DCD05646");

  for(;;) {
    foreach(var_5, var_2 in level.ball_goals) {
      if(self.lastcarrierteam == var_5) {
        continue;
      }
      if(!var_2.useobject ball_goal_can_use()) {
        continue;
      }
      var_3 = distance(var_0.origin, var_2.origin);

      if(var_3 <= var_2.radius) {
        thread ball_touched_goal(var_2);
        var_0 notify("_encstr_B8FE09888F7B6BBFAA6DDD");
        return;
      }

      if(isDefined(var_0.origin_prev)) {
        var_4 = line_interect_sphere(var_0.origin_prev, var_0.origin, var_2.origin, var_2.radius);

        if(var_4) {
          thread ball_touched_goal(var_2);
          var_0 notify("_encstr_B8FE09888F7B6BBFAA6DDD");
          return;
        }
      }
    }

    waitframe();
  }
}

ball_goal_can_use(var_0) {
  var_1 = self.goal;

  if(var_1.ball_in_goal)
    return 0;

  return 1;
}

ball_goal_contested() {
  ball_waypoint_contest();
}

ball_goal_uncontested(var_0) {
  goal_waypoint();
}

ball_carrier_touched_goal(var_0) {
  if(!isDefined(var_0) || !isDefined(var_0.carryobject)) {
    return;
  }
  if(isDefined(level.scorefrozenuntil) && level.scorefrozenuntil > gettime()) {
    return;
  }
  if(istimeup()) {
    return;
  }
  if(level.gameended) {
    return;
  }
  var_0 notify("_encstr_A7ED0CEFAFDFAA37F8318DD2E918");
  var_1 = level.scorecarry;
  var_0 thread scripts\mp\awards::givemidmatchaward("_encstr_A967115BB746ACAFD50E8D2D9B5B7D4657CDD6");
  ball_check_assist(var_0, 1);
  var_0 scripts\mp\utility\stats::incpersstat("_encstr_95F70BD1EDBA1B1A46DBBB376E", 1);
  var_0 scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_95F70BD1EDBA1B1A46DBBB376E", var_0.pers["_encstr_95F70BD1EDBA1B1A46DBBB376E"]);

  if(isPlayer(var_0)) {
    var_0 scripts\mp\utility\stats::setextrascore0(var_0.pers["_encstr_95F70BD1EDBA1B1A46DBBB376E"]);
    var_0 thread scripts\common\utility::_id_13E0A(level._id_11B29, "_encstr_86660519EADCB6", var_0.origin);
  }

  var_2 = self.goal.team;
  var_3 = scripts\mp\utility\game::getotherteam(var_2)[0];
  scripts\mp\utility\dialog::statusdialog("_encstr_ABD5120870982D838E0717BA4217C606EF603A3A", var_2, 1);
  scripts\mp\utility\dialog::statusdialog("_encstr_8DC2116E3209D30EFEF26BBE1B5E23F677CDCD", var_3, 1);
  ball_play_score_fx(self.goal);
  ball_score_sound(var_3, 1);
  var_4 = var_0.carryobject;
  var_4.lastcarrierscored = 1;
  var_4 _encstr_A275229BB19C2DC18EDCF2B61C97D90BDA59D1CB1C56B997F6899AF5C4B0D8C67176378D::ball_set_dropped(1, self.trigger.origin, 1);
  var_4 thread ball_score_event(self.goal);
  ball_give_score(var_3, var_1);
}

should_record_final_score_cam(var_0, var_1) {
  var_2 = scripts\mp\gamescore::_getteamscore(var_0);
  var_3 = scripts\mp\gamescore::_getteamscore(scripts\mp\utility\game::getotherteam(var_0)[0]);
  return var_2 + var_1 >= var_3;
}

line_interect_sphere(var_0, var_1, var_2, var_3) {
  var_4 = vectorNormalize(var_1 - var_0);
  var_5 = vectordot(var_4, var_0 - var_2);
  var_5 = var_5 * var_5;
  var_6 = var_0 - var_2;
  var_6 = var_6 * var_6;
  var_7 = var_3 * var_3;
  return var_5 - var_6 + var_7 >= 0;
}

ball_touched_goal(var_0) {
  if(isDefined(level.scorefrozenuntil) && level.scorefrozenuntil > gettime()) {
    return;
  }
  if(istimeup()) {
    return;
  }
  if(level.gameended) {
    return;
  }
  ball_play_score_fx(var_0);
  var_1 = level.scorethrow;
  var_2 = var_0.team;
  var_3 = scripts\mp\utility\game::getotherteam(var_2)[0];
  scripts\mp\utility\dialog::statusdialog("_encstr_922612DBA87F5D19372B13C66F175FF0E6F7ABC8", var_2, 1);
  scripts\mp\utility\dialog::statusdialog("_encstr_BD3911408A55A3BE8B085ED80FFFE35F7D93E8", var_3, 1);

  if(isDefined(self.lastcarrier)) {
    self.lastcarrierscored = 1;
    self.lastcarrier thread scripts\mp\awards::givemidmatchaward("_encstr_B1F11620F72CE9FF6B2A199385A2B7319977B0E02FCFA1A1");
    ball_check_assist(self.lastcarrier, 0);
    self.lastcarrier scripts\mp\utility\stats::incpersstat("_encstr_8B980B9996591B19D9DE168D9B", 1);
    self.lastcarrier scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_8B980B9996591B19D9DE168D9B", self.lastcarrier.pers["_encstr_8B980B9996591B19D9DE168D9B"]);

    if(isPlayer(self.lastcarrier)) {
      self.lastcarrier scripts\mp\utility\stats::setextrascore1(self.lastcarrier.pers["_encstr_8B980B9996591B19D9DE168D9B"]);
      self.lastcarrier thread scripts\common\utility::_id_13E0A(level._id_11B29, "_encstr_8E040ABD6B37D0E344DFD821", self.lastcarrier.origin);
    }
  }

  if(isDefined(self.killcament))
    self.killcament unlink();

  ball_score_sound(var_3, 0);
  thread ball_score_event(var_0);
  ball_give_score(var_3, var_1);
}

istimeup() {
  var_0 = scripts\mp\utility\dvars::getwatcheddvar("_encstr_8B250A53848DC8D17A472BE9");

  if(var_0 != 0) {
    var_1 = scripts\mp\gamelogic::gettimeremaining();

    if(var_1 <= 0)
      return 1;
  }

  return 0;
}

ball_give_score(var_0, var_1) {
  level scripts\mp\gamescore::giveteamscoreforobjective(var_0, var_1, 0);
}

ball_score_event(var_0) {
  level thread scorefrozentimer();
  self notify("_encstr_A7380C6ED87B39ACFA95CE2BE6A3");

  if(istrue(level.practicemode)) {
    foreach(var_2 in level.players) {
      if(var_2 ishost()) {
        var_2 thread _encstr_A275229BB19C2DC18EDCF2B61C97D90BDA59D1CB1C56B997F6899AF5C4B0D8C67176378D::moveballtoplayer();
        break;
      }
    }
  }

  self.in_goal = 1;
  var_0.ball_in_goal = 1;
  var_4 = self.visuals[0];

  if(isDefined(self.projectile))
    self.projectile delete();

  var_4 physicslaunchserver(var_4.origin, (0, 0, 0));
  var_4 physicsstopserver();
  scripts\mp\gameobjects::allowcarry("_encstr_8BBA05185F8B99");
  _encstr_A275229BB19C2DC18EDCF2B61C97D90BDA59D1CB1C56B997F6899AF5C4B0D8C67176378D::ball_waypoint_upload();
  var_5 = 0.4;
  var_6 = 1.2;
  var_7 = 1.0;
  var_8 = var_5 + var_7;
  var_9 = var_8 + var_6;
  var_4 moveTo(var_0.origin, var_5, 0, var_5);
  var_4 rotatevelocity((1080, 1080, 0), var_9, var_9, 0);
  wait(var_8);
  var_4 movez(4000, var_6, var_6 * 0.1, 0);
  wait(var_6);
  var_0.ball_in_goal = 0;
  _encstr_A275229BB19C2DC18EDCF2B61C97D90BDA59D1CB1C56B997F6899AF5C4B0D8C67176378D::ball_return_home(0, 0);
}

ball_check_assist(var_0, var_1) {
  if(!isDefined(var_0.passtime) || !isDefined(var_0.passplayer)) {
    return;
  }
  if(var_0.passtime + 3000 < gettime()) {
    return;
  }
  if(var_1)
    var_0.passplayer thread scripts\mp\awards::givemidmatchaward("_encstr_BAE414E18D129BA63D835878934BFECB3AF5637865AB");
}

ball_play_score_fx(var_0) {
  var_0.score_fx["_encstr_ACFC091AE8AB2FCBE15119"] hide();
  var_0.score_fx["_encstr_88BF06FD784A6393"] hide();

  foreach(var_2 in level.players) {
    var_3 = ball_get_view_team(var_2);

    if(var_3 == var_0.team) {
      var_0.score_fx["_encstr_ACFC091AE8AB2FCBE15119"] showtoplayer(var_2);
      continue;
    }

    var_0.score_fx["_encstr_88BF06FD784A6393"] showtoplayer(var_2);
  }

  triggerfx(var_0.score_fx["_encstr_ACFC091AE8AB2FCBE15119"]);
  triggerfx(var_0.score_fx["_encstr_88BF06FD784A6393"]);
}

ball_waypoint_reset() {
  scripts\mp\gameobjects::setobjectivestatusicons("_encstr_A2141683D94B3B2548D56447C52BEAD775B6BA6AC32A275A", "_encstr_A2141683D94B3B2548D56447C52BEAD775B6BA6AC32A275A");
}

ball_waypoint_contest() {
  scripts\mp\gameobjects::setobjectivestatusicons("_encstr_83D61A6CB93FD33FBC0A50015312C1088B2BE0EE1F3B1B636293C020", "_encstr_83D61A6CB93FD33FBC0A50015312C1088B2BE0EE1F3B1B636293C020");
}

goal_waypoint() {
  scripts\mp\gameobjects::setobjectivestatusicons("_encstr_ADE9169F974911BF3A3A750FBABCAB4305A14CAF2AF07ADA", "_encstr_825C14FB02F737705C6E114F8AC598FD535971606ADB");
}

ball_score_sound(var_0, var_1) {
  if(var_1)
    _encstr_A275229BB19C2DC18EDCF2B61C97D90BDA59D1CB1C56B997F6899AF5C4B0D8C67176378D::ball_play_local_team_sound(var_0, "_encstr_B18120903BA75B112ABCE86219B26781CCEF9878AB2210E35229D4F6ECCA5DE924CF", "_encstr_8C961DD683AF571C63969BD6BEECDB58D8FA1BC2E4E44B56C8BEAC9B59AD97");
  else
    _encstr_A275229BB19C2DC18EDCF2B61C97D90BDA59D1CB1C56B997F6899AF5C4B0D8C67176378D::ball_play_local_team_sound(var_0, "_encstr_8237181BB069108F033A68F06117C8787D0785DD414F70DD6B53", "_encstr_B6CC15D638EB5783B1D29BD6AFD9BD1636FA95CDB26BCB");
}

scorefrozentimer() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level.scorefrozenuntil = gettime() + 10000;

  foreach(var_1 in level.ball_goals)
  var_1 thread dogoalreset();
}

dogoalreset() {
  self.useobject ball_waypoint_reset();
  level scripts\engine\utility::_id_143B9(10, "_encstr_8F3B0B377DE3B9A1D01F4F47F1");
  self.useobject goal_waypoint();
}

ball_on_connect() {
  for(;;) {
    level waittill("_encstr_AA940A6CB7DC9B2B6C3ACA91", var_0);
    var_0.ball_goal_fx = [];
    var_0 thread player_on_disconnect();
  }
}

player_on_disconnect() {
  self waittill("_encstr_8D820B49520F0EC02DDE6367EC");
  player_delete_ball_goal_fx();
}

ball_goal_fx_for_player(var_0) {
  var_1 = ball_get_view_team(var_0);
  var_0 player_delete_ball_goal_fx();

  foreach(var_6, var_3 in level.ball_goals) {
    var_4 = scripts\engine\utility::ter_op(var_6 == var_1, "_encstr_AD0A137AA05A18D7777050F087EAF6C18858140137", "_encstr_BA1E10BE09404CE9A4CF8FB3475D02BDA092");
    var_5 = spawnfxforclient(scripts\engine\utility::getfx(var_4), var_3.origin, var_0, (1, 0, 0));
    var_5 setfxkilldefondelete();
    var_0.ball_goal_fx[var_4] = var_5;
    triggerfx(var_5);
  }
}

ball_get_view_team(var_0) {
  var_1 = var_0.team;

  if(var_1 != "_encstr_9A8507BA4040188D08" && var_1 != "_encstr_8E8405EA382B2A") {
    if(var_0 ismlgspectator())
      var_1 = var_0 getmlgspectatorteam();
    else
      var_1 = "_encstr_9A8507BA4040188D08";
  }

  return var_1;
}

player_delete_ball_goal_fx() {
  if(isDefined(self.ball_goal_fx)) {
    foreach(var_1 in self.ball_goal_fx) {
      if(isDefined(var_1))
        var_1 delete();
    }
  }
}

goal_watch_game_ended() {
  level waittill("_encstr_9B1D0BC7932875276230426AA1");

  foreach(var_1 in level.players)
  var_1 player_delete_ball_goal_fx();
}

ball_play_fx_joined_team() {}

onplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = self;
  var_11 = 0;

  if(!isDefined(var_1) || !isDefined(var_1.team) || !isDefined(var_10) || !isDefined(var_10.team)) {
    return;
  }
  if(var_1 == var_10) {
    return;
  }
  if(var_1.team == var_10.team) {
    return;
  }
  var_12 = var_1.origin;
  var_13 = 0;

  if(isDefined(var_0)) {
    var_12 = var_0.origin;
    var_13 = var_0 == var_1;
  }

  if(isDefined(var_1) && isPlayer(var_1) && var_1.pers["_encstr_8AEF05472BC2D6"] != var_10.pers["_encstr_8AEF05472BC2D6"]) {
    if(isDefined(var_1.ball_carried) && var_13)
      var_11 = 1;

    if(isDefined(var_10.ball_carried)) {
      var_1 scripts\mp\utility\stats::incpersstat("_encstr_B1F7085B03F492AE98DB", 1);
      var_1 scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_B1F7085B03F492AE98DB", var_1.pers["_encstr_B1F7085B03F492AE98DB"]);
      thread scripts\common\utility::_id_13E0A(level._id_11B30, var_9, "_encstr_852F09FA41FB7ADB3968C4");
      _encstr_A275229BB19C2DC18EDCF2B61C97D90BDA59D1CB1C56B997F6899AF5C4B0D8C67176378D::updatetimers("_encstr_A7A408B9CA5D1D4E2C63", 1, 0);
      var_11 = 1;
    }
  }

  if(!var_11) {
    var_14 = 0;

    foreach(var_16 in level.balls) {
      var_14 = distsquaredcheck(var_12, var_10.origin, var_16.curorigin);

      if(var_14 && var_1.team != var_10.team) {
        if(var_16.ownerteam == var_10.team)
          var_1 thread scripts\mp\awards::givemidmatchaward("_encstr_8E020FAB6877F10FCBEFD81F63FB9B901C");
        else if(var_16.ownerteam == var_1.team)
          var_1 thread scripts\mp\awards::givemidmatchaward("_encstr_93D80ED6F646B2AFF0EB1995CCCA3791");

        break;
      }
    }

    if(!var_14) {
      foreach(var_21, var_19 in level.ball_goals) {
        var_20 = distsquaredcheck(var_12, var_10.origin, var_19.trigger.origin);

        if(var_20) {
          if(var_21 == var_10.team) {
            var_1 thread scripts\mp\awards::givemidmatchaward("_encstr_8E020FAB6877F10FCBEFD81F63FB9B901C");
            continue;
          }

          var_1 thread scripts\mp\awards::givemidmatchaward("_encstr_93D80ED6F646B2AFF0EB1995CCCA3791");
        }
      }
    }
  }
}

distsquaredcheck(var_0, var_1, var_2) {
  var_3 = distancesquared(var_2, var_0);
  var_4 = distancesquared(var_2, var_1);

  if(var_3 < 90000 || var_4 < 90000)
    return 1;
  else
    return 0;
}

onspawnplayer() {
  self.teleporting = 0;
}

hidehudelementongameend(var_0) {
  level waittill("_encstr_9B1D0BC7932875276230426AA1");

  if(isDefined(var_0))
    var_0.alpha = 0;
}

removeuplinkgoal() {
  self endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    if(getDvar("_encstr_8DFE1527F0A3AFB233C49257A1FF4B5DCD28D76BE0B9CF", "_encstr_B40101") != "_encstr_B40101") {
      var_0 = getDvar("_encstr_8DFE1527F0A3AFB233C49257A1FF4B5DCD28D76BE0B9CF", "_encstr_B40101");

      if(var_0 == "_encstr_B20703DFCF")
        var_1 = "_encstr_9A8507BA4040188D08";
      else
        var_1 = "_encstr_8E8405EA382B2A";

      level.ball_goals[var_1].useobject scripts\mp\gameobjects::allowuse("_encstr_8BBA05185F8B99");
      level.ball_goals[var_1].useobject.trigger = undefined;
      level.ball_goals[var_1].useobject notify("_encstr_8BE208E31FA8E1631D65");

      foreach(var_3 in level.players)
      var_3 player_delete_ball_goal_fx();

      level.ball_goals[var_1].useobject.visibleteam = "_encstr_8BBA05185F8B99";
      level.ball_goals[var_1].useobject scripts\mp\gameobjects::setobjectivestatusicons(undefined, undefined);
      setdynamicdvar("_encstr_8DFE1527F0A3AFB233C49257A1FF4B5DCD28D76BE0B9CF", "_encstr_B40101");
    }

    wait 1;
  }
}

placeuplinkgoal() {
  self endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    if(getDvar("_encstr_8A19149BB04D713331ACC0E4CF19FF4F8F2850E218CF", "_encstr_B40101") != "_encstr_B40101") {
      var_0 = getDvar("_encstr_8A19149BB04D713331ACC0E4CF19FF4F8F2850E218CF", "_encstr_B40101");

      if(var_0 == "_encstr_B20703DFCF")
        var_1 = "_encstr_9A8507BA4040188D08";
      else
        var_1 = "_encstr_8E8405EA382B2A";

      var_2 = spawnStruct();
      var_2.origin = level.players[0].origin;
      var_2.origin = var_2.origin + (0, 0, 190);
      var_2.radius = 50;
      var_2.team = var_1;
      var_2.ball_in_goal = 0;
      var_2.highestspawndistratio = 0;
      level.ball_goals[var_1] = var_2;
      var_2.trigger = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_2.origin - (0, 0, var_2.radius), 0, var_2.radius, var_2.radius * 2);
      var_2.useobject = scripts\mp\gameobjects::createuseobject(var_1, var_2.trigger, [], (0, 0, var_2.radius * 2.1));
      var_2.useobject.goal = var_2;
      var_2.useobject scripts\mp\gameobjects::setobjectivestatusicons("_encstr_ADE9169F974911BF3A3A750FBABCAB4305A14CAF2AF07ADA", "_encstr_825C14FB02F737705C6E114F8AC598FD535971606ADB");
      var_2.useobject scripts\mp\gameobjects::setvisibleteam("_encstr_9A19040BCDBC");
      var_2.useobject scripts\mp\gameobjects::allowuse("_encstr_88BF06FD784A6393");
      var_2.useobject scripts\mp\gameobjects::setkeyobject(level.balls);
      var_2.useobject scripts\mp\gameobjects::setusetime(0);
      var_2.useobject scripts\mp\gameobjects::cancontestclaim(1);
      var_2.useobject.onuse = ::ball_carrier_touched_goal;
      var_2.useobject.canuseobject = ::ball_goal_can_use;
      var_2.useobject.oncontested = ::ball_goal_contested;
      var_2.useobject.onuncontested = ::ball_goal_uncontested;
      var_2.killcament = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2.origin + (0, 0, 20));
      var_2.killcament setscriptmoverkillcam("_encstr_AB440A3180D0C0109B17550B");
      ball_goal_fx();
      setdynamicdvar("_encstr_8A19149BB04D713331ACC0E4CF19FF4F8F2850E218CF", "_encstr_B40101");
    }

    wait 1;
  }
}