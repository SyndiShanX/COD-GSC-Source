/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\final_killcam.gsc
***********************************************/

initfinalkillcam() {
  level.finalkillcamenabled = level.finalkillcamtype == 0;
  level.finalkillcams = [];

  foreach(var_1 in level.teamnamelist)
  level.finalkillcams[var_1] = undefined;

  level.finalkillcams["_encstr_8BBA05185F8B99"] = undefined;
  level.finalkillcam_winner = undefined;
  level.recordfinalkillcam = 1;

  if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB") {
    level.finalkillcamenabled = 1;
    return;
  }
}

erasefinalkillcam() {
  for(var_0 = 0; var_0 < level.teamnamelist.size; var_0++)
    level.finalkillcams[level.teamnamelist[var_0]] = undefined;

  level.finalkillcams["_encstr_8BBA05185F8B99"] = undefined;
  level.finalkillcam_winner = undefined;
}

preloadfinalkillcam() {
  var_0 = undefined;

  if(istrue(level.nukedetonated)) {
    return;
  }
  if(istrue(level.disable_back_light)) {
    return;
  }
  if(getdvarint("_encstr_8E7E1CD7BF13983B211DE1BE8203384779037B654F1A40587135C8312EFD", 0) == 1) {
    return;
  }
  if(istrue(level.skipfinalkillcam)) {
    return;
  }
  if(level.potgenabled) {
    if(scripts\mp\potg::shouldskippotg()) {
      level.potgenabled = 0;
      level.finalkillcamtype = 0;
      level.finalkillcamenabled = 1;
    }
  }

  if(level.finalkillcamenabled) {
    var_1 = level.finalkillcams[level.finalkillcam_winner];

    if(!isDefined(var_1)) {
      scripts\mp\flags::levelflagset("_encstr_937618B027EE51A181B4D3694D7A839877DB98D05BB7E979CA9F");
      return;
    }

    var_0 = var_1.attacker;
  } else {
    var_2 = gettime();

    while(!scripts\mp\potg::issystemfinalized())
      waitframe();

    if(scripts\mp\potg::shouldskippotg() == 0) {
      var_3 = scripts\mp\potg::getfinalpotginfo();

      if(!isDefined(var_3)) {
        scripts\mp\flags::levelflagset("_encstr_937618B027EE51A181B4D3694D7A839877DB98D05BB7E979CA9F");
        return;
      }

      var_0 = var_3.spectateentity;
    } else {
      level.potgenabled = 0;
      level.finalkillcamtype = 0;
      level.finalkillcamenabled = 1;
      var_1 = level.finalkillcams[level.finalkillcam_winner];

      if(!isDefined(var_1)) {
        scripts\mp\flags::levelflagset("_encstr_937618B027EE51A181B4D3694D7A839877DB98D05BB7E979CA9F");
        return;
      }

      var_0 = var_1.attacker;
    }
  }

  if(!isDefined(var_0) || !isPlayer(var_0)) {
    scripts\mp\flags::levelflagset("_encstr_937618B027EE51A181B4D3694D7A839877DB98D05BB7E979CA9F");
    return;
  }

  var_4 = var_0 getEye();

  foreach(var_6 in level.players) {
    var_6 loadcustomizationplayerview(var_0);
    var_6 predictstreampos(var_4, 1);
  }

  if(level.potgenabled)
    wait 1.0;

  scripts\mp\flags::levelflagset("_encstr_937618B027EE51A181B4D3694D7A839877DB98D05BB7E979CA9F");
}

dopotgkillcam() {
  if(istrue(level.skipfinalkillcam) || istrue(level.nukedetonated)) {
    return;
  }
  level.showingfinalkillcam = 1;
  level.maxkillcamdelay = 0.0;

  foreach(var_1 in level.players)
  var_1 thread dopotgkillcamforplayer();

  for(;;) {
    var_3 = 0;

    foreach(var_1 in level.players) {
      if(istrue(var_1.inpotgkillcam)) {
        var_3 = 1;
        break;
      }
    }

    if(!var_3) {
      break;
    }

    waitframe();
  }

  level.showingfinalkillcam = 0;
}

dopotgkillcamforplayer() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self.inpotgkillcam = 1;
  scripts\mp\utility\player::restorebasevisionset(0);
  self setclientomnvar("_encstr_8F221028C7DFA391C4B9557B8FB3B3584DF0", 4);
  var_0 = scripts\mp\potg::getfinalpotginfo();

  if(!isDefined(var_0) || !isDefined(var_0.spectateentity)) {
    potgkillcamover();
    return;
  }

  thread scripts\mp\killcam::potg_killcam(var_0.spectateentity, var_0.psoffsettime, var_0.starttime, var_0.endtime);
  var_1 = scripts\engine\utility::_id_143B4("_encstr_8D860E6955CFC7F01712F863A25F2FC8", "_encstr_84BC0E804AC539896F9D584D6683B1E1");

  if(var_1 == "_encstr_84BC0E804AC539896F9D584D6683B1E1") {
    potgkillcamover();
    return;
  }

  thread scripts\mp\utility\game::setuipostgamefade(1.0, self.killcamlength - 0.5);
  self waittill("_encstr_84BC0E804AC539896F9D584D6683B1E1");
  potgkillcamover();
}

potgkillcamover() {
  self setclientomnvar("_encstr_8F221028C7DFA391C4B9557B8FB3B3584DF0", 1);
  self.inpotgkillcam = 0;
}

dofinalkillcam() {
  if(!level.finalkillcamenabled)
    return 0;

  if(istrue(level.skipfinalkillcam) || istrue(level.nukedetonated))
    return 0;

  level.showingfinalkillcam = 1;
  var_0 = "_encstr_8BBA05185F8B99";

  if(isDefined(level.finalkillcam_winner))
    var_0 = level.finalkillcam_winner;

  var_1 = level.finalkillcams[var_0];

  if(!isDefined(var_1)) {
    level.showingfinalkillcam = 0;
    return 0;
  }

  var_2 = var_1.attacker;
  var_3 = var_1.victim;

  if(!isDefined(var_3) || !isDefined(var_2)) {
    level.showingfinalkillcam = 0;
    return 0;
  }

  var_4 = 20;
  var_5 = scripts\mp\utility\game::getsecondspassed() - var_1.timerecorded;

  if(var_5 > var_4) {
    level.showingfinalkillcam = 0;
    return 0;
  }

  level thread scripts\cp\vehicles\vehicle_compass_cp::processfinalkillchallenges(var_2, var_3);
  var_6 = (gettime() - var_3.deathtime) / 1000;
  setglobalsoundcontext("_encstr_BAD20BF19B6F6048D2A00B5DD5", "_encstr_8A130803D3E8D3869B38", 0.1);
  level.maxkillcamdelay = 0.0;

  foreach(var_8 in level.players) {
    var_8 scripts\mp\utility\player::restorebasevisionset(0);
    var_8.killcamentitylookat = var_3 getentitynumber();
    var_8 scripts\mp\damage::updatedeathdetails(var_1.attackers, var_1.attackerdata, var_2);

    if(!scripts\mp\utility\weapon::iskillstreakweapon(var_1.objweapon.basename))
      var_8 scripts\mp\killcam::setkillcamnormalweaponomnvars(var_1.objweapon, var_1.smeansofdeath, var_1.einflictor, var_1.executionref);

    var_8 setclientomnvar("_encstr_8F221028C7DFA391C4B9557B8FB3B3584DF0", 3);
    var_8 setclientomnvar("_encstr_A7A01E7B97BFA01A382102A1CDC7987B58EB425B97F57E8F1353FB5FFB920373", 1);
    var_8 playlocalsound("_encstr_8BF5111238AD36DB8EEA313C7151B77DA7401A");
    var_8 setclienttriggeraudiozonepartial("_encstr_8A130803D3E8D3869B38", "_encstr_AB1904853B28");
    var_8 thread scripts\mp\killcam::dokillcamfromstruct(var_1, var_6, 0, 1);
  }

  wait(0.15 + level.maxkillcamdelay);

  while(anyplayersinkillcam())
    waitframe();

  level.showingfinalkillcam = 0;
}

play_patrol_sequence_based_on_first_vehicle() {
  self notify("_encstr_938516CD0DBDBB96379DEBCCA59B2C8D7D5BA5B1638D16DA");
  var_0 = 1.0;
  var_1 = self.killcamlength - 0.5;

  if(getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_B18D0B5281530117EDEAC82033") {
    var_0 = 0;
    var_1 = 0;
  }

  thread scripts\mp\utility\game::setuipostgamefade(var_0, var_1);
  self setclientomnvar("_encstr_8F221028C7DFA391C4B9557B8FB3B3584DF0", 3);
  thread watchplaybackend();
}

watchplaybackend() {
  self endon("_encstr_958F11AD5AD836D8855BBE6C0B378D95B12B19");
  self waittill("_encstr_84BC0E804AC539896F9D584D6683B1E1");
  setglobalsoundcontext("_encstr_BAD20BF19B6F6048D2A00B5DD5", "_encstr_B40101", 0.5);

  if(scripts\mp\utility\game::getgametype() != "_encstr_A9B606B0C956B916")
    self playlocalsound("_encstr_A6D41233B49B858DFAAD2D63B1D816D6EBBDBAA3");

  self clearclienttriggeraudiozone(4);
  thread scripts\mp\playerlogic::spawnendofgame();
}

recordfinalkillcam(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(!scripts\mp\potg::shouldskippotg()) {
    return;
  }
  var_11 = spawnStruct();

  if(isDefined(var_4) && isagent(var_4)) {
    var_11.agent_type = var_4.agent_type;
    var_11.lastspawntime = var_4.lastspawntime;
  }

  var_12 = scripts\mp\killcam::makekillcamdata(var_4, var_11, var_3, var_5, var_6, var_1 getentitynumber(), var_7, var_8, var_9, 12, var_2, var_1, var_10, var_2.pers["_encstr_86CB0DFB97F7022F90BB3A7F53487B"], 0, 1);
  var_12.timerecorded = scripts\mp\utility\game::getsecondspassed();

  if(var_10 == "_encstr_AA230E8CF56CD18DB12FC7E303C8C001") {
    var_12.timerecorded = var_12.timerecorded - 3.0;
    var_12.timerecorded = max(0, var_12.timerecorded);
  }

  var_12.attackers = var_1.attackers;
  var_12.attackerdata = var_1.attackerdata;

  if(level.teambased && isDefined(var_2.team))
    level.finalkillcams[var_2.team] = var_12;
  else if(!level.teambased)
    level.finalkillcams[var_2.guid] = var_12;

  level.finalkillcams["_encstr_8BBA05185F8B99"] = var_12;
}

waitskipkillcambuttonduringdeathtimer() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AFE71B5B96C6D836C26BFA2395B0E8A1D732F69B56F5BBC2D2D1B4DCCE");
  self notifyonplayercommand("_encstr_B4E80ED172A6DC4C5EBB1B2642C09775", "_encstr_97410B23BD6B976233901AF2F8");
  self notifyonplayercommand("_encstr_B4E80ED172A6DC4C5EBB1B2642C09775", "_encstr_B4C60AD707B2BDC0E6CE1309");
  self waittill("_encstr_B4E80ED172A6DC4C5EBB1B2642C09775");
  self notify("_encstr_81331CD48BF084B6A80D5994D2A9191AF19A6B51749FC86727F708D2E26D");
}

waitskipkillcamduringdeathtimer(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_81331CD48BF084B6A80D5994D2A9191AF19A6B51749FC86727F708D2E26D");
  wait(var_0);
  self notify("_encstr_AFE71B5B96C6D836C26BFA2395B0E8A1D732F69B56F5BBC2D2D1B4DCCE");
}

skipkillcamduringdeathtimer(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(level.showingfinalkillcam)
    return 0;

  if(!isai(self)) {
    thread waitskipkillcambuttonduringdeathtimer();
    thread waitskipkillcamduringdeathtimer(var_0);
    var_1 = scripts\engine\utility::_id_143AD("_encstr_AFE71B5B96C6D836C26BFA2395B0E8A1D732F69B56F5BBC2D2D1B4DCCE", "_encstr_81331CD48BF084B6A80D5994D2A9191AF19A6B51749FC86727F708D2E26D");

    if(isDefined(var_1) && var_1 == "_encstr_AFE71B5B96C6D836C26BFA2395B0E8A1D732F69B56F5BBC2D2D1B4DCCE") {
      self.skippedkillcam = 0;
      return 0;
    } else {
      self.skippedkillcam = 1;
      scripts\mp\utility\stats::incpersstat("_encstr_9365101BA7930358C5F98289A408DB3A4858", 1);
      return 1;
    }
  }

  return 0;
}

anyplayersinkillcam() {
  foreach(var_1 in level.players) {
    if(isDefined(var_1.killcam))
      return 1;
  }

  return 0;
}