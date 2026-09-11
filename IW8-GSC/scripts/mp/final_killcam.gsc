/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\final_killcam.gsc
***********************************************/

function initfinalkillcam() {
  level.finalkillcamenabled = level.finalkillcamtype == 0;
  level.finalkillcams = [];

  foreach(var_1 in level.teamnamelist) {
    level.finalkillcams[var_1] = undefined;
  }

  level.finalkillcams["none"] = undefined;
  level.finalkillcam_winner = undefined;
  level.recordfinalkillcam = 1;

  if(scripts\mp\utility\game::getgametype() == "br") {
    level.finalkillcamenabled = 1;
    return;
  }
}

function erasefinalkillcam() {
  for(var_0 = 0; var_0 < level.teamnamelist.size; var_0++) {
    level.finalkillcams[level.teamnamelist[var_0]] = undefined;
  }

  level.finalkillcams["none"] = undefined;
  level.finalkillcam_winner = undefined;
}

function preloadfinalkillcam() {
  var_0 = undefined;

  if(istrue(level.nukedetonated)) {
    return;
  }

  if(istrue(level.disable_back_light)) {
    return;
  }

  if(getdvarint("scr_game_skip_final_killcam", 0) == 1) {
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
      scripts\mp\flags::levelflagset("final_killcam_preloaded");
      return;
    }

    var_0 = var_1.attacker;
  } else {
    var_2 = gettime();

    while(!scripts\mp\potg::issystemfinalized()) {
      waitframe();
    }

    if(scripts\mp\potg::shouldskippotg() == 0) {
      var_3 = scripts\mp\potg::getfinalpotginfo();

      if(!isDefined(var_3)) {
        scripts\mp\flags::levelflagset("final_killcam_preloaded");
        return;
      }

      var_0 = var_3.spectateentity;
    } else {
      level.potgenabled = 0;
      level.finalkillcamtype = 0;
      level.finalkillcamenabled = 1;
      var_1 = level.finalkillcams[level.finalkillcam_winner];

      if(!isDefined(var_1)) {
        scripts\mp\flags::levelflagset("final_killcam_preloaded");
        return;
      }

      var_0 = var_1.attacker;
    }
  }

  if(!isDefined(var_0) || !isPlayer(var_0)) {
    scripts\mp\flags::levelflagset("final_killcam_preloaded");
    return;
  }

  var_4 = var_0 getEye();

  foreach(var_6 in level.players) {
    var_6 loadcustomizationplayerview(var_0);
    var_6 predictstreampos(var_4, 1);
  }

  if(level.potgenabled) {
    wait 1;
  }

  scripts\mp\flags::levelflagset("final_killcam_preloaded");
}

function dopotgkillcam() {
  if(istrue(level.skipfinalkillcam) || istrue(level.nukedetonated)) {
    return;
  }

  level.showingfinalkillcam = 1;
  level.maxkillcamdelay = 0;

  foreach(var_1 in level.players) {
    thread dopotgkillcamforplayer();
  }

  for(;;) {
    var_3 = 0;

    foreach(var_1 in level.players) {
      if(istrue(var_1.inpotgkillcam)) {
        var_3 = 1;
        break;
      }
    }

    waitframe();
  }

  LOC_0000009e:
    level.showingfinalkillcam = 0;
}

function dopotgkillcamforplayer() {
  self endon("disconnect");
  self.inpotgkillcam = 1;
  scripts\mp\utility\player::restorebasevisionset(0);
  self setclientomnvar("post_game_state", 4);
  var_0 = scripts\mp\potg::getfinalpotginfo();

  if(!isDefined(var_0) || !isDefined(var_0.spectateentity)) {
    potgkillcamover();
    return;
  }

  thread scripts\mp\killcam::potg_killcam(var_0.spectateentity, var_0.psoffsettime, var_0.starttime, var_0.endtime);
  var_1 = scripts\engine\utility::ref_143b4("begin_killcam", "killcam_ended");

  if(var_1 == "killcam_ended") {
    potgkillcamover();
    return;
  }

  thread scripts\mp\utility\game::setuipostgamefade(1, self.killcamlength - 0.5);
  self waittill("killcam_ended");
  potgkillcamover();
}

function potgkillcamover() {
  self setclientomnvar("post_game_state", 1);
  self.inpotgkillcam = 0;
}

function dofinalkillcam() {
  if(!level.finalkillcamenabled) {
    return 0;
  }

  if(istrue(level.skipfinalkillcam) || istrue(level.nukedetonated)) {
    return 0;
  }

  level.showingfinalkillcam = 1;
  var_0 = "none";

  if(isDefined(level.finalkillcam_winner)) {
    var_0 = level.finalkillcam_winner;
  }

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
  setglobalsoundcontext("atmosphere", "killcam", 0.1);
  level.maxkillcamdelay = 0;

  foreach(var_8 in level.players) {
    var_8 scripts\mp\utility\player::restorebasevisionset(0);
    var_8.killcamentitylookat = var_3 getentitynumber();
    var_8 scripts\mp\damage::updatedeathdetails(var_1.attackers, var_1.attackerdata, var_2);

    if(!scripts\mp\utility\weapon::iskillstreakweapon(var_1.objweapon.basename)) {
      var_8 scripts\mp\killcam::setkillcamnormalweaponomnvars(var_1.objweapon, var_1.smeansofdeath, var_1.einflictor, var_1.executionref);
    }

    var_8 setclientomnvar("post_game_state", 3);
    var_8 setclientomnvar("ui_killcam_victim_or_attacker", 1);
    var_8 playlocalsound("final_killcam_in");
    var_8 setclienttriggeraudiozonepartial("killcam", "mix");
    var_8 thread scripts\mp\killcam::dokillcamfromstruct(var_1, var_6, 0, 1);
  }

  wait 0.15 + level.maxkillcamdelay;

  while(anyplayersinkillcam()) {
    waitframe();
  }

  level.showingfinalkillcam = 0;
}

function play_patrol_sequence_based_on_first_vehicle() {
  self notify("showing_final_killcam");
  var_0 = 1;
  var_1 = self.killcamlength - 0.5;

  if(getDvar("scr_br_gametype", "") == "kingslayer") {
    var_0 = 0;
    var_1 = 0;
  }

  thread scripts\mp\utility\game::setuipostgamefade(var_0, var_1);
  self setclientomnvar("post_game_state", 3);
  thread watchplaybackend();
}

function watchplaybackend() {
  self endon("killcam_canceled");
  self waittill("killcam_ended");
  setglobalsoundcontext("atmosphere", "", 0.5);

  if(scripts\mp\utility\game::getgametype() != "arena") {
    self playlocalsound("final_killcam_out");
  }

  self clearclienttriggeraudiozone(4);
  thread scripts\mp\playerlogic::spawnendofgame();
}

function recordfinalkillcam(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(!scripts\mp\potg::shouldskippotg()) {
    return;
  }

  var_11 = spawnStruct();

  if(isDefined(var_4) && isagent(var_4)) {
    var_11.agent_type = var_4.agent_type;
    var_11.lastspawntime = var_4.lastspawntime;
  }

  var_12 = scripts\mp\killcam::makekillcamdata(var_4, var_11, var_3, var_5, var_6, var_1 getentitynumber(), var_7, var_8, var_9, 12, var_2, var_1, var_10, var_2.pers["loadoutPerks"], 0, 1);
  var_12.timerecorded = scripts\mp\utility\game::getsecondspassed();

  if(var_10 == "MOD_EXECUTION") {
    var_12.timerecorded -= 3;
    var_12.timerecorded = max(0, var_12.timerecorded);
  }

  var_12.attackers = var_1.attackers;
  var_12.attackerdata = var_1.attackerdata;

  if(level.teambased && isDefined(var_2.team)) {
    level.finalkillcams[var_2.team] = var_12;
  } else if(!level.teambased) {
    level.finalkillcams[var_2.guid] = var_12;
  }

  level.finalkillcams["none"] = var_12;
}

function waitskipkillcambuttonduringdeathtimer() {
  self endon("disconnect");
  self endon("killcam_death_done_waiting");
  self notifyonplayercommand("death_respawn", "+usereload");
  self notifyonplayercommand("death_respawn", "+activate");
  self waittill("death_respawn");
  self notify("killcam_death_button_cancel");
}

function waitskipkillcamduringdeathtimer(var_0) {
  self endon("disconnect");
  self endon("killcam_death_button_cancel");
  wait var_0;
  self notify("killcam_death_done_waiting");
}

function skipkillcamduringdeathtimer(var_0) {
  self endon("disconnect");

  if(level.showingfinalkillcam) {
    return false;
  }

  if(!isai(self)) {
    thread waitskipkillcambuttonduringdeathtimer();
    thread waitskipkillcamduringdeathtimer(var_0);
    var_1 = scripts\engine\utility::ref_143ad("killcam_death_done_waiting", "killcam_death_button_cancel");

    if(isDefined(var_1) && var_1 == "killcam_death_done_waiting") {
      self.skippedkillcam = 0;
      return false;
    } else {
      self.skippedkillcam = 1;
      scripts\mp\utility\stats::incpersstat("skippedKillcams", 1);
      return true;
    }
  }

  return false;
}

function anyplayersinkillcam() {
  foreach(var_1 in level.players) {
    if(isDefined(var_1.killcam)) {
      return true;
    }
  }

  return false;
}