/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\payload.gsc
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
    scripts\mp\utility\game::registertimelimitdvar(scripts\mp\utility\game::getgametype(), 10);
    scripts\mp\utility\game::registerscorelimitdvar(scripts\mp\utility\game::getgametype(), 2);
    scripts\mp\utility\game::registerroundlimitdvar(scripts\mp\utility\game::getgametype(), 3);
    scripts\mp\utility\game::registerwinlimitdvar(scripts\mp\utility\game::getgametype(), 2);
    scripts\mp\utility\game::registernumlivesdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
  }

  updategametypedvars();
  level.scoreperplayer = undefined;
  level.teambased = 1;
  level.ontimelimit = ::ontimelimit;
  level.onstartgametype = ::onstartgametype;
  level.getspawnpoint = ::getspawnpoint;
  level.modeonspawnplayer = ::onspawnplayer;
  level.lastcaptime = gettime();
  level.previousclosespawnent = undefined;
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_B67B0A1A2C279107DBB49BA3";

  if(getdvarint("_encstr_B2020AE1F36BF74429D93F01"))
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_8A19042AB017" + game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"];
  else if(getdvarint("_encstr_82570B397A4D3192935192A562"))
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_979708CC69F02253FF26" + game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"];
  else if(getdvarint("_encstr_96050CDCD839EB46B4560D58938C"))
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_B21804C8D0D7" + game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"];
  else if(getdvarint("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_95B909F7CB45A81F58EF63"))
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] + "_encstr_824305B93705A7";

  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_95240C659372588E43623137DE6C"] = "_encstr_9B0B0C8D0BC11DAB39CAD7BDC4A9";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_93420C4255FBEA5D408FD1FD2A62"] = "_encstr_9B0B0C8D0BC11DAB39CAD7BDC4A9";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_83CF0EDB26357D46B2CD47C9DB2FAC32"] = "_encstr_83CF0EDB26357D46B2CD47C9DB2FAC32";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_96150D4AF18ABF1EC031AC950DD8E7"] = "_encstr_96150D4AF18ABF1EC031AC950DD8E7";
}

initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("_encstr_85F11D2646BB279BF16FE07BF70CB6BF52AB952E5FC301E1CF1BA858EB210A", 5);
}

onstartgametype(var_0) {
  var_1 = scripts\mp\utility\game::istimetobeatvalid();

  if(game["_encstr_8DC30DAA0285FD69FAE113371B1934"] == 0) {
    setomnvar("_encstr_BDDF21D55AFA93DEAEB919F5D04B9BE8FABDCEB2C9E42DC8CAFAB0A3D10BB15BAC39B9", 1);
    setomnvar("_encstr_BD3721E0DA99B5B88F0E55C010274071714270F8C36ADB91A7176DC5F63F0829A73BA0", 1);
  } else if(var_1) {
    setomnvar("_encstr_BDDF21D55AFA93DEAEB919F5D04B9BE8FABDCEB2C9E42DC8CAFAB0A3D10BB15BAC39B9", scripts\engine\utility::ter_op(game["_encstr_A5D40F8ED2DACA51F62456C2D14556586B"] == game["_encstr_991C0AB9ED5B57161FE89B83"], 2, 3));
    setomnvar("_encstr_BD3721E0DA99B5B88F0E55C010274071714270F8C36ADB91A7176DC5F63F0829A73BA0", scripts\engine\utility::ter_op(game["_encstr_A5D40F8ED2DACA51F62456C2D14556586B"] == game["_encstr_B6A70A23CA6659DC91CAE4DC"], 2, 3));
  } else {
    setomnvar("_encstr_BDDF21D55AFA93DEAEB919F5D04B9BE8FABDCEB2C9E42DC8CAFAB0A3D10BB15BAC39B9", 4);
    setomnvar("_encstr_BD3721E0DA99B5B88F0E55C010274071714270F8C36ADB91A7176DC5F63F0829A73BA0", 4);
  }

  if(!isDefined(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"]))
    game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"] = 0;

  if(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"]) {
    var_2 = game["_encstr_991C0AB9ED5B57161FE89B83"];
    var_3 = game["_encstr_B6A70A23CA6659DC91CAE4DC"];
    game["_encstr_991C0AB9ED5B57161FE89B83"] = var_3;
    game["_encstr_B6A70A23CA6659DC91CAE4DC"] = var_2;
  }

  foreach(var_5 in level.teamnamelist) {
    scripts\mp\utility\game::setobjectivetext(var_5, &"_encstr_8EE010A78449A86851292B2A9AF2D2A78A09");

    if(level.splitscreen)
      scripts\mp\utility\game::setobjectivescoretext(var_5, &"_encstr_8EE010A78449A86851292B2A9AF2D2A78A09");
    else
      scripts\mp\utility\game::setobjectivescoretext(var_5, &"_encstr_8F8E16FF96E3C81EFCB35DE5A99D2BD71118994F03575FEF");

    scripts\mp\utility\game::setobjectivehinttext(var_5, &"_encstr_92E0155D08136D63C5096F4F23CD382F7F9B9FB87B999C");
  }

  setclientnamemode("_encstr_B6900C7BCDABC8AF2722B158FA17");
  initspawns();
  seticonnames();
  level createpatharray();
}

initspawns() {
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::setactivespawnlogic("_encstr_8B1608CC43B8D647A113", "_encstr_A6E80F61DA270BDE09B2C8C33B40AB859D");
  scripts\mp\spawnlogic::addstartspawnpoints("_encstr_B8441EF952B9A969398B4820B34763E1E23BE068EE6249500D9FC1B8DB919B51");
  scripts\mp\spawnlogic::addstartspawnpoints("_encstr_B6F91C72201F821FBAB9E7E14586AF4A8B80CAE90B09BC1F561EE41966CB");
  scripts\mp\spawnlogic::addspawnpoints("_encstr_9A8507BA4040188D08", "_encstr_86B21880EB3911D91F6CB0BF7C5F43D91E231089928D7190479B");
  scripts\mp\spawnlogic::addspawnpoints("_encstr_8E8405EA382B2A", "_encstr_B2991628831F33FBA33590AF0FF9E7FB8907B8412FE0A897");
  level.payloadspawnsets = [];
  level.payloadspawnsets["_encstr_9A8507BA4040188D08"] = "_encstr_9A8507BA4040188D08";
  level.payloadspawnsets["_encstr_8E8405EA382B2A"] = "_encstr_8E8405EA382B2A";
  scripts\mp\spawnlogic::registerspawnset("_encstr_9A8507BA4040188D08", "_encstr_86B21880EB3911D91F6CB0BF7C5F43D91E231089928D7190479B");
  scripts\mp\spawnlogic::registerspawnset("_encstr_8E8405EA382B2A", "_encstr_B2991628831F33FBA33590AF0FF9E7FB8907B8412FE0A897");
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

getspawnpoint() {
  var_0 = self.pers["_encstr_8AEF05472BC2D6"];

  if(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"])
    var_0 = scripts\mp\utility\game::getotherteam(var_0)[0];

  if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    var_1 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_B87E12B06AB7823953126F8925CEEA03E2D730A9" + var_0 + "_encstr_B4810709B378B9F3F5");
    var_2 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var_1);
  } else
    var_2 = scripts\mp\spawnscoring::getspawnpoint(self, var_0, level.payloadspawnsets[var_0]);

  return var_2;
}

updategametypedvars() {
  _encstr_97EA20CDB1E44B1C3AB95EB583F2D9B05B95A3F2E056B9CBD8BDB66BF673B8D9CDB1::updatecommongametypedvars();
}

ontimelimit() {
  level scripts\mp\gamescore::giveteamscoreforobjective(scripts\mp\utility\game::getotherteam(level.tank.team)[0], 1, 0);
  thread scripts\mp\gamelogic::endgame(scripts\mp\utility\game::getotherteam(level.tank.team)[0], game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_B40B13237BEFC5278BC385D3C98FEA8518524C203D"]);
}

onnormaldeath(var_0, var_1, var_2, var_3, var_4, var_5) {
  _encstr_97EA20CDB1E44B1C3AB95EB583F2D9B05B95A3F2E056B9CBD8BDB66BF673B8D9CDB1::oncommonnormaldeath(var_0, var_1, var_2, var_3, var_4, var_5);
}

onspawnplayer() {}

spawnbradleypayload() {
  var_0 = level.players[0];
  var_1 = game["_encstr_991C0AB9ED5B57161FE89B83"];
  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", level.tankmovetopath.origin);
  var_2.angles = level.tankmovetopath.angles;
  var_2.team = var_1;
  var_2 setModel("_encstr_821521CEAC0D1C7DB65A8DAFB1E619EB9893BDB5CADEAFB0C6D85ACAB9F5B6C1D747B7");
  var_2 setentityowner(var_0);
  var_2 setotherent(var_0);
  var_3 = undefined;

  if(isDefined(var_0))
    var_3 = var_0 getentitynumber();

  var_4 = (-532.957, -3351.52, 312.255);
  var_5 = (0, 90, 0);
  var_2.owner = var_0;
  var_2.ownerid = var_3;
  var_2.team = var_1;
  var_2 setCanDamage(0);
  var_6 = var_2 gettagorigin("_encstr_99FE0B2B19086F6B9DC5D387E1");
  var_7 = spawnturret("_encstr_97710C6B2DCD1BAF3AD54E4E598E", var_6, "_encstr_ABFC0FCB7B408FEAFE032B03632361E5F8", 0);
  var_7 linkTo(var_2, "_encstr_99FE0B2B19086F6B9DC5D387E1", (0, 0, 0), (0, 0, 0));
  var_7 setModel("_encstr_B87E25682F6B9007594263B721E82FF1D2DD108A6D12500B208A4399C5218769D27F48D6C98BC3");
  var_7.owner = var_0;
  var_7.team = var_1;
  var_7 setmode("_encstr_84FD0F03BB736BB3C36E7AF251911725E0");
  var_7 setsentryowner(undefined);
  var_7 makeunusable();
  var_7 setdefaultdroppitch(0);
  var_7 setCanDamage(0);
  var_7 setturretmodechangewait(1);
  var_2.turret = var_7;
  var_2.isbradley = 1;
  var_7.vehicle = var_2;
  var_7.damageshakeexplosivenum = 0;
  var_7.damageshakebulletnum = 0;
  var_8 = [];
  var_9 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_2.origin, 0, 300, 192);
  var_9 enablelinkTo();
  var_9 linkTo(var_2);
  var_10 = scripts\mp\gameobjects::createuseobject(var_1, var_9, var_8, (0, 0, 90));
  var_10 scripts\mp\gameobjects::allowuse("_encstr_ACFC091AE8AB2FCBE15119");
  var_10 scripts\mp\gameobjects::setusetime(0);
  var_10 scripts\mp\gameobjects::cancontestclaim(1);
  var_10 scripts\mp\gameobjects::mustmaintainclaim(1);
  var_10.onuse = ::tank_onuse;
  var_10.onunoccupied = ::tank_onunoccupied;
  var_10.oncontested = ::tank_oncontested;
  var_10.onuncontested = ::tank_onuncontested;
  var_2.useobj = var_10;
  var_2.damaged = 0;
  var_2.trackedobject = var_2 scripts\mp\gameobjects::createtrackedobject(var_2, (0, 0, 64));
  var_2.trackedobject.objidpingfriendly = 0;
  var_2.trackedobject.objidpingenemy = 1;
  var_2.trackedobject.objpingdelay = 0.05;
  var_2.trackedobject.visibleteam = "_encstr_9A19040BCDBC";
  var_2.invulnerable = 1;
  var_2.trackedobject scripts\mp\gameobjects::setobjectivestatusicons(level.icontarget, level.icontarget);
  level.tank = var_2;
}

bradley_handletacopsdamage(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0.meansofdeath;
  var_4 = var_0.damage;
  var_5 = var_0.idflags;

  if(var_3 == "_encstr_8DED0A21C79B660BC7588981")
    return 0;

  var_4 = scripts\mp\utility\killstreak::getmodifiedantikillstreakdamage(var_1, var_2, var_3, var_4, 3000, 8, 12, 16);
  return var_4;
}

bradley_handlefataltacopsdamage(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0.meansofdeath;
  var_4 = var_0.damage;
  var_5 = var_0.idflags;

  if(level.teambased) {
    var_6 = "_encstr_B40101";

    if(isDefined(var_1) && isDefined(var_1.team))
      var_6 = var_1.team;

    if(var_6 != self.team) {}
  } else if(isDefined(var_1) && (!isDefined(self.owner) || self.owner != var_1)) {}

  thread bradley_vehicledestroy(var_1, var_2, var_3, 0);
}

bradley_vehicledestroy(var_0, var_1, var_2, var_3) {
  self.damaged = 1;
  self notify("_encstr_AF2911281B6689C8DF29F86D01BF514D8DF290");
  var_3 = istrue(var_3);
  self.isdestroyed = 1;
  self setCanDamage(0);
  self.turret setCanDamage(0);
  scripts\mp\utility\print::printboldonteam("_encstr_8D43346B68BFA76A6BC8C2132390E63172C213BE7D71FD36E4B72FCA028E3B9B391FDD8BE890B6C01310EC0841A647439A282AF8944B", "_encstr_9A8507BA4040188D08");
  thread bradley_restorehealth();
}

watchdamagecycle() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AF2911281B6689C8DF29F86D01BF514D8DF290");

  for(;;) {
    self waittill("_encstr_B2BE0788BAF573592F", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);

    if(istrue(self.isrepairing)) {
      continue;
    }
    scripts\engine\utility::_id_143B9(3, "_encstr_B2BE0788BAF573592F");
    self.allowpartialrepairs = 1;
  }
}

bradley_restorehealth() {
  if(!isDefined(self.damagetaken) || self.damagetaken == 0) {
    return;
  }
  if(istrue(self.isrepairing) || !istrue(self.allowpartialrepairs)) {
    return;
  }
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!istrue(self.damaged)) {
    self endon("_encstr_B2BE0788BAF573592F");
    self.allowpartialrepairs = 0;
    var_0 = 0;
    var_1 = 0.2;
    var_2 = 10;
  } else {
    self.isrepairing = 1;
    var_0 = 10;
    var_1 = 0.1;
    var_2 = 100;
  }

  wait(var_0);
  scripts\mp\utility\print::printboldonteam("_encstr_B82512818841C63FDB3BE6E76725AB0E81587A8B", "_encstr_9A8507BA4040188D08");

  while(self.damagetaken != 0) {
    self.damagetaken = max(self.damagetaken - var_2, 0);
    wait(var_1);
  }

  scripts\mp\utility\print::printboldonteam("_encstr_9B3A11BE028A5118F56F82E9E7187183636F15", "_encstr_9A8507BA4040188D08");
  self.isrepairing = 0;
  self setCanDamage(1);
  self.turret setCanDamage(1);
  self.damaged = 0;
  self.isdestroyed = 0;
  thread scripts\mp\damage::monitordamage(3000, "_encstr_B40101", ::bradley_handlefataltacopsdamage, ::bradley_handletacopsdamage, 1);
  self.movementdisabled = 0;
}

tank_onuse(var_0) {
  var_1 = var_0.team;
  var_2 = scripts\mp\gameobjects::getownerteam();
  var_3 = scripts\mp\utility\game::getotherteam(var_1)[0];
  var_4 = gettime();

  if(istrue(self.allowpartialrepairs))
    level.tank thread bradley_restorehealth();

  level thread startmove(level.tank);
  level.usestartspawns = 0;
  var_5 = 0;
  level.tank.trackedobject scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);

  if(!isDefined(level.lastcaptureteam) || level.lastcaptureteam != var_1) {
    var_6 = [];
    var_7 = getarraykeys(self.touchlist[var_1]);

    for(var_8 = 0; var_8 < var_7.size; var_8++)
      var_6[var_7[var_8]] = self.touchlist[var_1][var_7[var_8]];
  }

  level.hpcapteam = var_1;
  scripts\mp\gameobjects::setownerteam(var_1);
  level.lastcaptureteam = var_1;
}

tank_onunoccupied() {
  level notify("_encstr_A29C0FA77BE659D74656B9479CDBE52B91");
  level.hpcapteam = "_encstr_A7A408B9CA5D1D4E2C63";
  var_0 = 1;

  foreach(var_2 in level.teamnamelist) {
    if(self.numtouching[var_2] > 0) {
      var_0 = 0;
      break;
    }
  }

  if(var_0) {
    level.tank.useobj.wasleftunoccupied = 1;
    level.tank.trackedobject scripts\mp\gameobjects::setobjectivestatusicons(level.icontarget);
  }

  self notify("_encstr_9A41107B7B0B72DFA029494A03F8086BED99");
  level.tank moveTo(level.tank.origin, 0.05, 0, 0);
  level.tank rotateTo(level.tank.angles, 1, 0, 0);
}

tank_oncontested() {
  var_0 = level.tank.useobj scripts\mp\gameobjects::getownerteam();
  level.tank.trackedobject scripts\mp\gameobjects::setobjectivestatusicons(level.iconcontested);

  if(var_0 == "_encstr_A7A408B9CA5D1D4E2C63")
    var_1 = self.claimteam;
  else
    var_1 = var_0;

  self notify("_encstr_9A41107B7B0B72DFA029494A03F8086BED99");
  level.tank moveTo(level.tank.origin, 0.05, 0, 0);
}

tank_onuncontested(var_0) {
  var_1 = level.tank.useobj scripts\mp\gameobjects::getownerteam();

  if(var_0 == "_encstr_8BBA05185F8B99" || var_1 == "_encstr_A7A408B9CA5D1D4E2C63")
    level.tank.trackedobject scripts\mp\gameobjects::setobjectivestatusicons(level.icontarget);
  else
    level.tank.trackedobject scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);
}

startmove(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 moveonpath(level.tankmovetopath);
}

createpatharray() {
  level.tankmovetopath = scripts\engine\utility::getStruct("_encstr_95D80A8B5E6650A0139FC9F9", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  thread spawnbradleypayload();
}

getpathstart(var_0, var_1) {
  var_2 = 100;
  var_3 = 150;
  var_4 = (0, var_1, 0);
  var_5 = var_0 + anglesToForward(var_4) * (-1 * var_3);
  var_5 = var_5 + ((randomfloat(2) - 1) * var_2, (randomfloat(2) - 1) * var_2, 0);
  return var_5;
}

moveonpath(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_A70E14FCCFFBD3561967B6E75C5A63A501A77D728803");
  self endon("_encstr_AC9E0F2C80DF7B21A9602F9778800AD259");
  self endon("_encstr_A1B6107257C393B8603921B7A3C899CBAF7D");
  self endon("_encstr_9A41107B7B0B72DFA029494A03F8086BED99");
  self.speed = 100;
  level.tankspeed = self.speed;

  if(istrue(self.damaged)) {
    level.tank moveTo(level.tank.origin, 0.05, 0, 0);
    self notify("_encstr_9A41107B7B0B72DFA029494A03F8086BED99");
  } else {
    var_1 = level.tankmovetopath.origin;
    var_2 = getphysicspointaboutnavmesh(var_1);
    var_3 = distance(self.origin, var_2);

    if(var_3 < 10 && !level.gameended) {
      if(isDefined(level.tankmovetopath.target)) {
        level scripts\mp\gamescore::giveteamscoreforobjective(level.tank.team, 1, 0);
        level.tankmovetopath = scripts\engine\utility::getStruct(level.tankmovetopath.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
        return;
      }

      game["_encstr_A16D07532531CB4BF7"] = "_encstr_A1680AE42B6CF6E48C152A12";
      level scripts\mp\gamescore::giveteamscoreforobjective(level.tank.team, 1, 0);
      thread scripts\mp\gamelogic::endgame(level.tank.team, game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_81221428DB3AE18F03640C9DF12ACFA8885BF0682FCC"]);
      return;
      return;
    }

    var_4 = var_3 / self.speed;
    self moveTo(var_2, var_4, 0, 0);
    self rotateTo((level.tankmovetopath.angles[0], level.tankmovetopath.angles[1], self.angles[2]), 1);
    wait(var_4);
  }
}

getphysicspointaboutnavmesh(var_0) {
  var_1 = scripts\engine\trace::create_contents(undefined, 1, 1, undefined, undefined, undefined, undefined);
  var_2 = physics_raycast(var_0 + (0, 0, 48), var_0 - (0, 0, 48), var_1, undefined, 0, "_encstr_838C158FAC235780CB6F10381FF25AD76A558896473B11");
  var_3 = isDefined(var_2) && var_2.size > 0;

  if(var_3) {
    var_4 = var_2[0]["_encstr_BD260953AA97E3F014279D"];
    return var_4;
  }

  return var_0;
}

seticonnames() {
  level.icontarget = "_encstr_8F511ABB16F2E0DE969B8E7D43584E19E0DB2DCD3AFA8EB039CE95A3";
  level.iconcapture = "_encstr_82FD166339ABDBC568F5446787404AB3D533DA69C00B63FD";
  level.icondefend = "_encstr_BE7610A351B00882DBB5B3279BFE0A5FB09B";
  level.iconcontested = "_encstr_A6C21D1FA7E70AAF8B30C529326FF8C477B827133CBEBAAF085B630BFB4345";
}