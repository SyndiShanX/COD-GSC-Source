/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\final_killcam.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\utility;
#using scripts\mp\damage;
#using scripts\mp\flags;
#using scripts\mp\killcam;
#using scripts\mp\playerlogic;
#using scripts\mp\potg;
#using scripts\mp\utility\game;
#using scripts\mp\utility\player;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\weapon;
#namespace final_killcam;

function initfinalkillcam() {
  level.finalkillcamenabled = level.finalkillcamtype == 0;
  level.finalkillcams = [];

  foreach(teamname in level.teamnamelist) {
    level.finalkillcams[teamname] = undefined;
  }

  level.finalkillcams["none"] = undefined;
  level.finalkillcam_winner = undefined;
  level.recordfinalkillcam = 1;

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    level.finalkillcamenabled = 1;
    return;
  }
}

function erasefinalkillcam() {
  for(i = 0; i < level.teamnamelist.size; i++) {
    level.finalkillcams[level.teamnamelist[i]] = undefined;
  }

  level.finalkillcams["none"] = undefined;
  level.finalkillcam_winner = undefined;
}

function preloadfinalkillcam() {
  spectateentity = undefined;

  if(istrue(level.nukeinfo.detonated)) {
    return;
  }

  if(istrue(level.brdisablefinalkillcam)) {
    return;
  }

  if(getdvarint(@ "hash_166b51bf7450fc22", 0) == 1) {
    return;
  }

  if(istrue(level.skipfinalkillcam)) {
    return;
  }

  assertex(level.finalkillcamenabled || level.potgenabled, "<dev string:x1c>");

  if(level.potgenabled) {
    if(scripts\mp\potg::shouldskippotg()) {
      level.potgenabled = 0;
      level.finalkillcamtype = 0;
      level.finalkillcamenabled = 1;
    }
  }

  killcamstruct = undefined;

  if(level.finalkillcamenabled) {
    killcamstruct = level.finalkillcams[level.finalkillcam_winner];

    if(!isDefined(killcamstruct)) {
      scripts\mp\flags::levelflagset("final_killcam_preloaded");
      return;
    }

    spectateentity = killcamstruct.attacker;
  } else {
    assert(level.potgenabled);
    waitstarttime = gettime();

    while(!scripts\mp\potg::issystemfinalized()) {
      waitframe();
    }

    if(scripts\mp\potg::shouldskippotg() == 0) {
      potginfo = scripts\mp\potg::getfinalpotginfo();

      if(!isDefined(potginfo)) {
        scripts\mp\flags::levelflagset("final_killcam_preloaded");
        return;
      }

      spectateentity = potginfo.spectateentity;
    } else {
      level.potgenabled = 0;
      level.finalkillcamtype = 0;
      level.finalkillcamenabled = 1;
      killcamstruct = level.finalkillcams[level.finalkillcam_winner];

      if(!isDefined(killcamstruct)) {
        scripts\mp\flags::levelflagset("final_killcam_preloaded");
        return;
      }

      spectateentity = killcamstruct.attacker;
    }
  }

  if(!isDefined(spectateentity) || !isPlayer(spectateentity)) {
    scripts\mp\flags::levelflagset("final_killcam_preloaded");
    return;
  }

  if(isDefined(killcamstruct) && isDefined(killcamstruct.streampos)) {
    var_b2d56fe9c46fb7b4 = killcamstruct.streampos;
  } else {
    var_b2d56fe9c46fb7b4 = spectateentity getEye();
  }

  foreach(player in level.players) {
    player loadcustomizationplayerview(spectateentity);
    player predictstreamposuntilcleared(var_b2d56fe9c46fb7b4);
  }

  if(level.potgenabled) {
    wait 1;
  }

  scripts\mp\flags::levelflagset("final_killcam_preloaded");
}

function dopotgkillcam() {
  if(istrue(level.skipfinalkillcam) || istrue(level.nukeinfo.detonated)) {
    return;
  }

  level.showingfinalkillcam = 1;
  level.maxkillcamdelay = 0;

  foreach(player in level.players) {
    player thread dopotgkillcamforplayer();
  }

  while(true) {
    anyplayersinkillcam = 0;

    foreach(player in level.players) {
      if(istrue(player.inpotgkillcam)) {
        anyplayersinkillcam = 1;
        break;
      }
    }

    if(!anyplayersinkillcam) {
      break;
    }

    waitframe();
  }

  level.showingfinalkillcam = 0;
}

function dopotgkillcamforplayer() {
  self endon("disconnect");
  self.inpotgkillcam = 1;
  restorebasevisionset(0);
  self setclientomnvar("post_game_state", 4);
  potginfo = scripts\mp\potg::getfinalpotginfo();

  if(!isDefined(potginfo) || !isDefined(potginfo.spectateentity)) {
    potgkillcamover();
    return;
  }

  thread scripts\mp\killcam::potg_killcam(potginfo.spectateentity, potginfo.psoffsettime, potginfo.starttime, potginfo.endtime);
  result = waittill_any_return_no_endon_death_2("begin_killcam", "killcam_ended");

  if(result == "killcam_ended") {
    potgkillcamover();
    return;
  }

  thread setuipostgamefade(1, self.killcamlength - 0.5);
  self waittill("killcam_ended");
  potgkillcamover();
}

function potgkillcamover() {
  self setclientomnvar("post_game_state", 1);
  self.inpotgkillcam = 0;
}

function dofinalkillcam() {
  assertex(level.finalkillcamenabled, "<dev string:x7b>");

  if(!level.finalkillcamenabled) {
    return 0;
  }

  if(istrue(level.skipfinalkillcam) || istrue(level.nukeinfo.detonated)) {
    return 0;
  }

  level.showingfinalkillcam = 1;
  winner = "none";

  if(isDefined(level.finalkillcam_winner)) {
    winner = level.finalkillcam_winner;
  }

  killcamstruct = level.finalkillcams[winner];

  if(!isDefined(killcamstruct)) {
    level.showingfinalkillcam = 0;
    return 0;
  }

  attacker = killcamstruct.attacker;
  victim = killcamstruct.victim;

  if(!isDefined(victim) || !isDefined(attacker)) {
    level.showingfinalkillcam = 0;
    return 0;
  }

  var_16abe9498a90c7bf = 20;
  killcamoffsettime = getsecondspassed() - killcamstruct.timerecorded;

  if(killcamoffsettime > var_16abe9498a90c7bf) {
    level.showingfinalkillcam = 0;
    return 0;
  }

  level thread scripts\cp_mp\challenges::processfinalkillchallenges(attacker, victim);
  postdeathdelay = (gettime() - victim.deathtime) / 1000;
  setglobalsoundcontext("atmosphere", "killcam", 0.1);
  level.maxkillcamdelay = 0;

  foreach(player in level.players) {
    player restorebasevisionset(0);
    player.killcamentitylookat = victim getentitynumber();
    player scripts\mp\damage::updatedeathdetails(killcamstruct.attackers, killcamstruct.attackerdata, attacker);

    if(!iskillstreakweapon(killcamstruct.objweapon.basename)) {
      player scripts\mp\killcam::setkillcamnormalweaponomnvars(killcamstruct.objweapon, killcamstruct.smeansofdeath, killcamstruct.einflictor, killcamstruct.executionref, killcamstruct.attacker);
    }

    if(istrue(level.var_262278c955a4e742)) {
      player thread scripts\mp\killcam::dokillcamfromstruct(killcamstruct, postdeathdelay, 0, 0);
      continue;
    }

    player thread scripts\mp\killcam::dokillcamfromstruct(killcamstruct, postdeathdelay, 0, 1);
  }

  wait 0.15 + level.maxkillcamdelay;
  level thread waitanyplayersinkillcam();
  level waittill_notify_or_timeout("waitAnyPlayersInKillcam", 15);
  level notify("timeoutAnyPlayersInKillcam");
  level.showingfinalkillcam = 0;
}

function waitanyplayersinkillcam() {
  level endon("timeoutAnyPlayersInKillcam");

  while(anyplayersinkillcam()) {
    waitframe();
  }

  level notify("waitAnyPlayersInKillcam");
}

function finalkillcamplaybackbegin() {
  self notify("showing_final_killcam");
  thread setuipostgamefade(1, self.killcamlength - 0.5);
  self setclientomnvar("post_game_state", 3);
  thread watchplaybackend();
}

function watchplaybackend() {
  self endon("killcam_canceled");
  self waittill("killcam_ended");
  setglobalsoundcontext("atmosphere", "", 0.5);

  if(getgametype() != "arena") {
    self playlocalsound("final_killcam_out");
  }

  self clearclienttriggeraudiozone(4);
  thread scripts\mp\playerlogic::spawnendofgame();
}

function recordfinalkillcam(delay, victim, attacker, attackernum, einflictor, killcamentityindex, killcamentitystarttime, var_f2d4e6802c5d8473, objweapon, psoffsettime, smeansofdeath) {
  if(!scripts\mp\potg::shouldskippotg()) {
    return;
  }

  inflictoragentinfo = spawnStruct();

  if(isDefined(einflictor) && isagent(einflictor)) {
    inflictoragentinfo.agent_type = einflictor.agent_type;
    inflictoragentinfo.lastspawntime = einflictor.lastspawntime;

    if(!isDefined(inflictoragentinfo.lastspawntime)) {
      inflictoragentinfo.lastspawntime = einflictor.spawntime;
    }

    assert(isDefined(inflictoragentinfo.lastspawntime), "<dev string:xab>");
  }

  perkarray = [];

  foreach(perk in attacker.pers["loadoutPerks"]) {
    perkarray[perkarray.size] = perk;
  }

  if(isDefined(attacker.var_15f3e6df722fb1cf)) {
    perkarray[perkarray.size] = attacker.var_15f3e6df722fb1cf;
  }

  if(isDefined(attacker.var_15f3e5df722faf9c)) {
    perkarray[perkarray.size] = attacker.var_15f3e5df722faf9c;
  }

  killcamstruct = scripts\mp\killcam::makekillcamdata(einflictor, inflictoragentinfo, attackernum, killcamentityindex, killcamentitystarttime, victim getentitynumber(), var_f2d4e6802c5d8473, objweapon, psoffsettime, 12, attacker, victim, smeansofdeath, perkarray, 0, 1);
  killcamstruct.timerecorded = getsecondspassed();

  if(smeansofdeath == "MOD_EXECUTION" || smeansofdeath == "MOD_MELEE_TAKEDOWN") {
    killcamstruct.timerecorded -= 3;
    killcamstruct.timerecorded = max(0, killcamstruct.timerecorded);
  }

  killcamstruct.attackers = victim.attackers;
  killcamstruct.attackerdata = victim.attackerdata;

  if(level.teambased && isDefined(attacker.team)) {
    level.finalkillcams[attacker.team] = killcamstruct;
  } else if(!level.teambased) {
    level.finalkillcams[attacker.guid] = killcamstruct;
  }

  level.finalkillcams["none"] = killcamstruct;
}

function waitskipkillcambuttonduringdeathtimer() {
  self endon("disconnect");
  self endon("killcam_death_done_waiting");
  self notifyonplayercommand("death_respawn", "+usereload");
  self notifyonplayercommand("death_respawn", "+activate");
  self waittill("death_respawn");
  self notify("killcam_death_button_cancel");
}

function waitskipkillcamduringdeathtimer(waittime) {
  self endon("disconnect");
  self endon("killcam_death_button_cancel");
  wait waittime;
  self notify("killcam_death_done_waiting");
}

function skipkillcamduringdeathtimer(waittime) {
  if(!isDefined(self)) {
    return false;
  }

  self endon("disconnect");

  if(level.showingfinalkillcam) {
    return false;
  }

  if(!isai(self)) {
    thread waitskipkillcambuttonduringdeathtimer();
    thread waitskipkillcamduringdeathtimer(waittime);
    result = waittill_any_return_2("killcam_death_done_waiting", "killcam_death_button_cancel");

    if(!isDefined(self)) {
      return false;
    }

    if(isDefined(result) && result == "killcam_death_done_waiting") {
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
  foreach(player in level.players) {
    if(isDefined(player.killcam)) {
      return true;
    }
  }

  return false;
}