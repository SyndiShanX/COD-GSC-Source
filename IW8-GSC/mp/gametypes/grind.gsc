/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\grind.gsc
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
    scripts\mp\utility\game::registerroundswitchdvar(scripts\mp\utility\game::getgametype(), 0, 0, 9);
    scripts\mp\utility\game::registertimelimitdvar(scripts\mp\utility\game::getgametype(), 600);
    scripts\mp\utility\game::registerscorelimitdvar(scripts\mp\utility\game::getgametype(), 85);
    scripts\mp\utility\game::registerroundlimitdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registerwinlimitdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registernumlivesdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
  }

  updategametypedvars();
  level.dogtagsplayer = [];
  _encstr_81A5277BCF9854D32D73D6FA3BA8D70E08BBF4E941981A665849BAC1A15E2705982D9776F32AA76F76::init();
  level.teambased = 1;
  level.onstartgametype = ::onstartgametype;
  level.onplayerconnect = ::onplayerconnect;
  level.getspawnpoint = ::getspawnpoint;
  level.onnormaldeath = ::onnormaldeath;
  level.modeonspawnplayer = ::onspawnplayer;
  level.modeonsuicidedeath = ::onsuicidedeath;
  level.conf_fx["_encstr_8BE007AB0FE8607F9B"] = loadfx("_encstr_AB531FCE99C3CB1BDEE456F25AB51CC26CE8CDBC9BDA2CC636F5CD73B777865AE8");
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_A3150F9AF7E842838BD3C55EB84B52402D";

  if(getdvarint("_encstr_B2020AE1F36BF74429D93F01"))
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_8A19042AB017" + game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"];
  else if(getdvarint("_encstr_82570B397A4D3192935192A562"))
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_979708CC69F02253FF26" + game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"];

  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_91B2067E0898939B"] = "_encstr_852F0CEA4F8F7B0B0F204EA7DD43";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_95240C659372588E43623137DE6C"] = "_encstr_852F0CEA4F8F7B0B0F204EA7DD43";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_93420C4255FBEA5D408FD1FD2A62"] = "_encstr_852F0CEA4F8F7B0B0F204EA7DD43";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_81250F97F590053A2F0AFA8AC6F4D5011B"] = "_encstr_81250F97F590053A2F0AFA8AC6F4D5011B";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AD250FCACB7B93E73F87C201B6E38361C1"] = "_encstr_AD250FCACB7B93E73F87C201B6E38361C1";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_BAFE109D394B9B19FA23B49B0B26C6CAD716"] = "_encstr_BAFE109D394B9B19FA23B49B0B26C6CAD716";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A9FE102F9284A8E5AF8AE8D3A223A9B8511A"] = "_encstr_A9FE102F9284A8E5AF8AE8D3A223A9B8511A";
}

initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("_encstr_8BC11313A7F0B1F756589AC266A62735E061B18533", getmatchrulesdata("_encstr_A7E00A979679B0FBF426751B", "_encstr_B6BD0901163E087DCAD7A3"));
  setdynamicdvar("_encstr_A3F5130B52ABF060CA39958967B62820A7D9C1539A", getmatchrulesdata("_encstr_A7E00A979679B0FBF426751B", "_encstr_BACF09DD798D48268F4351"));
  setdynamicdvar("_encstr_AC901A8F42F25161F82B23E79F7EC876DF33A19B1557CE37296B8A4A", getmatchrulesdata("_encstr_A7E00A979679B0FBF426751B", "_encstr_A65110FD59AD688EAF2393BB2B97DDA085B5"));
  setdynamicdvar("_encstr_91D41660A7C259EF1A17C8B709FDD3052B05242BA79AD5C7", getmatchrulesdata("_encstr_A7E00A979679B0FBF426751B", "_encstr_BA500C1E37553AD4B89B2723D011"));
  setdynamicdvar("_encstr_8BAE1AE6B19CFACEE4A5B98CBE8985E65B444B372C98D859A816ECCD", getmatchrulesdata("_encstr_A7E00A979679B0FBF426751B", "_encstr_9A3010888A05772D0FC3078EA447572B2F33"));
  setdynamicdvar("_encstr_B6AE1A07834221641B5A083141232FE05C3CBBBF29AE40BDAB726019", getmatchrulesdata("_encstr_A7E00A979679B0FBF426751B", "_encstr_8D30104C0B37AD44D26EB03136ACA2A5AD59"));
  setdynamicdvar("_encstr_8D0518DCD8C9FA9D9CB4B919BED62BCE582485E65B984B5B4B1D", getmatchrulesdata("_encstr_A7E00A979679B0FBF426751B", "_encstr_99630EBF20E17130DB28FC3D839BDA2C"));
  setdynamicdvar("_encstr_881A1A37B139AFB39396B991AFAD59CEC21216B9DA21F6DCABB9694D", getmatchrulesdata("_encstr_A7E00A979679B0FBF426751B", "_encstr_821210ADACECB009B09B6D21BDE65D6ED29A"));
  setdynamicdvar("_encstr_AF7E14B9B1C9EBCEC9B437237D31C2DC5B21DBCD57DC", getmatchrulesdata("_encstr_A7E00A979679B0FBF426751B", "_encstr_B6EB0E7209142F3EB865AB8A0FA8BB3F"));
  setdynamicdvar("_encstr_A253139F9776B92FD010AD37CE5871C2C4017F7F73", 0);
  scripts\mp\utility\game::registerhalftimedvar("_encstr_A7290676E4D2378C", 0);
  setdynamicdvar("_encstr_BD8F12026E05118FA3B84393F11B52DAE3F04F3F", 0);
}

onstartgametype() {
  setclientnamemode("_encstr_B6900C7BCDABC8AF2722B158FA17");

  if(!isDefined(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"]))
    game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"] = 0;

  scripts\mp\utility\game::setobjectivetext("_encstr_9A8507BA4040188D08", &"_encstr_A5660F7F6E627D337D2B17E9A21DD98F75");
  scripts\mp\utility\game::setobjectivetext("_encstr_8E8405EA382B2A", &"_encstr_A5660F7F6E627D337D2B17E9A21DD98F75");

  if(level.splitscreen) {
    scripts\mp\utility\game::setobjectivescoretext("_encstr_9A8507BA4040188D08", &"_encstr_A5660F7F6E627D337D2B17E9A21DD98F75");
    scripts\mp\utility\game::setobjectivescoretext("_encstr_8E8405EA382B2A", &"_encstr_A5660F7F6E627D337D2B17E9A21DD98F75");
  } else {
    scripts\mp\utility\game::setobjectivescoretext("_encstr_9A8507BA4040188D08", &"_encstr_8E0115EFFEFCF57FDDF961736767B9353A5927B7BFB66F");
    scripts\mp\utility\game::setobjectivescoretext("_encstr_8E8405EA382B2A", &"_encstr_8E0115EFFEFCF57FDDF961736767B9353A5927B7BFB66F");
  }

  scripts\mp\utility\game::setobjectivehinttext("_encstr_9A8507BA4040188D08", &"_encstr_9A1A147A4825518645A495A2A6BCD50A92BE09A49C8A");
  scripts\mp\utility\game::setobjectivehinttext("_encstr_8E8405EA382B2A", &"_encstr_9A1A147A4825518645A495A2A6BCD50A92BE09A49C8A");
  initspawns();
  createtags();
  level.dogtagallyonusecb = ::dogtagallyonusecb;
  setupwaypointicons();
  thread createzones();
  level thread removetagsongameended();
}

updategametypedvars() {
  _encstr_97EA20CDB1E44B1C3AB95EB583F2D9B05B95A3F2E056B9CBD8BDB66BF673B8D9CDB1::updatecommongametypedvars();
  level.banktime = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_B6BD0901163E087DCAD7A3", 2, 0, 10);
  level.bankrate = scripts\mp\utility\dvars::dvarintvalue("_encstr_BACF09DD798D48268F4351", 1, 1, 10);
  level.bankcapturetime = scripts\mp\utility\dvars::dvarintvalue("_encstr_A65110FD59AD688EAF2393BB2B97DDA085B5", 0, 0, 10);
  level.bankdisable = scripts\mp\utility\dvars::dvarintvalue("_encstr_BA500C1E37553AD4B89B2723D011", 1, 0, 1);
  level.bankdisabletags = scripts\mp\utility\dvars::dvarintvalue("_encstr_9A3010888A05772D0FC3078EA447572B2F33", 0, 0, 50);
  level.bankdisabletime = scripts\mp\utility\dvars::dvarintvalue("_encstr_8D30104C0B37AD44D26EB03136ACA2A5AD59", 0, 0, 120);
  level.megabanklimit = scripts\mp\utility\dvars::dvarintvalue("_encstr_99630EBF20E17130DB28FC3D839BDA2C", 5, 5, 15);
  level.megabankbonusks = scripts\mp\utility\dvars::dvarintvalue("_encstr_821210ADACECB009B09B6D21BDE65D6ED29A", 1, 0, 10);
  level.megabankbonus = scripts\mp\utility\dvars::dvarintvalue("_encstr_B6EB0E7209142F3EB865AB8A0FA8BB3F", 150, 0, 750);
  var_0 = scripts\mp\utility\dvars::getwatcheddvar("_encstr_B6FB0B93B87F020F183BE5E94D");

  if(var_0 == 0 && level.bankdisabletags == 0)
    level.bankdisable = 0;
  else if(level.bankdisabletags == 0 && var_0 > 0)
    level.bankdisabletags = int(var_0);
}

onspawnplayer() {
  self setclientomnvar("_encstr_9B061AD54B7D5B0B3AC61A7DE6D1C247ABDC7DA1B4DC1DD78ECA87E8", 34);

  if(isDefined(self.tagscarried))
    self setclientomnvar("_encstr_81730E57C86EEFAB43A08771957BB2A3", self.tagscarried);
}

onsuicidedeath(var_0) {
  self setclientomnvar("_encstr_81730E57C86EEFAB43A08771957BB2A3", 0);
  level thread droptags(var_0);
}

createtags() {
  level.dogtags = [];

  for(var_0 = 0; var_0 < 50; var_0++) {
    var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (0, 0, 0));

    if(istrue(level.setplayerselfrevivingextrainfo))
      var_1 setModel("_encstr_880B20D934AABBEB019398B1D357C1C902DF4E48CC936BB1E60FC018FF7C7867BF12");
    else
      var_1 setModel("_encstr_96DB156B2D8DD2E80B9CE5AF19F63B4758766ED7A5BB07");

    var_1 scriptmodelplayanim("_encstr_845B0F80326F10804A938B9F27535730E6");

    if(istrue(level.setplayerselfrevivingextrainfo)) {} else
      var_1 setscriptablepartstate("_encstr_A1430B84E48B6BF9D91BE83877", "_encstr_BECC055CF3811A", 0);

    var_1 setasgametypeobjective();
    var_2 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", (0, 0, 0), 0, 32, 32);
    var_2.targetname = "_encstr_AF980F150AAA1F2765EB36231FA2BB97C0";
    var_2 hide();
    var_3 = spawnStruct();
    var_3.type = "_encstr_8CC00AABB9599E984D2BD81D";
    var_3.curorigin = var_2.origin;
    var_3.entnum = var_2 getentitynumber();
    var_3.lastusedtime = 0;
    var_3.visuals = var_1;
    var_3.offset3d = (0, 0, 16);
    var_3.trigger = var_2;
    var_3.trigger enablelinkTo();
    var_3.triggertype = "_encstr_83650AB19BA26B100D3CE35A";
    var_3 scripts\mp\gameobjects::allowuse("_encstr_8BBA05185F8B99");
    level.dogtags[level.dogtags.size] = var_3;
  }
}

gettag() {
  var_0 = level.dogtags[0];
  var_1 = gettime();

  foreach(var_3 in level.dogtags) {
    if(!isDefined(var_3.lastusedtime)) {
      continue;
    }
    if(var_3.interactteam == "_encstr_8BBA05185F8B99") {
      var_0 = var_3;
      break;
    }

    if(var_3.lastusedtime < var_1) {
      var_1 = var_3.lastusedtime;
      var_0 = var_3;
    }
  }

  var_0 notify("_encstr_88F20627959BCAE8");
  var_0 scripts\mp\gameobjects::initializetagpathvariables();
  var_0.lastusedtime = gettime();
  return var_0;
}

spawntag(var_0) {
  var_1 = var_0.origin;
  var_2 = var_0.team;
  var_3 = var_1 + (0, 0, 14);
  var_4 = 35;
  var_5 = var_0 getstance();

  if(var_5 == "_encstr_922406F1A6FD5E05")
    var_4 = 14;

  if(var_5 == "_encstr_B13D076BED70539F23")
    var_4 = 25;

  var_6 = var_1 + (0, 0, var_4);
  var_7 = (0, randomfloat(360), 0);
  var_8 = anglesToForward(var_7);
  var_9 = randomfloatrange(30, 150);
  var_10 = 0.5;
  var_11 = var_3 + var_9 * var_8;
  var_12 = playerphysicstrace(var_3, var_11);
  var_13 = gettag();
  var_13.curorigin = var_6;
  var_13.trigger.origin = var_6;
  var_13.visuals.origin = var_6;
  var_13.team = var_0.team;
  var_13.visuals.team = var_13.team;
  var_13.interactteam = "_encstr_9A19040BCDBC";
  var_13.trigger show();
  var_13.trigger linkTo(var_13.visuals, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");

  if(istrue(level.setplayerselfrevivingextrainfo))
    playsoundatpos(var_3, "_encstr_BE091CA5C7BFB2618070979F58F9296B83C86BDE244F49B4AB80D35743B3");
  else
    playsoundatpos(var_3, "_encstr_999214B912F9C74B6943D01133B7A00B5271A5BEAD63");

  var_13 thread tagmoveTo(var_2, var_6, var_12, var_10);
  return var_13;
}

tagmoveTo(var_0, var_1, var_2, var_3) {
  scripts\mp\gameobjects::allowuse("_encstr_9A19040BCDBC");
  self.visuals thread showtoteam(self, scripts\mp\utility\game::getotherteam(var_0)[0]);
  self.visuals setasgametypeobjective();
  var_4 = getdvarint("_encstr_979A08F619C1EA8361C7");
  var_5 = distance(var_1, var_2);
  var_6 = var_2 - var_1;
  var_7 = 0.5 * var_4 * squared(var_3) * -1;
  var_8 = (var_6[0] / var_3, var_6[1] / var_3, (var_6[2] - var_7) / var_3);
  self.visuals movegravity(var_8, var_3);
  self.curorigin = var_2;
}

showtoteam(var_0, var_1) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_88F20627959BCAE8");

  if(istrue(level.setplayerselfrevivingextrainfo)) {
    return;
  }
  self setscriptablepartstate("_encstr_A1430B84E48B6BF9D91BE83877", "_encstr_BD1805CB69C063", 0);
  return;
}

monitortaguse(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8BE208E31FA8E1631D65");
  var_0 endon("_encstr_88F20627959BCAE8");

  for(;;) {
    var_0.trigger waittill("_encstr_8F5C086405E70FBA4B4A", var_1);

    if(!scripts\mp\utility\player::isreallyalive(var_1)) {
      continue;
    }
    if(var_1 scripts\mp\utility\player::isusingremote() || isDefined(var_1.spawningafterremotedeath)) {
      continue;
    }
    if(isDefined(var_1.classname) && var_1.classname == "_encstr_86440FCD8D9CD2833AFA3B2B34B4D81B56") {
      continue;
    }
    if(isagent(var_1) && isDefined(var_1.owner))
      var_1 = var_1.owner;

    if(istrue(level.setplayerselfrevivingextrainfo)) {
      if(isDefined(var_1) && var_1.team == var_0.team) {
        playFX(level.conf_fx["_encstr_8BE007AB0FE8607F9B"], var_0.trigger.origin);
        playFX(level.spawnoffsettacinsertmax["_encstr_8C930DA4C67A4BFBF8F7C0C00F0E13"], var_0.trigger.origin + (0, 0, 45));
      } else {
        playFX(level.conf_fx["_encstr_8BE007AB0FE8607F9B"], var_0.trigger.origin);
        playFX(level.spawnoffsettacinsertmax["_encstr_81930D73E6AE887E4AAF090F97A2C8"], var_0.trigger.origin + (0, 0, 45));
      }
    } else
      var_0.visuals setscriptablepartstate("_encstr_A1430B84E48B6BF9D91BE83877", "_encstr_BECC055CF3811A", 0);

    var_0.trigger hide();
    var_0.curorigin = (0, 0, 1000);
    var_0.trigger.origin = (0, 0, 1000);
    var_0.visuals.origin = (0, 0, 1000);
    var_0 scripts\mp\gameobjects::allowuse("_encstr_8BBA05185F8B99");
    var_1 playersettagcount(var_1.tagscarried + 1);
    var_1 thread scripts\mp\utility\points::giveunifiedpoints("_encstr_96590EE82CB3D71BDE36B1ACD88E598C");

    if(istrue(level.setplayerselfrevivingextrainfo))
      var_1 playSound("_encstr_9B4D1E7753C17A34209DA65FC0C39F32EB4F28389F5AE702DA9E22B3F0698C83");
    else
      var_1 playSound("_encstr_841616FD71694F532B68EA4133707F8798477871EF6013A3");

    if(isDefined(level.supportcranked) && level.supportcranked) {
      if(isDefined(var_1.cranked) && var_1.cranked)
        var_1 scripts\mp\cranked::setcrankedplayerbombtimer("_encstr_ABD70578F3D02C");
      else
        var_1 scripts\mp\cranked::oncranked(undefined, var_1);
    }

    break;
  }
}

onplayerconnect(var_0) {
  var_0.isscoring = 0;
  var_0 thread monitorjointeam();
}

playersettagcount(var_0) {
  self.tagscarried = var_0;
  self.game_extrainfo = var_0;

  if(var_0 > 999)
    var_0 = 999;

  self setclientomnvar("_encstr_81730E57C86EEFAB43A08771957BB2A3", var_0);
}

monitorjointeam() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  for(;;) {
    scripts\engine\utility::_id_143A5("_encstr_81170C244F9CBDE72C01BB99A298", "_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B");
    playersettagcount(0);
  }
}

hidehudelementongameend(var_0) {
  level waittill("_encstr_9B1D0BC7932875276230426AA1");

  if(isDefined(var_0))
    var_0.alpha = 0;
}

createzones() {
  var_0 = getEntArray("_encstr_827F0FE12BAF302029942F2F81CB80080B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_0) {
    var_3 = _encstr_81A5277BCF9854D32D73D6FA3BA8D70E08BBF4E941981A665849BAC1A15E2705982D9776F32AA76F76::setupobjective(var_2, 1, 1);
    var_3 thread runzonethink();
    level.objectives[var_3.objectivekey] = var_3;
  }

  if(level.mapname == "_encstr_86D70CE85A1768FD42CB95B7CB2A") {
    var_5 = spawnStruct();
    var_5.origin = (1416, 1368, 300);
    var_5.angles = (0, 0, 0);
    var_5.script_label = "_encstr_8B4C024C";
    var_3 = _encstr_81A5277BCF9854D32D73D6FA3BA8D70E08BBF4E941981A665849BAC1A15E2705982D9776F32AA76F76::setupobjective(var_5, 1, 1);
    var_3 thread runzonethink();
    level.objectives[var_3.objectivekey] = var_3;
  }

  if(!scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B"))
    level scripts\engine\utility::_id_143A5("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B", "_encstr_8F55118F8B711B6436974A09E1173783D313D9");

  foreach(var_3 in level.objectives) {
    var_7 = _encstr_81A5277BCF9854D32D73D6FA3BA8D70E08BBF4E941981A665849BAC1A15E2705982D9776F32AA76F76::getreservedobjid(var_3.objectivekey);
    var_3 scripts\mp\gameobjects::requestid(1, 1, var_7);
    var_3 scripts\mp\gameobjects::setvisibleteam("_encstr_9A19040BCDBC");
    var_3 _encstr_81A5277BCF9854D32D73D6FA3BA8D70E08BBF4E941981A665849BAC1A15E2705982D9776F32AA76F76::_id_1317D();
    var_3 _encstr_81A5277BCF9854D32D73D6FA3BA8D70E08BBF4E941981A665849BAC1A15E2705982D9776F32AA76F76::setneutral();
  }
}

isinzone(var_0, var_1) {
  if(scripts\mp\utility\player::isreallyalive(var_0) && var_0 istouching(var_1.trigger) && var_1.ownerteam == var_0.team)
    return 1;

  return 0;
}

runzonethink() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8C030DE6A3DE387DE839A5B3B3CA93" + self.objectivekey);

  for(;;) {
    self.trigger waittill("_encstr_8F5C086405E70FBA4B4A", var_0);

    if(self.disabled) {
      continue;
    }
    if(self.stalemate) {
      continue;
    }
    if(isagent(var_0)) {
      continue;
    }
    if(!isPlayer(var_0)) {
      continue;
    }
    if(var_0.isscoring) {
      continue;
    }
    var_0.isscoring = 1;
    level thread processscoring(var_0, self);
  }
}

removetagsongameended() {
  level waittill("_encstr_9B1D0BC7932875276230426AA1");

  foreach(var_1 in level.players) {
    if(!isDefined(var_1)) {
      continue;
    }
    if(!isDefined(var_1.tagscarried)) {
      continue;
    }
    var_1.tagscarried = 0;
  }
}

processscoring(var_0, var_1) {
  while(var_0.tagscarried && isinzone(var_0, var_1) && !var_1.stalemate && !var_1.disabled) {
    if(var_0.tagscarried >= level.megabanklimit) {
      var_0 playsoundtoplayer("_encstr_BD571C92C0FFE7F318184C7F2DE0AFAF3521EAAAD84FDFE3B671516A4C49", var_0);
      scoreamount(var_0, level.megabanklimit, var_1);
      var_2 = scripts\mp\rank::getscoreinfovalue("_encstr_AB9C0A23BA37083846F77543");
      var_2 = var_2 * level.megabanklimit;

      if(!var_0 scripts\mp\utility\perk::_hasperk("_encstr_96F4242EE80FF173FE6A107031140B684373352655C738D763625158EA2DF581871CBE15A947"))
        var_0 scripts\mp\killstreaks\killstreaks::givestreakpoints("_encstr_95EB0866891B23FB85B3", level.megabankbonusks);

      var_0 thread scripts\mp\utility\points::giveunifiedpoints("_encstr_8DF80AC238DF5677494F969B", undefined, var_2 + level.megabankbonus);
      var_0 scripts\mp\utility\stats::incpersstat("_encstr_99C60FE8B0ECB9A6ACEC1609B09B5B9519", 1);
    } else {
      var_0 playsoundtoplayer("_encstr_A9FB168922C9F77B599323E1C367903B0201F6073D224BE1", var_0);
      var_3 = level.bankrate;

      if(var_3 > var_0.tagscarried)
        var_3 = var_0.tagscarried;

      scoreamount(var_0, var_3, var_1);

      for(var_4 = 0; var_4 < var_3; var_4++)
        var_0 thread scripts\mp\utility\points::giveunifiedpoints("_encstr_AB9C0A23BA37083846F77543");
    }

    if(isDefined(level.supportcranked) && level.supportcranked && isDefined(var_0.cranked) && var_0.cranked)
      var_0 scripts\mp\cranked::setcrankedplayerbombtimer("_encstr_ABD70578F3D02C");

    wait(level.banktime);
  }

  var_1 _encstr_81A5277BCF9854D32D73D6FA3BA8D70E08BBF4E941981A665849BAC1A15E2705982D9776F32AA76F76::setneutralicons();
  var_0.isscoring = 0;
}

scoreamount(var_0, var_1, var_2) {
  var_0 playersettagcount(var_0.tagscarried - var_1);
  scripts\mp\gamescore::giveteamscoreforobjective(var_0.team, var_1, 0);
  var_0 scripts\mp\utility\stats::incpersstat("_encstr_820E0A2AE8981DBA528588DC", var_1);
  var_0 scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_820E0A2AE8981DBA528588DC", var_0.pers["_encstr_820E0A2AE8981DBA528588DC"]);
  var_0 scripts\mp\utility\stats::setextrascore0(var_0.pers["_encstr_820E0A2AE8981DBA528588DC"]);

  if(level.bankdisable) {
    var_2.tagsdeposited = var_2.tagsdeposited + var_1;

    if(var_2.tagsdeposited >= level.bankdisabletags) {
      var_2 scripts\mp\gameobjects::allowuse("_encstr_8BBA05185F8B99");
      var_2 thread _id_1439D();
      var_2.disabled = 1;
      var_2.scriptable setscriptablepartstate("_encstr_8F7905C4EDE23F", "_encstr_BA19049F4B2D");
      var_2.scriptable setscriptablepartstate("_encstr_8A0C06B1E08832D3", "_encstr_BA19049F4B2D");

      if(isDefined(var_2.objectivekey)) {
        foreach(var_4 in level.teamnamelist)
        scripts\mp\utility\dialog::statusdialog("_encstr_93B10F9063C16869698F3B3E2652B1F10F" + var_2.objectivekey, var_4);
      }

      if(level.bankdisabletime == 0) {
        return;
      }
      var_2 thread waitthenenablezone();
      return;
    }
  }
}

_id_1439D() {
  foreach(var_1 in level.players)
  scripts\mp\objidpoolmanager::objective_unpin_player(self.objidnum, var_1);

  waitframe();
  scripts\mp\gameobjects::setvisibleteam("_encstr_8BBA05185F8B99");
}

waitthenenablezone() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait(level.bankdisabletime);
  self.disabled = 0;
  self.scriptable setscriptablepartstate("_encstr_8F7905C4EDE23F", "_encstr_A7C5056BD931D1");
  scripts\mp\gameobjects::allowuse("_encstr_9A19040BCDBC");
  scripts\mp\gameobjects::setvisibleteam("_encstr_9A19040BCDBC");

  if(isDefined(self.objectivekey)) {
    foreach(var_1 in level.teamnamelist)
    scripts\mp\utility\dialog::statusdialog("_encstr_8BD10EC0DBA4DD89777520AF4A8391F7" + self.objectivekey, var_1);
  }
}

initspawns() {
  scripts\mp\spawnlogic::setactivespawnlogic("_encstr_8B1608CC43B8D647A113", "_encstr_A6E80F61DA270BDE09B2C8C33B40AB859D");
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::addstartspawnpoints("_encstr_A1C01A915857A3F96DC9D8C84283B59E07FCA91BA51F0E1F1332A8F0");
  scripts\mp\spawnlogic::addstartspawnpoints("_encstr_8AF71849707F8BC155E180A03AEB9DA6DF10C33EC76733137ABB");
  scripts\mp\spawnlogic::addspawnpoints(game["_encstr_991C0AB9ED5B57161FE89B83"], "_encstr_A1C01A915857A3F96DC9D8C84283B59E07FCA91BA51F0E1F1332A8F0");
  scripts\mp\spawnlogic::addspawnpoints(game["_encstr_B6A70A23CA6659DC91CAE4DC"], "_encstr_8AF71849707F8BC155E180A03AEB9DA6DF10C33EC76733137ABB");
  var_0 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_A1C01A915857A3F96DC9D8C84283B59E07FCA91BA51F0E1F1332A8F0");
  var_1 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_8AF71849707F8BC155E180A03AEB9DA6DF10C33EC76733137ABB");
  scripts\mp\spawnlogic::registerspawnset("_encstr_8203101FF33885AB060225CD31A68A4B6AD7", var_0);
  scripts\mp\spawnlogic::registerspawnset("_encstr_9AE3109755F34D5879256960F390C8FFD207", var_1);
  scripts\mp\spawnlogic::addspawnpoints("_encstr_9A8507BA4040188D08", "_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD");
  scripts\mp\spawnlogic::addspawnpoints("_encstr_8E8405EA382B2A", "_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD");
  scripts\mp\spawnlogic::addspawnpoints("_encstr_9A8507BA4040188D08", "_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", 1, 1);
  scripts\mp\spawnlogic::addspawnpoints("_encstr_8E8405EA382B2A", "_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", 1, 1);
  var_2 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD");
  var_3 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318");
  scripts\mp\spawnlogic::registerspawnset("_encstr_820E07FAE8780B3A4C", var_2);
  scripts\mp\spawnlogic::registerspawnset("_encstr_AD0C095DF195E8B6074A18", var_3);
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

getspawnpoint() {
  var_0 = self.pers["_encstr_8AEF05472BC2D6"];

  if(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"])
    var_0 = scripts\mp\utility\game::getotherteam(var_0)[0];

  if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    var_1 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_A1BD0E5B07D7E823D6D7371C58BB37F5" + var_0 + "_encstr_B4810709B378B9F3F5");
    var_2 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var_1);
  } else
    var_2 = scripts\mp\spawnlogic::getspawnpoint(self, var_0, "_encstr_820E07FAE8780B3A4C", "_encstr_AD0C095DF195E8B6074A18");

  return var_2;
}

onnormaldeath(var_0, var_1, var_2, var_3, var_4, var_5) {
  _encstr_97EA20CDB1E44B1C3AB95EB583F2D9B05B95A3F2E056B9CBD8BDB66BF673B8D9CDB1::oncommonnormaldeath(var_0, var_1, var_2, var_3, var_4, var_5);
  level thread droptags(var_0, var_1);
}

droptags(var_0, var_1) {
  if(isagent(var_0)) {
    return;
  }
  if(var_0.tagscarried > 49)
    var_2 = 49;
  else if(var_0.tagscarried > 0)
    var_2 = var_0.tagscarried + 1;
  else
    var_2 = 1;

  if(istrue(level.setplayerselfrevivingextrainfo) && !isDefined(level.player_current_primary_is_rpg)) {
    level.player_current_primary_is_rpg = 1;
    var_2 = 4;
  }

  for(var_3 = 0; var_3 < var_2; var_3++) {
    var_4 = spawntag(var_0);
    var_4.team = var_0.team;
    var_4.victim = var_0;
    var_4.attacker = var_1;
    level notify("_encstr_871E107D55071984D9C07FC790315FD28B7D", var_4);
    level thread monitortaguse(var_4);
  }

  var_5 = var_0.tagscarried - var_2;
  var_5 = int(max(0, var_5));
  var_0 playersettagcount(var_5);
}

dogtagallyonusecb(var_0) {
  if(isPlayer(var_0))
    var_0 scripts\mp\utility\stats::setextrascore1(var_0.pers["_encstr_B64E070F391562989D"]);
}

setupwaypointicons() {
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_8437100BF918A03A731D6BCF6D2F72E38141", 0, "_encstr_A7A408B9CA5D1D4E2C63", "_encstr_A6E81D1152FFD8FC0181D96F9759E50DA1F8496652AE42142447193F5F3899", "_encstr_95F514A22F95A85940918328F0C452FCA95B4D4979B1", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_B63710EE0BCB1CDEB43747D7C458CDADBEC4", 0, "_encstr_A7A408B9CA5D1D4E2C63", "_encstr_A6E81D1152FFD8FC0181D96F9759E50DA1F8496652AE42142447193F5F3899", "_encstr_BAF514A56CDB9BD7BBC22F07F62DCD8EEB46B7B6EB98", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_8ECF1723407BEFC751BD31885A3F88553B1887616DFF05882F", 2, "_encstr_88BF06FD784A6393", "_encstr_937320E9C3DF54E5743EC1FD81B8DDBC71A671E9C387AF376812CB70EFD18FC580FF", "_encstr_95F514A22F95A85940918328F0C452FCA95B4D4979B1", 1);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_82CF1748E2A81910A76635B853A7D8A514BA5081EA457B2E53", 2, "_encstr_88BF06FD784A6393", "_encstr_937320E9C3DF54E5743EC1FD81B8DDBC71A671E9C387AF376812CB70EFD18FC580FF", "_encstr_BAF514A56CDB9BD7BBC22F07F62DCD8EEB46B7B6EB98", 1);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_A17D1A50FAB011185F6E3DA06BAFC0DD1CB25889E20A7B116B8C50A7", 2, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_937320E9C3DF54E5743EC1FD81B8DDBC71A671E9C387AF376812CB70EFD18FC580FF", "_encstr_95F514A22F95A85940918328F0C452FCA95B4D4979B1", 1);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_8F7D1A4CAE6311ED815B782907A3584D0A15CCC0C76BEB897E6B19D8", 2, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_937320E9C3DF54E5743EC1FD81B8DDBC71A671E9C387AF376812CB70EFD18FC580FF", "_encstr_BAF514A56CDB9BD7BBC22F07F62DCD8EEB46B7B6EB98", 1);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_BA411567BF22CBDDD388B319F8075513191EECED458ED7", 0, "_encstr_93B508770F528D90B3DB", "_encstr_A6A8224D5B417F4860B718FF8987ED7169EF9D3BDA115FA75019451399C7E187BDAFE1C6", "_encstr_95F514A22F95A85940918328F0C452FCA95B4D4979B1", 1);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_954115DD2CE583F6D2731DF5D8DE37E8CA9B3A9532EB26", 0, "_encstr_93B508770F528D90B3DB", "_encstr_A6A8224D5B417F4860B718FF8987ED7169EF9D3BDA115FA75019451399C7E187BDAFE1C6", "_encstr_BAF514A56CDB9BD7BBC22F07F62DCD8EEB46B7B6EB98", 1);
}

removepoint() {
  self endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    if(getDvar("_encstr_8DFE1527F0A3AFB233C49257A1FF4B5DCD28D76BE0B9CF", "_encstr_B40101") != "_encstr_B40101") {
      var_0 = getDvar("_encstr_8DFE1527F0A3AFB233C49257A1FF4B5DCD28D76BE0B9CF", "_encstr_B40101");

      foreach(var_2 in level.objectives) {
        if(isDefined(var_2.objectivekey) && var_2.objectivekey == var_0) {
          var_2 notify("_encstr_8C030DE6A3DE387DE839A5B3B3CA93" + var_2.objectivekey);
          var_2 scripts\mp\gameobjects::allowuse("_encstr_8BBA05185F8B99");
          var_2.trigger = undefined;
          var_2 notify("_encstr_8BE208E31FA8E1631D65");
          var_2.visibleteam = "_encstr_8BBA05185F8B99";
          var_2 scripts\mp\gameobjects::setobjectivestatusicons(undefined, undefined);
          var_3 = [];

          foreach(var_5 in level.objectives) {
            if(var_5.objectivekey != var_0)
              var_3[var_5.objectivekey] = var_5;
          }

          level.objectives = var_3;
          break;
        }
      }

      setdynamicdvar("_encstr_8DFE1527F0A3AFB233C49257A1FF4B5DCD28D76BE0B9CF", "_encstr_B40101");
    }

    wait 1;
  }
}

placepoint() {
  self endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    if(getDvar("_encstr_8A19149BB04D713331ACC0E4CF19FF4F8F2850E218CF", "_encstr_B40101") != "_encstr_B40101") {
      var_0 = getDvar("_encstr_8A19149BB04D713331ACC0E4CF19FF4F8F2850E218CF", "_encstr_B40101");
      var_1 = undefined;
      var_2 = getEntArray("_encstr_827F0FE12BAF302029942F2F81CB80080B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

      foreach(var_4 in var_2) {
        if("_encstr_BA4C02DF" + var_4.script_label == var_0)
          var_1 = var_4;
      }

      var_1.origin = level.players[0].origin;
      var_1.ownerteam = "_encstr_A7A408B9CA5D1D4E2C63";
      var_6 = var_1.origin + (0, 0, 32);
      var_7 = var_1.origin + (0, 0, -32);
      var_8 = scripts\engine\trace::ray_trace(var_6, var_7, undefined, scripts\engine\trace::create_default_contents(1));
      var_1.origin = var_8["_encstr_BD260953AA97E3F014279D"];
      var_1.upangles = vectortoangles(var_8["_encstr_820E07FAE8780B3A4C"]);
      var_1.forward = anglesToForward(var_1.upangles);
      var_1.right = anglestoright(var_1.upangles);
      var_9[0] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1.origin);
      var_9[0].angles = var_1.angles;
      var_10 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_1.origin, 0, 90, 128);
      var_10.script_label = var_1.script_label;
      var_1 = var_10;
      var_11 = scripts\mp\gameobjects::createuseobject("_encstr_A7A408B9CA5D1D4E2C63", var_1, var_9, (0, 0, 100));

      if(isDefined(var_1.objectivekey))
        var_11.objectivekey = var_1.objectivekey;
      else
        var_11.objectivekey = var_11 scripts\mp\gameobjects::getlabel();

      if(isDefined(var_1.iconname))
        var_11.iconname = var_1.iconname;
      else
        var_11.iconname = var_11 scripts\mp\gameobjects::getlabel();

      var_11 thread runzonethink();
      var_11 scripts\mp\gameobjects::allowuse("_encstr_88BF06FD784A6393");
      var_11 scripts\mp\gameobjects::setusetime(level.bankcapturetime);
      var_11 scripts\mp\gameobjects::setobjectivestatusicons("_encstr_994B105B20DB3A9F30206457CD5973870DE0", "_encstr_95010EEEC297E07B2D733A7D13C237D6");
      var_11 scripts\mp\gameobjects::setvisibleteam("_encstr_9A19040BCDBC");
      var_11 scripts\mp\gameobjects::cancontestclaim(1);
      var_11.onuse = _encstr_81A5277BCF9854D32D73D6FA3BA8D70E08BBF4E941981A665849BAC1A15E2705982D9776F32AA76F76::zone_onuse;
      var_11.onbeginuse = _encstr_81A5277BCF9854D32D73D6FA3BA8D70E08BBF4E941981A665849BAC1A15E2705982D9776F32AA76F76::zone_onusebegin;
      var_11.onunoccupied = _encstr_81A5277BCF9854D32D73D6FA3BA8D70E08BBF4E941981A665849BAC1A15E2705982D9776F32AA76F76::zone_onunoccupied;
      var_11.oncontested = _encstr_81A5277BCF9854D32D73D6FA3BA8D70E08BBF4E941981A665849BAC1A15E2705982D9776F32AA76F76::zone_oncontested;
      var_11.onuncontested = _encstr_81A5277BCF9854D32D73D6FA3BA8D70E08BBF4E941981A665849BAC1A15E2705982D9776F32AA76F76::zone_onuncontested;
      var_11.claimgracetime = level.bankcapturetime * 1000;
      var_6 = var_11.visuals[0].origin + (0, 0, 32);
      var_7 = var_11.visuals[0].origin + (0, 0, -32);
      var_12 = scripts\engine\trace::create_contents(1, 1, 1, 1, 0, 1, 1);
      var_13 = [];
      var_8 = scripts\engine\trace::ray_trace(var_6, var_7, var_13, var_12);
      var_11.baseeffectpos = var_8["_encstr_BD260953AA97E3F014279D"];
      var_14 = vectortoangles(var_8["_encstr_820E07FAE8780B3A4C"]);
      var_14 = -1 * var_14;
      var_11.baseeffectforward = anglesToForward(var_14);
      var_11 _encstr_81A5277BCF9854D32D73D6FA3BA8D70E08BBF4E941981A665849BAC1A15E2705982D9776F32AA76F76::setneutral();
      level.objectives[var_11.objectivekey] = var_11;
      setdynamicdvar("_encstr_8A19149BB04D713331ACC0E4CF19FF4F8F2850E218CF", "_encstr_B40101");
    }

    wait 1;
  }
}