/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\dm.gsc
***********************************************/

main() {
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  var_0[0] = scripts\mp\utility\game::getgametype();
  scripts\mp\gameobjects::main(var_0);

  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread scripts\mp\utility\game::reinitializematchrulesonmigration();
  } else {
    scripts\mp\utility\game::registertimelimitdvar(scripts\mp\utility\game::getgametype(), 600);
    scripts\mp\utility\game::registerscorelimitdvar(scripts\mp\utility\game::getgametype(), 30);
    scripts\mp\utility\game::registerwinlimitdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registerroundlimitdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registernumlivesdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
  }

  updategametypedvars();
  level.onstartgametype = ::onstartgametype;
  level.onplayerconnect = ::onplayerconnect;
  level.getspawnpoint = ::getspawnpoint;
  level.modeonspawnplayer = ::onspawnplayer;
  level.onnormaldeath = ::onnormaldeath;
  level.onplayerscore = ::onplayerscore;
  level.didhalfscorevoboost = 0;
  setteammode("_encstr_AC18045DF6D6");

  if(istrue(level.aonrules)) {
    _encstr_97EA20CDB1E44B1C3AB95EB583F2D9B05B95A3F2E056B9CBD8BDB66BF673B8D9CDB1::bearsred();
    level.bypassclasschoicefunc = ::alwaysgamemodeclass;
    setomnvarforallclients("_encstr_8E8510ABB0472A5FC0DFBFB478E92B754B30", 1);
    setspecialloadout();
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_97100D4F07523528E98A314EF6D7B0";
  } else
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_99100DB316B556D1BCC12B7D99CC2C";

  if(getdvarint("_encstr_B2020AE1F36BF74429D93F01"))
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_8A19042AB017" + game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"];
  else if(getdvarint("_encstr_82570B397A4D3192935192A562"))
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_979708CC69F02253FF26" + game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"];

  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_88430F5DF6D671B1176AF98602FF76D82B"] = "_encstr_8DF50F803FD51957EBFEA5255942B34104";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_879810B5E36AD0E0EDD619767AD5A0703273"] = "_encstr_82DC11CCC9E0BDD644A7F18310B7917818B30D";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8D3F0F0CA72A87B855AF23E1C360D015A2"] = "_encstr_835A10790E672AAF8332835F9195A3D7A3C8";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AD8D0EAEEA5861DC2DCFAAC1A1430294"] = "_encstr_86F40FD9C2D656DC4758E8CAEB8DC2E63A";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_95240C659372588E43623137DE6C"] = "_encstr_AF980D1B11DA0C576B5A50400312B8";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_93420C4255FBEA5D408FD1FD2A62"] = "_encstr_AC4509137CC2C9F67E8B0B";
}

alwaysgamemodeclass() {
  return "_encstr_AAAC09D09972B9C83F2B7F";
}

initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata(1);
  setdynamicdvar("_encstr_AA5E10E33EC3F79F5B81629A10BD13F3999E", getmatchrulesdata("_encstr_976F0723AD110B3AB0", "_encstr_BDF4096A9048CBDBE85BEB"));
  setdynamicdvar("_encstr_8DF01B2037CA5E797A71262655A3B3800E8348A0BF75730912E61B3DEA", getmatchrulesdata("_encstr_976F0723AD110B3AB0", "_encstr_8A7F145890DAAD877F9879DB4D8F5D4BAA8B968F32E6"));
  setdynamicdvar("_encstr_B8FD1990877AEEC92A21D55742A20333C0139848E71221CB121545", getmatchrulesdata("_encstr_976F0723AD110B3AB0", "_encstr_958112D185E4ECCAD128D8C297CAC986CB36B1CA"));
  setdynamicdvar("_encstr_8ADC169B8D39EBC8B6F5DC0DB7EED1C29376AC3AE8B46B95", getmatchrulesdata("_encstr_976F0723AD110B3AB0", "_encstr_8B1E0F836442D3DFB0DB9F50C3F98335B9"));
  setdynamicdvar("_encstr_ADAB108703C2A165E7B9AB10D29BAB785C8C", 1);
  scripts\mp\utility\game::registerwinlimitdvar("_encstr_9707038CB6", 1);
  setdynamicdvar("_encstr_A23D12CEAE53CFE1051FC8289F2EB9F18A554BD5", 1);
  scripts\mp\utility\game::registerroundlimitdvar("_encstr_9707038CB6", 1);
  setdynamicdvar("_encstr_BE37106E1B27AF23ADD7341663668E2DDA2B", 0);
  scripts\mp\utility\game::registerhalftimedvar("_encstr_9707038CB6", 0);
}

onstartgametype() {
  setclientnamemode("_encstr_B6900C7BCDABC8AF2722B158FA17");

  foreach(var_1 in level.teamnamelist) {
    scripts\mp\utility\game::setobjectivetext(var_1, &"_encstr_8B3F0E27AD52BB87E1731E6F917E1C80");

    if(level.splitscreen)
      scripts\mp\utility\game::setobjectivescoretext(var_1, &"_encstr_8B3F0E27AD52BB87E1731E6F917E1C80");
    else
      scripts\mp\utility\game::setobjectivescoretext(var_1, &"_encstr_8DE9146F1A5030357961F45DAF3727203969A6B4F14F");

    scripts\mp\utility\game::setobjectivehinttext(var_1, &"_encstr_95BF13F448528A348A2565A86AF2449AF5844A278A");
  }

  scripts\mp\spawnlogic::setactivespawnlogic("_encstr_838B0B942AE27B65C76B91F03B", "_encstr_829A0D0F1AF8FB5ED127855073F940");
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::addstartspawnpoints("_encstr_858C12AF1A37B997E9607371037AA963717F2D9B", 1);
  scripts\mp\spawnlogic::addspawnpoints("_encstr_9A8507BA4040188D08", "_encstr_8A550CA8037FCD9021830923AF55");
  scripts\mp\spawnlogic::addspawnpoints("_encstr_9A8507BA4040188D08", "_encstr_BA891631A8D8EDA759B36AC36B3A1F3E62C34FBB35138B50", 1, 1);
  scripts\mp\spawnlogic::addspawnpoints("_encstr_8E8405EA382B2A", "_encstr_8A550CA8037FCD9021830923AF55");
  scripts\mp\spawnlogic::addspawnpoints("_encstr_8E8405EA382B2A", "_encstr_BA891631A8D8EDA759B36AC36B3A1F3E62C34FBB35138B50", 1, 1);
  var_3 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_8A550CA8037FCD9021830923AF55");
  var_4 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_BA891631A8D8EDA759B36AC36B3A1F3E62C34FBB35138B50");
  scripts\mp\spawnlogic::registerspawnset("_encstr_9707038CB6", var_3);
  scripts\mp\spawnlogic::registerspawnset("_encstr_ADF50C28BF57C9C33AEDDE570662", var_4);
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
  level.quickmessagetoall = 1;
}

updategametypedvars() {
  _encstr_97EA20CDB1E44B1C3AB95EB583F2D9B05B95A3F2E056B9CBD8BDB66BF673B8D9CDB1::updatecommongametypedvars();
  level.aonrules = scripts\mp\utility\dvars::dvarintvalue("_encstr_BDF4096A9048CBDBE85BEB", 0, 0, 4);
  level.scoreontargetplayer = scripts\mp\utility\dvars::dvarintvalue("_encstr_8A7F145890DAAD877F9879DB4D8F5D4BAA8B968F32E6", 0, 0, 1);
  level.targetplayercycle = scripts\mp\utility\dvars::dvarintvalue("_encstr_958112D185E4ECCAD128D8C297CAC986CB36B1CA", 0, 0, 1);
  level.showtargettime = scripts\mp\utility\dvars::dvarintvalue("_encstr_8B1E0F836442D3DFB0DB9F50C3F98335B9", 1, 0, 6);

  switch (level.showtargettime) {
    case 0:
      level.objpingdelay = 60.0;
      break;
    case 1:
      level.objpingdelay = 0.05;
      break;
    case 2:
      level.objpingdelay = 1.0;
      break;
    case 3:
      level.objpingdelay = 1.5;
      break;
    case 4:
      level.objpingdelay = 2.0;
      break;
    case 5:
      level.objpingdelay = 3.0;
      break;
    case 6:
      level.objpingdelay = 4.0;
      break;
  }

  if(level.aonrules > 0)
    level.blockweapondrops = 1;
  else
    level notify("_encstr_A6DA132A3128AF7F488F542F8B7083FFC78B6242DB");
}

getspawnpoint() {
  var_0 = undefined;

  if(level.ingraceperiod) {
    var_1 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_858C12AF1A37B997E9607371037AA963717F2D9B");

    if(!isDefined(level.requiresminstartspawns)) {}

    if(var_1.size > 0)
      var_0 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var_1, 1);

    if(!isDefined(var_0)) {
      var_1 = scripts\mp\spawnlogic::getteamspawnpoints(self.team);
      var_0 = scripts\mp\spawnscoring::getstartspawnpoint_freeforall(var_1);
    }
  } else
    var_0 = scripts\mp\spawnlogic::getspawnpoint(self, "_encstr_8BBA05185F8B99", "_encstr_9707038CB6", "_encstr_ADF50C28BF57C9C33AEDDE570662");

  return var_0;
}

onspawnplayer() {
  self setclientomnvar("_encstr_9B061AD54B7D5B0B3AC61A7DE6D1C247ABDC7DA1B4DC1DD78ECA87E8", 0);

  if(level.aonrules > 0)
    thread onspawnfinished();

  if(level.scoreontargetplayer) {
    if(!isDefined(self.targetvictim)) {
      thread gettarget();
      thread newtargetmessage();
    }
  }

  level notify("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
}

onnormaldeath(var_0, var_1, var_2, var_3, var_4, var_5) {
  _encstr_97EA20CDB1E44B1C3AB95EB583F2D9B05B95A3F2E056B9CBD8BDB66BF673B8D9CDB1::oncommonnormaldeath(var_0, var_1, var_2, var_3, var_4, var_5);

  if(level.aonrules > 0) {}

  var_6 = 0;

  foreach(var_8 in level.players) {
    if(isDefined(var_8.score) && var_8.score > var_6)
      var_6 = var_8.score;
  }

  if(!level.didhalfscorevoboost) {
    if(var_1.score >= int(level.scorelimit * level.currentround - level.scorelimit / 2))
      thread dohalftimevo(var_1);
  }

  if(var_1.score == level.scorelimit - 2)
    level.kick_afk_check = 1;

  var_10 = var_1 scripts\mp\utility\stats::getpersstat("_encstr_8B560B62B16B5067FCFAB88833");

  if(isDefined(var_10))
    var_1 scripts\mp\utility\stats::setextrascore1(var_10);
}

onplayerscore(var_0, var_1, var_2, var_3) {
  var_1 scripts\mp\utility\stats::incpersstat("_encstr_A7E80EB868982F22383F6F4FD680F85D", var_2);
  var_4 = int(var_1 scripts\mp\utility\stats::getpersstat("_encstr_A7E80EB868982F22383F6F4FD680F85D"));
  var_1 scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_A7E80EB868982F22383F6F4FD680F85D", var_4);

  if(var_1.pers["_encstr_84C910D248050977F8F9A49F0E236BCF4B20"] > var_1 scripts\mp\utility\stats::getpersstat("_encstr_8B560B62B16B5067FCFAB88833")) {
    var_1.pers["_encstr_8B560B62B16B5067FCFAB88833"] = var_1.pers["_encstr_84C910D248050977F8F9A49F0E236BCF4B20"];
    var_1 scripts\mp\utility\stats::setextrascore1(var_1.pers["_encstr_84C910D248050977F8F9A49F0E236BCF4B20"]);
  }

  if(issubstr(var_0, "_encstr_81F407AF432AED63D1"))
    return 0;

  if(issubstr(var_0, "_encstr_921208BB831008111EA3"))
    return 0;

  if(issubstr(var_0, "_encstr_ABD70578F3D02C")) {
    if(level.scoreontargetplayer) {
      if(var_3 != var_1.targetvictim)
        return 0;
      else {
        var_1 notify("_encstr_A576126429C587C5315945A163B0527D37B16719");
        var_1.targetvictim = undefined;
        var_1 thread gettarget();
        var_1 thread newtargetmessage();
      }
    }

    var_5 = scripts\mp\rank::getscoreinfovalue("_encstr_A68210DFBFAF8BEFB7C7E03172C73B106349");
    return var_5;
  } else if(var_0 == "_encstr_91A70B13A312807E13497961B2")
    var_1 scripts\mp\utility\script::bufferednotify("_encstr_AD7116B258277356C8BECDB17BE459AF26D566999593B232", var_2);

  return 0;
}

dohalftimevo(var_0) {
  var_0 scripts\mp\utility\dialog::leaderdialogonplayer("_encstr_88430F5DF6D671B1176AF98602FF76D82B");
  var_1 = scripts\engine\utility::array_sort_with_func(level.players, ::compare_player_score);

  if(isDefined(var_1[1]))
    var_1[1] scripts\mp\utility\dialog::leaderdialogonplayer("_encstr_879810B5E36AD0E0EDD619767AD5A0703273");

  if(isDefined(var_1[2]) && var_1.size > 2)
    var_1[2] scripts\mp\utility\dialog::leaderdialogonplayer("_encstr_8D3F0F0CA72A87B855AF23E1C360D015A2");

  if(isDefined(var_1[var_1.size - 1]) && var_1.size > 3)
    var_1[var_1.size - 1] scripts\mp\utility\dialog::leaderdialogonplayer("_encstr_AD8D0EAEEA5861DC2DCFAAC1A1430294");

  level.didhalfscorevoboost = 1;
}

compare_player_score(var_0, var_1) {
  return var_0.score >= var_1.score;
}

onspawnfinished() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self setclientomnvar("_encstr_8E8510ABB0472A5FC0DFBFB478E92B754B30", 1);
  self waittill("_encstr_B2030CA0C91D2F44C0B314F8836B");
  runaonrules();
}

setspecialloadout() {
  if(scripts\mp\utility\game::matchmakinggame()) {
    var_0 = scripts\engine\utility::ter_op(randomintrange(0, 99) > 50, "_encstr_9B031467F4EAE7ADE56E91CFF3656002AE6B3129F5AB", "_encstr_87610AB4EE83FAD6374B3395");

    if(var_0 == "_encstr_87610AB4EE83FAD6374B3395")
      var_1 = 11;
    else
      var_1 = 0;

    if(getdvarint("_encstr_A3F9169F3BE2AF7058018E3A0B5BEA30EEE7099755304F65", 1) == 1) {
      var_2 = randomintrange(0, 99);

      if(var_2 > 75) {
        var_0 = "_encstr_B6BD13609368A9E10A1FABA7DF52BEE0CAAD6B18FB";
        var_1 = 2;
      }
    }
  } else {
    switch (level.aonrules) {
      case 1:
        var_0 = "_encstr_87610AB4EE83FAD6374B3395";
        var_1 = 11;
        break;
      case 2:
        var_0 = "_encstr_9B031467F4EAE7ADE56E91CFF3656002AE6B3129F5AB";
        var_1 = 0;
        break;
      case 3:
        var_0 = "_encstr_B6BD13609368A9E10A1FABA7DF52BEE0CAAD6B18FB";
        var_1 = 2;
        break;
      default:
        var_0 = "_encstr_87610AB4EE83FAD6374B3395";
        var_1 = 11;
        break;
    }
  }

  level.aon_loadouts["_encstr_9A8507BA4040188D08"]["_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243"] = var_0;
  level.aon_loadouts["_encstr_9A8507BA4040188D08"]["_encstr_9643193A25FBB9209BBB027A21C5C9FE9A07A8F86730C0DB505878"] = "_encstr_8BBA05185F8B99";
  level.aon_loadouts["_encstr_9A8507BA4040188D08"]["_encstr_A1651A992F661880E76B2F5382BF4F60B8992151C94EC0D9CFA2A353"] = "_encstr_8BBA05185F8B99";
  level.aon_loadouts["_encstr_9A8507BA4040188D08"]["_encstr_856C13D8BD0B19DEEAA3A027B46BC227BC0D2C6BED"] = "_encstr_8BBA05185F8B99";
  level.aon_loadouts["_encstr_9A8507BA4040188D08"]["_encstr_AA0216B867B9590F9BDB978EF4725BC3F93B48F0E75390C3"] = "_encstr_8BBA05185F8B99";
  level.aon_loadouts["_encstr_9A8507BA4040188D08"]["_encstr_935A1863DB1619ED5DA3284E2D5B85E4E52BB0935A5873E89222"] = var_1;
  level.aon_loadouts["_encstr_9A8507BA4040188D08"]["_encstr_914E11521FAFF595BD93F9EF781F36EA0B708B"] = "_encstr_8BE20ED75722A6731BF84F3064CA126B";
  level.aon_loadouts["_encstr_9A8507BA4040188D08"]["_encstr_A96F1B782D99D84853DBB7D3AFDA376031C2425593D4B8765A47C3FDEB"] = "_encstr_8BBA05185F8B99";
  level.aon_loadouts["_encstr_9A8507BA4040188D08"]["_encstr_B8DB1C1C17A137958B719F02564FF061B64E77B134A3D1DF58BF9BC633C7"] = "_encstr_8BBA05185F8B99";
  level.aon_loadouts["_encstr_9A8507BA4040188D08"]["_encstr_8CEA1501B78EF0781F83D7199A1FA0A8260293D7217560"] = "_encstr_8BBA05185F8B99";
  level.aon_loadouts["_encstr_9A8507BA4040188D08"]["_encstr_83B6181AA01BCF6F63FD93DD1E48239743E0F37168D94487786D"] = "_encstr_8BBA05185F8B99";
  level.aon_loadouts["_encstr_9A8507BA4040188D08"]["_encstr_88531A48DA76F9D8EF34EEFD3BDFA0B1DEB36801D24A3BD1AB5C9B75"] = 1;
  level.aon_loadouts["_encstr_9A8507BA4040188D08"]["_encstr_93A4182DD83854DA9DC90FD7E34BF385F0CDA3BAD3C0157276CB"] = "_encstr_952115DD01A75899A9C3C8936A7B6370578752C0618381";
  level.aon_loadouts["_encstr_9A8507BA4040188D08"]["_encstr_8B781A89822F040F6B83E54BC8CA9378059D855728CF2D2DBF69104B"] = "_encstr_8BBA05185F8B99";
  level.aon_loadouts["_encstr_9A8507BA4040188D08"]["_encstr_85920D9D304BCAFF3B38EF7F3011BA"] = "_encstr_8BBA05185F8B99";
  level.aon_loadouts["_encstr_9A8507BA4040188D08"]["_encstr_AD1B1288DD6928B843CB87C1FB6AF70834307321"] = "_encstr_AB3508737F830710ACDB";
  level.aon_loadouts["_encstr_9A8507BA4040188D08"]["_encstr_8EE713601A6FD59883AC471BACAD30A55BD2590847"] = "_encstr_8BBA05185F8B99";
  level.aon_loadouts["_encstr_9A8507BA4040188D08"]["_encstr_91E71336EDC291F6AE8E5A5AD88DB91DE456B05B8C"] = "_encstr_8BBA05185F8B99";
  level.aon_loadouts["_encstr_9A8507BA4040188D08"]["_encstr_ACE713DD22D19AE80D98115804EB13E1D2D58F27C7"] = "_encstr_8BBA05185F8B99";
  level.aon_loadouts["_encstr_9A8507BA4040188D08"]["_encstr_BD7517A417C0D76F6D53B1DBD8C897C2A0FB2339A310DC5795"] = 1;
  level.aon_loadouts["_encstr_9A8507BA4040188D08"]["_encstr_86CB0DFB97F7022F90BB3A7F53487B"] = ["_encstr_963D111F88AFE85B6F2253FA39630D3083FC4B", "_encstr_B60B139B8B686E2A10B149A887D9E7EB894AC4E00F"];
  level.aon_loadouts["_encstr_9A8507BA4040188D08"]["_encstr_97EA12B1B7C223DBBA3A8AE1A327582859C95BE6"] = ["_encstr_8882193783958D5A0BC64797D7CD362C6795379D56C9BEC1B1BAE6", "_encstr_A98E15C8705AAAC417D19C23490BD537C957A61343BFAB", "_encstr_8B8117CD07B21B5A5863D12FAF37AE9CD9594B1B8DB0E66C95"];
  level.aon_loadouts["_encstr_9A8507BA4040188D08"]["_encstr_B4450F51E53FE10F4B0C1791B7ABED8085"] = "_encstr_A63C0B33252188F56B439B89EF";
  level.aon_loadouts["_encstr_9A8507BA4040188D08"]["_encstr_91C8151BEDB08C7BAEE891B4B28D91550E9DC9588CAC62"] = "_encstr_A66C12DE3B63AB1307C36048AB4308C15A655E6D";
  level.aon_loadouts["_encstr_9A8507BA4040188D08"]["_encstr_ACC815D8F62C23F6BAD19196598DC8AA387693C2C8598C"] = "_encstr_8BBA05185F8B99";
  level.aon_loadouts["_encstr_8E8405EA382B2A"] = level.aon_loadouts["_encstr_9A8507BA4040188D08"];
}

runaonrules() {
  giveextraaonperks();
  var_0 = getcompleteweaponname("_encstr_AFBB115ADD1CD75BDCA5CC56DC1D2CC4D7DAC1");
  self giveweapon(var_0);
  self assignweaponmeleeslot(var_0);
}

giveextraaonperks() {
  var_0 = ["_encstr_9A86139BA008488198DBDB8B56EE5901CD4B57F0A7", "_encstr_916914E63856D85AB08DE85EF53B1C6E9A16ADDA5693", "_encstr_8F6D15E6C1CA1BD22CB1D1E57DCCC2368D1985B616D959", "_encstr_884116A03B678768CF3C6DE337BF704B0AA349F0223E1363", "_encstr_AB6D127F07796F1BA8D24DDF5FB80B504DC2B392"];

  foreach(var_2 in var_0)
  scripts\mp\utility\perk::giveperk(var_2);
}

onplayerconnect(var_0) {
  if(level.aonrules > 0) {
    if(level.allowkillstreaks) {}

    var_0.pers["_encstr_959506B911C79707"] = "_encstr_AAAC09D09972B9C83F2B7F";
    var_0.pers["_encstr_92690A5B078ED325F539E25E"] = "_encstr_B40101";
    var_0.class = var_0.pers["_encstr_959506B911C79707"];
    var_0.lastclass = var_0.pers["_encstr_92690A5B078ED325F539E25E"];
    var_0.pers["_encstr_8CFB10507A35BBD8C7E435A9F72721679B93"] = level.aon_loadouts["_encstr_9A8507BA4040188D08"];
    var_0 loadweaponsforplayer(["_encstr_B8B311C42CC8F74278DFF7F29998FA43110A4B", "_encstr_BED80D7C9C59D95BF870DBDFA9F018"], 1);
  }
}

gettarget() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_8F990B97FDB9A12C71F0F7E7D8");
  self endon("_encstr_8F990B97FDB9A12C71F0F7E7D8");

  if(!scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B"))
    level waittill("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");

  var_0 = 0;

  if(!isDefined(self.targetarray) || !level.targetplayercycle) {
    self.targetarray = [];
    self.targetindex = 0;
    var_0 = 1;

    foreach(var_2 in level.players) {
      if(var_2 == self)
        continue;
      else
        self.targetarray[self.targetarray.size] = var_2;
    }
  }

  if(self.targetarray.size > 0) {
    if(!level.targetplayercycle)
      self.targetindex = randomint(self.targetarray.size);
    else {
      if(!var_0)
        self.targetindex++;

      if(self.targetindex == self.targetarray.size)
        self.targetindex = 0;
    }
  }

  self.targetvictim = self.targetarray[self.targetindex];

  if(!isDefined(self.targetvictim)) {
    waitframe();
    thread gettarget();
    thread newtargetmessage();
    return;
  }

  waitframe();

  if(level.showtargettime != 0) {
    self.curorigin = self.origin;
    self.offset3d = (0, 0, 10);
    scripts\mp\gameobjects::requestid(1, 1);
    var_4 = self.objidnum;
    objective_setlabel(var_4, "_encstr_A3671F95FF3EF75D47C968E0513F05BB56F82F121AC64B5655E190E969FF0E034F");
    objective_setzoffset(var_4, 90);
    objective_icon(var_4, "_encstr_AC5C1D236B4D89116880FD89DB40324295F19F6B57EF02D15029F28151687A");
    objective_setplayintro(var_4, 1);
    scripts\mp\objidpoolmanager::objective_playermask_single(var_4, self);
    objective_setbackground(var_4, 2);
    objective_position(var_4, self.curorigin);
    objective_state(var_4, "_encstr_AF5A081BBAC993AC73A3");
    scripts\mp\objidpoolmanager::update_objective_onentity(var_4, self.targetvictim);
    objective_setownerclient(var_4, self.targetvictim);

    if(level.showtargettime > 1)
      thread updatetargetlocation();
  }

  thread targetvictimdeathwatcher();
}

targetvictimdeathwatcher() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self waittill("_encstr_A576126429C587C5315945A163B0527D37B16719");
  thread scripts\mp\hud_message::showsplash("_encstr_A576126429C587C5315945A163B0527D37B16719", scripts\mp\rank::getscoreinfovalue("_encstr_ABD70578F3D02C"));
  objective_state(self.objidnum, "_encstr_8267056410C669");
  scripts\mp\gameobjects::releaseid();
}

updatetargetlocation() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.targetvictim endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_A576126429C587C5315945A163B0527D37B16719");
  thread updatetargetcurorigin();
  objective_setpings(self.objidnum, 1);

  if(!isDefined(level.objpingdelay))
    level.objpingdelay = 3.0;

  for(;;) {
    if(isDefined(self.targetvictim)) {
      scripts\mp\objidpoolmanager::update_objective_position(self.objidnum, self.curorigin + self.offset3d);
      objective_ping(self.objidnum);
      wait(level.objpingdelay);
      continue;
    }

    waitframe();
  }
}

updatetargetcurorigin() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.targetvictim endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_A576126429C587C5315945A163B0527D37B16719");

  for(;;) {
    if(isDefined(self.targetvictim))
      self.curorigin = self.targetvictim.origin + (0, 0, 90);

    waitframe();
  }
}

newtargetmessage() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_88CC103B70810C218BFC23CC091B4668BB96");
  self endon("_encstr_88CC103B70810C218BFC23CC091B4668BB96");

  if(!scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B"))
    level waittill("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");

  wait 2.5;

  if(isDefined(self.targetvictim))
    self iprintlnbold(&"_encstr_B6451167FFFF3131E863558BD79B2E66077FC5", self.targetvictim.name);
}