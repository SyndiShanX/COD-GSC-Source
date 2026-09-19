/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\_leprechauns.gsc
********************************************/

init() {
  thread _id_87A7();
}

_id_87A7() {
  setdvarifuninitialized("leprechauns_enabled", 0);
  setdvarifuninitialized("spv_min_lep_kills", 30);
  setdvarifuninitialized("spv_lep_chance", 30);
  setdvarifuninitialized("spv_lep_health", 700);
  setdvarifuninitialized("spv_lep_cap", 6);

  if(getdvarint("leprechauns_enabled", 0) == 1 && !_func_3A9()) {
    level.leprechaun_model = "usa_leprechaun_mtx7";
    level._effect["leprechaun_spawn_fx"] = loadfx("vfx/unique/st_patricks_day_leprechaun_spawn");
    level._effect["leprechaun_death_fx"] = loadfx("vfx/unique/st_patricks_day_leprechaun_death");
    level._id_0A41["leprechauns"] = [];
    level._id_0A41["leprechauns"]["spawn"] = ::spawn_leprechaun;
    level._id_0A41["leprechauns"]["think"] = ::leprechaun_think;
    level._id_0A41["leprechauns"]["on_killed"] = ::on_leprechaun_killed;

    while(!isDefined(level._id_0A41) || !isDefined(level._id_0A41["player"]))
      waitframe();

    level._id_0A41["leprechauns"]["on_damaged"] = level._id_0A41["player"]["on_damaged"];
    level._id_0A41["leprechauns"]["on_damaged_finished"] = level._id_0A41["player"]["on_damaged_finished"];
    level.leprechaun_spawns = [];
    level.total_leprechauns = 0;
    level.spawns_without_leprechaun = 0;
    var_0 = randomint(2);

    if(var_0 == 0)
      level.leprechauns_team = "axis";
    else
      level.leprechauns_team = "allies";

    level thread try_spawn_leprechauns();
  }
}

try_spawn_leprechauns() {
  level endon("game_ended");

  for(;;) {
    level waittill("normal_enemy_kill");

    if(!maps\mp\_utility::gameflag("prematch_done")) {
      continue;
    }
    if(level.total_leprechauns >= getdvarint("spv_lep_cap", 6)) {
      return;
    }
    if(isDefined(level.leprechaun) || isalive(level.leprechaun)) {
      continue;
    }
    var_0 = maps\mp\agents\_agent_utility::get_max_agents();

    if(maps\mp\agents\_agent_utility::_id_45BB() >= var_0) {
      continue;
    }
    var_1 = getdvarint("spv_lep_chance", 30);

    if(var_1 <= 0)
      var_1 = 1;

    var_2 = randomint(var_1);

    if(var_2 != 0 && level.spawns_without_leprechaun < getdvarint("spv_min_lep_kills", 30)) {
      level.spawns_without_leprechaun++;
      continue;
    }

    level.spawns_without_leprechaun = 0;
    var_3 = randomint(3) + 2;
    wait(var_3);
    var_4 = undefined;
    var_5 = [];

    foreach(var_7 in level.players) {
      if(maps\mp\_utility::isreallyalive(var_7))
        var_5[var_5.size] = var_7;
    }

    if(isDefined(var_5) && var_5.size > 0) {
      var_9 = randomint(var_5.size);

      if(isDefined(var_5[var_9]))
        var_4 = var_5[var_9].origin;
    }

    if(isDefined(var_4)) {
      level.leprechaun_spawns = _getnodesinradiussorted(var_4, 2000, 1000, 500, "Path");

      if(level.leprechaun_spawns.size > 0)
        level spawn_leprechaun_handler();
    }
  }
}

spawn_leprechaun_handler() {
  level endon("game_ended");
  var_0 = randomint(level.leprechaun_spawns.size);
  var_1 = level.leprechaun_spawns[var_0].origin;
  var_2 = level.leprechaun_spawns[var_0].angles;
  level.leprechaun = [[level._id_0A4D]]("leprechauns", level.leprechauns_team, undefined, var_1, var_2, undefined, 0, 0, "veteran");
}

spawn_leprechaun(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon("disconnect");

  while(!isDefined(level._id_4696))
    waitframe();

  if(self._id_4B60)
    wait(_randomintrange(6, 10));

  maps\mp\agents\_agent_utility::_id_5334(1);

  if(isDefined(var_0) && isDefined(var_1)) {
    var_7 = var_0;
    var_8 = var_1;
    self._id_5BE0 = spawnStruct();
    self._id_5BE0.origin = var_7;
    self._id_5BE0.angles = var_8;
  } else {
    self _meth_856C();
    var_9 = [[level._id_4696]]();
    var_7 = var_9.origin;
    var_8 = var_9.angles;
    self._id_5BE0 = var_9;
  }

  maps\mp\agents\_agent_utility::_id_08A7();
  self._id_5CC6 = maps\mp\agents\_agent_utility::_id_45AE(self.name);
  self._id_5BE2 = gettime();
  var_10 = var_7 + (0, 0, 25);
  var_11 = var_7;
  var_12 = _playerphysicstrace(var_10, var_11);

  if(distancesquared(var_12, var_10) > 1)
    var_7 = var_12;

  self spawnagent(var_7, var_8);
  self[[level.bot_funcs["bot_set_difficulty"]]]("veteran");
  self[[level.bot_funcs["bot_set_personality"]]]("run_and_gun");
  maps\mp\agents\_agent_common::_id_83FD(getdvarint("spv_lep_health", 700));

  if(isDefined(var_4) && var_4)
    self._id_7DAD = 1;

  if(isDefined(var_2))
    maps\mp\agents\_agent_utility::hudoutlineenable(var_2.team, var_2);
  else
    maps\mp\agents\_agent_utility::hudoutlineenable(level.leprechauns_team);

  if(isDefined(self._id_0117))
    self thread[[level._id_0A55]](self._id_0117);

  thread maps\mp\_flashgrenades::_id_6394();
  self enableanimstate(0);
  maps\mp\_utility::giveperk("specialty_silentmovement");
  maps\mp\_utility::giveperk("specialty_plainsight");
  maps\mp\_utility::giveperk("specialty_coldblooded");
  maps\mp\_utility::giveperk("specialty_spygame");
  maps\mp\_utility::giveperk("specialty_heartbreaker");
  maps\mp\_utility::giveperk("specialty_uavhidden");
  maps\mp\_utility::giveperk("specialty_delaymine");
  self thread[[level.bot_funcs["bot_think_watch_enemy"]]](1);
  self thread[[level.bot_funcs["bot_think_tactical_goals"]]]();
  self thread[[maps\mp\agents\_agent_utility::_id_0A59("think")]]();

  if(!self._id_4B60)
    _id_050D::_id_09FA();

  thread _id_0513::_id_9B90();
  self._id_4B60 = 0;
  thread _id_04D6::_id_73FC();
  self._id_0009 = undefined;
  self setModel(level.leprechaun_model);
  waittillframeend;
  playFX(common_scripts\utility::_id_44F5("leprechaun_spawn_fx"), self.origin);
  self botsetflag("disable_attack", 1);
  self botsetflag("force_sprint", 1);
  self botsetflag("melee_critical_path", 1);
  self botsetflag("no_enemy_search", 1);
  self botsetflag("dont_path_to_enemy", 1);
  self _meth_85BE(0);
  self _meth_85BD(0);
  self allowcrouch(0);
  self allowprone(0);
  thread leprechaun_behavior_loop();
  thread start_leprechaun_audio();
  thread setup_leprechaun_aim_assist();
  self takeallweapons();
  self giveweapon("emote_weapon_mp");
  level notify("spawned_agent_player", self);
  level notify("spawned_agent", self);
  self notify("spawned_player");
  thread watch_leprechaun_damage();
  level.total_leprechauns++;

  if(level.leprechauns_team == "allies")
    level.leprechauns_team = "axis";
  else if(level.leprechauns_team == "axis")
    level.leprechauns_team = "allies";

  thread message_leprechaun_arrival();
}

message_leprechaun_arrival() {
  level endon("game_ended");

  foreach(var_1 in level.players)
  var_1 iprintlnbold(&"SPLASHES_MTX3_5_LEPRECHAUN_SPAWN");
}

message_leprechaun_death() {
  level endon("game_ended");
  wait 1;

  foreach(var_1 in level.players)
  var_1 iprintlnbold(&"SPLASHES_MTX3_5_LEPRECHAUN_DEATH");
}

leprechaun_behavior_loop() {
  level endon("game_ended");
  self endon("death");
  var_0 = 0;

  for(;;) {
    var_0 = !var_0;
    self botsetflag("no_enemy_search", var_0);
    self botsetflag("dont_path_to_enemy", var_0);

    if(var_0 == 1) {
      wait 7;
      continue;
    }

    wait 2;
  }
}

setup_leprechaun_aim_assist() {
  level endon("game_ended");
  self endon("death");

  if(!level.teambased) {
    return;
  }
  foreach(var_1 in level.players) {
    if(isDefined(var_1.team) && var_1.team == self.team)
      var_1 _meth_8656(self);
  }

  for(;;) {
    level waittill("player_spawned", var_1);

    if(isDefined(var_1.team) && var_1.team == self.team)
      var_1 _meth_8656(self);
  }
}

leprechaun_think() {
  self notify("leprechaun_think");
  self endon("leprechaun_think");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self endon("owner_disconnect");

  for(;;) {
    self[[self._id_6F7F]]();
    waitframe();
  }
}

on_leprechaun_killed(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  playFX(common_scripts\utility::_id_44F5("leprechaun_death_fx"), self.origin);
  thread message_leprechaun_death();
  thread leprechaun_death_sfx();
  self[[level._id_0A5D]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, 1);
  var_9 = _id_047A::_id_43D6(var_4, var_3);
  level thread all_player_card_splash("leprechaun_killed", var_1);

  if(isPlayer(var_1)) {
    level thread maps\mp\gametypes\_rank::_id_1457("leprechaun_killed", var_1, var_4, undefined, var_3);
    var_1 thread give_leprechaun_score_over_time();
    var_1 thread _id_0468::_id_0A22("lepKill");
  }

  if(isDefined(level._id_6A75))
    [[level._id_6A75]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);

  if(self._id_565F) {
    self._id_4B60 = 1;

    if(maps\mp\_utility::getgametypenumlives() != 1 && (isDefined(self._id_7DAD) && self._id_7DAD))
      self thread[[maps\mp\agents\_agent_utility::_id_0A59("spawn")]]();
    else
      maps\mp\agents\_agent_utility::_id_2A73();
  }

  level.leprechaun = undefined;
}

get_highest_streak_cost() {
  if(!isDefined(self.killstreaks))
    return 0;

  var_0 = 0;

  foreach(var_2 in self.killstreaks) {
    var_3 = _id_051E::_id_46B4(var_2);

    if(var_3 > var_0)
      var_0 = var_3;
  }

  return var_0;
}

give_leprechaun_score_over_time() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  var_0 = 0;
  var_1 = get_highest_streak_cost();

  if(maps\mp\_utility::_hasperk("specialty_killstreaks"))
    var_0 = 1;
  else {
    var_0 = 100;
    var_1 = int(var_1 / var_0);
  }

  for(var_2 = 0; var_2 < var_1; var_2++) {
    _id_051E::_id_4771(var_0);
    waitframe();
  }
}

is_valid_leprechaun_attacker(var_0) {
  var_1 = undefined;

  if(isDefined(var_0) && isDefined(self._id_0117)) {
    if(isDefined(var_0._id_0117) && isPlayer(var_0._id_0117))
      var_0 = var_0._id_0117;

    if(var_0 == self._id_0117) {
      return;
    }
    if(_issentient(self._id_0117) && _issentient(var_0)) {
      if(!_isalliedsentient(self._id_0117, var_0))
        var_1 = var_0;
    } else if(level.teambased) {
      if(self._id_0117.team != var_0.team)
        var_1 = var_0;
    } else if(self._id_0117 != var_0)
      var_1 = var_0;
  }

  return var_1;
}

all_player_card_splash(var_0, var_1, var_2) {
  if(level.hardcoremode) {
    return;
  }
  foreach(var_4 in level.players) {
    if(!isDefined(var_4)) {
      continue;
    }
    if(!isPlayer(var_4)) {
      continue;
    }
    var_4 thread maps\mp\gametypes\_hud_message::playercardsplashnotify(var_0, var_1, var_2);
  }
}

watch_leprechaun_damage() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
    thread leprechaun_hit_sfx();
    var_10 = var_0;
  }
}

start_leprechaun_audio() {
  var_0 = 2;
  var_1 = 5;
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  _id_0380::_id_6844("mp_st_pattys_lepre_appearance", undefined, self);
  self.leprechaun_vo = _id_0380::_id_6846("mp_st_pattys_lepre_vo_intro", undefined, self);

  if(isDefined(self.leprechaun_vo)) {
    self.leprechaun_vo _meth_8640(self, "leprechaun_vo_done");
    self waittill("leprechaun_vo_done");
    self.leprechaun_vo = undefined;
  }

  for(;;) {
    var_2 = _randomfloatrange(var_0, var_1);
    wait(var_2);

    if(!isDefined(self.leprechaun_hit_vo)) {
      self.leprechaun_vo = _id_0380::_id_6846("mp_st_pattys_lepre_vo_run", undefined, self);

      if(isDefined(self.leprechaun_vo)) {
        self.leprechaun_vo _meth_8640(self, "leprechaun_vo_done");
        self waittill("leprechaun_vo_done");
        self.leprechaun_vo = undefined;
      }
    }
  }
}

leprechaun_hit_sfx() {
  if(isDefined(self.leprechaun_vo)) {
    _id_0380::_id_6850(self.leprechaun_vo, 0.05);
    self.leprechaun_vo = undefined;
  }

  if(!isDefined(self.leprechaun_hit_vo)) {
    self.leprechaun_hit_vo = _id_0380::_id_6846("mp_st_pattys_lepre_vo_hit", undefined, self);

    if(isDefined(self.leprechaun_hit_vo)) {
      self.leprechaun_hit_vo _meth_8640(self, "leprechaun_hit_vo_done");
      self waittill("leprechaun_hit_vo_done");
      wait 4.0;
      self.leprechaun_hit_vo = undefined;
    }
  }
}

leprechaun_death_sfx() {
  if(isDefined(self.leprechaun_vo)) {
    _id_0380::_id_6850(self.leprechaun_vo, 0.05);
    self.leprechaun_vo = undefined;
  }

  if(isDefined(self.leprechaun_hit_vo)) {
    _id_0380::_id_6850(self.leprechaun_hit_vo, 0.05);
    self.leprechaun_hit_vo = undefined;
  }

  _id_0380::_id_6842("mp_st_pattys_lepre_vo_outro", undefined, self.origin);
  _id_0380::_id_6842("mp_st_pattys_lepre_explo", undefined, self.origin);
  _id_0380::_id_6842("mp_st_pattys_lepre_explo_coins", undefined, self.origin);
  _id_0380::_id_6842("mp_st_pattys_lepre_explo_debris", undefined, self.origin);
}