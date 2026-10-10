/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\killstreaks\supply_sweep.gsc
******************************************************/

#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\cp_mp\killstreaks\killstreakdeploy;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\utility;
#using scripts\mp\flags;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\hud_util;
#using scripts\mp\killstreaks\killstreaks;
#using scripts\mp\killstreaks\supply_sweep;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;
#namespace supply_sweep;

function autoexec main() {
  level thread init();
}

function init() {
  while(!isDefined(level.killstreaksetups)) {
    wait 1;
  }

  waitframe();
  scripts\mp\killstreaks\killstreaks::registerkillstreak("supply_sweep", &scripts\mp\killstreaks\supply_sweep::function_9770267c5fb4f3b3);
  initdialog();
  level thread initteamdata();
  level.var_ea7c6955bb1589bd = &function_94e49d4aa7d532a2;
}

function initdialog() {
  game["dialog"]["supply_sweep_start"] = "trials_killstreak_supplysweep_start";
  game["dialog"]["supply_sweep_end"] = "trials_killstreak_supplysweep_end";
}

function initteamdata() {
  waitframe();
  scripts\mp\flags::gameflagwait("prematch_fade_done");

  for(i = 0; i < level.teamnamelist.size; i++) {
    level.teamdata[level.teamnamelist[i]]["activeSupplySweeps"] = [];
    level.teamdata[level.teamnamelist[i]]["supplySweepEndTime"] = 0;
    level.teamdata[level.teamnamelist[i]]["numSupplySweepKillstreakStarted"] = 0;
  }
}

function function_9770267c5fb4f3b3(streakinfo) {
  level endon("game_ended");
  self endon("disconnect");
  useresult = undefined;

  if(istrue(level.var_975b837a4ffa005e)) {
    useresult = "KILLSTREAKS/AUAVSCAN_IN_PROGRESS";
  } else if(istrue(self.hasradar)) {
    useresult = "KILLSTREAKS/UAV_SCAN_IN_PROGRESS";
  }

  if(isDefined(useresult)) {
    if(issharedfuncdefined("hud", "showErrorMessage")) {
      self[[getsharedfunc("hud", "showErrorMessage")]](useresult);
    }

    return false;
  }

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](streakinfo)) {
      return false;
    }
  }

  playgestureresult = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_dogesturedeploy(streakinfo, makeweapon("ks_gesture_phone_mp"));

  if(!istrue(playgestureresult)) {
    return false;
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](streakinfo)) {
      return false;
    }
  }

  level thread function_cb5055ef9503457f(self, streakinfo);
  return true;
}

function function_f881c4e02a77d4d7(streakinfo) {
  level endon("game_ended");
  self endon("disconnect");

  if(!istrue(streakinfo.var_f7e9b63a09d59e0c)) {
    deployweapon = "ks_gesture_generic_mp";
    deployresult = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_dogesturedeploy(streakinfo, makeweapon(deployweapon));

    if(!istrue(deployresult)) {
      return false;
    }
  }

  return true;
}

function function_cb5055ef9503457f(owner, streakinfo, isnonkillstreak, var_e1d15925155200c8) {
  team = owner.team;
  assertex(array_contains(level.teamnamelist, team), "<dev string:x1c>" + team + "<dev string:x25>");
  assertex(isDefined(level.teamdata[team]["<dev string:x41>"]), "<dev string:x57>" + team + "<dev string:x6d>");
  function_c8f5936c729fe30e(team);

  if(!istrue(isnonkillstreak)) {
    function_5ea457cbcc4810ed(owner, team, streakinfo);
  }

  var_84b4dd2d6d918790 = getdvarint(@ "hash_ae6a45f480e3b2dc", 20);

  if(istrue(var_e1d15925155200c8)) {
    var_84b4dd2d6d918790 = getdvarint(@ "hash_ff52cdafc5178625", 20);
  }

  var_cd8090039a345a6e = 0;

  if(isDefined(level.teamdata[team]["activeSupplySweeps"])) {
    var_cd8090039a345a6e = level.teamdata[team]["activeSupplySweeps"].size > 0;
  }

  if(istrue(var_e1d15925155200c8) && var_cd8090039a345a6e) {
    return;
  }

  effectendtime = undefined;

  if(var_cd8090039a345a6e) {
    effectendtime = level.teamdata[team]["supplySweepEndTime"] + var_84b4dd2d6d918790 * 1000;
  } else {
    effectendtime = gettime() + var_84b4dd2d6d918790 * 1000;
  }

  level.teamdata[team]["activeSupplySweeps"] = array_add(level.teamdata[team]["activeSupplySweeps"], streakinfo);
  level.teamdata[team]["supplySweepEndTime"] = effectendtime;
  allteammembers = getteamdata(team, "players");

  foreach(player in allteammembers) {
    if(isDefined(player) && !player scripts\mp\gametypes\br_public::playeriszombie()) {
      player function_c682f38a22ea89d6(1);
      player playsoundtoplayer("activate_supply_sweep", player);
    }
  }

  var_d90d9ac30239347e = level.teamdata[team]["activeSupplySweeps"].size >= 3;
  function_bf750a843caf9b55(var_d90d9ac30239347e, team);
  secondstowait = max((effectendtime - gettime()) / 1000, 0.1);
  waittill_any_timeout_1(secondstowait, "game_ended");
  level.teamdata[team]["activeSupplySweeps"] = array_remove(level.teamdata[team]["activeSupplySweeps"], streakinfo);
  var_d90d9ac30239347e = level.teamdata[team]["activeSupplySweeps"].size >= 3;
  function_bf750a843caf9b55(var_d90d9ac30239347e, team);
  var_23d218ec402fc01c = level.teamdata[team]["activeSupplySweeps"].size == 0;

  if(var_23d218ec402fc01c) {
    allteammembers = getteamdata(team, "players");

    foreach(player in allteammembers) {
      if(isDefined(player)) {
        player function_c682f38a22ea89d6(0);
      }
    }
  } else {
    while(!var_23d218ec402fc01c && !level.gameended) {
      effectendtime = level.teamdata[team]["supplySweepEndTime"];
      secondstowait = max((effectendtime - gettime()) / 1000, 0.1);
      waittill_any_timeout_1(secondstowait, "game_ended");
      var_23d218ec402fc01c = level.teamdata[team]["activeSupplySweeps"].size == 0;
    }
  }

  if(!istrue(isnonkillstreak)) {
    function_5541a7c0f6747c86(owner, team, streakinfo);
  }
}

function function_5ea457cbcc4810ed(owner, team, streakinfo) {
  assertex(isDefined(team), "<dev string:xa0>");

  if(issharedfuncdefined("killstreak", "logKillstreakEvent")) {
    self[[getsharedfunc("killstreak", "logKillstreakEvent")]](streakinfo.streakname, owner.origin);
  }

  if(issharedfuncdefined("hud", "teamPlayerCardSplash")) {
    level thread[[getsharedfunc("hud", "teamPlayerCardSplash")]]("used_supply_sweep", owner);
  }

  if(!istrue(level.gameended)) {
    function_2617455bebb5944(team, "supply_sweep_start");
  }

  level.teamdata[team]["numSupplySweepKillstreakStarted"]++;
}

function function_5541a7c0f6747c86(owner, team, streakinfo) {
  assertex(isDefined(team), "<dev string:xd1>");
  level.teamdata[team]["numSupplySweepKillstreakStarted"]--;

  if(level.teamdata[team]["numSupplySweepKillstreakStarted"] == 0 && !istrue(level.gameended)) {
    function_2617455bebb5944(team, "supply_sweep_end");
  }

  level callback::callback("killstreak_finish_use", {
    #streakinfo: streakinfo
  });

  if(isDefined(owner) && !istrue(level.recordedgameendstats)) {
    owner scripts\cp_mp\utility\killstreak_utility::recordkillstreakendstats(streakinfo);
  }

  if(issharedfuncdefined("player", "printGameAction")) {
    [[getsharedfunc("player", "printGameAction")]]("killstreak ended - " + streakinfo.streakname, owner);
  }
}

function function_5a93fbbb0fd1f33e() {
  player = self;
  return !istrue(level.var_975b837a4ffa005e) && !istrue(player.hasradar);
}

function function_8192e9b94c7be3a6(player) {
  if(!player function_5a93fbbb0fd1f33e()) {
    return false;
  }

  streakinfo = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("supply_sweep", player);
  level thread function_cb5055ef9503457f(player, streakinfo, 1, 0);
  return true;
}

function function_94e49d4aa7d532a2() {
  foreach(name, team in level.teamdata) {
    foreach(teammate in level.teamdata[name]["alivePlayers"]) {
      if(isreallyalive(teammate) && !teammate scripts\mp\gametypes\br_public::isplayerinorgoingtogulag()) {
        streakinfo = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("supply_sweep", teammate);
        level thread function_cb5055ef9503457f(teammate, streakinfo, 1, 1);
        break;
      }
    }
  }
}

function function_bf750a843caf9b55(isenabled, team) {
  allteammembers = getteamdata(team, "players");

  foreach(player in allteammembers) {
    if(isDefined(player) && !player scripts\mp\gametypes\br_public::playeriszombie()) {
      player function_ef7982d1f82e7a51(isenabled);
    }
  }
}

function function_c8f5936c729fe30e(team) {
  level notify("jump_master_supply_sweep_stop" + team);
  allteammembers = getteamdata(team, "players");

  foreach(player in allteammembers) {
    if(isDefined(player)) {
      player function_6d446993dd36bb41(0);
    }
  }
}

function function_2617455bebb5944(team, dialog) {
  if(istrue(level.disableannouncer)) {
    return;
  }

  if(!isDefined(game["dialog"][dialog])) {
    println("<dev string:x100>" + dialog + "<dev string:x10b>");
    return;
  }

  soundname = "dx_bra_pilo_" + game["dialog"][dialog];
  teamplayers = level.teamdata[team]["players"];

  foreach(player in teamplayers) {
    thread function_4138f41eac3bb46f(soundname, dialog, player, 1, 0);
  }
}

function function_4138f41eac3bb46f(soundname, dialog, player, var_a64cad1ecc519617, allowdead, delay) {
  level endon("game_ended");

  if(!isDefined(player)) {
    return;
  }

  player endon("death_or_disconnect");

  if(!isalive(player) && !istrue(allowdead)) {
    return;
  }

  if(player scripts\mp\gametypes\br_public::modeplayerskipdialog(dialog, var_a64cad1ecc519617)) {
    return;
  }

  if(isDefined(soundname)) {
    soundname = tolower(soundname);
    soundlength = lookupsoundlength(soundname, 1) / 1000;

    if(isDefined(delay)) {
      wait delay;
    }

    player queuedialogforplayer(soundname, dialog, soundlength);
  }
}