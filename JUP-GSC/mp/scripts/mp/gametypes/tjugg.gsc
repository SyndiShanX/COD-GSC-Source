/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\tjugg.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\utility;
#using scripts\mp\class;
#using scripts\mp\equipment\tac_insert;
#using scripts\mp\gameobjects;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\common;
#using scripts\mp\globallogic;
#using scripts\mp\hostmigration;
#using scripts\mp\hud_util;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\playerlogic;
#using scripts\mp\spawnlogic;
#using scripts\mp\spawnscoring;
#using scripts\mp\tweakables;
#using scripts\mp\utility\dialog;
#using scripts\mp\utility\dvars;
#using scripts\mp\utility\entity;
#using scripts\mp\utility\game;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\print;
#using scripts\mp\utility\script;
#using scripts\mp\utility\sound;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\usability;
#using scripts\mp\weapons;
#namespace tjugg;

function main() {
  if(getDvar(@ "g_mapname") == "mp_background") {
    return;
  }

  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  allowed[0] = getgametype();
  scripts\mp\gameobjects::main(allowed);

  if(isusingmatchrulesdata()) {
    level.initializematchrules = &initializematchrules;
    [[level.initializematchrules]]();
    level thread reinitializematchrulesonmigration();
  } else {
    registertimelimitdvar(level.gametype, 10);
    registerroundlimitdvar(level.gametype, 1);
    registerscorelimitdvar(level.gametype, 150);
    registerwinlimitdvar(level.gametype, 1);
    registernumlivesdvar(level.gametype, 0);
    registerhalftimedvar(level.gametype, 0);
    level.juggswitchtime = 90;
  }

  updategametypedvars();
  level.teambased = 1;
  level.doprematch = 1;
  level.onstartgametype = &onstartgametype;
  level.onplayerconnect = &onplayerconnect;
  level.getspawnpoint = &getspawnpoint;
  level.onplayerkilled = &onplayerkilled;
  game["dialog"]["gametype"] = "gametype_tjugg";
  game["dialog"]["boost"] = "boost_tjugg";
  game["dialog"]["offense_obj"] = "boost_tjugg";
  game["dialog"]["defense_obj"] = "boost_tjugg";
}

function initializematchrules() {
  setcommonrulesfrommatchrulesdata();
  setdynamicdvar(@ "hash_5e082608d1c0b076", getmatchrulesdata("tjuggData", "juggHealth"));
  setdynamicdvar(@ "hash_fd08a0be7fb6883d", getmatchrulesdata("tjuggData", "juggSwitchTime"));
  setdynamicdvar(@ "hash_8552c10f4aac8ff", getmatchrulesdata("tjuggData", "ppkAsJugg"));
  setdynamicdvar(@ "hash_66052a303431277a", getmatchrulesdata("tjuggData", "ppkOnJugg"));
  setdynamicdvar(@ "hash_ca1d7e784fc1147d", getmatchrulesdata("tjuggData", "ppkJuggOnJugg"));
  setdynamicdvar(@ "hash_611fcae6caeebe05", 0);
  registerroundswitchdvar("tjugg", 0, 0, 9);
  setdynamicdvar(@ "hash_46632ecea89e2d48", 1);
  registerroundlimitdvar("tjugg", 1);
  setdynamicdvar(@ "hash_71b71a084374019e", 1);
  registerwinlimitdvar("tjugg", 1);
  setdynamicdvar(@ "hash_c3b133abf86e27df", 0);
  registerhalftimedvar("tjugg", 0);
  setdynamicdvar(@ "hash_cfc79c8d140c710d", 0);
  setdynamicdvar(@ "hash_9cadb51d661e162d", 0);
  setdynamicdvar(@ "hash_5d64cd3b24cf883a", 1);
  setdynamicdvar(@ "scr_team_fftype", 0);
  setdynamicdvar(@ "hash_3d9b2dcdb77fe161", 0);
}

function onstartgametype() {
  setclientnamemode("auto_change");

  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  if(game["switchedsides"]) {
    oldattackers = game["attackers"];
    olddefenders = game["defenders"];
    game["attackers"] = olddefenders;
    game["defenders"] = oldattackers;
  }

  setobjectivetext("allies", &"OBJECTIVES/TJUGG");
  setobjectivetext("axis", &"OBJECTIVES/TJUGG");

  if(level.splitscreen) {
    setobjectivescoretext("allies", &"OBJECTIVES/TJUGG");
    setobjectivescoretext("axis", &"OBJECTIVES/TJUGG");
  } else {
    setobjectivescoretext("allies", &"OBJECTIVES/TJUGG_SCORE");
    setobjectivescoretext("axis", &"OBJECTIVES/TJUGG_SCORE");
  }

  setobjectivehinttext("allies", &"OBJECTIVES/TJUGG_HINT");
  setobjectivehinttext("axis", &"OBJECTIVES/TJUGG_HINT");
  initspawns();
  val::group_register("tjugg", ["usability", "killstreaks", "supers"]);
  level.respawnoldjugg_fx = loadfx("vfx/core/expl/bouncing_betty_explosion");
  level.jugg_available = [];
  level.jugg_available["axis"] = 1;
  level.jugg_available["allies"] = 1;
  level.jugg_attackers = [];
  level.jugg_attackers["axis"] = [];
  level.jugg_attackers["allies"] = [];
  level.jugg_currjugg = [];
  level.jugg_currjugg["axis"] = undefined;
  level.jugg_currjugg["allies"] = undefined;
  level.tjugg_timerdisplay = [];
  level.tjugg_timerdisplay["allies"] = createservertimer("objective", 1.4, "allies");
  level.tjugg_timerdisplay["allies"] setpoint("TOPLEFT", "TOPLEFT", 55, 150);
  level.tjugg_timerdisplay["allies"].label = &"MP_JUGG_NEXT_JUGG_IN";
  level.tjugg_timerdisplay["allies"].alpha = 0;
  level.tjugg_timerdisplay["allies"].archived = 0;
  level.tjugg_timerdisplay["allies"].hidewheninmenu = 1;
  level.tjugg_timerdisplay["axis"] = createservertimer("objective", 1.4, "axis");
  level.tjugg_timerdisplay["axis"] setpoint("TOPLEFT", "TOPLEFT", 55, 150);
  level.tjugg_timerdisplay["axis"].label = &"MP_JUGG_NEXT_JUGG_IN";
  level.tjugg_timerdisplay["axis"].alpha = 0;
  level.tjugg_timerdisplay["axis"].archived = 0;
  level.tjugg_timerdisplay["axis"].hidewheninmenu = 1;
  thread hidetimerdisplayongameend(level.tjugg_timerdisplay["allies"]);
  thread hidetimerdisplayongameend(level.tjugg_timerdisplay["axis"]);
  level.favorclosespawnscalar = 5;
}

function updategametypedvars() {
  scripts\mp\gametypes\common::updatecommongametypedvars();
  level.jugghealth = dvarintvalue("juggHealth", 1000, 1000, 10000);
  level.juggswitchtime = dvarfloatvalue("juggSwitchTime", 60, 10, 180);
  level.ppkasjugg = dvarintvalue("ppkAsJugg", 2, 1, 100);
  level.ppkonjugg = dvarintvalue("ppkOnJugg", 5, 1, 100);
  level.ppkjuggonjugg = dvarintvalue("ppkJuggOnJugg", 10, 1, 100);
}

function onplayerconnect(player) {
  player.hasbeenjugg = 0;
  player.jugg_allegiance = 0;
}

function initspawns() {
  level.spawnmins = (2.14748e+09, 2.14748e+09, 2.14748e+09);
  level.spawnmaxs = (-2147483647, -2147483647, -2147483647);

  if(function_bff229a11ecd1e34()) {
    scripts\mp\spawnlogic::setactivespawnlogic(#"default");
  } else {
    scripts\mp\spawnlogic::setactivespawnlogic("Default", "Crit_Frontline");
  }

  scripts\mp\spawnlogic::addstartspawnpoints("mp_tdm_spawn_allies_start");
  scripts\mp\spawnlogic::addstartspawnpoints("mp_tdm_spawn_axis_start");
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn");
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn_secondary", 1, 1);
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn");
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn_secondary", 1, 1);
  scripts\mp\spawnlogic::registerspawnset("normal", "mp_tdm_spawn");
  scripts\mp\spawnlogic::registerspawnset("fallback", "mp_tdm_spawn_secondary");
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

function getspawnpoint() {
  spawnteam = self.pers["team"];

  if(game["switchedsides"]) {
    spawnteam = getotherteam(spawnteam)[0];
  }

  if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    spawnpoints = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_" + spawnteam + "_start");
    spawnpoint = scripts\mp\spawnlogic::getspawnpoint_startspawn(spawnpoints);
  } else {
    spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, "normal", "fallback");

    spawncompare(spawnpoint, spawnteam);
  }

  return spawnpoint;
}

function spawncompare(spawnpoint, spawnteam) {
  if(getdvarint(@ "hash_b5ceec3e3cb419be") != 0) {
    spawnpoints = scripts\mp\spawnlogic::getteamspawnpoints(spawnteam);
    fallbackspawnpoints = [];
    scriptspawnpoint = scripts\mp\spawnscoring::getspawnpoint_legacy(spawnpoints, fallbackspawnpoints);

    if(!isDefined(level.var_3d292942d52b104a)) {
      level.var_3d292942d52b104a = 0;
      level.var_2dc7108159dc1da3 = 0;
      level.var_a065445ba781ddf6 = 0;
    }

    level.var_3d292942d52b104a++;
    println("<dev string:x1c>" + scriptspawnpoint.index + "<dev string:x37>" + scriptspawnpoint.totalscore);

    if(scriptspawnpoint.index == spawnpoint.index) {
      level.var_2dc7108159dc1da3++;
      iprintlnbold("<dev string:x4d>" + level.var_2dc7108159dc1da3 / level.var_3d292942d52b104a * 100 + "<dev string:x6c>" + "<dev string:x7a>" + level.var_2dc7108159dc1da3 + "<dev string:x7f>" + level.var_3d292942d52b104a);
    } else {
      level.var_a065445ba781ddf6++;
      iprintlnbold("<dev string:x84>" + level.var_2dc7108159dc1da3 / level.var_3d292942d52b104a * 100 + "<dev string:x6c>" + "<dev string:x7a>" + level.var_2dc7108159dc1da3 + "<dev string:x7f>" + level.var_3d292942d52b104a);
    }

    return scriptspawnpoint;
  }
}

function onplayerkilled(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, lifeid) {
  if(smeansofdeath == "MOD_SUICIDE" && objweapon.basename == "none" && isDefined(self.wasswitchingteamsforonplayerkilled)) {
    return;
  }

  victim = self;

  if(isDefined(victim.isjuggmodejuggernaut)) {
    if(isDefined(victim.juggoverlay)) {
      victim.juggoverlay destroy();
    }

    victim.playerstreakspeedscale = undefined;
    victim.nostuckdamagekill = 0;
    victim _setsuit("iw9_defaultsuit_mp");
    cleanupobjectiveiconsforjugg(victim);
  }

  if(isDefined(attacker) && isPlayer(attacker)) {
    newjugg = 0;
    givejugg = 0;
    var_9d26360583de8411 = 0;
    var_f2983a5ac513bd5e = 0;
    var_b345478efe9f8796 = 0;
    defendjugg = 0;
    score = 0;

    if(attacker == victim) {
      if(isDefined(victim.isjuggmodejuggernaut)) {
        givejugg = 1;
      }
    } else if(attacker.team != victim.team) {
      if(isDefined(victim.isjuggmodejuggernaut)) {
        givejugg = 1;

        if(isDefined(attacker.isjuggmodejuggernaut)) {
          var_9d26360583de8411 = 1;
        } else {
          var_f2983a5ac513bd5e = 1;
        }
      } else if(isDefined(attacker.isjuggmodejuggernaut)) {
        var_b345478efe9f8796 = 1;
      }

      if(level.jugg_available[attacker.team]) {
        newjugg = 1;
      }
    } else if(isDefined(victim.isjuggmodejuggernaut) && attacker.team == victim.team) {
      victim thread givejuggloadout();
      return;
    }

    if(newjugg) {
      resetjugg(attacker);
    }

    if(givejugg) {
      nextjugg = getbestteammate(victim.team, 0);

      if(!isDefined(nextjugg)) {
        nextjugg = getbestteammate(victim.team, 1);
      }

      if(!isDefined(nextjugg)) {
        nextjugg = victim;
      }

      resetjugg(nextjugg, victim);
    }

    if(newjugg || givejugg) {
      playsoundonplayers("mp_enemy_obj_captured");
    }

    if(attacker != victim && attacker.team != victim.team && !isDefined(attacker.isjuggmodejuggernaut)) {
      if(attacker.hasbeenjugg) {
        attacker.jugg_allegiance += 25;

        if(var_f2983a5ac513bd5e) {
          attacker.jugg_allegiance += 75;
        }

        if(isDefined(level.jugg_attackers[attacker.team][victim.guid])) {
          defendjugg = 1;
          attacker.jugg_allegiance += 50;
          level.jugg_attackers[attacker.team][victim.guid] = undefined;
        }
      } else {
        attacker.jugg_allegiance += 50;

        if(var_f2983a5ac513bd5e) {
          attacker.jugg_allegiance += 100;
        }

        if(isDefined(level.jugg_attackers[attacker.team][victim.guid])) {
          defendjugg = 1;
          attacker.jugg_allegiance += 100;
          level.jugg_attackers[attacker.team][victim.guid] = undefined;
        }
      }
    }

    if(var_f2983a5ac513bd5e) {
      attacker thread function_e3e3e81453fd788b(#"kill_juggernaut");
      score = level.ppkonjugg;
    } else if(var_9d26360583de8411) {
      attacker thread function_e3e3e81453fd788b(#"jugg_on_jugg");
      score = level.ppkjuggonjugg;
    } else if(var_b345478efe9f8796) {
      attacker thread function_e3e3e81453fd788b(#"hash_670456684d1ac92f");
      score = level.ppkasjugg;
    }

    if(score) {
      attacker scripts\mp\gamescore::giveteamscoreforobjective(attacker.pers["team"], score);
    }

    if(attacker.team != victim.team && game["state"] == "postgame" && game["teamScores"][attacker.team] > game["teamScores"][level.otherteam[attacker.team]]) {
      attacker.finalkill = 1;
    }

    return;
  }

  if(isDefined(victim.isjuggmodejuggernaut)) {
    nextjugg = getbestteammate(victim.team, 0);

    if(!isDefined(nextjugg)) {
      nextjugg = getbestteammate(victim.team, 1);
    }

    if(!isDefined(nextjugg)) {
      nextjugg = victim;
    }

    resetjugg(nextjugg, victim);
  }
}

function resetjugg(newjugg, var_a978e1b119c99ae5) {
  if(isDefined(var_a978e1b119c99ae5)) {
    var_a978e1b119c99ae5 notify("lost_juggernaut");
    var_a978e1b119c99ae5.isjuggmodejuggernaut = undefined;
  } else {
    level.jugg_available[newjugg.team] = 0;
  }

  level.jugg_currjugg[newjugg.team] = undefined;
  level.tjugg_timerdisplay[newjugg.team].alpha = 0;
  level.jugg_attackers[newjugg.team] = [];

  foreach(player in level.players) {
    if(player.team == newjugg.team) {
      player.jugg_allegiance = 0;
    }
  }

  newjugg thread givejuggloadout();
}

function givejuggloadout() {
  if(!isreallyalive(self) || isusingremote()) {
    self endon("disconnect");
    thread resetjuggloadoutondisconnect(0);

    while(!isreallyalive(self) || isusingremote()) {
      waitframe();
    }

    self notify("end_resetJuggLoadoutOnDisconnect");
  }

  if(isDefined(self.iscarrying) && self.iscarrying == 1) {
    self notify("force_cancel_placement");
    waitframe();
  }

  while(self ismantling()) {
    waitframe();
  }

  while(!self isonground()) {
    waitframe();
  }

  if(istrue(self.isjuggmodejuggernaut)) {
    self notify("lost_juggernaut");
    waitframe();
  }

  self.isjuggmodejuggernaut = 1;
  level.jugg_currjugg[self.team] = self;
  self.hasbeenjugg = 1;
  scripts\mp\equipment\tac_insert::spawnpoint_setspawnpoint(self.origin, self.angles);
  scripts\mp\class::function_a16868d4dcd81a4b();
  self notify("faux_spawn");
  self.faux_spawn_stance = self getstance();
  thread scripts\mp\playerlogic::spawnplayer(1);
  createjuggobjectiveicon(self);
  thread updatejuggpingorigin();
  self.isjuggernaut = 1;
  self.maxhealth = level.jugghealth;
  self.health = self.maxhealth;
  self.nostuckdamagekill = 1;
  scripts\mp\class::loadout_clearweapons(1);
  val::group_set("tjugg", 0);
  weapon = scripts\cp_mp\weapon::buildweapon("iw8_lm_kilo121", ["holo"], "none", "none", -1);
  self giveweapon(weapon);
  forcevalidweapon(weapon);
  weapon = scripts\cp_mp\weapon::buildweapon("iw8_la_rpapa7", [], "none", "none", -1);
  self giveweapon(weapon);
  self givemaxammo(weapon);
  giveperk("specialty_stun_resistance");
  giveperk("specialty_sharp_focus");
  _setsuit("iw9_juggernaut_mp");
  self.playerstreakspeedscale = -0.2;
  scripts\mp\weapons::updatemovespeedscale();
  self.juggoverlay = newclienthudelem(self);
  self.juggoverlay.x = 0;
  self.juggoverlay.y = 0;
  self.juggoverlay.alignx = "left";
  self.juggoverlay.aligny = "top";
  self.juggoverlay.horzalign = "fullscreen";
  self.juggoverlay.vertalign = "fullscreen";
  self.juggoverlay setshader("gasmask_overlay_delta", 640, 480);
  self.juggoverlay.sort = -10;
  self.juggoverlay.archived = 1;
  self.juggoverlay.alpha = 1;
  self.friendlyoutlineid = outlineenableforteam(self, self.team, "outlinefill_nodepth_cyan", "killstreak");
  thread resetjuggloadoutondisconnect(1);
  thread resetjuggloadoutonchangeteam();
  thread rewardteammateproximity();
  thread logattackers();

  if(level.juggswitchtime != 0) {
    thread nextjuggtimeout();
  }
}

function nextjuggtimeout() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  level.tjugg_timerdisplay[self.team].label = &"MP_JUGG_NEXT_JUGG_IN";
  level.tjugg_timerdisplay[self.team] settimer(level.juggswitchtime);
  level.tjugg_timerdisplay[self.team].alpha = 1;
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(level.juggswitchtime);
  level.tjugg_timerdisplay[self.team].alpha = 0;
  newjugg = getbestteammate(self.team, 0);

  if(!isDefined(newjugg)) {
    newjugg = getbestteammate(self.team, 1);
  }

  if(!isDefined(newjugg)) {
    newjugg = self;
  }

  playsoundonplayers("mp_enemy_obj_captured");
  resetjugg(newjugg, self);

  if(newjugg != self) {
    thread respawnoldjugg();
  }
}

function respawnoldjugg() {
  level endon("game_ended");
  self endon("disconnect");

  while(!isreallyalive(self) || isusingremote()) {
    waitframe();
  }

  if(isDefined(self.iscarrying) && self.iscarrying == 1) {
    self notify("force_cancel_placement");
    waitframe();
  }

  scripts\mp\equipment\tac_insert::spawnpoint_setspawnpoint(self.origin, self.angles);
  playFX(level.respawnoldjugg_fx, self.origin);
  self notify("lost_juggernaut");
  waitframe();

  while(!self isonground()) {
    waitframe();
  }

  self notify("faux_spawn");

  if(isDefined(self.juggoverlay)) {
    self.juggoverlay destroy();
  }

  self.faux_spawn_stance = self getstance();
  self.playerstreakspeedscale = undefined;
  self.isjuggernaut = 0;
  self.nostuckdamagekill = 0;
  outlinedisable(self.friendlyoutlineid, self);
  self.maxhealth = scripts\mp\tweakables::gettweakablevalue("player", "maxhealth");
  thread scripts\mp\playerlogic::spawnplayer(1);
  _setsuit("iw9_defaultsuit_mp");
  scripts\mp\weapons::updatemovespeedscale();
  cleanupobjectiveiconsforjugg(self);
}

function rewardteammateproximity() {
  level endon("game_ended");
  self endon("death_or_disconnect");

  while(true) {
    wait 1;

    foreach(player in level.players) {
      if(isreallyalive(player) && !player isusingremote() && player != self && player.team == self.team && distancesquared(player.origin, self.origin) < 48400) {
        if(player.hasbeenjugg) {
          player.jugg_allegiance += 15;
          continue;
        }

        player.jugg_allegiance += 25;
      }
    }
  }
}

function logattackers() {
  level endon("game_ended");
  self endon("death_or_disconnect");

  while(true) {
    self waittill("damage", amount, attacker);

    if(isPlayer(attacker) && attacker.team != self.team) {
      if(!isDefined(level.jugg_attackers[self.team][attacker.guid])) {
        level.jugg_attackers[self.team][attacker.guid] = 1;
      }
    }
  }
}

function resetjuggloadoutondisconnect(endondeath) {
  level endon("game_ended");

  if(endondeath) {
    self endon("death");
  } else {
    self endon("end_resetJuggLoadoutOnDisconnect");
  }

  team = self.team;
  self waittill("disconnect");
  newjugg = getbestteammate(team, 0);

  if(!isDefined(newjugg)) {
    newjugg = getbestteammate(team, 1);
  }

  if(isDefined(newjugg)) {
    playsoundonplayers("mp_enemy_obj_captured");
    resetjugg(newjugg);
    return;
  }

  level.jugg_available[team] = 1;
  level.jugg_currjugg[team] = undefined;
  level.tjugg_timerdisplay[team].alpha = 0;
  level.jugg_attackers[team] = [];

  foreach(player in level.players) {
    if(player.team == team) {
      player.jugg_allegiance = 0;
    }
  }
}

function resetjuggloadoutonchangeteam() {
  level endon("game_ended");
  self endon("disconnect");
  team = self.team;
  waittill_any_2("joined_team", "joined_spectators");
  self.isjuggmodejuggernaut = undefined;
  newjugg = getbestteammate(team, 0);

  if(!isDefined(newjugg)) {
    newjugg = getbestteammate(team, 1);
  }

  if(isDefined(newjugg)) {
    playsoundonplayers("mp_enemy_obj_captured");
    resetjugg(newjugg);
    return;
  }

  level.jugg_available[team] = 1;
  level.jugg_currjugg[team] = undefined;
  level.tjugg_timerdisplay[team].alpha = 0;
  level.jugg_attackers[team] = [];

  foreach(player in level.players) {
    if(player.team == team) {
      player.jugg_allegiance = 0;
    }
  }
}

function getbestteammate(team, allowremote) {
  bestteammate = undefined;
  var_e21b54d8672d06a = -1;

  foreach(player in level.players) {
    if((allowremote || !player isusingremote()) && player != self && player.team == team && player.jugg_allegiance > var_e21b54d8672d06a) {
      bestteammate = player;
      var_e21b54d8672d06a = player.jugg_allegiance;
    }
  }

  return bestteammate;
}

function hidetimerdisplayongameend(timerdisplay) {
  level waittill("game_ended");
  timerdisplay.alpha = 0;
}

function createjuggobjectiveicon(juggplayer) {
  objid = scripts\mp\objidpoolmanager::requestobjectiveid(99);
  juggplayer.juggobjid = objid;
  juggplayer.offset3d = (0, 0, 90);
  juggplayer.visibleteam = "any";
  juggplayer.ownerteam = juggplayer.team;
  scripts\mp\objidpoolmanager::objective_add_objective(objid, "current", juggplayer.origin, "hud_icon_minimap_killstreak_juggernaut");
  scripts\mp\objidpoolmanager::objective_set_play_intro(objid, 0);
  scripts\mp\objidpoolmanager::objective_set_play_outro(objid, 0);
  scripts\mp\objidpoolmanager::objective_playermask_showtoall(objid);
  scripts\mp\objidpoolmanager::update_objective_onentity(objid, juggplayer);
  scripts\mp\objidpoolmanager::update_objective_setzoffset(objid, juggplayer.offset3d[2]);
  objective_setownerteam(objid, juggplayer.team);
  objective_setfriendlylabel(objid, "MP_INGAME_ONLY/OBJ_DEFEND_CAPS");
  objective_setenemylabel(objid, "MP_INGAME_ONLY/OBJ_KILL_CAPS");
}

function cleanupobjectiveiconsforjugg(juggplayer) {
  scripts\mp\objidpoolmanager::returnobjectiveid(juggplayer.juggobjid);
  juggplayer.juggobjid = undefined;
}

function updatejuggcurorigin() {
  self endon("death_or_disconnect");
  self endon("lost_juggernaut");

  while(true) {
    self.curorigin = self.origin + (0, 0, 90);
    waitframe();
  }
}

function updatejuggpingorigin() {
  self endon("death_or_disconnect");
  self endon("lost_juggernaut");
  thread updatejuggcurorigin();

  if(!isDefined(self.objpingdelay)) {
    self.objpingdelay = 4;
  }

  for(;;) {
    foreach(teamname in level.teamnamelist) {
      if(!scripts\mp\gameobjects::isfriendlyteam(teamname)) {
        objective_setpingsforteam(self.juggobjid, teamname);
        objective_ping(self.juggobjid);
      }
    }

    waittill_any_timeout_no_endon_death_1(self.objpingdelay);
  }
}

function setspecialloadouts() {
  level.tjugg_loadouts["default"]["loadoutArchetype"] = "archetype_assault";
  level.tjugg_loadouts["default"]["loadoutPrimary"] = "iw8_lm_kilo121";
  level.tjugg_loadouts["default"]["loadoutPrimaryAttachment"] = "none";
  level.tjugg_loadouts["default"]["loadoutPrimaryAttachment2"] = "none";
  level.tjugg_loadouts["default"]["loadoutPrimaryCamo"] = "none";
  level.tjugg_loadouts["default"]["loadoutPrimaryReticle"] = "none";
  level.tjugg_loadouts["default"]["loadoutSecondary"] = "iw8_la_rpapa7";
  level.tjugg_loadouts["default"]["loadoutSecondaryAttachment"] = "none";
  level.tjugg_loadouts["default"]["loadoutSecondaryAttachment2"] = "none";
  level.tjugg_loadouts["default"]["loadoutSecondaryCamo"] = "none";
  level.tjugg_loadouts["default"]["loadoutSecondaryReticle"] = "none";
  level.tjugg_loadouts["default"]["loadoutMeleeSlot"] = "iw9_me_fists_mp_ls";
  level.tjugg_loadouts["default"]["loadoutEquipmentPrimary"] = "equip_frag";
  level.tjugg_loadouts["default"]["loadoutEquipmentSecondary"] = "equip_smoke";
  level.tjugg_loadouts["default"]["loadoutStreakType"] = "assault";
  level.tjugg_loadouts["default"]["loadoutKillstreak1"] = "none";
  level.tjugg_loadouts["default"]["loadoutKillstreak2"] = "none";
  level.tjugg_loadouts["default"]["loadoutKillstreak3"] = "none";
  level.tjugg_loadouts["default"]["loadoutSuper"] = "none";
  level.tjugg_loadouts["default"]["loadoutPerks"] = ["specialty_scavenger", "specialty_blastshield"];
  level.tjugg_loadouts["default"]["loadoutGesture"] = "playerData";
}