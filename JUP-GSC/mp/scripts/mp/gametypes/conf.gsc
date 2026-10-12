/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\conf.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\codcasterclientmatchdata;
#using scripts\mp\equipment\temp_v;
#using scripts\mp\gameobjects;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\common;
#using scripts\mp\gametypes\mgl_mp;
#using scripts\mp\globallogic;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\killstreaks\killstreaks;
#using scripts\mp\spawnlogic;
#using scripts\mp\utility\dialog;
#using scripts\mp\utility\disconnect_event_aggregator;
#using scripts\mp\utility\dvars;
#using scripts\mp\utility\game;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\perk_shared;
#using scripts\mp\utility\points;
#using scripts\mp\utility\spawn_event_aggregator;
#using scripts\mp\utility\stats;
#namespace conf;

function main() {
  if(getDvar(@ "g_mapname") == "mp_background") {
    return;
  }

  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();

  if(isjuggermoshgamemode()) {
    level.var_29ed825c4a9a052c = scripts\mp\utility\game::function_9a59855eebf296b6();
  }

  allowed[0] = getgametype();
  scripts\mp\gameobjects::main(allowed);

  if(isusingmatchrulesdata()) {
    level.initializematchrules = &initializematchrules;
    [[level.initializematchrules]]();
    level thread reinitializematchrulesonmigration();
  } else {
    registerroundswitchdvar(getgametype(), 0, 0, 9);
    registertimelimitdvar(getgametype(), 600);
    registerscorelimitdvar(getgametype(), 65);
    registerroundlimitdvar(getgametype(), 1);
    registerwinlimitdvar(getgametype(), 1);
    registernumlivesdvar(getgametype(), 0);
    registerhalftimedvar(getgametype(), 0);
    registerdogtagsenableddvar(getgametype(), 1);
  }

  updategametypedvars();
  level.teambased = 1;
  level.onstartgametype = &onstartgametype;
  level.var_952bd6e10104d8a = &function_952bd6e10104d8a;
  level.getspawnpoint = &getspawnpoint;
  level.onnormaldeath = &onnormaldeath;
  level.modeonspawnplayer = &onspawnplayer;
  level.delayleadtakendialog = 0.25;

  if(scripts\cp_mp\utility\game_utility::function_21322da268e71c19()) {
    game["dialog"]["gametype"] = "dx_mp_kchc_mode_t141_name";
  } else {
    game["dialog"]["gametype"] = "dx_mp_kill_game_uktl_name";
  }

  if(function_75eb145bbb9d4d95()) {
    game["dialog"]["gametype"] = "dx_mp_mtow_mode_t141_name";
  }

  game["dialog"]["boost"] = "dx_mp_kill_game_uktl_bost";
  game["dialog"]["offense_obj"] = "dx_mp_kill_game_uktl_bost";
  game["dialog"]["defense_obj"] = "dx_mp_kill_game_uktl_bost";
  game["dialog"]["kill_confirmed"] = "dx_mp_kill_game_uktl_kcnf";
  game["dialog"]["hint_tags"] = "dx_mp_kill_game_uktl_htag";
  level.conf_fx["vanish"] = loadfx("vfx/core/impacts/small_snowhit");

  if(function_acfcdd7f0c4401ca()) {
    level.var_c26d962ddc188b43 = 1;
    level.wrapkillstreaks = 1;
    level.onplayerkilled = &onplayerkilled;
    scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(&onplayerdisconnect);
  }

  if(scripts\cp_mp\utility\game_utility::ismagellanmode()) {
    scripts\mp\gametypes\mgl_mp::function_47e2a0de1d6b6115();
  }

  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(&onplayerspawn);
}

function initializematchrules() {
  setcommonrulesfrommatchrulesdata();
  setdynamicdvar(@ "scr_conf_pointsperconfirm", getmatchrulesdata("confData", "pointsPerConfirm"));
  setdynamicdvar(@ "hash_2db4a6681a9b932", getmatchrulesdata("confData", "pointsPerDeny"));
  setdynamicdvar(@ "scr_conf_killstreakconfirmed", getmatchrulesdata("confData", "killstreakConfirmed"));
  setdynamicdvar(@ "hash_8412d62137fbce7a", 0);
  registerhalftimedvar("conf", 0);
  setdynamicdvar(@ "hash_1952d99344f2932a", 0);
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

  foreach(entry in level.teamnamelist) {
    setobjectivetext(entry, &"OBJECTIVES/CONF");

    if(level.splitscreen) {
      setobjectivescoretext(entry, &"OBJECTIVES/CONF");
    } else {
      setobjectivescoretext(entry, &"OBJECTIVES/CONF_SCORE");
    }

    setobjectivehinttext(entry, &"OBJECTIVES/CONF_HINT");
  }

  initspawns();
  level.dogtagallyonusecb = &dogtagallyonusecb;
  level.dogtagenemyonusecb = &dogtagenemyonusecb;

  if(function_75eb145bbb9d4d95()) {
    halfscore = int(getscorelimit() / 2);

    foreach(team in level.teamnamelist) {
      function_2a5a687f57c9caa6(team, halfscore);
    }
  }

  thread function_c878e93998246855();
}

function private function_952bd6e10104d8a() {
  if(istrue(level.killstreakconfirmed)) {
    setDvar(@ "hash_cf1c084c7a6622f9", 0);
  }
}

function initspawns() {
  if(function_bff229a11ecd1e34()) {
    scripts\mp\spawnlogic::setactivespawnlogic(#"default");
  } else if(getdvarint(@ "t10", 0) > 0) {
    scripts\mp\spawnlogic::setactivespawnlogic("Default", "Crit_Default");
  } else {
    scripts\mp\spawnlogic::setactivespawnlogic("Default", "Crit_Frontline");
  }

  level.spawnmins = (2.14748e+09, 2.14748e+09, 2.14748e+09);
  level.spawnmaxs = (-2147483647, -2147483647, -2147483647);
  scripts\mp\spawnlogic::addstartspawnpoints("mp_tdm_spawn_allies_start");
  scripts\mp\spawnlogic::addstartspawnpoints("mp_tdm_spawn_axis_start");
  scripts\mp\spawnlogic::addspawnpoints(game["attackers"], "mp_tdm_spawn_allies_start");
  scripts\mp\spawnlogic::addspawnpoints(game["defenders"], "mp_tdm_spawn_axis_start");
  attackers = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_allies_start");
  defenders = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_axis_start");
  scripts\mp\spawnlogic::registerspawnset("start_attackers", attackers);
  scripts\mp\spawnlogic::registerspawnset("start_defenders", defenders);
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn");
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn");
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn_secondary", 1, 1);
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn_secondary", 1, 1);
  spawns = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn");
  spawnssecondary = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_secondary");
  scripts\mp\spawnlogic::registerspawnset("normal", spawns);
  scripts\mp\spawnlogic::registerspawnset("fallback", spawnssecondary);
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

function updategametypedvars() {
  updatecommongametypedvars();
  level.scoreconfirm = dvarintvalue("pointsPerConfirm", 1, 0, 25);
  level.scoredeny = dvarintvalue("pointsPerDeny", 0, 0, 25);
  level.killstreakconfirmed = dvarintvalue("killstreakConfirmed", 0, 0, 1);
}

function getspawnpoint() {
  spawnteam = self.pers["team"];

  if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    if(spawnteam == game["attackers"]) {
      scripts\mp\spawnlogic::activatespawnset("start_attackers", 1);
      spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, undefined, "start_attackers");
    } else {
      scripts\mp\spawnlogic::activatespawnset("start_defenders", 1);
      spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, undefined, "start_defenders");
    }
  } else {
    spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, "normal", "fallback");
  }

  return spawnpoint;
}

function onnormaldeath(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon) {
  oncommonnormaldeath(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon);
}

function onspawnplayer(revivespawn) {
  scripts\mp\hud_message::function_f004ef4606b9efdc("kill_collect_tags");

  if(scripts\cp_mp\utility\game_utility::ismagellanmode()) {
    thread scripts\mp\gametypes\mgl_mp::function_f9ae07213a0af3de();
  }

  if(function_acfcdd7f0c4401ca()) {
    if(_hasperk("specialty_killstreak_to_scorestreak")) {
      scripts\mp\utility\perk::removeperk("specialty_killstreak_to_scorestreak");
    }
  }
}

function onplayerdisconnect(disconnectedplayer) {
  if(istrue(disconnectedplayer.var_cce3fff3ac7e4767)) {
    disconnectedplayer function_9625dcbe330dbad8();
  }
}

function function_c878e93998246855() {
  self endon("<dev string:x1c>");

  while(true) {
    if(getdvarint(@ "hash_46a6b424af6acbc2") != 0) {
      scripts\mp\gamescore::giveteamscoreforobjective("<dev string:x2a>", getdvarint(@ "hash_46a6b424af6acbc2"), 0);
      break;
    } else if(getdvarint(@ "hash_86e14326e43c0115") != 0) {
      scripts\mp\gamescore::giveteamscoreforobjective("<dev string:x34>", getdvarint(@ "hash_86e14326e43c0115"), 0);
      break;
    }

    wait 1;
  }

  setdevdvar(@ "hash_46a6b424af6acbc2", 0);
  setdevdvar(@ "hash_86e14326e43c0115", 0);
  thread function_c878e93998246855();
}

function dogtagallyonusecb(player) {
  if(isPlayer(player)) {
    player setextrascore1(player.pers["denied"]);
    player scripts\mp\gamescore::giveteamscoreforobjective(player.pers["team"], level.scoredeny, 0);

    if(function_acfcdd7f0c4401ca()) {
      if(getdvarint(@ "hash_61a01bbb63374511", 1)) {
        player function_5ed2699b0bd6cd0a();
      }
    }
  }
}

function dogtagenemyonusecb(player) {
  if(isPlayer(player)) {
    player scripts\mp\utility\dialog::leaderdialogonplayer("kill_confirmed", undefined, undefined, undefined, 4);
    player setextrascore0(player.pers["confirmed"]);

    if(function_acfcdd7f0c4401ca()) {
      player function_5ed2699b0bd6cd0a();
    }

    if(istrue(level.killstreakconfirmed)) {
      if(!player scripts\mp\utility\perk::_hasperk("specialty_killstreak_to_scorestreak")) {
        player scripts\mp\killstreaks\killstreaks::givestreakpoints(#"capture", 1, 0);
      } else {
        player scripts\mp\killstreaks\killstreaks::givestreakpoints(#"capture", 1, 150);
      }
    }

    player scripts\mp\codcasterclientmatchdata::function_48544e365f4f5648(15, 1);
  }

  scoreconfirm = level.scoreconfirm;

  if(getdvarint(@ "hash_4753586a2ac8718f", 0) == 1) {
    headsize = self.var_5b88599322728cd0;
    scoreconfirm *= headsize;
  }

  player scripts\mp\gamescore::giveteamscoreforobjective(player.pers["team"], scoreconfirm, 0);

  if(function_75eb145bbb9d4d95()) {
    otherteam = getotherteam(player.pers["team"])[0];
    newenemyscore = getteamscore(player.pers["team"]);
    function_2a5a687f57c9caa6(otherteam, getscorelimit() - newenemyscore);
  }
}

function givesuper() {
  scripts\mp\equipment\temp_v::function_11e36f0effe3e0a7();
}

function function_5ed2699b0bd6cd0a() {
  level.wrapkillstreaks = 1;
  killstreaktype = getxhash("temp_v");
  scripts\mp\killstreaks\killstreaks::givestreakpoints(killstreaktype, 1, 0);

  if(!isDefined(self.numvials)) {
    self.numvials = 1;
  } else {
    self.numvials += 1;
  }

  switch (self.numvials) {
    case 1:
      scripts\mp\utility\perk::giveperk("specialty_durability");
      self setclientomnvar("ui_aon_perk_progress_0", 1);
      self setclientomnvar("ui_aon_perk_splash_0", 1);
      self playlocalsound("jup_confv_perk_durability", undefined, undefined, 1);
      break;
    case 2:
      scripts\mp\utility\perk::giveperk("specialty_super_speed");
      self setclientomnvar("ui_aon_perk_progress_1", 1);
      self setclientomnvar("ui_aon_perk_splash_1", 1);
      self playlocalsound("jup_confv_perk_super_speed", undefined, undefined, 1);
      function_5cad57aaebc86449();
      break;
    case 3:
      scripts\mp\utility\perk::giveperk("specialty_super_strength");
      self setclientomnvar("ui_aon_perk_progress_2", 1);
      self setclientomnvar("ui_aon_perk_splash_2", 1);
      self playlocalsound("jup_confv_perk_super_strength", undefined, undefined, 1);
      break;
    case 5:
    case 10:
    case 15:
    case 20:
    case 25:
    case 30:
    case 35:
    case 40:
      thread function_40332f3e05619ec4();
      thread scripts\mp\utility\points::doscoreevent(#"hash_551eaf3c0cc43c44");
    default:
      break;
  }
}

function function_23b30982847d4558() {
  if(isDefined(self.numvials)) {
    self.numvials = 0;
  }

  if(scripts\mp\utility\perk_shared::function_56ad1b98a0613f8a("specialty_durability")) {
    scripts\mp\utility\perk::removeperk("specialty_durability");
  } else if(scripts\mp\utility\perk_shared::function_56ad1b98a0613f8a("specialty_super_speed")) {
    scripts\mp\utility\perk::removeperk("specialty_super_speed");
  } else if(scripts\mp\utility\perk_shared::function_56ad1b98a0613f8a("specialty_super_strength")) {
    scripts\mp\utility\perk::removeperk("specialty_super_strength");
  }

  clearkillstreaks();
  self setclientomnvar("ui_spawn_perks_updated", gettime());
}

function function_40332f3e05619ec4() {
  self endon("death");
  self endon("disconnect");
  self waittill("disable_super_speed_vfx");
  self setscriptablepartstate("conf_v_super_speed_fx", "super_speed_off");
  self waittill("enable_super_speed_vfx");
  self setscriptablepartstate("conf_v_super_speed_fx", "super_speed_on");
}

function function_9625dcbe330dbad8() {
  self setscriptablepartstate("conf_v_super_speed_fx", "super_speed_off");
  self.var_cce3fff3ac7e4767 = 0;
}

function function_5cad57aaebc86449() {
  self setscriptablepartstate("conf_v_super_speed_fx", "super_speed_on");
  self.var_cce3fff3ac7e4767 = 1;
}

function onplayerkilled(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, killid) {
  if(function_acfcdd7f0c4401ca()) {
    function_9625dcbe330dbad8();
    function_23b30982847d4558();
  }
}

function function_75eb145bbb9d4d95() {
  return getDvar(@ "ui_gametype", "conf") == "conf_tw";
}

function function_acfcdd7f0c4401ca() {
  return getDvar(@ "ui_gametype", "conf") == "conf_v";
}

function function_2a5a687f57c9caa6(team, score) {
  scripts\mp\gamescore::_setteamscore(team, score, 0);
  level notify("update_team_score", team, score);
}

function private onplayerspawn() {
  resetomnvars(self);
}

function private resetomnvars(player) {
  if(function_acfcdd7f0c4401ca()) {
    player setclientomnvar("ui_spawn_perk_0", "specialty_durability");
    player setclientomnvar("ui_spawn_perk_1", "specialty_super_speed");
    player setclientomnvar("ui_spawn_perk_2", "specialty_super_strength");
    player setclientomnvar("ui_spawn_perk_3", "none");
    player setclientomnvar("ui_spawn_perk_4", "none");
    player setclientomnvar("ui_spawn_perk_5", "none");
    player setclientomnvar("ui_aon_perk_progress_0", 0);
    player setclientomnvar("ui_aon_perk_progress_1", 0);
    player setclientomnvar("ui_aon_perk_progress_2", 0);
    player setclientomnvar("ui_aon_perk_progress_3", 0);
    player setclientomnvar("ui_aon_perk_splash_0", 0);
    player setclientomnvar("ui_aon_perk_splash_1", 0);
    player setclientomnvar("ui_aon_perk_splash_2", 0);
    player setclientomnvar("ui_aon_perk_splash_3", 0);
  }
}