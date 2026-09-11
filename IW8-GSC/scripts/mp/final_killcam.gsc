/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\final_killcam.gsc
***********************************************/

function initfinalkillcam() {
  level.finalkillcamenabled = level.finalkillcamtype == 0;
  level.finalkillcams = [];

  foreach(var1 in level.teamnamelist) {
    level.finalkillcams[var1] = undefined;
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
  for(var0 = 0; var0 < level.teamnamelist.size; var0++) {
    level.finalkillcams[level.teamnamelist[var0]] = undefined;
  }

  level.finalkillcams["none"] = undefined;
  level.finalkillcam_winner = undefined;
}

function preloadfinalkillcam() {
  var0 = undefined;

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
    var1 = level.finalkillcams[level.finalkillcam_winner];

    if(!isDefined(var1)) {
      scripts\mp\flags::levelflagset("final_killcam_preloaded");
      return;
    }

    var0 = var1.attacker;
  } else {
    var2 = gettime();

    while(!scripts\mp\potg::issystemfinalized()) {
      waitframe();
    }

    if(scripts\mp\potg::shouldskippotg() == 0) {
      var3 = scripts\mp\potg::getfinalpotginfo();

      if(!isDefined(var3)) {
        scripts\mp\flags::levelflagset("final_killcam_preloaded");
        return;
      }

      var0 = var3.spectateentity;
    } else {
      level.potgenabled = 0;
      level.finalkillcamtype = 0;
      level.finalkillcamenabled = 1;
      var1 = level.finalkillcams[level.finalkillcam_winner];

      if(!isDefined(var1)) {
        scripts\mp\flags::levelflagset("final_killcam_preloaded");
        return;
      }

      var0 = var1.attacker;
    }
  }

  if(!isDefined(var0) || !isPlayer(var0)) {
    scripts\mp\flags::levelflagset("final_killcam_preloaded");
    return;
  }

  var4 = var0 getEye();

  foreach(var6 in level.players) {
    var6 loadcustomizationplayerview(var0);
    var6 predictstreampos(var4, 1);
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

  foreach(var1 in level.players) {
    thread dopotgkillcamforplayer();
  }

  for(;;) {
    var3 = 0;

    foreach(var1 in level.players) {
      if(istrue(var1.inpotgkillcam)) {
        var3 = 1;
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
  var0 = scripts\mp\potg::getfinalpotginfo();

  if(!isDefined(var0) || !isDefined(var0.spectateentity)) {
    potgkillcamover();
    return;
  }

  thread scripts\mp\killcam::potg_killcam(var0.spectateentity, var0.psoffsettime, var0.starttime, var0.endtime);
  var1 = scripts\engine\utility::ref_143b4("begin_killcam", "killcam_ended");

  if(var1 == "killcam_ended") {
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
  var0 = "none";

  if(isDefined(level.finalkillcam_winner)) {
    var0 = level.finalkillcam_winner;
  }

  var1 = level.finalkillcams[var0];

  if(!isDefined(var1)) {
    level.showingfinalkillcam = 0;
    return 0;
  }

  var2 = var1.attacker;
  var3 = var1.victim;

  if(!isDefined(var3) || !isDefined(var2)) {
    level.showingfinalkillcam = 0;
    return 0;
  }

  var4 = 20;
  var5 = scripts\mp\utility\game::getsecondspassed() - var1.timerecorded;

  if(var5 > var4) {
    level.showingfinalkillcam = 0;
    return 0;
  }

  level thread scripts\cp\vehicles\vehicle_compass_cp::processfinalkillchallenges(var2, var3);
  var6 = (gettime() - var3.deathtime) / 1000;
  setglobalsoundcontext("atmosphere", "killcam", 0.1);
  level.maxkillcamdelay = 0;

  foreach(var8 in level.players) {
    var8 scripts\mp\utility\player::restorebasevisionset(0);
    var8.killcamentitylookat = var3 getentitynumber();
    var8 scripts\mp\damage::updatedeathdetails(var1.attackers, var1.attackerdata, var2);

    if(!scripts\mp\utility\weapon::iskillstreakweapon(var1.objweapon.basename)) {
      var8 scripts\mp\killcam::setkillcamnormalweaponomnvars(var1.objweapon, var1.smeansofdeath, var1.einflictor, var1.executionref);
    }

    var8 setclientomnvar("post_game_state", 3);
    var8 setclientomnvar("ui_killcam_victim_or_attacker", 1);
    var8 playlocalsound("final_killcam_in");
    var8 setclienttriggeraudiozonepartial("killcam", "mix");
    var8 thread scripts\mp\killcam::dokillcamfromstruct(var1, var6, 0, 1);
  }

  wait 0.15 + level.maxkillcamdelay;

  while(anyplayersinkillcam()) {
    waitframe();
  }

  level.showingfinalkillcam = 0;
}

function play_patrol_sequence_based_on_first_vehicle() {
  self notify("showing_final_killcam");
  var0 = 1;
  var1 = self.killcamlength - 0.5;

  if(getDvar("scr_br_gametype", "") == "kingslayer") {
    var0 = 0;
    var1 = 0;
  }

  thread scripts\mp\utility\game::setuipostgamefade(var0, var1);
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

function recordfinalkillcam(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10) {
  if(!scripts\mp\potg::shouldskippotg()) {
    return;
  }

  var11 = spawnStruct();

  if(isDefined(var4) && isagent(var4)) {
    var11.agent_type = var4.agent_type;
    var11.lastspawntime = var4.lastspawntime;
  }

  var12 = scripts\mp\killcam::makekillcamdata(var4, var11, var3, var5, var6, var1 getentitynumber(), var7, var8, var9, 12, var2, var1, var10, var2.pers["loadoutPerks"], 0, 1);
  var12.timerecorded = scripts\mp\utility\game::getsecondspassed();

  if(var10 == "MOD_EXECUTION") {
    var12.timerecorded -= 3;
    var12.timerecorded = max(0, var12.timerecorded);
  }

  var12.attackers = var1.attackers;
  var12.attackerdata = var1.attackerdata;

  if(level.teambased && isDefined(var2.team)) {
    level.finalkillcams[var2.team] = var12;
  } else if(!level.teambased) {
    level.finalkillcams[var2.guid] = var12;
  }

  level.finalkillcams["none"] = var12;
}

function waitskipkillcambuttonduringdeathtimer() {
  self endon("disconnect");
  self endon("killcam_death_done_waiting");
  self notifyonplayercommand("death_respawn", "+usereload");
  self notifyonplayercommand("death_respawn", "+activate");
  self waittill("death_respawn");
  self notify("killcam_death_button_cancel");
}

function waitskipkillcamduringdeathtimer(var0) {
  self endon("disconnect");
  self endon("killcam_death_button_cancel");
  wait var0;
  self notify("killcam_death_done_waiting");
}

function skipkillcamduringdeathtimer(var0) {
  self endon("disconnect");

  if(level.showingfinalkillcam) {
    return false;
  }

  if(!isai(self)) {
    thread waitskipkillcambuttonduringdeathtimer();
    thread waitskipkillcamduringdeathtimer(var0);
    var1 = scripts\engine\utility::ref_143ad("killcam_death_done_waiting", "killcam_death_button_cancel");

    if(isDefined(var1) && var1 == "killcam_death_done_waiting") {
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
  foreach(var1 in level.players) {
    if(isDefined(var1.killcam)) {
      return true;
    }
  }

  return false;
}