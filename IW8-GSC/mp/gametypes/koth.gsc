/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\koth.gsc
***********************************************/

main() {
  if(getDvar("_encstr_9570084B1793A090CDFF") == "_encstr_8D510E52E3A7C6985EB7B9BE2F35C690") {
    return;
  }
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  var_0[0] = scripts\mp\utility\game::getgametype();
  var_0[1] = "_encstr_B67B0A1A2C279107DBB49BA3";
  var_0[2] = "_encstr_A11904E823B6";
  scripts\mp\gameobjects::main(var_0);

  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread scripts\mp\utility\game::reinitializematchrulesonmigration();
  } else {
    scripts\mp\utility\game::registertimelimitdvar(scripts\mp\utility\game::getgametype(), 300);
    scripts\mp\utility\game::registerscorelimitdvar(scripts\mp\utility\game::getgametype(), 300);
    scripts\mp\utility\game::registerroundlimitdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registerwinlimitdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registernumlivesdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
  }

  updategametypedvars();
  level.hpstarttime = 0;
  level.scoreperplayer = undefined;
  level.teambased = 1;
  level.onstartgametype = ::onstartgametype;
  level.onplayerconnect = ::onplayerconnect;
  level.getspawnpoint = ::getspawnpoint;
  level.modeonspawnplayer = ::onspawnplayer;
  level.onplayerkilled = ::onplayerkilled;
  level.onrespawndelay = ::getrespawndelay;
  level.lastcaptime = gettime();
  level.usehprules = 1;
  level.usezonecapture = 1;
  level.getkothzonedeadzonedist = ::getkothzonedeadzonedist;
  level.alliescapturing = [];
  level.axiscapturing = [];
  level.lastcaptureteam = undefined;
  level.previousclosespawnent = undefined;
  setomnvar("_encstr_AD5F10BA5AFA1AE2EB73AE5BBE581B5AB359", 0);
  setomnvar("_encstr_86491063E151C0C7078283A80A9B7D10764D", -1);
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_AC0E136F19B72DBB1343704E303F2255BA58E4D520";

  if(getdvarint("_encstr_B2020AE1F36BF74429D93F01"))
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_8A19042AB017" + game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"];
  else if(getdvarint("_encstr_82570B397A4D3192935192A562"))
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_979708CC69F02253FF26" + game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"];

  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_91B2067E0898939B"] = "_encstr_A3E9105A2880FBBDEE20F140F4174058A08B";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_95240C659372588E43623137DE6C"] = "_encstr_A3E9105A2880FBBDEE20F140F4174058A08B";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_93420C4255FBEA5D408FD1FD2A62"] = "_encstr_A3E9105A2880FBBDEE20F140F4174058A08B";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_83CF0EDB26357D46B2CD47C9DB2FAC32"] = "_encstr_83CF0EDB26357D46B2CD47C9DB2FAC32";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_96150D4AF18ABF1EC031AC950DD8E7"] = "_encstr_96150D4AF18ABF1EC031AC950DD8E7";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_962909991059C7F8721301"] = "_encstr_962909991059C7F8721301";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AA8D10032AC1ED815F5F786887617B3B2A55"] = "_encstr_AA8D10032AC1ED815F5F786887617B3B2A55";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B1341202FF59E78993406BB05124317D280B40A2"] = "_encstr_B1341202FF59E78993406BB05124317D280B40A2";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_86CF15588B077A4350BBADB2A2F1D7952A64D2BAFD3992"] = "_encstr_86CF15588B077A4350BBADB2A2F1D7952A64D2BAFD3992";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8C5E0D34E0BEB1DBCD1D59373A2B23"] = "_encstr_8C5E0D34E0BEB1DBCD1D59373A2B23";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A2D90D0DE07DB6BDD956D7DCB7EDB9"] = "_encstr_A2D90D0DE07DB6BDD956D7DCB7EDB9";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8DF313F87BE7D973ABBB25AED462B78605EB6858C7"] = "_encstr_8DF313F87BE7D973ABBB25AED462B78605EB6858C7";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8FAD16C8485FB69008A3CB7B2F38CFF06F434BED08E06968"] = "_encstr_8FAD16C8485FB69008A3CB7B2F38CFF06F434BED08E06968";
  level.nosuspensemusic = 1;
  thread writeplayerrotationscoretomatchdataongameend();
}

initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("_encstr_AF75161BB6BB571A9F1B137052F038EDA4C4EE0555442F27", getmatchrulesdata("_encstr_8F0B09903AD3015D5F9457", "_encstr_86550DFA1D220B34D12B80A33FFD29"));
  setdynamicdvar("_encstr_A20119F852FAD76DCF0C4B28EA27687B6EDA5848AB92EBBFEF0DC5", getmatchrulesdata("_encstr_8F0B09903AD3015D5F9457", "_encstr_B4CE10F4BD73CA6816E0D1BA93598A2DDA59"));
  setdynamicdvar("_encstr_AA07226EB193D7D6B7A30DF566A5C96E472DDB372BA0C6E8D267168ED2DB3711AC8DB0F2", getmatchrulesdata("_encstr_8F0B09903AD3015D5F9457", "_encstr_87E51966D293CD1D2DDEDCCA82361D4BD9C2A3A5DEB922598DC2E5"));
  setdynamicdvar("_encstr_86781DEEB62E90F2F8183381728ACD3FB146D3474B6BB5C7820D48E9340977", getmatchrulesdata("_encstr_8F0B09903AD3015D5F9457", "_encstr_934B143DF6DC2B82B13A2D9D0BA396DB7344ACD82CE5"));
  setdynamicdvar("_encstr_96A71DD389DE973488116857F510BDA388E0989A113F73ECB03DB762E168C2", getmatchrulesdata("_encstr_8F0B09903AD3015D5F9457", "_encstr_AB9F14E3BA1395D8C5D44F4FE16B20E8EBB07BA942CB"));
  setdynamicdvar("_encstr_AD24198BDAF657245FC3A2C637C3810203EADB9F064020D314B292", getmatchrulesdata("_encstr_8F0B09903AD3015D5F9457", "_encstr_829C10A99FECC0B502436B0F3F4AFE988E37"));
  setdynamicdvar("_encstr_8B4B136EB127EBB6DB47A17D070B57379545B4B5AC", getmatchrulesdata("_encstr_8F0B09903AD3015D5F9457", "_encstr_83FE0A484FBDAB0BF9EC1915"));
  setdynamicdvar("_encstr_B16A15F79F33B8404F3B20DE272D30EFFB3B515B4FEAF6", getmatchrulesdata("_encstr_8F0B09903AD3015D5F9457", "_encstr_A9210CA017EC518B7175D7E30F6B"));
  setdynamicdvar("_encstr_AAE2142B9E3AB1FAA28BB1D7BF7B3728CEB711408689", getmatchrulesdata("_encstr_8F0B09903AD3015D5F9457", "_encstr_8CA10BD013238F78BFFAB053C3"));
  setdynamicdvar("_encstr_8D3E1486E61B87585FFB60E1C77B5161F1427D81FFA3", getmatchrulesdata("_encstr_8F0B09903AD3015D5F9457", "_encstr_832F0B5BCFA2A1623A2B6903B6"));
  setdynamicdvar("_encstr_ABC212E636C9FADADBE834AF0DC2B199474BD6B2", 0);
  scripts\mp\utility\game::registerhalftimedvar("_encstr_BDD705AD7BD143", 0);
}

onstartgametype() {
  foreach(var_1 in level.teamnamelist) {
    scripts\mp\utility\game::setobjectivetext(var_1, &"_encstr_8EE010A78449A86851292B2A9AF2D2A78A09");

    if(level.splitscreen)
      scripts\mp\utility\game::setobjectivescoretext(var_1, &"_encstr_8EE010A78449A86851292B2A9AF2D2A78A09");
    else
      scripts\mp\utility\game::setobjectivescoretext(var_1, &"_encstr_8F8E16FF96E3C81EFCB35DE5A99D2BD71118994F03575FEF");

    scripts\mp\utility\game::setobjectivehinttext(var_1, &"_encstr_92E0155D08136D63C5096F4F23CD382F7F9B9FB87B999C");
  }

  if(level.scoremod["_encstr_ABD70578F3D02C"] > 0) {
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_95240C659372588E43623137DE6C"] = "_encstr_A9341086475D6B710127AD68ED4042EFC908";
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_93420C4255FBEA5D408FD1FD2A62"] = "_encstr_A9341086475D6B710127AD68ED4042EFC908";
  }

  setclientnamemode("_encstr_B6900C7BCDABC8AF2722B158FA17");
  level thread setupzones();
  level thread setupzoneareabrushes();
  initspawns();
  setkothwaypoints();
  seticonnames();

  if(!level.zonerandomlocationorder)
    _id_12BBC();

  level thread hardpointmainloop();
}

updategametypedvars() {
  _encstr_97EA20CDB1E44B1C3AB95EB583F2D9B05B95A3F2E056B9CBD8BDB66BF673B8D9CDB1::updatecommongametypedvars();
  level.zoneduration = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_86550DFA1D220B34D12B80A33FFD29", 60, 0, 300);
  level.zonecapturetime = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_B4CE10F4BD73CA6816E0D1BA93598A2DDA59", 0, 0, 30);
  level.firstzoneactivationdelay = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_87E51966D293CD1D2DDEDCCA82361D4BD9C2A3A5DEB922598DC2E5", 30, 0, 60);
  level.zoneactivationdelay = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_934B143DF6DC2B82B13A2D9D0BA396DB7344ACD82CE5", 0, 0, 60);
  level.zonerandomlocationorder = scripts\mp\utility\dvars::dvarintvalue("_encstr_AB9F14E3BA1395D8C5D44F4FE16B20E8EBB07BA942CB", 0, 0, 1);
  level.zoneadditivescoring = scripts\mp\utility\dvars::dvarintvalue("_encstr_829C10A99FECC0B502436B0F3F4AFE988E37", 0, 0, 1);
  level._id_1221A = scripts\mp\utility\dvars::dvarintvalue("_encstr_83FE0A484FBDAB0BF9EC1915", 1, 0, 1);
  level.delayplayer = scripts\mp\utility\dvars::dvarintvalue("_encstr_A9210CA017EC518B7175D7E30F6B", 0, 0, 1);
  level.spawndelay = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_8CA10BD013238F78BFFAB053C3", 0.5, 0, 10);
  level.usehqrules = scripts\mp\utility\dvars::dvarintvalue("_encstr_832F0B5BCFA2A1623A2B6903B6", 0, 0, 1);

  if(scripts\mp\utility\game::matchmakinggame() && !scripts\mp\utility\game::isanymlgmatch() && getdvarint("_encstr_A9CA25FF7B8AE9BAB743F01EEB5367CBA5D94779DAB528F5372A8BC0B33FA5C8BD26A1C3849E68", 15) != 0)
    level.zoneactivationdelay = binoculars_getfov();
}

binoculars_getfov() {
  var_0 = scripts\cp_mp\utility\game_utility::getmapname();

  switch (var_0) {
    case "_encstr_A3890850E25F90B79A83":
    case "_encstr_A6640D9D1109AF2FC7082B029395FF":
    case "_encstr_86D70CE85A1768FD42CB95B7CB2A":
      return getdvarint("_encstr_A9CA25FF7B8AE9BAB743F01EEB5367CBA5D94779DAB528F5372A8BC0B33FA5C8BD26A1C3849E68", 15);
    case "_encstr_93FB0A6B1C7D2CB92D5EB00D":
      return getdvarint("_encstr_A9CA25FF7B8AE9BAB743F01EEB5367CBA5D94779DAB528F5372A8BC0B33FA5C8BD26A1C3849E68", 15) + 15;
    default:
      return level.zoneactivationdelay;
  }
}

seticonnames() {
  level.icontarget = "_encstr_96DC0C5BED8ED0BEA358C9B35947";
  level.iconneutral = "_encstr_96730D2FF80BE0794D25C3BB967B02";
  level.iconcapture = "_encstr_8B850D2A78191331CF61ABB8566F78";
  level.icondefend = "_encstr_BE470C3BF8C3EB918910527A50D1";
  level.iconcontested = "_encstr_AF500F6D7B470DBEC6BD734756373A568C";
  level.icontaking = "_encstr_8D0B0C6DBDD10DEB47C2B5B4739D";
  level.iconlosing = "_encstr_A3F50C0892B36BA14D3FAF9356F7";
  level.icondefending = "_encstr_AD1F0F6DBD8E43BE3295CCCA374696E6D9";
}

hardpointmainloop() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  setomnvar("_encstr_873A1B7B08D94F3A22DB87D32BD4B2876890F5C7C3811B1388C9D36F29", 1);
  setomnvar("_encstr_A5A3135B23C10B1F636CA0F2722261B80C5C7BC075", 0);
  level.zone = getfirstzone();
  var_0 = 1;
  level.kothhillrotation = 0;

  if(!scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B"))
    level scripts\engine\utility::_id_143A5("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B", "_encstr_8F55118F8B711B6436974A09E1173783D313D9");

  level.zone _encstr_ADAF29DBC862F0B9946332ADE38E07C908AF33A068896AD6176A58F1524FD68AC861A25BCB4AAD7E4F430E::activatezone();
  level.favorclosespawnent = level.zone;
  level.zone.active = 1;
  level.zone scripts\mp\gameobjects::setvisibleteam("_encstr_9A19040BCDBC");
  level.zone scripts\mp\gameobjects::setobjectivestatusicons(level.icontarget);
  scripts\mp\utility\game::_id_119AC(undefined, undefined, "_encstr_AF1E0E86752B42AC7B20EAA3E0431DAB", level.zone.trigger.origin);
  level.zone thread scripts\common\utility::_id_13E0A(level._id_11B29, "_encstr_9AA40B86A51B8DF5ADBDB3958C", level.zone.trigger.origin);
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");

  if(level._id_1221A)
    level scripts\mp\gamelogic::pausetimer();

  setomnvar("_encstr_873A1B7B08D94F3A22DB87D32BD4B2876890F5C7C3811B1388C9D36F29", 0);
  var_1 = 0;

  if(level.firstzoneactivationdelay) {
    var_1 = 1;
    level.zoneendtime = int(gettime() + level.firstzoneactivationdelay * 1000);
    setomnvar("_encstr_A5A3135B23C10B1F636CA0F2722261B80C5C7BC075", level.zoneendtime);
    setomnvar("_encstr_81410DB3318110F73773B3196BF7AE", 12);
    level._id_14726 = 1;
    level thread scripts\mp\hud_message::updatematchstatushintforallplayers(undefined, 36, 36);
    level thread waitthenplaynewobj();
    level.zone thread _encstr_ADAF29DBC862F0B9946332ADE38E07C908AF33A068896AD6176A58F1524FD68AC861A25BCB4AAD7E4F430E::_id_1199E(level.firstzoneactivationdelay, level.zone.curorigin + level.zone.offset3d);
    wait(level.firstzoneactivationdelay);
    level._id_14726 = 0;
    level thread scripts\mp\hud_message::updatematchstatushintforallplayers(undefined, 35, 35);
    scripts\mp\utility\game::setmlgannouncement(5, "_encstr_BD78059C33C543");
  }

  scripts\mp\utility\sound::playsoundonplayers("_encstr_A63B13DA38BE1A8BEB0B36E84BCE58E8B2BE37661E");

  for(;;) {
    if(!isDefined(level._id_11AD5))
      level thread setupzonecallouts();

    level.objectivesetorder = 1;

    if(level._id_1221A)
      level scripts\mp\gamelogic::resumetimer();

    waittillframeend;
    level.zone scripts\mp\gameobjects::enableobject();
    level.zone.capturecount = 0;

    if(level.codcasterenabled)
      level.zone thread _encstr_ADAF29DBC862F0B9946332ADE38E07C908AF33A068896AD6176A58F1524FD68AC861A25BCB4AAD7E4F430E::trackgametypevips();

    scripts\mp\spawnlogic::clearlastteamspawns();
    hqactivatenextzone(var_1, var_0);
    var_0 = 0;
    var_1 = 0;
    setomnvar("_encstr_81410DB3318110F73773B3196BF7AE", 10);
    scripts\mp\spawnlogic::clearlastteamspawns();
    hpcaptureloop();
    var_2 = level.zone scripts\mp\gameobjects::getownerteam();

    if(level._id_1221A)
      level scripts\mp\gamelogic::resumetimer();

    level.lastcaptureteam = undefined;
    level.zone killhardpointvfx();
    level.zone.active = 0;

    if(istrue(level.usehpzonebrushes)) {
      foreach(var_4 in level.players)
      level.zone _encstr_ADAF29DBC862F0B9946332ADE38E07C908AF33A068896AD6176A58F1524FD68AC861A25BCB4AAD7E4F430E::hideplayerspecificbrushes(var_4);
    }

    level.zone scripts\mp\gameobjects::disableobject();
    level.zone scripts\mp\gameobjects::allowuse("_encstr_8BBA05185F8B99");
    level.zone scripts\mp\gameobjects::setownerteam("_encstr_A7A408B9CA5D1D4E2C63");
    updateservericons("_encstr_83270B204F9E4157D3C463FCDB", 0);
    level notify("_encstr_9B740BDBEF187A77B0B1CA578B");
    setomnvar("_encstr_81410DB3318110F73773B3196BF7AE", -1);
    spawn_next_zone();

    if(scripts\mp\utility\game::getgametype() == "_encstr_9A7205B39CB919" && level.kothhillrotation == 1) {}

    wait 0.5;

    if(level.usehqrules)
      thread forcespawnplayers();

    wait 0.5;
  }
}

waitthenplaynewobj() {
  if(istrue(level.infilvotiming))
    wait 9.5;
  else
    wait 7.0;

  foreach(var_1 in level.teamnamelist)
  scripts\mp\utility\dialog::statusdialog("_encstr_962909991059C7F8721301", var_1);
}

killhardpointvfx() {
  foreach(var_1 in level.players) {
    foreach(var_3 in var_1._hardpointeffect) {
      var_1._hardpointeffect = scripts\engine\utility::array_remove(var_1._hardpointeffect, var_3);

      if(isDefined(var_3))
        var_3 delete();
    }
  }

  if(isDefined(self.neutralhardpointfx) && self.neutralhardpointfx.size > 0) {
    foreach(var_3 in self.neutralhardpointfx)
    var_3 delete();
  }

  self.neutralhardpointfx = [];
}

_id_12BBC() {
  switch (level.mapname) {
    case "_encstr_994B10FAA8973CA771A27E6D431E0F8635E0":
    case "_encstr_86570E71DA311191DB1FD8887FCFA9A3":
      level._id_12BBE = ["_encstr_A34C02BB", "_encstr_AC4C024A", "_encstr_A14C023B", "_encstr_8B4C0227", "_encstr_864C02F9"];
      break;
    case "_encstr_AB5D0960CBB77E40E7D955":
    case "_encstr_8E940C29F87032C3FF82F50F725A":
      level._id_12BBE = ["_encstr_B84C027E", "_encstr_AC4C024A", "_encstr_A14C023B", "_encstr_A74C0222", "_encstr_8F4C026A"];
      break;
    case "_encstr_BDFF088922C9FF1946BF":
    case "_encstr_99020BB0027F38974BA78783FF":
      level._id_12BBE = ["_encstr_A34C02BB", "_encstr_B84C027E", "_encstr_A74C0222", "_encstr_A14C023B", "_encstr_AC4C024A"];
      break;
    case "_encstr_BA4D0DED61799A1FB5DB6AD2E30753":
      level._id_12BBE = ["_encstr_A34C02BB", "_encstr_8B4C0227", "_encstr_AC4C024A", "_encstr_B84C027E", "_encstr_A74C0222"];
      break;
    case "_encstr_86D70CE85A1768FD42CB95B7CB2A":
      level._id_12BBE = ["_encstr_8C0703491D", "_encstr_9A07034C89", "_encstr_A14C023B", "_encstr_A34C02BB", "_encstr_A74C0222"];
      break;
    case "_encstr_A3890850E25F90B79A83":
      level._id_12BBE = ["_encstr_990703B2F9", "_encstr_A74C0222", "_encstr_864C02F9", "_encstr_8B4C0227", "_encstr_B84C027E"];
      break;
    case "_encstr_B4870E0751AFABC1B8F1CE97A8181CF3":
      level._id_12BBE = ["_encstr_A34C02BB", "_encstr_B84C027E", "_encstr_914C02DC", "_encstr_A14C023B", "_encstr_864C02F9"];
      break;
    case "_encstr_97450D3D6B99037BE7B7EB8A8717F2":
    case "_encstr_82670A6D9FF7A9AAD022B0CA":
      level._id_12BBE = ["_encstr_A34C02BB", "_encstr_990703B2F9", "_encstr_B84C027E", "_encstr_AC4C024A", "_encstr_990703AAEB"];
      break;
    case "_encstr_BD960C6B0ED7CAD61CED395AD5B6":
      level._id_12BBE = ["_encstr_A34C02BB", "_encstr_A74C0222", "_encstr_A14C023B", "_encstr_AC4C024A", "_encstr_B84C027E"];
      break;
    case "_encstr_8E630E4F83673666B7C2EBA9B2233305":
      level._id_12BBE = ["_encstr_A34C02BB", "_encstr_A74C0222", "_encstr_A14C023B", "_encstr_AC4C024A", "_encstr_B84C027E"];
      break;
    default:
      break;
  }
}

getfirstzone() {
  if(isDefined(level._id_12BBE)) {
    var_0 = level.objectives[level._id_12BBE[0]];
    level.prevzoneindex = 0;
    level.playerzombiedroploot = level.objectives[level._id_12BBE[1]];
  } else {
    var_0 = level.objectives["_encstr_A34C02BB"];
    level.prevzoneindex = 1;
    level.playerzombiedroploot = level.objectives["_encstr_A74C0222"];
  }

  var_0 thread _encstr_ADAF29DBC862F0B9946332ADE38E07C908AF33A068896AD6176A58F1524FD68AC861A25BCB4AAD7E4F430E::_id_144DA();
  level.playerzombiedroploot thread _encstr_ADAF29DBC862F0B9946332ADE38E07C908AF33A068896AD6176A58F1524FD68AC861A25BCB4AAD7E4F430E::_id_144DA();
  return var_0;
}

getnextzone() {
  level notify("_encstr_A2FA163B83B8D3C1A0E35C53E908D5C7C8FBA30249045F42");

  if(level.zonerandomlocationorder) {
    var_0 = [];

    foreach(var_2 in level.teamnamelist)
    var_0[var_2] = (0, 0, 0);

    var_4 = scripts\mp\utility\game::getpotentiallivingplayers();

    foreach(var_6 in var_4) {
      if(var_6.team == "_encstr_AF8C0A1B6A1D6045925B4F7D") {
        continue;
      }
      var_0[var_6.team] = var_0[var_6.team] + var_6.origin;
    }

    var_8 = [];

    foreach(var_2 in level.teamnamelist) {
      var_10 = scripts\mp\utility\teams::getteamdata(var_2, "_encstr_9775086022BE1B413B8B");
      var_11 = max(var_10.size, 1);
      var_8[var_2] = var_0[var_2] / var_11;
    }

    if(!isDefined(level.prevzonelist) || isDefined(level.prevzonelist) && level.prevzonelist.size == level.objectives.size - 1)
      level.prevzonelist = [];

    level.prevzonelist[level.prevzonelist.size] = level.prevzoneindex;
    var_13 = 0.7;
    var_14 = 0.3;
    var_15 = undefined;
    var_16 = undefined;

    foreach(var_18 in level.objectives) {
      var_19 = 0;

      foreach(var_21 in level.prevzonelist) {
        if(var_18.objectivekey == scripts\engine\utility::string(var_21)) {
          var_19 = 1;
          break;
        }
      }

      if(var_19) {
        continue;
      }
      var_23 = var_18;
      var_24 = 0;

      foreach(var_2 in level.teamnamelist)
      var_24 = var_24 + distance2dsquared(var_23.curorigin, var_8[var_2]);

      var_27 = distance2dsquared(var_23.curorigin, level.zone.curorigin);
      var_28 = var_24 * var_13 + var_27 * var_14;

      if(!isDefined(var_16) || var_28 > var_16) {
        var_16 = var_28;
        var_15 = var_18.objectivekey;
      }
    }

    var_23 = level.objectives[var_15];
    level.prevzoneindex = var_15;
  } else {
    if(isDefined(level._id_12BBE)) {
      level.prevzoneindex++;

      if(level.prevzoneindex > level._id_12BBE.size - 1)
        level.prevzoneindex = 0;

      var_23 = level.objectives[level._id_12BBE[level.prevzoneindex]];
      var_30 = level.prevzoneindex + 1;

      if(var_30 > level._id_12BBE.size - 1)
        var_30 = 1;

      level.playerzombiedroploot = level.objectives[level._id_12BBE[var_30]];
    } else {
      level.prevzoneindex++;

      if(level.prevzoneindex > level.objectives.size)
        level.prevzoneindex = 1;

      var_23 = level.objectives[scripts\engine\utility::string(level.prevzoneindex)];
      var_30 = level.prevzoneindex + 1;

      if(var_30 > level.objectives.size)
        var_30 = 2;

      level.playerzombiedroploot = level.objectives[scripts\engine\utility::string(var_30)];
    }

    level.playerzombiedroploot thread _encstr_ADAF29DBC862F0B9946332ADE38E07C908AF33A068896AD6176A58F1524FD68AC861A25BCB4AAD7E4F430E::_id_144DA();
  }

  return var_23;
}

spawn_next_zone() {
  writecurrentrotationteamscore();
  level.zone _encstr_ADAF29DBC862F0B9946332ADE38E07C908AF33A068896AD6176A58F1524FD68AC861A25BCB4AAD7E4F430E::deactivatezone();
  level.zone = getnextzone();
  level.kothhillrotation++;
  level.zone _encstr_ADAF29DBC862F0B9946332ADE38E07C908AF33A068896AD6176A58F1524FD68AC861A25BCB4AAD7E4F430E::activatezone();
  level.favorclosespawnent = level.zone;
  level.zone.active = 1;
  level.zone.lastactivatetime = gettime();

  if(level.zoneactivationdelay > 0)
    level.zone scripts\mp\gameobjects::setobjectivestatusicons(level.icontarget);
  else
    level.zone scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);

  scripts\mp\utility\game::_id_119AC(undefined, undefined, "_encstr_AF1E0E86752B42AC7B20EAA3E0431DAB", level.zone.trigger.origin);
  level.zone thread scripts\common\utility::_id_13E0A(level._id_11B29, "_encstr_9AA40B86A51B8DF5ADBDB3958C", level.zone.trigger.origin);
}

hqactivatenextzone(var_0, var_1) {
  if(var_1) {
    foreach(var_3 in level.teamnamelist)
    scripts\mp\utility\dialog::statusdialog("_encstr_AA8314574B50C73FDF38F323237E81CF7780B5FDD3BF", var_3);
  } else {
    foreach(var_3 in level.teamnamelist)
    scripts\mp\utility\dialog::statusdialog("_encstr_AA8D10032AC1ED815F5F786887617B3B2A55", var_3);
  }

  scripts\mp\utility\sound::playsoundonplayers("_encstr_A63B13DA38BE1A8BEB0B36E84BCE58E8B2BE37661E");
  level.zone thread _encstr_ADAF29DBC862F0B9946332ADE38E07C908AF33A068896AD6176A58F1524FD68AC861A25BCB4AAD7E4F430E::hardpoint_setneutral();
  level.zone scripts\mp\gameobjects::allowuse("_encstr_8BBA05185F8B99");

  if(istrue(var_0)) {} else if(level.zoneactivationdelay) {
    level.zone scripts\mp\gameobjects::setobjectivestatusicons(level.icontarget);
    updateservericons("_encstr_9651163DED73B2AF161BE85AD958474BDE9BD7465663585E", 0);
    level.zoneendtime = int(gettime() + 1000 * level.zoneactivationdelay);
    setomnvar("_encstr_A5A3135B23C10B1F636CA0F2722261B80C5C7BC075", level.zoneendtime);
    setomnvar("_encstr_81410DB3318110F73773B3196BF7AE", 12);

    if(level._id_1221A)
      level scripts\mp\gamelogic::pausetimer();

    level._id_14726 = 1;
    level thread scripts\mp\hud_message::updatematchstatushintforallplayers(undefined, 36, 36);
    level.zone thread _encstr_ADAF29DBC862F0B9946332ADE38E07C908AF33A068896AD6176A58F1524FD68AC861A25BCB4AAD7E4F430E::_id_1199E(level.zoneactivationdelay, level.zone.curorigin + level.zone.offset3d);
    wait(level.zoneactivationdelay);
    level._id_14726 = 0;
    level thread scripts\mp\hud_message::updatematchstatushintforallplayers(undefined, 35, 35);
    scripts\mp\utility\game::setmlgannouncement(5, "_encstr_BD78059C33C543");
  }

  level.zone scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);
  updateservericons("_encstr_A7A408B9CA5D1D4E2C63", 0);

  if(level.zoneduration) {
    updateservericons("_encstr_A7A408B9CA5D1D4E2C63", 0);

    if(level.usehqrules)
      thread locktimeruntilcap();
    else {
      thread movezoneaftertime(level.zoneduration);
      level.zoneendtime = int(gettime() + 1000 * level.zoneduration);
      setomnvar("_encstr_A5A3135B23C10B1F636CA0F2722261B80C5C7BC075", level.zoneendtime);
    }
  } else
    level.zonedestroyedbytimer = 0;
}

locktimeruntilcap() {
  level endon("_encstr_86C30E225D088A98370A61DBF31607CC");

  for(;;) {
    level.zoneendtime = int(gettime() + 1000 * level.zoneduration);
    setomnvar("_encstr_A5A3135B23C10B1F636CA0F2722261B80C5C7BC075", level.zoneendtime);
    waitframe();
  }
}

hpcaptureloop() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_87BD0BFA5FF0DFF73978FBF221");
  level.hpstarttime = gettime();

  for(;;) {
    level.zone scripts\mp\gameobjects::allowuse("_encstr_88BF06FD784A6393");
    level.zone scripts\mp\gameobjects::setvisibleteam("_encstr_9A19040BCDBC");
    level.zone scripts\mp\gameobjects::setusetext(&"_encstr_838E1511A2461705EBF709D9B3C79EC9A89A9B054CF865");

    if(!level.usehqrules) {
      level.zone thread _encstr_ADAF29DBC862F0B9946332ADE38E07C908AF33A068896AD6176A58F1524FD68AC861A25BCB4AAD7E4F430E::hardpoint_setneutral();
      level.zone scripts\mp\gameobjects::cancontestclaim(1);
    }

    if(isDefined(level.matchrules_droptime) && level.matchrules_droptime)
      level thread _encstr_A9631EE6B1939638D1B9F2B6C1973B85B6AC3AF283ACE65EEC4EDC2371CEDCD8::randomdrops();

    var_0 = level scripts\engine\utility::_id_143AD("_encstr_86C30E225D088A98370A61DBF31607CC", "_encstr_A29C0FA77BE659D74656B9479CDBE52B91");

    if(var_0 == "_encstr_A29C0FA77BE659D74656B9479CDBE52B91") {
      continue;
    }
    var_1 = level.zone scripts\mp\gameobjects::getownerteam();
    scripts\mp\utility\sound::playsoundonplayers("_encstr_88DB1FA8039FB07B93B79F28CC6A699E0BDFC898FF6AA93929DA182E24239BE375", var_1);
    scripts\mp\utility\sound::playsoundonplayers("_encstr_83371F10BB2778B34B7F67E014A2D1C64397805037A2116161E5D5FC6E5BD32BAD", scripts\mp\utility\game::getotherteam(var_1)[0]);

    if(level.usehqrules && level.zoneduration > 0)
      thread movezoneaftertime(level.zoneduration);

    level waittill("_encstr_A29C0FA77BE659D74656B9479CDBE52B91", var_2);

    if(isDefined(var_2))
      level.zone scripts\mp\gameobjects::setownerteam(var_2);
    else
      level.zone scripts\mp\gameobjects::setownerteam("_encstr_8BBA05185F8B99");

    if(level.usehqrules) {
      setomnvar("_encstr_81410DB3318110F73773B3196BF7AE", -1);
      break;
    }
  }
}

initspawns() {
  scripts\mp\spawnlogic::setactivespawnlogic("_encstr_8B1608CC43B8D647A113", "_encstr_A6E80F61DA270BDE09B2C8C33B40AB859D");
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::addstartspawnpoints("_encstr_929D1B23507162284B89D7DB03F89F302F56F36D370753A1B0A386AB3B");
  scripts\mp\spawnlogic::addstartspawnpoints("_encstr_ACBC19ED4796D7AD9928916BD08BE38BCEA770915E3E0FB35B102B");
  scripts\mp\spawnlogic::addspawnpoints(game["_encstr_991C0AB9ED5B57161FE89B83"], "_encstr_929D1B23507162284B89D7DB03F89F302F56F36D370753A1B0A386AB3B");
  scripts\mp\spawnlogic::addspawnpoints(game["_encstr_B6A70A23CA6659DC91CAE4DC"], "_encstr_ACBC19ED4796D7AD9928916BD08BE38BCEA770915E3E0FB35B102B");
  var_0 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_929D1B23507162284B89D7DB03F89F302F56F36D370753A1B0A386AB3B");
  var_1 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_ACBC19ED4796D7AD9928916BD08BE38BCEA770915E3E0FB35B102B");
  scripts\mp\spawnlogic::registerspawnset("_encstr_8203101FF33885AB060225CD31A68A4B6AD7", var_0);
  scripts\mp\spawnlogic::registerspawnset("_encstr_9AE3109755F34D5879256960F390C8FFD207", var_1);
  scripts\mp\spawnlogic::addspawnpoints("_encstr_9A8507BA4040188D08", "_encstr_97BF0EB607FADABD1DA1D76E8316BB9B", 1);
  scripts\mp\spawnlogic::addspawnpoints("_encstr_8E8405EA382B2A", "_encstr_97BF0EB607FADABD1DA1D76E8316BB9B", 1);
  scripts\mp\spawnlogic::addspawnpoints("_encstr_9A8507BA4040188D08", "_encstr_ABC218DA077D5BDB1DD0AFB90EC2DD9BF59B56B1B7CD8CC2C9BC", 1, 1);
  scripts\mp\spawnlogic::addspawnpoints("_encstr_8E8405EA382B2A", "_encstr_ABC218DA077D5BDB1DD0AFB90EC2DD9BF59B56B1B7CD8CC2C9BC", 1, 1);

  if(!isDefined(level.spawnpoints) || istrue(level.binoculars_clearuidata)) {
    scripts\mp\spawnlogic::addspawnpoints("_encstr_9A8507BA4040188D08", "_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD");
    scripts\mp\spawnlogic::addspawnpoints("_encstr_8E8405EA382B2A", "_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD");
    scripts\mp\spawnlogic::addspawnpoints("_encstr_9A8507BA4040188D08", "_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", 1, 1);
    scripts\mp\spawnlogic::addspawnpoints("_encstr_8E8405EA382B2A", "_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", 1, 1);
    var_2 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD");
    var_3 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318");
    scripts\mp\spawnlogic::registerspawnset("_encstr_820E07FAE8780B3A4C", var_2);
    scripts\mp\spawnlogic::registerspawnset("_encstr_AD0C095DF195E8B6074A18", var_3);
  }

  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);

  if(istrue(level.binoculars_clearuidata)) {
    return;
  }
  foreach(var_5 in level.objectives) {
    var_5.furthestspawndistsq = 0;
    var_5.spawnpoints = [];
    var_5.fallbackspawnpoints = [];
  }

  foreach(var_8 in level.spawnpoints) {
    var_9 = var_8.classname == "_encstr_929D1B23507162284B89D7DB03F89F302F56F36D370753A1B0A386AB3B" || var_8.classname == "_encstr_ACBC19ED4796D7AD9928916BD08BE38BCEA770915E3E0FB35B102B";
    var_10 = 0;
    var_11 = var_8.classname == "_encstr_97BF0EB607FADABD1DA1D76E8316BB9B";
    var_12 = var_8.classname == "_encstr_ABC218DA077D5BDB1DD0AFB90EC2DD9BF59B56B1B7CD8CC2C9BC";
    var_13 = [];

    if(var_9) {
      continue;
    }
    if(var_11 || var_12) {
      if(isDefined(var_8.script_noteworthy) && var_8.script_noteworthy != "_encstr_B40101") {
        var_10 = 1;
        var_13 = strtok(var_8.script_noteworthy, "_encstr_974C0246");

        foreach(var_15 in var_13) {
          if(var_15 == "_encstr_8A1804CF18C5" || var_15 == "_encstr_B27706C1CF833659") {
            continue;
          }
          if(!postshipmodifiedzones(var_15)) {
            var_5 = level.objectives[var_15];

            if(var_11) {
              var_5.spawnpoints[var_5.spawnpoints.size] = var_8;
              continue;
            }

            var_5.fallbackspawnpoints[var_5.fallbackspawnpoints.size] = var_8;
          }
        }
      }
    }

    calculatespawndisttozones(var_8, var_13);
    var_17 = scripts\mp\spawnlogic::getoriginidentifierstring(var_8);

    if(isDefined(level.kothextraprimaryspawnpoints) && isDefined(level.kothextraprimaryspawnpoints[var_17])) {
      foreach(var_15 in level.kothextraprimaryspawnpoints[var_17]) {
        var_5 = level.objectives[var_15];
        var_5.spawnpoints[var_5.spawnpoints.size] = var_8;
      }
    }

    if(!var_10) {
      foreach(var_5 in level.objectives) {
        if(var_11) {
          var_5.spawnpoints[var_5.spawnpoints.size] = var_8;
          continue;
        }

        var_5.fallbackspawnpoints[var_5.fallbackspawnpoints.size] = var_8;
      }
    }
  }

  foreach(var_24, var_5 in level.objectives) {
    var_5.spawnset = "_encstr_839F069FEF15AA77" + var_24;
    scripts\mp\spawnlogic::registerspawnset(var_5.spawnset, var_5.spawnpoints);
    var_5.fallbackspawnset = "_encstr_83FC0F9077BCC87FDAEE999106824F102F" + var_24;
    scripts\mp\spawnlogic::registerspawnset(var_5.fallbackspawnset, var_5.fallbackspawnpoints);
  }
}

calculatespawndisttozones(var_0, var_1) {
  var_2 = 0;
  var_0.scriptdata.distsqtokothzones = [];

  foreach(var_4 in level.objectives) {
    if(isDefined(var_0.script_noteworthy) && var_0.script_noteworthy == "_encstr_B40101")
      var_2 = 1;
    else {
      foreach(var_6 in var_1) {
        if(var_6 == var_4.trigger.objectivekey) {
          var_2 = 1;
          break;
        }
      }
    }

    if(!var_2) {
      continue;
    }
    var_8 = getpathdist(var_0.origin, var_4.trigger.baseorigin, 5000);

    if(var_8 < 0)
      var_8 = scripts\engine\utility::distance_2d_squared(var_0.origin, var_4.trigger.baseorigin);
    else
      var_8 = var_8 * var_8;

    var_0.scriptdata.distsqtokothzones[var_4.trigger getentitynumber()] = var_8;

    if(var_8 > var_4.furthestspawndistsq)
      var_4.furthestspawndistsq = var_8;
  }
}

comparezoneindexes(var_0, var_1) {
  var_2 = int(var_0.objectivekey);
  var_3 = int(var_1.objectivekey);

  if(!isDefined(var_2) && !isDefined(var_3))
    return 0;

  if(!isDefined(var_2) && isDefined(var_3))
    return 1;

  if(isDefined(var_2) && !isDefined(var_3))
    return 0;

  if(var_2 > var_3)
    return 1;

  return 0;
}

getzonearray(var_0) {
  var_1 = getEntArray(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_3 in var_1)
  var_3.objectivekey = var_3.script_label;

  if(!isDefined(var_1) || var_1.size == 0)
    return undefined;

  var_5 = 1;

  for(var_6 = var_1.size; var_5; var_6--) {
    var_5 = 0;

    for(var_7 = 0; var_7 < var_6 - 1; var_7++) {
      if(comparezoneindexes(var_1[var_7], var_1[var_7 + 1])) {
        var_8 = var_1[var_7];
        var_1[var_7] = var_1[var_7 + 1];
        var_1[var_7 + 1] = var_8;
        var_5 = 1;
      }
    }
  }

  return var_1;
}

setupzones() {
  var_0 = getzonearray("_encstr_8E4A0FABC16B29497522C86039483F206F");
  var_1 = [];

  for(var_2 = 0; var_2 < var_0.size; var_2++)
    var_1[var_1.size] = var_0[var_2];

  level.objectives = [];

  foreach(var_4 in var_1) {
    var_5 = _encstr_ADAF29DBC862F0B9946332ADE38E07C908AF33A068896AD6176A58F1524FD68AC861A25BCB4AAD7E4F430E::setupobjective(var_4);
    level.objectives[var_5.objectivekey] = var_5;
  }

  var_7 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_ACBC19ED4796D7AD9928916BD08BE38BCEA770915E3E0FB35B102B");
  var_8 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_929D1B23507162284B89D7DB03F89F302F56F36D370753A1B0A386AB3B");
  level.startpos["_encstr_9A8507BA4040188D08"] = var_8[0].origin;
  level.startpos["_encstr_8E8405EA382B2A"] = var_7[0].origin;
  return 1;
}

setupzoneareabrushes() {
  level.neutralzonebrushes = [];
  level.contestedzonebrushes = [];
  level.friendlyzonebrushes = [];
  level.enemyzonebrushes = [];
  var_0 = getzonearray("_encstr_B16316A1F75345F8EFDC401B49D2C8889AA7052BC74B9F20");
  var_1 = getzonearray("_encstr_BE9B1EF1A70315A85F6CF0CB992218582AF7757B779B6F9057C6D8807BE59B8D");
  var_2 = getzonearray("_encstr_99C51DE44FE54278E058A3F3D17A2FAA93C8EBDC2E43AABC0EC8DB8F68901C");
  var_3 = getzonearray("_encstr_B6D41C52D835D70B280BD6C408D22F1DB3913BDAA0C34EB30665AECD395A");

  if(!isDefined(var_0))
    level.usehpzonebrushes = 0;
  else
    level.usehpzonebrushes = 1;

  if(istrue(level.usehpzonebrushes)) {
    foreach(var_5 in var_0) {
      level.neutralzonebrushes[var_5.script_label] = var_5;
      var_5 hide();
    }

    foreach(var_5 in var_1) {
      level.contestedzonebrushes[var_5.script_label] = var_5;
      var_5 hide();
    }

    foreach(var_5 in var_2) {
      level.friendlyzonebrushes[var_5.script_label] = var_5;
      var_5 hide();
    }

    foreach(var_5 in var_3) {
      level.enemyzonebrushes[var_5.script_label] = var_5;
      var_5 hide();
    }

    postshipmodifiedzonebrushes();
    thread matchbrushestozones();
  }
}

postshipmodifiedzonebrushes() {
  if(level.mapname == "_encstr_824D0B772110BBD920C07DC3DB") {
    for(var_0 = 0; var_0 < level.neutralzonebrushes.size; var_0++) {
      if(level.neutralzonebrushes[var_0].script_label == "_encstr_A34C02BB") {
        level.neutralzonebrushes[var_0] hide();
        var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (0, 0, 0));
        var_1 setModel("_encstr_8FBB1EDA03A0D34E88F74745DDB954DF5EF9836288801B09C0D14F57B5918A66");
        var_1.angles = (0, 0, 0);
        var_1.script_label = "_encstr_A34C02BB";
        level.neutralzonebrushes[var_0] = var_1;
      }
    }

    for(var_0 = 0; var_0 < level.contestedzonebrushes.size; var_0++) {
      if(level.contestedzonebrushes[var_0].script_label == "_encstr_A34C02BB") {
        level.contestedzonebrushes[var_0] hide();
        var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (0, 0, 0));
        var_2 setModel("_encstr_871D266B837D07B04E5BED5D27FA34C29CC883DB96733AD7CC1BDEDEE4F56089F56CB7E64756CD1D");
        var_2.angles = (0, 0, 0);
        var_2.script_label = "_encstr_A34C02BB";
        level.contestedzonebrushes[var_0] = var_2;
      }
    }

    for(var_0 = 0; var_0 < level.friendlyzonebrushes.size; var_0++) {
      if(level.friendlyzonebrushes[var_0].script_label == "_encstr_A34C02BB") {
        level.friendlyzonebrushes[var_0] hide();
        var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (0, 0, 0));
        var_3 setModel("_encstr_950A25ADE0BEC1B093DAB7ABC9D70DC2E44638DBA59BD1AF9936BDBD277D0389FA66E45AACE619");
        var_3.angles = (0, 0, 0);
        var_3.script_label = "_encstr_A34C02BB";
        level.friendlyzonebrushes[var_0] = var_3;
      }
    }

    for(var_0 = 0; var_0 < level.enemyzonebrushes.size; var_0++) {
      if(level.enemyzonebrushes[var_0].script_label == "_encstr_A34C02BB") {
        level.enemyzonebrushes[var_0] hide();
        var_4 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (0, 0, 0));
        var_4 setModel("_encstr_8252248119BF839806E757F308E1695976E15A672350FC07A6630760A267B78A583DE3A988EA");
        var_4.angles = (0, 0, 0);
        var_4.script_label = "_encstr_A34C02BB";
        level.enemyzonebrushes[var_0] = var_4;
      }
    }
  }
}

matchbrushestozones() {
  foreach(var_1 in level.objectives) {
    var_1.neutralbrush = level.neutralzonebrushes[var_1.objectivekey];
    var_1.enemybrush = level.enemyzonebrushes[var_1.objectivekey];
    var_1.contestedbrush = level.contestedzonebrushes[var_1.objectivekey];
    var_1.friendlybrush = level.friendlyzonebrushes[var_1.objectivekey];
  }
}

setupzonecallouts() {
  var_0 = undefined;
  var_1 = undefined;
  var_2 = undefined;
  var_3 = level.zone.visuals[0];

  foreach(var_5 in level.calloutglobals.areatriggers) {
    var_1 = ispointinvolume(var_3.baseorigin, var_5);
    var_2 = isDefined(var_3.script_noteworthy) && isDefined(var_5.script_noteworthy) && var_3.script_noteworthy == var_5.script_noteworthy;

    if(var_1 || var_2) {
      var_0 = level.calloutglobals.areaidmap[var_5.script_noteworthy];

      foreach(var_7 in level.players) {
        if(isDefined(var_0))
          var_7 setclientomnvar("_encstr_997811BA96FAA11C7D1B2C36C6DEAEE87DB491", var_0);
      }

      break;
    }
  }

  scripts\mp\utility\game::setmlgannouncement(4, "_encstr_BD78059C33C543");
}

forcespawnplayers() {
  var_0 = level.players;

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];

    if(!isDefined(var_2) || isalive(var_2)) {
      continue;
    }
    var_2 notify("_encstr_A3D50C33DE93B159EBCD1CB0DDB9");
    waitframe();
  }
}

getspawnpoint() {
  var_0 = self.pers["_encstr_8AEF05472BC2D6"];
  var_1 = getkothzonedeadzonedist();
  var_2 = [];
  var_2["_encstr_95E3152CC6A35AEC5996A7A284A5BD9BCAE457B513B239"] = level.zone.trigger getentitynumber();
  var_2["_encstr_AC921AF7627031A3C02F53A7A46D886BA324607C1E2B45B62B6B3B4A"] = level.zone.furthestspawndistsq;
  var_2["_encstr_A1F117DA7BD18669F6CD5922B28523A7B7E65944D2DCD14DE2"] = var_1 * var_1;
  var_2["_encstr_B6421CDFE1BF8870FE8B55C53F7F20EB55B7D9B30F5DAF5311ECAE61092A"] = 12250000;

  if(istrue(level.binoculars_clearuidata)) {
    if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
      if(var_0 == game["_encstr_991C0AB9ED5B57161FE89B83"]) {
        scripts\mp\spawnlogic::activatespawnset("_encstr_8203101FF33885AB060225CD31A68A4B6AD7", 1);
        var_3 = scripts\mp\spawnlogic::getspawnpoint(self, var_0, undefined, "_encstr_8203101FF33885AB060225CD31A68A4B6AD7");
      } else {
        scripts\mp\spawnlogic::activatespawnset("_encstr_9AE3109755F34D5879256960F390C8FFD207", 1);
        var_3 = scripts\mp\spawnlogic::getspawnpoint(self, var_0, undefined, "_encstr_9AE3109755F34D5879256960F390C8FFD207");
      }
    } else {
      scripts\mp\spawnlogic::activatespawnset("_encstr_820E07FAE8780B3A4C", 1);
      var_3 = scripts\mp\spawnlogic::getspawnpoint(self, var_0, undefined, "_encstr_AD0C095DF195E8B6074A18");
    }
  } else if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    if(var_0 == game["_encstr_991C0AB9ED5B57161FE89B83"]) {
      scripts\mp\spawnlogic::activatespawnset("_encstr_8203101FF33885AB060225CD31A68A4B6AD7", 1);
      var_3 = scripts\mp\spawnlogic::getspawnpoint(self, var_0, undefined, "_encstr_8203101FF33885AB060225CD31A68A4B6AD7", undefined, var_2);
    } else {
      scripts\mp\spawnlogic::activatespawnset("_encstr_9AE3109755F34D5879256960F390C8FFD207", 1);
      var_3 = scripts\mp\spawnlogic::getspawnpoint(self, var_0, undefined, "_encstr_9AE3109755F34D5879256960F390C8FFD207", undefined, var_2);
    }
  } else {
    if(!isDefined(level._id_139D1)) {
      level._id_139D1 = 1;
      scripts\mp\spawnlogic::setactivespawnlogic("_encstr_B67B0A122C279107DBB49BA3", "_encstr_829A0D0F1AF8FB5ED127855073F940");
    }

    var_3 = scripts\mp\spawnlogic::getspawnpoint(self, var_0, level.zone.spawnset, level.zone.fallbackspawnset, "_encstr_8F1904CA1729", var_2);
  }

  return var_3;
}

getkothzonedeadzonedist() {
  return 1000;
}

onspawnplayer() {
  scripts\mp\utility\lower_message::setlowermessageomnvar(0);
  self.forcespawnnearteammates = undefined;
  thread updatematchstatushintonspawn();
}

movezoneaftertime(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_9B740BDBEF187A77B0B1CA578B");
  level endon("_encstr_A6940FED853B0E2535D3E028F988FFE0AF");
  level.zonemovetime = var_0;
  level.zonedestroyedbytimer = 0;
  _encstr_ADAF29DBC862F0B9946332ADE38E07C908AF33A068896AD6176A58F1524FD68AC861A25BCB4AAD7E4F430E::zonetimerwait();
  level.zonedestroyedbytimer = 1;
  level notify("_encstr_87BD0BFA5FF0DFF73978FBF221");
  level notify("_encstr_A29C0FA77BE659D74656B9479CDBE52B91");
}

onplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!isPlayer(var_1) || var_1.team == self.team) {
    return;
  }
  if(var_1 == self) {
    return;
  }
  if(!isDefined(level.zone)) {
    return;
  }
  var_10 = level.zone.ownerteam;

  if(!isDefined(var_10)) {
    return;
  }
  if(isDefined(var_4) && scripts\mp\utility\weapon::iskillstreakweapon(var_4.basename)) {
    return;
  }
  var_11 = self;
  var_12 = 0;
  var_13 = var_1.team;

  if(level.zonecapturetime > 0 && var_1 istouching(level.zone.trigger)) {
    if(var_10 != var_13)
      var_12 = 1;
  }

  if(var_13 != var_10) {
    if(var_12)
      var_1 thread scripts\mp\utility\points::giveunifiedpoints("_encstr_8DFD0D67E0E384A31D4DD1D4A3F9EA");
    else if(var_11 istouching(level.zone.trigger)) {
      var_1 thread scripts\mp\rank::scoreeventpopup("_encstr_AB3508737F830710ACDB");
      var_1 thread scripts\mp\awards::givemidmatchaward("_encstr_8E020FAB6877F10FCBEFD81F63FB9B901C");
      thread scripts\common\utility::_id_13E0A(level._id_11B30, var_9, "_encstr_ABA70A195633CADC324BDC76");
    }
  } else if(var_1 istouching(level.zone.trigger)) {
    var_1 thread scripts\mp\rank::scoreeventpopup("_encstr_A20C07ABF304625E08");
    var_1 thread scripts\mp\awards::givemidmatchaward("_encstr_93D80ED6F646B2AFF0EB1995CCCA3791");
    var_1 scripts\mp\utility\stats::incpersstat("_encstr_B1F7085B03F492AE98DB", 1);
    var_1 scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_B1F7085B03F492AE98DB", var_1.pers["_encstr_B1F7085B03F492AE98DB"]);
    var_1 scripts\mp\utility\stats::setextrascore1(var_1.pers["_encstr_B1F7085B03F492AE98DB"]);
  }
}

give_capture_credit(var_0, var_1, var_2, var_3, var_4, var_5) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level.lastcaptime = gettime();
  scripts\mp\utility\game::_id_119AC(var_4, undefined, "_encstr_AA66138BA0E3D4B3670B5DD3C767FA888BB8EBA760", var_4.origin);
  var_6 = var_4;

  if(isDefined(var_6.owner))
    var_6 = var_6.owner;

  if(isPlayer(var_6)) {
    var_6 thread scripts\common\utility::_id_13E0A(level._id_11B29, "_encstr_95EB0866891B23FB85B3", var_6.origin);

    if(unset_forced_aitype_armored(var_6) && !scripts\mp\utility\game::isanymlgmatch()) {} else if(!isscoreboosting(var_6)) {
      var_6 thread scripts\mp\rank::scoreeventpopup("_encstr_A3790A6321108BDDA8033AC7");
      var_6 thread scripts\mp\awards::givemidmatchaward("_encstr_B2A70FEDC8F1EFA1A1E8916B788F63FB89");
    } else {
      var_6 thread scripts\mp\rank::scoreeventpopup("_encstr_A3790A6321108BDDA8033AC7");
      var_6 thread scripts\mp\awards::givemidmatchaward("_encstr_811517E54FDFAB0F2078175BE2E808DB30C10B77DA03D329C1");
    }

    if(isDefined(level.zone.lastactivatetime) && gettime() - level.zone.lastactivatetime <= 2100) {
      var_6 thread scripts\mp\rank::scoreeventpopup("_encstr_AD7F0D8607EBC5AB4B6CB6D7C6B0E0");
      var_6 thread scripts\mp\awards::givemidmatchaward("_encstr_97D91205E8A9323760F0074720B8C31A07768EFA");
    }

    if(var_6.lastkilltime + 500 > gettime()) {} else
      var_6 _encstr_ADAF29DBC862F0B9946332ADE38E07C908AF33A068896AD6176A58F1524FD68AC861A25BCB4AAD7E4F430E::setcrankedtimerzonecap(var_6);
  }

  var_7 = getarraykeys(var_0);

  for(var_8 = 0; var_8 < var_7.size; var_8++) {
    var_9 = var_0[var_7[var_8]].player;
    var_9 updatecapsperminute(var_3);

    if(!isscoreboosting(var_9)) {
      var_9 scripts\mp\utility\stats::incpersstat("_encstr_81CF0936850ED1D54EACCD", 1);
      var_9 scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_81CF0936850ED1D54EACCD", var_9.pers["_encstr_81CF0936850ED1D54EACCD"]);
    } else {}

    if(var_6 != var_9) {
      var_9 thread scripts\mp\rank::scoreeventpopup("_encstr_96E10F4E1293111B5BCF794043AB0C0FFB");
      var_9 thread scripts\mp\awards::givemidmatchaward("_encstr_A57E172DC0B12ADF09F027E73801DB93356D39A6B6C7A23BD3");
      var_9 _encstr_ADAF29DBC862F0B9946332ADE38E07C908AF33A068896AD6176A58F1524FD68AC861A25BCB4AAD7E4F430E::setcrankedtimerzonecap(var_9);
    }

    wait 0.05;
  }
}

awardcapturepoints() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_9B740BDBEF187A77B0B1CA578B");
  level endon("_encstr_87BD0BFA5FF0DFF73978FBF221");
  level notify("_encstr_83DD1A1BAF8E40FDC7D2B33BFB6B2509A519BDB933BAB0304B4A0841");
  level endon("_encstr_83DD1A1BAF8E40FDC7D2B33BFB6B2509A519BDB933BAB0304B4A0841");
  var_0 = 1;
  var_1 = 1;

  while(!level.gameended) {
    var_2 = 0.0;

    while(var_2 < var_0 && !level.gameended) {
      wait(level.framedurationseconds);
      scripts\mp\hostmigration::waittillhostmigrationdone();
      var_2 = var_2 + level.framedurationseconds;

      if(level.zone.stalemate)
        var_2 = 0.0;
    }

    var_3 = level.zone scripts\mp\gameobjects::getownerteam();

    if(var_3 == "_encstr_A7A408B9CA5D1D4E2C63") {
      continue;
    }
    if(level.gameended) {
      break;
    }

    if(level.usehqrules) {
      if(level.zoneadditivescoring)
        var_1 = level.zone.touchlist[var_3].size;

      scripts\mp\gamescore::giveteamscoreforobjective(var_3, var_1, 0);
      continue;
    }

    if(!level.zone.stalemate && !level.gameended) {
      if(level.zoneadditivescoring)
        var_1 = level.zone.touchlist[var_3].size;

      scripts\mp\gamescore::giveteamscoreforobjective(var_3, var_1, 0);

      foreach(var_5 in level.zone.touchlist[var_3]) {
        var_5.player scripts\mp\utility\stats::incpersstat("_encstr_ACF5089FF6827199725B", 1);

        if(isDefined(var_5.player.timebyrotation[level.kothhillrotation]))
          var_5.player.timebyrotation[level.kothhillrotation]++;
        else
          var_5.player.timebyrotation[level.kothhillrotation] = 1;

        var_5.player scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_ACF5089FF6827199725B", var_5.player.pers["_encstr_ACF5089FF6827199725B"]);
        var_5.player scripts\mp\utility\stats::setextrascore0(var_5.player.pers["_encstr_ACF5089FF6827199725B"]);

        if(isDefined(var_5.player.spawn_sentry_at_pos) && var_5.player.spawn_sentry_at_pos > 3) {
          var_5.player.spawn_sentry_at_pos = 0;

          if(scripts\mp\utility\game::getgametype() == "_encstr_BDD705AD7BD143")
            var_5.player scripts\mp\utility\points::giveunifiedpoints("_encstr_991E0CD6DBD11AD75AB9EBBDC4A9", undefined, 15);
          else if(scripts\mp\utility\game::getgametype() == "_encstr_9A7205B39CB919")
            var_5.player scripts\mp\utility\points::giveunifiedpoints("_encstr_88560C1188E51F7F119A57370892", undefined, 15);

          continue;
        }

        if(!isDefined(var_5.player.spawn_sentry_at_pos))
          var_5.player.spawn_sentry_at_pos = 0;
        else
          var_5.player.spawn_sentry_at_pos++;

        var_5.player scripts\mp\gamescore::giveplayerscore("_encstr_991E0CD6DBD11AD75AB9EBBDC4A9", 10);
      }
    }
  }
}

updatecapsperminute(var_0) {
  if(!isDefined(self.capsperminute)) {
    self.numcaps = 0;
    self.capsperminute = 0;
  }

  if(!isDefined(var_0) || var_0 == "_encstr_A7A408B9CA5D1D4E2C63") {
    return;
  }
  self.numcaps++;
  var_1 = scripts\mp\utility\game::gettimepassed() / 60000;

  if(isPlayer(self) && isDefined(self.timeplayed["_encstr_BE7D0633C08849E2"]))
    var_1 = self.timeplayed["_encstr_BE7D0633C08849E2"] / 60;

  self.capsperminute = self.numcaps / var_1;

  if(self.capsperminute > self.numcaps)
    self.capsperminute = self.numcaps;
}

isscoreboosting(var_0) {
  if(var_0.capsperminute > 3)
    return 1;

  return 0;
}

unset_forced_aitype_armored(var_0) {
  if(var_0.capsperminute > 6)
    return 1;

  return 0;
}

onplayerconnect(var_0) {
  var_0._hardpointeffect = [];
  var_0.numcaps = 0;
  var_0.capsperminute = 0;
  var_0.timebyrotation = [];
  var_0 scripts\mp\utility\stats::setextrascore0(0);

  if(isDefined(var_0.pers["_encstr_ACF5089FF6827199725B"]))
    var_0 scripts\mp\utility\stats::setextrascore0(var_0.pers["_encstr_ACF5089FF6827199725B"]);

  var_0 scripts\mp\utility\stats::setextrascore1(0);

  if(isDefined(var_0.pers["_encstr_B1F7085B03F492AE98DB"]))
    var_0 scripts\mp\utility\stats::setextrascore1(var_0.pers["_encstr_B1F7085B03F492AE98DB"]);

  thread onplayerspawned(var_0);

  foreach(var_2 in level.objectives) {
    if(istrue(level.usehpzonebrushes))
      var_2 _encstr_ADAF29DBC862F0B9946332ADE38E07C908AF33A068896AD6176A58F1524FD68AC861A25BCB4AAD7E4F430E::hideplayerspecificbrushes(var_0);
  }

  var_0 thread refreshfreecamhardpointfx();
}

onplayerspawned(var_0) {
  for(;;) {
    var_0 waittill("_encstr_BA350853C128FB939DB9");

    foreach(var_2 in level.objectives) {
      if(istrue(var_2.active)) {
        if(var_2.ownerteam == "_encstr_A7A408B9CA5D1D4E2C63") {
          var_2 _encstr_ADAF29DBC862F0B9946332ADE38E07C908AF33A068896AD6176A58F1524FD68AC861A25BCB4AAD7E4F430E::playhardpointneutralfx();
          continue;
        }

        var_2 _encstr_ADAF29DBC862F0B9946332ADE38E07C908AF33A068896AD6176A58F1524FD68AC861A25BCB4AAD7E4F430E::showcapturedhardpointeffecttoplayer(var_2.ownerteam, var_0);
      }
    }
  }
}

updateservericons(var_0, var_1) {
  var_2 = -1;

  if(var_1)
    var_2 = -2;
  else if(scripts\mp\utility\teams::isgameplayteam(var_0)) {
    var_3 = thread getownerteamplayer(var_0);

    if(isDefined(var_3))
      var_2 = var_3 getentitynumber();
  } else {
    switch (var_0) {
      case "_encstr_9651163DED73B2AF161BE85AD958474BDE9BD7465663585E":
        var_2 = -3;
        break;
      case "_encstr_83270B204F9E4157D3C463FCDB":
      default:
        break;
    }
  }

  setomnvar("_encstr_95E80DAE5ABEA11693190EB79637A3", var_2);
}

getownerteamplayer(var_0) {
  var_1 = undefined;

  foreach(var_3 in level.players) {
    if(var_3.team == var_0) {
      var_1 = var_3;
      break;
    }
  }

  return var_1;
}

refreshfreecamhardpointfx() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    self waittill("_encstr_8DEB10B1FD2F404F8B0A906083E72D1B7782", var_0, var_1);

    if(var_0 == "_encstr_A9B710B6B1767D675ACADDFAC60DC23776CA") {
      foreach(var_3 in level.objectives) {
        if(var_3.ownerteam != "_encstr_A7A408B9CA5D1D4E2C63")
          var_3 _encstr_ADAF29DBC862F0B9946332ADE38E07C908AF33A068896AD6176A58F1524FD68AC861A25BCB4AAD7E4F430E::showcapturedhardpointeffecttoplayer(var_3.ownerteam, self);
      }
    }
  }
}

getrespawndelay() {
  if(!level.delayplayer)
    return undefined;

  var_0 = level.zone.ownerteam;

  if(isDefined(var_0)) {
    if(self.pers["_encstr_8AEF05472BC2D6"] == var_0) {
      if(!level.spawndelay)
        return undefined;

      return level.spawndelay;
    }
  }
}

postshipmodifiedzones(var_0) {
  if(level.mapname == "_encstr_B2860A4A938957DBAB1DED3D" && var_0 == "_encstr_B84C027E")
    return 1;

  return 0;
}

writeplayerrotationscoretomatchdataongameend() {
  level waittill("_encstr_9B1D0BC7932875276230426AA1");
  writecurrentrotationteamscore();
}

writecurrentrotationteamscore() {
  if(level.kothhillrotation < 24) {
    setmatchdata("_encstr_BE7D1176A0484172A6BDAFDFDDC5D983A88BEF", level.kothhillrotation, getteamscore("_encstr_9A8507BA4040188D08"));
    setmatchdata("_encstr_A56F0FEBCBBA96A1576388C18203104ED2", level.kothhillrotation, getteamscore("_encstr_8E8405EA382B2A"));
  }
}

setkothwaypoints() {
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_8B850D2A78191331CF61ABB8566F78", 0, "_encstr_88BF06FD784A6393", "_encstr_966420E58F4E870D179958D081EFF56B66A87F622A16E7866109C15949F7FE17FF7E", "_encstr_87A213BF1BF04ED1C79F6822F083BA1C9ED82F73F0", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_BE470C3BF8C3EB918910527A50D1", 0, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_ACB71FA04759DCD6891D9554091C3EFCE1D6B7E6FA7184F94D086C08079BEF0FCA", "_encstr_87A213BF1BF04ED1C79F6822F083BA1C9ED82F73F0", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_AD1F0F6DBD8E43BE3295CCCA374696E6D9", 0, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_BA37220373A9AB257CAED1AD0FD7A198E9AA287DD30ED890A9571D39C965C1416F23B19F", "_encstr_87A213BF1BF04ED1C79F6822F083BA1C9ED82F73F0", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_96730D2FF80BE0794D25C3BB967B02", 0, "_encstr_A7A408B9CA5D1D4E2C63", "_encstr_966420E58F4E870D179958D081EFF56B66A87F622A16E7866109C15949F7FE17FF7E", "_encstr_87A213BF1BF04ED1C79F6822F083BA1C9ED82F73F0", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_AF500F6D7B470DBEC6BD734756373A568C", 0, "_encstr_93B508770F528D90B3DB", "_encstr_A6A8224D5B417F4860B718FF8987ED7169EF9D3BDA115FA75019451399C7E187BDAFE1C6", "_encstr_87A213BF1BF04ED1C79F6822F083BA1C9ED82F73F0", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_A3F50C0892B36BA14D3FAF9356F7", 0, "_encstr_88BF06FD784A6393", "_encstr_8D341FA982AF25E48E28A6A2AFE972312BCB3D2449EB31F44DA4E48EF50DA014A9", "_encstr_87A213BF1BF04ED1C79F6822F083BA1C9ED82F73F0", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_96DC0C5BED8ED0BEA358C9B35947", 0, "_encstr_A7A408B9CA5D1D4E2C63", "_encstr_A3671F95FF3EF75D47C968E0513F05BB56F82F121AC64B5655E190E969FF0E034F", "_encstr_88EC152D6CBDDCAF77B09738BDB4DCE8BEB1BDD8B5B219", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_8D0B0C6DBDD10DEB47C2B5B4739D", 0, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_83AA23C9FF07B85E797F958FA9217159FE754FED41714CF80F118DE09F44DDAF193D26211F", "_encstr_87A213BF1BF04ED1C79F6822F083BA1C9ED82F73F0", 1);
}

updatematchstatushintonspawn() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(istrue(level._id_14726))
    self setclientomnvar("_encstr_9B061AD54B7D5B0B3AC61A7DE6D1C247ABDC7DA1B4DC1DD78ECA87E8", 36);
  else
    self setclientomnvar("_encstr_9B061AD54B7D5B0B3AC61A7DE6D1C247ABDC7DA1B4DC1DD78ECA87E8", 35);
}