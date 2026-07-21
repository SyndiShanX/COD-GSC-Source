/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\pill.gsc
***********************************************/

main() {
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  var_0[0] = scripts\mp\utility\game::getgametype();
  var_0[1] = "_encstr_A7290676E4D2378C";
  var_0[2] = "_encstr_8218041DF5FA";
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
  level.givetagsfromcache = ::givetagsfromcache;
  level.conf_fx["_encstr_8BE007AB0FE8607F9B"] = loadfx("_encstr_AB531FCE99C3CB1BDEE456F25AB51CC26CE8CDBC9BDA2CC636F5CD73B777865AE8");
  scripts\mp\flashpoint::init();
  level.iconneutral = "_encstr_979016B3038528F88F5A6A33C28F28B0D19F2305AD2AE83E";
}

initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("_encstr_84BD1240EA425FEB4F9CC1506A97D0FF23D23848", getmatchrulesdata("_encstr_81B90912BBC9D25C3180AF", "_encstr_B6BD0901163E087DCAD7A3"));
  setdynamicdvar("_encstr_9BCE129B364EAFC196D8D8AF13589B6D92B01DCA", getmatchrulesdata("_encstr_81B90912BBC9D25C3180AF", "_encstr_BACF09DD798D48268F4351"));
  setdynamicdvar("_encstr_955C1903590E472208913C07A560ED2F2EB1ABFB63E6671350EB2D", getmatchrulesdata("_encstr_81B90912BBC9D25C3180AF", "_encstr_A65110FD59AD688EAF2393BB2B97DDA085B5"));
  setdynamicdvar("_encstr_A96F179B2E8A01C792BBC9A7977A84481206A0109DC9D8739B", getmatchrulesdata("_encstr_81B90912BBC9D25C3180AF", "_encstr_99630EBF20E17130DB28FC3D839BDA2C"));
  setdynamicdvar("_encstr_957513FBA25B2008DCECA1CF0A0620F233DAD0A3CB", getmatchrulesdata("_encstr_81B90912BBC9D25C3180AF", "_encstr_B6EB0E7209142F3EB865AB8A0FA8BB3F"));
  setdynamicdvar("_encstr_B277128366828FD9B052F8D7A2E181ED730AC0F9", 0);
  scripts\mp\utility\game::registerhalftimedvar("_encstr_A7290676E4D2378C", 0);
  setdynamicdvar("_encstr_99AC11D32ED3E78A43E84289F08D85E7A8054D", 0);
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
  _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::initarrays();
  _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::initpickupusability();
  spawnlootcaches();
  level thread removetagsongameended();
  level thread bankthink();
}

updategametypedvars() {
  _encstr_97EA20CDB1E44B1C3AB95EB583F2D9B05B95A3F2E056B9CBD8BDB66BF673B8D9CDB1::updatecommongametypedvars();
  level.banktime = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_B6BD0901163E087DCAD7A3", 2, 0, 10);
  level.bankrate = scripts\mp\utility\dvars::dvarintvalue("_encstr_BACF09DD798D48268F4351", 1, 1, 1000);
  level.bankcapturetime = scripts\mp\utility\dvars::dvarintvalue("_encstr_A65110FD59AD688EAF2393BB2B97DDA085B5", 0, 0, 10);
  level.megabanklimit = scripts\mp\utility\dvars::dvarintvalue("_encstr_99630EBF20E17130DB28FC3D839BDA2C", 5, 5, 15);
  level.megabankbonus = scripts\mp\utility\dvars::dvarintvalue("_encstr_B6EB0E7209142F3EB865AB8A0FA8BB3F", 150, 0, 750);
}

onspawnplayer() {
  if(isDefined(self.tagscarried))
    self setclientomnvar("_encstr_96D4147308480BE0C1048B885BA9808FA56B68C0AF51", self.tagscarried);
}

createtags() {
  level.dogtags = [];

  for(var_0 = 0; var_0 < 30; var_0++) {
    var_1[0] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (0, 0, 0));
    var_1[0] setModel("_encstr_84CD1C70848CA8DDFA3B0BBF9BE2AC88599F3B8E2CFF5AAF321333D5BF6A");
    var_1[1] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (0, 0, 0));
    var_1[1] setModel("_encstr_8CFD1ADD63D0EC6B0F8B5B2151506FE30BD75B679BE060FFA620938A");
    var_1[0] scriptmodelplayanim("_encstr_845B0F80326F10804A938B9F27535730E6");
    var_1[1] scriptmodelplayanim("_encstr_845B0F80326F10804A938B9F27535730E6");
    var_1[0] hide();
    var_1[1] hide();
    var_1[0] setasgametypeobjective();
    var_1[1] setasgametypeobjective();
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

spawntag(var_0, var_1) {
  var_2 = var_0 + (0, 0, 14);
  var_3 = (0, randomfloat(360), 0);
  var_4 = anglesToForward(var_3);
  var_5 = randomfloatrange(30, 150);
  var_6 = var_2 + var_5 * var_4;
  var_2 = playerphysicstrace(var_2, var_6);
  var_7 = gettag();
  var_7.curorigin = var_2;
  var_7.trigger.origin = var_2;
  var_7.visuals[0].origin = var_2;
  var_7.visuals[1].origin = var_2;
  var_7.trigger show();
  var_7 scripts\mp\gameobjects::allowuse("_encstr_9A19040BCDBC");
  var_7.visuals[0] thread showtoteam(var_7, scripts\mp\utility\game::getotherteam(var_1)[0]);
  var_7.visuals[1] thread showtoteam(var_7, var_1);
  var_7.visuals[0] setasgametypeobjective();
  var_7.visuals[1] setasgametypeobjective();
  playsoundatpos(var_2, "_encstr_999214B912F9C74B6943D01133B7A00B5271A5BEAD63");
  return var_7;
}

showtoteam(var_0, var_1) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_88F20627959BCAE8");
  self hide();

  foreach(var_3 in level.players) {
    if(playercanusetags(var_3)) {
      if(var_3.team == var_1)
        self showtoplayer(var_3);

      if(var_3.team == "_encstr_AF8C0A1B6A1D6045925B4F7D" && var_1 == "_encstr_9A8507BA4040188D08")
        self showtoplayer(var_3);
    }
  }

  for(;;) {
    level waittill("_encstr_81170C244F9CBDE72C01BB99A298");
    self hide();

    foreach(var_3 in level.players) {
      if(playercanusetags(var_3)) {
        if(var_3.team == var_1)
          self showtoplayer(var_3);
      }

      if(var_3.team == "_encstr_AF8C0A1B6A1D6045925B4F7D" && var_1 == "_encstr_9A8507BA4040188D08")
        self showtoplayer(var_3);

      if(var_0.victimteam == var_3.team && var_3 == var_0.attacker)
        scripts\mp\objidpoolmanager::update_objective_state(var_0.objid, "_encstr_A2BE0AB4DC3BB46E5A981BAC");
    }
  }
}

playercanusetags(var_0) {
  return 1;
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

    var_0.visuals[0] hide();
    var_0.visuals[1] hide();
    var_0.trigger hide();
    var_0.curorigin = (0, 0, 1000);
    var_0.trigger.origin = (0, 0, 1000);
    var_0.visuals[0].origin = (0, 0, 1000);
    var_0.visuals[1].origin = (0, 0, 1000);
    var_0 scripts\mp\gameobjects::allowuse("_encstr_8BBA05185F8B99");

    if(var_0.team != var_1.team) {
      var_1 playersettagcount(var_1.tagscarried + 1);
      var_1 thread scripts\mp\utility\points::giveunifiedpoints("_encstr_96590EE82CB3D71BDE36B1ACD88E598C");
    }

    var_1 playSound("_encstr_B6521B4D9B5942F899A0A3B5E68C228ABFA11D7BC773196398A7DBE579");

    if(isDefined(level.supportcranked) && level.supportcranked) {
      if(isDefined(var_1.cranked) && var_1.cranked)
        var_1 scripts\mp\cranked::setcrankedplayerbombtimer("_encstr_ABD70578F3D02C");
      else
        var_1 scripts\mp\cranked::oncranked(undefined, var_1);
    }

    playsoundatpos(var_1.origin, "_encstr_841616FD71694F532B68EA4133707F8798477871EF6013A3");
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
  self setclientomnvar("_encstr_96D4147308480BE0C1048B885BA9808FA56B68C0AF51", var_0);
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
    var_3 = _encstr_81A5277BCF9854D32D73D6FA3BA8D70E08BBF4E941981A665849BAC1A15E2705982D9776F32AA76F76::setupobjective(var_2);
    var_3 thread runzonethink();
    level.objectives[var_3.objectivekey] = var_3;
  }
}

isinzone(var_0, var_1) {
  if(scripts\mp\utility\player::isreallyalive(var_0) && var_0 istouching(var_1.trigger) && var_1.ownerteam == var_0.team)
    return 1;

  return 0;
}

runzonethink() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    self.trigger waittill("_encstr_8F5C086405E70FBA4B4A", var_0);

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
  while(var_0.tagscarried && isinzone(var_0, var_1) && !var_1.stalemate) {
    var_0 playsoundtoplayer("_encstr_A9FB168922C9F77B599323E1C367903B0201F6073D224BE1", var_0);
    var_2 = level.bankrate;

    if(var_2 > var_0.tagscarried)
      var_2 = var_0.tagscarried;

    scoreamount(var_0, var_2);

    for(var_3 = 0; var_3 < var_2; var_3++)
      var_0 thread scripts\mp\utility\points::giveunifiedpoints("_encstr_AB9C0A23BA37083846F77543");

    if(isDefined(level.supportcranked) && level.supportcranked && isDefined(var_0.cranked) && var_0.cranked)
      var_0 scripts\mp\cranked::setcrankedplayerbombtimer("_encstr_ABD70578F3D02C");

    wait(level.banktime);
  }

  var_1 _encstr_81A5277BCF9854D32D73D6FA3BA8D70E08BBF4E941981A665849BAC1A15E2705982D9776F32AA76F76::setneutralicons();
  var_0.isscoring = 0;
}

scoreamount(var_0, var_1) {
  var_0 playersettagcount(var_0.tagscarried - var_1);
  scripts\mp\gamescore::giveteamscoreforobjective(var_0.team, var_1, 0);
}

initspawns() {
  scripts\mp\spawnlogic::setactivespawnlogic("_encstr_973807485A3B8A88D4", "_encstr_A6E80F61DA270BDE09B2C8C33B40AB859D");
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::addstartspawnpoints("_encstr_A1C01A915857A3F96DC9D8C84283B59E07FCA91BA51F0E1F1332A8F0");
  scripts\mp\spawnlogic::addstartspawnpoints("_encstr_8AF71849707F8BC155E180A03AEB9DA6DF10C33EC76733137ABB");
  scripts\mp\spawnlogic::addspawnpoints("_encstr_9A8507BA4040188D08", "_encstr_A1C01A915857A3F96DC9D8C84283B59E07FCA91BA51F0E1F1332A8F0");
  scripts\mp\spawnlogic::addspawnpoints("_encstr_8E8405EA382B2A", "_encstr_8AF71849707F8BC155E180A03AEB9DA6DF10C33EC76733137ABB");
  scripts\mp\spawnlogic::registerspawnset("_encstr_9ACE0E35185562D930394F63B8C895CB", "_encstr_A1C01A915857A3F96DC9D8C84283B59E07FCA91BA51F0E1F1332A8F0");
  scripts\mp\spawnlogic::registerspawnset("_encstr_AD490CE67B39AD58C6EBC23CA5DC", "_encstr_8AF71849707F8BC155E180A03AEB9DA6DF10C33EC76733137ABB");
  scripts\mp\spawnlogic::registerspawnset("_encstr_AD0C095DF195E8B6074A18", "_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318");
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
  } else if(var_0 == "_encstr_9A8507BA4040188D08")
    var_2 = scripts\mp\spawnlogic::getspawnpoint(self, var_0, "_encstr_9ACE0E35185562D930394F63B8C895CB", "_encstr_AD0C095DF195E8B6074A18");
  else
    var_2 = scripts\mp\spawnlogic::getspawnpoint(self, var_0, "_encstr_AD490CE67B39AD58C6EBC23CA5DC", "_encstr_AD0C095DF195E8B6074A18");

  return var_2;
}

onnormaldeath(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(istrue(level.flashpointactive))
    scripts\mp\flashpoint::flashpoint_processnewevent(var_1, var_0, gettime(), "_encstr_A9D509DF776894B19E78B1" + var_1.team);

  var_0 _encstr_B82C2106669B6BBBC467DAF053A791B3B20F7D8B3A42E708A873ABE0EB050B757A327E::playersettagcount(var_0.tagscarried + 1000);
  _encstr_97EA20CDB1E44B1C3AB95EB583F2D9B05B95A3F2E056B9CBD8BDB66BF673B8D9CDB1::oncommonnormaldeath(var_0, var_1, var_2, var_3, var_4, var_5);
}

droptags(var_0, var_1) {
  if(isagent(var_0)) {
    return;
  }
  if(var_0.tagscarried > 9)
    var_2 = 10;
  else if(var_0.tagscarried > 0)
    var_2 = var_0.tagscarried;
  else
    var_2 = 0;

  for(var_3 = 0; var_3 < var_2; var_3++) {
    var_4 = spawntag(var_0.origin, var_0.team);
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

dogtagallyonusecb(var_0) {}

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
      var_11 scripts\mp\gameobjects::setobjectivestatusicons("_encstr_994B105B20DB3A9F30206457CD5973870DE0", "_encstr_85B118EB19F840DA93FDCB6FCF4FF39C7083E73531200C43FFE1");
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

spawnlootcaches() {
  scripts\cp_mp\killstreaks\airdrop::initplundercratedata();
  var_0 = scripts\engine\utility::getStructArray("_encstr_990714A04B2D50FF07E5F6F16B50B4A7B153232EDFA0", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = int(100 * var_0.size / 100);
  var_0 = scripts\engine\utility::array_randomize(var_0);
  level.currencycaches = [];

  for(var_2 = 0; var_2 < var_1; var_2++)
    spawnlootcache(var_0[var_2]);
}

spawnlootcache(var_0) {
  var_1 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::spawnpickup("_encstr_A9AC0EAFFCC4C81FC22F7F4F57EAD3D8", var_0.origin + level.br_pickups.br_dropoffsets[0], (0, 0, 0));
}

givetagsfromcache() {
  _encstr_B82C2106669B6BBBC467DAF053A791B3B20F7D8B3A42E708A873ABE0EB050B757A327E::playersettagcount(self.tagscarried + 1000);
}

bankthink() {
  self endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = getEntArray("_encstr_827F0FE12BAF302029942F2F81CB80080B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  wait 5;
  var_1 = [];
  var_2 = [];

  for(;;) {
    var_0 = scripts\engine\utility::array_randomize(var_0);
    var_3 = 0;
    var_4 = 0;

    while(var_3 < 1) {
      foreach(var_4, var_6 in var_0) {
        if(var_3 == 1) {
          break;
        }

        if((!isDefined(var_6.inuse) || !var_6.inuse) && (!isDefined(var_6.usedlastphase) || !var_6.usedlastphase)) {
          var_7 = _encstr_81A5277BCF9854D32D73D6FA3BA8D70E08BBF4E941981A665849BAC1A15E2705982D9776F32AA76F76::setupobjective(var_0[var_4]);
          var_7 scripts\mp\gameobjects::allowuse("_encstr_9A19040BCDBC");
          var_7 scripts\mp\gameobjects::setvisibleteam("_encstr_9A19040BCDBC");
          scripts\mp\objidpoolmanager::objective_set_play_intro(var_7.objidnum, 0);
          var_7.lockupdatingicons = 0;
          var_7 scripts\mp\gameobjects::setobjectivestatusicons("_encstr_979016B3038528F88F5A6A33C28F28B0D19F2305AD2AE83E");
          var_7.lockupdatingicons = 1;
          objective_setlabel(var_7.objidnum, &"_encstr_AC7F2291F92993CC1751B1BD770FF4D15696F1C950B53B25F7A72D851067FF2F7DC9C179");
          objective_setneutrallabel(var_7.objidnum, &"_encstr_AC7F2291F92993CC1751B1BD770FF4D15696F1C950B53B25F7A72D851067FF2F7DC9C179");
          objective_setfriendlylabel(var_7.objidnum, &"_encstr_AC7F2291F92993CC1751B1BD770FF4D15696F1C950B53B25F7A72D851067FF2F7DC9C179");
          objective_setenemylabel(var_7.objidnum, &"_encstr_AC7F2291F92993CC1751B1BD770FF4D15696F1C950B53B25F7A72D851067FF2F7DC9C179");
          var_7 thread runzonethink();
          var_1[var_4] = var_7;
          var_7.sourcetrigger = var_6;
          var_6.inuse = 1;
          var_3++;
        }
      }

      if(var_3 < 1) {
        foreach(var_6 in var_0)
        var_6.usedlastphase = 0;
      }
    }

    wait 5;

    foreach(var_6 in var_1) {
      var_6 scripts\mp\gameobjects::allowuse("_encstr_8BBA05185F8B99");
      var_6 scripts\mp\gameobjects::setvisibleteam("_encstr_8BBA05185F8B99");
      var_6 scripts\mp\gameobjects::releaseid();
      var_6.visibleteam = "_encstr_8BBA05185F8B99";
      var_6.scriptable delete();
      var_6.sourcetrigger.usedlastphase = 1;
      var_6.sourcetrigger.inuse = 0;
    }

    var_1 = [];
    wait 5;
  }
}