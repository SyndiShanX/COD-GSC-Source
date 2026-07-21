/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\front.gsc
***********************************************/

main() {
  if(getDvar("_encstr_9570084B1793A090CDFF") == "_encstr_8D510E52E3A7C6985EB7B9BE2F35C690") {
    return;
  }
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  var_0[0] = scripts\mp\utility\game::getgametype();
  scripts\mp\gameobjects::main(var_0);

  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread scripts\mp\utility\game::reinitializematchrulesonmigration();
  } else {
    scripts\mp\utility\game::registerroundswitchdvar(scripts\mp\utility\game::getgametype(), 0, 0, 9);
    scripts\mp\utility\game::registertimelimitdvar(scripts\mp\utility\game::getgametype(), 600);
    scripts\mp\utility\game::registerscorelimitdvar(scripts\mp\utility\game::getgametype(), 100);
    scripts\mp\utility\game::registerroundlimitdvar(scripts\mp\utility\game::getgametype(), 2);
    scripts\mp\utility\game::registerwinlimitdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registernumlivesdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
  }

  updategametypedvars();
  level.teambased = 1;
  level.onstartgametype = ::onstartgametype;
  level.onplayerconnect = ::onplayerconnect;
  level.getspawnpoint = ::getspawnpoint;
  level.onnormaldeath = ::onnormaldeath;
  level.modeonspawnplayer = ::onspawnplayer;
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_9BE50A3AC887CD83C0F32E5D";

  if(getdvarint("_encstr_B2020AE1F36BF74429D93F01"))
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_8A19042AB017" + game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"];
  else if(getdvarint("_encstr_82570B397A4D3192935192A562"))
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_979708CC69F02253FF26" + game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"];
  else if(getdvarint("_encstr_96050CDCD839EB46B4560D58938C"))
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_B21804C8D0D7" + game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"];
  else if(getdvarint("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_95B909F7CB45A81F58EF63"))
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] + "_encstr_824305B93705A7";

  game["_encstr_A1B10847BD1A23B8FA8B"]["_encstr_A5EE0E780BFD08A5321F7B07635AE040"] = &"_encstr_8F180FE58F40BBCC3D09C97169E9B567C5";
  thread spawnzonefx();
}

initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("_encstr_B61C1EB91B39D7CC93F637A3F595E62BB6F2840BDCAC2D2D36639259ECAC0B1B", getmatchrulesdata("_encstr_B8260AC2307F054B1D3FFCE1", "_encstr_A95814597395AD5E1216CD562DD21B6392B29D565863"));
  setdynamicdvar("_encstr_ACAF1CAFE7521F48CEB2A05C4896EAF06FAE41712F6ABADBD57E6135F5D7", getmatchrulesdata("_encstr_B8260AC2307F054B1D3FFCE1", "_encstr_8FCA1233C9D256E6C8D897122C9B59A66CF63956"));
  setdynamicdvar("_encstr_8340181AFEC39164C02205A50FC7DA3DD989B77AC1EB0F8F0B8F", getmatchrulesdata("_encstr_B8260AC2307F054B1D3FFCE1", "_encstr_83F80ED62D23992D95C6329A6CF627CA"));
  setdynamicdvar("_encstr_8F88199BD8E4AF334EEDCD1DEB569B59B5F2480BCD59D46CED4E95", getmatchrulesdata("_encstr_B8260AC2307F054B1D3FFCE1", "_encstr_96C50FA2803BB50FAD6FABB56ED10F3A53"));
  setdynamicdvar("_encstr_ABE812A0880249D74DF2A8F441A91A5AAB878487", 0);
}

onstartgametype() {
  setclientnamemode("_encstr_B6900C7BCDABC8AF2722B158FA17");

  if(!isDefined(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"]))
    game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"] = 0;

  if(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"]) {
    var_0 = game["_encstr_991C0AB9ED5B57161FE89B83"];
    var_1 = game["_encstr_B6A70A23CA6659DC91CAE4DC"];
    game["_encstr_991C0AB9ED5B57161FE89B83"] = var_1;
    game["_encstr_B6A70A23CA6659DC91CAE4DC"] = var_0;
  }

  foreach(var_3 in level.teamnamelist) {
    scripts\mp\utility\game::setobjectivetext(var_3, &"_encstr_BA0E1127EBC2B71BC119010DABAA03D179709B");

    if(level.splitscreen)
      scripts\mp\utility\game::setobjectivescoretext(var_3, &"_encstr_BA0E1127EBC2B71BC119010DABAA03D179709B");
    else
      scripts\mp\utility\game::setobjectivescoretext(var_3, &"_encstr_A52E17B489ACF7335D733FD0E7C63BFEE7F9E960B1977DA6CB");

    scripts\mp\utility\game::setobjectivehinttext(var_3, &"_encstr_A98C162932A8C84EC343BE3D29A8E61EBFDBEB964CB46843");
  }

  level.iconkill3d = "_encstr_82FD166339ABDBC568F5446787404AB3D533DA69C00B63FD";
  level.iconkill2d = "_encstr_82FD166339ABDBC568F5446787404AB3D533DA69C00B63FD";
  initspawns();
  base_setupvfx();
  thread setupbases();
  thread setupbaseareabrushes();
  level.disablebuddyspawn = 1;
}

updategametypedvars() {
  _encstr_97EA20CDB1E44B1C3AB95EB583F2D9B05B95A3F2E056B9CBD8BDB66BF673B8D9CDB1::updatecommongametypedvars();
  level.enemybasekillreveal = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_A95814597395AD5E1216CD562DD21B6392B29D565863", 5, 0, 60);
  level.friendlybasescore = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_8FCA1233C9D256E6C8D897122C9B59A66CF63956", 1, 0, 25);
  level.midfieldscore = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_83F80ED62D23992D95C6329A6CF627CA", 2, 0, 25);
  level.enemybasescore = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_96C50FA2803BB50FAD6FABB56ED10F3A53", 1, 0, 25);
}

initspawns() {
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::setactivespawnlogic("_encstr_8B1608CC43B8D647A113", "_encstr_829A0D0F1AF8FB5ED127855073F940");
  scripts\mp\spawnlogic::addspawnpoints("_encstr_9A8507BA4040188D08", "_encstr_839D1687D1804A5A58D00BD96B789193E0773F1B41332213");
  scripts\mp\spawnlogic::addspawnpoints("_encstr_8E8405EA382B2A", "_encstr_9B3B1429826955DBFF332081BF1871BFA2E1972B5CC3");
  level.frontlinespawnsets = [];
  level.frontlinespawnsets["_encstr_9A8507BA4040188D08"] = "_encstr_9A8507BA4040188D08";
  level.frontlinespawnsets["_encstr_8E8405EA382B2A"] = "_encstr_8E8405EA382B2A";
  scripts\mp\spawnlogic::registerspawnset("_encstr_9A8507BA4040188D08", "_encstr_839D1687D1804A5A58D00BD96B789193E0773F1B41332213");
  scripts\mp\spawnlogic::registerspawnset("_encstr_8E8405EA382B2A", "_encstr_9B3B1429826955DBFF332081BF1871BFA2E1972B5CC3");
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

onspawnplayer() {
  if(isPlayer(self)) {
    self.inenemybase = 0;
    self.infriendlybase = 0;
    self.outlinetime = 0;

    if(isDefined(self.outlineid))
      scripts\mp\utility\outline::outlinedisable(self.outlineid, self);

    self.useoutline = 0;
    self.outlineid = undefined;
    thread friendlybasewatcher();
    thread enemybasewatcher();

    foreach(var_1 in level.zones)
    var_1 showbaseeffecttoplayer(self);
  }
}

getspawnpoint() {
  var_0 = self.pers["_encstr_8AEF05472BC2D6"];

  if(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"])
    var_0 = scripts\mp\utility\game::getotherteam(var_0)[0];

  var_1 = scripts\mp\spawnlogic::getspawnpoint(self, var_0, level.frontlinespawnsets[var_0]);
  return var_1;
}

onnormaldeath(var_0, var_1, var_2, var_3, var_4, var_5) {
  _encstr_97EA20CDB1E44B1C3AB95EB583F2D9B05B95A3F2E056B9CBD8BDB66BF673B8D9CDB1::oncommonnormaldeath(var_0, var_1, var_2, var_3, var_4, var_5);
  var_6 = 0;

  if(var_0.infriendlybase || var_1.inenemybase) {
    var_1 thread scripts\mp\utility\points::giveunifiedpoints("_encstr_B6DB10599B56D6E5EB98169B59BEAD4B8DC6", var_4);
    var_6 = level.enemybasescore;
  } else if(var_1.infriendlybase || var_0.inenemybase) {
    var_1 thread scripts\mp\utility\points::giveunifiedpoints("_encstr_933913994E4B2B73C83697AF2658DCACEBD64B3636", var_4);
    var_6 = level.friendlybasescore;
  } else {
    var_1 thread scripts\mp\utility\points::giveunifiedpoints("_encstr_BDD90E0ACCA1DA5FEDD0FCF9AC32418A", var_4);
    var_6 = level.midfieldscore;
  }

  var_7 = game["_encstr_96040B1D59B0AD35B1F64E599B"][var_1.pers["_encstr_8AEF05472BC2D6"]] + var_6;
  var_8 = var_7 >= level.roundscorelimit;

  if(var_8 && level.roundscorelimit != 0)
    var_6 = level.roundscorelimit - game["_encstr_96040B1D59B0AD35B1F64E599B"][var_1.pers["_encstr_8AEF05472BC2D6"]];

  if(var_6 > 0) {
    scripts\mp\gamescore::giveteamscoreforobjective(var_1.pers["_encstr_8AEF05472BC2D6"], var_6, 0);
    var_1 thread scripts\mp\rank::scoreeventpopup("_encstr_85B0122B99385D1B96FFD387B7C8029C9001E079" + var_6);
  }
}

enemybasekillreveal() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self notify("_encstr_A95814517395AD5E1216CD562DD21B6392B29D565863");
  self endon("_encstr_A95814517395AD5E1216CD562DD21B6392B29D565863");

  if(isDefined(self.basekilloutlineid))
    scripts\mp\utility\outline::outlinedisable(self.basekilloutlineid, self);

  self.basekilloutlineid = scripts\mp\utility\outline::outlineenableforteam(self, scripts\mp\utility\game::getotherteam(self.team)[0], "_encstr_A2A117F6AB471B5AE656AFE6DB199583D134FADB930BCD76CA", "_encstr_960D052F10EBF0");

  if(!isbot(self))
    scripts\mp\utility\outline::_hudoutlineviewmodelenable("_encstr_A2A117F6AB471B5AE656AFE6DB199583D134FADB930BCD76CA", 0);

  self sethudtutorialmessage(&"_encstr_B43A126AA097C8943D39A2EB948A595150625422");
  wait(level.enemybasekillreveal);
  scripts\mp\utility\outline::outlinedisable(self.basekilloutlineid, self);
  scripts\mp\utility\outline::_hudoutlineviewmodeldisable();
  self clearhudtutorialmessage(0);
}

setupbases() {
  level.zones = [];

  if(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"]) {
    level.allieszone = getEntArray("_encstr_AFAE166693EDCDE8D8D273B2FAE9BDDCB2F52C1B365AB2CD", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    foreach(var_1 in level.allieszone) {
      var_1.team = "_encstr_8E8405EA382B2A";
      var_1 thread friendlybasewatcher();
      var_1 thread enemybasewatcher();
      var_1 thread enemybasekillstreakwatcher();
    }

    thread setupvisuals(level.allieszone[0]);
    level.zones[level.zones.size] = level.allieszone[0];
    level.axiszone = getEntArray("_encstr_AD2F1499E4EDB98E36967356D74FEDE6CAD758C39637", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    if(level.mapname == "_encstr_8147082D8A3F48F84548") {
      var_3 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", (-1410, -2080, 240), 0, 1000, 600);
      level.axiszone[level.axiszone.size] = var_3;
    }

    foreach(var_1 in level.axiszone) {
      var_1.team = "_encstr_9A8507BA4040188D08";
      var_1 thread friendlybasewatcher();
      var_1 thread enemybasewatcher();
      var_1 thread enemybasekillstreakwatcher();
    }

    thread setupvisuals(level.axiszone[0]);
    level.zones[level.zones.size] = level.axiszone[0];
  } else {
    level.allieszone = getEntArray("_encstr_AFAE166693EDCDE8D8D273B2FAE9BDDCB2F52C1B365AB2CD", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    foreach(var_1 in level.allieszone) {
      var_1.team = "_encstr_9A8507BA4040188D08";
      var_1 thread friendlybasewatcher();
      var_1 thread enemybasewatcher();
      var_1 thread enemybasekillstreakwatcher();
    }

    thread setupvisuals(level.allieszone[0]);
    level.zones[level.zones.size] = level.allieszone[0];
    level.axiszone = getEntArray("_encstr_AD2F1499E4EDB98E36967356D74FEDE6CAD758C39637", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    if(level.mapname == "_encstr_8147082D8A3F48F84548") {
      var_3 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", (-1410, -2080, 240), 0, 1000, 600);
      level.axiszone[level.axiszone.size] = var_3;
    }

    foreach(var_1 in level.axiszone) {
      var_1.team = "_encstr_8E8405EA382B2A";
      var_1 thread friendlybasewatcher();
      var_1 thread enemybasewatcher();
      var_1 thread enemybasekillstreakwatcher();
    }

    thread setupvisuals(level.axiszone[0]);
    level.zones[level.zones.size] = level.axiszone[0];
  }
}

setupvisuals(var_0) {
  var_1 = [];
  var_1[0] = var_0;

  if(isDefined(var_0.target)) {
    var_2 = getEntArray(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    for(var_3 = 0; var_3 < var_2.size; var_3++)
      var_1[var_1.size] = var_2[var_3];
  }

  var_1 = mappatchborders(var_1, var_0.target);
  var_0.visuals = var_1;
}

mappatchborders(var_0, var_1) {
  if(level.mapname == "_encstr_824D0B772110BBD920C07DC3DB" && var_1 == "_encstr_997E0FC6A670238B2F38124B89AB40F72B") {
    var_2 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (-1088, -1504, 136));
    var_2.angles = (0, 180, 0);
    var_2.targetname = var_1;
    var_0[var_0.size] = var_2;
    var_3 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (-1088, -1440, 136));
    var_3.angles = (0, 180, 0);
    var_2.targetname = var_1;
    var_0[var_0.size] = var_3;
  }

  return var_0;
}

friendlybasewatcher() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_0);

    if(!isPlayer(var_0)) {
      continue;
    }
    if(var_0.team != self.team) {
      continue;
    }
    if(var_0.infriendlybase) {
      continue;
    }
    var_0 thread friendlybasetriggerwatcher(self);
  }
}

friendlybasetriggerwatcher(var_0) {
  self notify("_encstr_B4F517CCC99695DC46B1CB2A93D23BD9CA93752C8E1BD0AC39");
  self endon("_encstr_B4F517CCC99695DC46B1CB2A93D23BD9CA93752C8E1BD0AC39");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"]) {
    if(self.team == "_encstr_9A8507BA4040188D08")
      var_1 = level.axiszone;
    else
      var_1 = level.allieszone;
  } else if(self.team == "_encstr_9A8507BA4040188D08")
    var_1 = level.allieszone;
  else
    var_1 = level.axiszone;

  for(;;) {
    self.infriendlybase = 0;

    foreach(var_0 in var_1) {
      if(self istouching(var_0)) {
        self.infriendlybase = 1;
        break;
      }
    }

    if(!self.infriendlybase || scripts\mp\arbitrary_up::isinarbitraryup()) {
      if(istrue(self.spawnprotection))
        _encstr_97EA20CDB1E44B1C3AB95EB583F2D9B05B95A3F2E056B9CBD8BDB66BF673B8D9CDB1::removespawnprotection();

      break;
    }

    waitframe();
  }
}

enemybasewatcher() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_0);

    if(isDefined(var_0.team) && var_0.team == self.team) {
      continue;
    }
    if(isalive(var_0) && isDefined(var_0.sessionstate) && var_0.sessionstate != "_encstr_AF8C0A1B6A1D6045925B4F7D" || playercontrolledstreak(var_0)) {
      var_0.inenemybase = 1;
      var_0 thread enemybasetriggerwatcher(self);
    }
  }
}

enemybasetriggerwatcher(var_0) {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(istrue(self.useoutline)) {
    return;
  }
  for(;;) {
    if(isDefined(self) && self istouching(var_0)) {
      if(!istrue(self.useoutline))
        thread enableenemybaseoutline();
    } else {
      self.useoutline = 0;
      self.inenemybase = 0;
      thread disableenemybaseoutline();
      break;
    }

    waitframe();
  }
}

enableenemybaseoutline() {
  self.useoutline = 1;
  self.outlinetime = gettime();
  self.outlineid = scripts\mp\utility\outline::outlineenableforteam(self, scripts\mp\utility\game::getotherteam(self.team)[0], "_encstr_A2A117F6AB471B5AE656AFE6DB199583D134FADB930BCD76CA", "_encstr_960D052F10EBF0");

  if(!isbot(self)) {
    if(isPlayer(self))
      scripts\mp\utility\outline::_hudoutlineviewmodelenable("_encstr_A2A117F6AB471B5AE656AFE6DB199583D134FADB930BCD76CA", 0);
  }
}

disableenemybaseoutline() {
  self.useoutline = 0;
  scripts\mp\utility\outline::outlinedisable(self.outlineid, self);
  self.outlineid = undefined;

  if(!isbot(self) && isPlayer(self))
    scripts\mp\utility\outline::_hudoutlineviewmodeldisable();
}

enemybasekillstreakwatcher() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    if(level.turrets.size > 0) {
      foreach(var_1 in level.turrets)
      handleoutlinesforstreaks(var_1);
    }

    wait 0.1;
  }
}

handleoutlinesforstreaks(var_0) {
  if(var_0.owner.team == self.team) {
    return;
  }
  if(var_0 istouching(self)) {
    if(!isDefined(var_0.outlineid))
      var_0.outlineid = scripts\mp\utility\outline::outlineenableforteam(var_0, self.team, "_encstr_A2A117F6AB471B5AE656AFE6DB199583D134FADB930BCD76CA", "_encstr_A7440781BA73D7D8C1");
  } else if(isDefined(var_0.outlineid)) {
    scripts\mp\utility\outline::outlinedisable(var_0.outlineid, var_0);
    var_0.outlineid = undefined;
  } else {}
}

playercontrolledstreak(var_0) {
  if(isDefined(var_0.streakname)) {
    switch (var_0.streakname) {
      default:
        return 0;
    }
  }

  return 0;
}

showbaseeffecttoplayer(var_0) {
  var_1 = self.team;
  var_2 = undefined;
  var_3 = var_0.team;

  if(!isDefined(var_3))
    var_3 = "_encstr_9A8507BA4040188D08";

  var_4 = var_0 ismlgspectator();

  if(var_4)
    var_3 = var_0 getmlgspectatorteam();
  else if(var_3 == "_encstr_AF8C0A1B6A1D6045925B4F7D")
    var_3 = "_encstr_9A8507BA4040188D08";

  var_5 = level.basefxid["_encstr_ACFC091AE8AB2FCBE15119"];
  var_6 = level.basefxid["_encstr_88BF06FD784A6393"];

  if(var_3 == var_1) {
    showfxarray(self._baseeffectfriendly, var_0);
    hidefxarray(self._baseeffectenemy, var_0);
  } else {
    showfxarray(self._baseeffectenemy, var_0);
    hidefxarray(self._baseeffectfriendly, var_0);
  }
}

showfxarray(var_0, var_1) {
  for(var_2 = 0; var_2 < var_0.size; var_2++)
    var_0[var_2] showtoplayer(var_1);
}

hidefxarray(var_0, var_1) {
  for(var_2 = 0; var_2 < var_0.size; var_2++)
    var_0[var_2] hidefromplayer(var_1);
}

spawnfxarray() {
  self._baseeffectfriendly = [];
  self._baseeffectenemy = [];

  for(var_0 = 1; var_0 < self.visuals.size; var_0++) {
    var_1 = anglesToForward(self.visuals[var_0].angles);
    self._baseeffectfriendly[self._baseeffectfriendly.size] = spawnfx(level.basefxid["_encstr_ACFC091AE8AB2FCBE15119"], self.visuals[var_0].origin, var_1);
    self._baseeffectfriendly[self._baseeffectfriendly.size - 1] setfxkilldefondelete();
    triggerfx(self._baseeffectfriendly[self._baseeffectfriendly.size - 1]);
  }

  for(var_0 = 1; var_0 < self.visuals.size; var_0++) {
    var_1 = anglesToForward(self.visuals[var_0].angles);
    self._baseeffectenemy[self._baseeffectenemy.size] = spawnfx(level.basefxid["_encstr_88BF06FD784A6393"], self.visuals[var_0].origin, var_1);
    self._baseeffectenemy[self._baseeffectenemy.size - 1] setfxkilldefondelete();
    triggerfx(self._baseeffectenemy[self._baseeffectenemy.size - 1]);
  }
}

base_setupvfx() {
  level.basefxid["_encstr_ACFC091AE8AB2FCBE15119"] = loadfx("_encstr_91362BA0E40B07DBF232270FA50F80BF074BA2DA430B306E292BE005E459C5A73B935713E937E0216BE8EB26DA");
  level.basefxid["_encstr_88BF06FD784A6393"] = loadfx("_encstr_A1C92BA3F1F8170298CDB7A6CB3F0E93989B9F7D6BA0F89964A597AB1170E2C718E117B2E690BA42CC05EB9311");
}

spawnzonefx() {
  waitframe();

  foreach(var_1 in level.zones)
  var_1 spawnfxarray();
}

onplayerconnect(var_0) {
  foreach(var_2 in level.zones)
  var_2 showbaseeffecttoplayer(var_0);
}

setupbaseareabrushes() {
  var_0 = getbasearray("_encstr_8E6921F3A898ABBBD980778E7FF0AED446853A3568FECD0D5015BF299E7B98CBDDB8E5");
  var_1 = getbasearray("_encstr_93A31FAF7B485E6B88D5A7ABC35093814063E6B5768078F2F687AFB72DEDEAD320");
  var_2 = getbasearray("_encstr_867F20E2CB303393696DCFC67B415B776643EACAF69FF34D204BEBEF0570A48F37D9");
  var_3 = getbasearray("_encstr_BA7B1E7CD2BA95CB1FD34858B747C3D3C3BB67F161B261501B2F08B0AF951871");
  var_4 = getbasearray("_encstr_975C1F2AC5570E41E7922848D3B9CEB120305ADCE18B38A8020FCB498110056090");
  var_5 = getbasearray("_encstr_8D461DFB688725EB1F08B81DE1EFEC300353927AE071B834EE5F6FD81781EB");
  hidebasebrushes(var_0);
  hidebasebrushes(var_1);
  hidebasebrushes(var_2);
  hidebasebrushes(var_3);
  hidebasebrushes(var_4);
  hidebasebrushes(var_5);
}

hidebasebrushes(var_0) {
  if(isDefined(var_0)) {
    for(var_1 = 0; var_1 < var_0.size; var_1++)
      var_0[var_1] hide();
  }
}

getbasearray(var_0) {
  var_1 = getEntArray(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(!isDefined(var_1) || var_1.size == 0)
    return undefined;

  return var_1;
}