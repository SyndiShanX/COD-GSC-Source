/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\_matchdata.gsc
******************************************/

init() {
  if(!isDefined(game["gamestarted"])) {
    var_0 = "mp/ddl/mp_matchdata.ddl";

    if(level.gametype == "zombies")
      var_0 = "mp/ddl/zm_matchdata.ddl";

    _func_127(var_0);
    level.ismatchdatadefset = 1;
    setmatchdata("match_common", "map", level._id_015D);

    if(level.hardcoremode) {
      var_1 = level.gametype + " hc";
      setmatchdata("match_common", "gametype", var_1);
    } else
      setmatchdata("match_common", "gametype", level.gametype);

    setmatchdata("match_common", "build_version", _func_12F());
    setmatchdata("match_common", "changelist", _func_130());
    _func_129();
    game["matchIDSet"] = 1;

    if(maps\mp\_utility::_id_579B()) {
      if(!common_scripts\utility::_id_562E(game["switchedsides"]))
        game["firstMatchID"] = getmatchdata("match_common", "matchID");
      else
        setmatchdata("match_common", "previous_match_id", game["firstMatchID"]);
    }
  }

  level.maxlives = 490;
  level._id_6083 = 255;
  level._id_6087 = 64;
  level._id_608C = 24;
  level._id_609D = 24;
  level._id_60A7 = 12;
  level thread _id_3F9E();

  if(getDvar("4017") != "1")
    level thread _id_7B2D();
}

_id_6036() {
  _func_29E("MatchStarted: Completed");

  if(getDvar("4017") == "1") {
    return;
  }
  if(getDvar("1673") == getDvar("5473")) {
    return;
  }
  if(_func_367()) {
    return;
  }
  var_0 = _func_2AA();
  setmatchdata("match_common", "playlist_name", var_0);
  var_1 = _func_2AB();
  setmatchdata("match_common", "localTimeStringAtMatchStart", var_1);
  var_2 = getmatchdata("match_common", "player_count");
  setmatchdata("match_common", "player_count_start", var_2);
  _func_39E();
  setmatchdata("match_common", "is_esports_rules", maps\mp\_utility::_id_56B1());

  if(maps\mp\_utility::privatematch())
    setmatchdata("match_common", "is_private_match", 1);

  if(_func_3AF())
    setmatchdata("match_common", "is_ranked_mode", 1);

  if(_id_4574() == 0) {
    setmatchdata("match_common", "utc_start_time", _func_131());
    startmatchtimer();

    if(!_func_367() && _func_3BC())
      _func_3BD();
  }

  thread _id_0853();
  thread _id_5EAE();
}

_id_0853() {
  level endon("game_ended");

  for(;;) {
    foreach(var_1 in level.players) {
      if(isbot(var_1) || istestclient(var_1)) {
        continue;
      }
      if(!isDefined(var_1.pers["pingAccumulation"]) || !isDefined(var_1.pers["minPing"]) || !isDefined(var_1.pers["maxPing"]) || !isDefined(var_1.pers["pingSampleCount"])) {
        continue;
      }
      var_2 = var_1 _meth_851E();
      var_1.pers["pingAccumulation"] = var_1.pers["pingAccumulation"] + var_2;
      var_1.pers["pingSampleCount"]++;

      if(var_1.pers["pingSampleCount"] > 5 && var_2 > 0) {
        if(var_2 > var_1.pers["maxPing"])
          var_1.pers["maxPing"] = var_2;

        if(var_2 < var_1.pers["minPing"])
          var_1.pers["minPing"] = var_2;
      }
    }

    wait 2;
  }
}

_id_4574() {
  return getmatchdata("match_common", "utc_start_time");
}

startmatchtimer() {
  game["matchStartTime"] = gettime();
}

getmatchtimepassed() {
  var_0 = 0;

  if(isDefined(game["matchStartTime"]))
    var_0 = gettime() - game["matchStartTime"];

  return var_0;
}

_id_5E99(var_0) {
  if(!_id_1F55(self) || !_id_1F58()) {
    return;
  }
  var_1 = getmatchdata("killstreak_available_count");
  setmatchdata("killstreak_available_count", var_1 + 1);
  var_2 = getmatchtimepassed();
  setmatchdata("killstreaks_available", var_1, "event_type", maps\mp\_utility::_id_452A(var_0));
  setmatchdata("killstreaks_available", var_1, "event_time_ms", var_2);
  setmatchdata("killstreaks_available", var_1, "life_index", self._id_5CC6);

  if(_func_3BC())
    self _meth_8681("dtel_killstreak", ["killstreak", ["life_index", self._id_5CC6, "player_index", self.clientid, "event_type", var_0, "event_time_ms", var_2, "event_pos", [0, 0, 0], "deployed", 0]]);
}

_id_5E9A(var_0, var_1) {
  maps\mp\gametypes\_persistence::incrementscorestreakstat(var_0, "uses", 1);

  if(!_id_1F55(self) || !_id_1F57()) {
    return;
  }
  if(level._id_53C7) {
    if(!isDefined(self._id_80C3))
      self._id_80C3 = [];

    if(!isDefined(self._id_80C3[var_0])) {
      self._id_80C3[var_0] = 0;

      if(self._id_80C3.size == 14)
        maps\mp\gametypes\_missions::processchallenge("ch_scorestreaktraining_allStreaks");
      else if(self._id_80C3.size == 5)
        maps\mp\gametypes\_missions::processchallenge("ch_scorestreaktraining_halfStreaks");
    }

    self._id_80C3[var_0]++;

    if(self._id_80C3[var_0] == 3)
      maps\mp\gametypes\_missions::processchallenge("ch_scorestreaktraining_practiceMakesPerfect");
  }

  var_2 = getmatchdata("killstreak_count");
  setmatchdata("killstreak_count", var_2 + 1);
  var_3 = getmatchtimepassed();
  setmatchdata("killstreaks", var_2, "event_type", maps\mp\_utility::_id_452A(var_0));
  setmatchdata("killstreaks", var_2, "event_time_ms", var_3);
  setmatchdata("killstreaks", var_2, "event_pos", 0, int(var_1[0]));
  setmatchdata("killstreaks", var_2, "event_pos", 1, int(var_1[1]));
  setmatchdata("killstreaks", var_2, "event_pos", 2, int(var_1[2]));
  setmatchdata("killstreaks", var_2, "life_index", self._id_5CC6);
  self._id_293B = var_2;

  if(_func_3BC())
    self _meth_8681("dtel_killstreak", ["killstreak", ["life_index", self._id_5CC6, "player_index", self.clientid, "event_type", var_0, "event_time_ms", var_3, "event_pos", [int(var_1[0]), int(var_1[1]), int(var_1[2])], "deployed", 1]]);

  _func_0F6(var_1, "script_mp_killstreak: eventType %s, player_name %s, player %d, gameTime %d", var_0, self.name, self.clientid, gettime());
}

logkillstreakassist(var_0) {
  if(!isDefined(var_0._id_293B)) {
    return;
  }
  if(0 <= var_0._id_293B && var_0._id_293B < level._id_6087) {
    var_1 = getmatchdata("killstreaks", var_0._id_293B, "assists_total");
    setmatchdata("killstreaks", var_0._id_293B, "assists_total", var_1 + 1);
  }
}

_id_5E93(var_0, var_1, var_2) {
  if(!_id_1F56()) {
    return;
  }
  var_3 = -1;

  if(maps\mp\_utility::_id_56FF(self)) {
    if(!_id_1F55(self))
      return;
    else {
      var_3 = self._id_5CC6;

      if(!isDefined(var_3))
        var_3 = -1;
    }
  }

  if(var_3 == -1) {
    return;
  }
  var_4 = getmatchdata("match_common", "event_count");
  setmatchdata("match_common", "event_count", var_4 + 1);
  var_5 = getmatchtimepassed();
  var_6 = 0;

  if(isDefined(var_2))
    var_6 = var_2;

  setmatchdata("events", var_4, "event_type", var_0);
  setmatchdata("events", var_4, "event_time_ms", var_5);
  setmatchdata("events", var_4, "event_pos", 0, int(var_1[0]));
  setmatchdata("events", var_4, "event_pos", 1, int(var_1[1]));
  setmatchdata("events", var_4, "event_pos", 2, int(var_1[2]));
  setmatchdata("events", var_4, "life_index", var_3);
  setmatchdata("events", var_4, "extra_data", var_6);

  if(_func_3BC())
    self _meth_8681("dtel_gameevent", ["gameevent", ["life_index", var_3, "event_type", var_0, "event_time_ms", var_5, "event_pos", [int(var_1[0]), int(var_1[1]), int(var_1[2])], "extra_data", var_6]]);

  if(var_3 != -1 && isDefined(self.name) && isDefined(self.clientid))
    _func_0F6(var_1, "script_mp_event: event_type %s, player_name %s, player %d, gameTime %d", var_0, self.name, self.clientid, gettime());
}

_id_5E96(var_0, var_1) {
  if(!_id_1F59(var_0)) {
    return;
  }
  setmatchdata("lives", var_0, "death_modifiers", var_1, 1);

  if(_func_3BC())
    self _meth_8681("dtel_death_modifier", ["death", ["life_index", var_0, "player_index", self.clientid, "modifier", var_1]]);
}

_id_5E9D(var_0, var_1) {
  if(!_id_1F59(var_0)) {
    return;
  }
  setmatchdata("lives", var_0, "multikill", var_1);

  if(_func_3BC())
    self _meth_8681("dtel_multikill", ["death", ["life_index", var_0, "player_index", self.clientid, "multikill", var_1]]);
}

_id_5EA6(var_0) {
  if(!_id_1F55(self) || !_id_1F59(self._id_5CC6)) {
    return;
  }
  var_1 = gettime() - level._id_5CC7[self._id_5CC6];
  self._id_9AB6 = self._id_9AB6 + var_1;
  setmatchdata("lives", self._id_5CC6, "player_index", self.clientid);
  setmatchdata("lives", self._id_5CC6, "spawn_pos", 0, int(self._id_9092[0]));
  setmatchdata("lives", self._id_5CC6, "spawn_pos", 1, int(self._id_9092[1]));
  setmatchdata("lives", self._id_5CC6, "spawn_pos", 2, int(self._id_9092[2]));
  setmatchdata("lives", self._id_5CC6, "wasTacticalInsertion", self._id_A87A);

  if(isDefined(self._id_90AC))
    setmatchdata("lives", self._id_5CC6, "spawn_time_ms", self._id_90AC);
  else
    setmatchdata("lives", self._id_5CC6, "spawn_time_ms", -1);

  setmatchdata("lives", self._id_5CC6, "duration_ms", var_1);

  if(!(isDefined(level._id_585D) && level._id_585D)) {
    if(isDefined(self._id_2943))
      setmatchdata("lives", self._id_5CC6, "victim_loadout_index", self._id_2943);
    else
      setmatchdata("lives", self._id_5CC6, "victim_loadout_index", -1);
  }

  var_2 = maps\mp\_utility::_id_2315(self.pers["score"] - self._id_80A7);
  setmatchdata("lives", self._id_5CC6, "score_earned", var_2);

  if(isDefined(self.pers["summary"]) && isDefined(self.pers["summary"]["xp"])) {
    if(isDefined(self._id_AAD0)) {
      var_3 = maps\mp\_utility::_id_2315(self.pers["summary"]["xp"] - self._id_AAD0);
      setmatchdata("lives", self._id_5CC6, "xp_earned", var_3);
    }
  }
}

_id_5EAA(var_0, var_1) {
  if(!_id_1F55(self)) {
    return;
  }
  setmatchdata("players", self.clientid, var_1, var_0);
}

_id_5EA1(var_0, var_1) {
  if(!_id_1F55(self) || isbot(self)) {
    return;
  }
  var_2 = getmatchdata("players", self.clientid, "awards", var_0);
  var_2 = var_2 + var_1;
  var_2 = maps\mp\_utility::_id_2314(var_2);
  setmatchdata("players", self.clientid, "awards", var_0, var_2);
}

_id_5E9F(var_0, var_1) {
  if(!_id_1F55(self) || !_id_1F55(var_1) || !_id_1F59(var_0)) {
    return;
  }
  if(var_1 _meth_8345() > 0.5)
    setmatchdata("lives", var_0, "attacker_was_ads", 1);

  var_2 = var_1 getEye();

  if(common_scripts\utility::within_fov(var_2, var_1.angles, self.origin, _func_0A7(getdvarfloat("cg_fov"))))
    setmatchdata("lives", var_0, "victim_was_in_attacker_fov", 1);

  var_3 = self getEye();

  if(common_scripts\utility::within_fov(var_3, self.angles, var_1.origin, _func_0A7(getdvarfloat("cg_fov"))))
    setmatchdata("lives", var_0, "attacker_was_in_victim_fov", 1);

  if(self _meth_8345() > 0.5)
    setmatchdata("lives", var_0, "victim_was_ads", 1);
}

_id_2E62(var_0, var_1) {
  var_2 = 6;
  var_3 = undefined;
  var_4 = undefined;

  if(var_0 == "none") {
    var_3 = "none";
    var_4 = "none";
  } else {
    var_3 = weaponinventorytype(var_0);
    var_4 = weaponclass(var_0);
  }

  if(issubstr(var_0, "destructible"))
    var_0 = "destructible";

  var_5 = [];

  for(var_6 = 0; var_6 < var_2; var_6++)
    var_5[var_6] = "None";

  var_7 = "";

  if(isDefined(var_3) && (var_3 == "primary" || var_3 == "altmode") && (var_4 == "pistol" || var_4 == "smg" || var_4 == "rifle" || var_4 == "spread" || var_4 == "mg" || var_4 == "grenade" || var_4 == "rocketlauncher" || var_4 == "sniper" || var_4 == "cone" || var_4 == "beam" || var_4 == "shield")) {
    if(var_3 == "altmode") {
      if(isDefined(var_1))
        var_0 = var_1;
    }

    var_7 = maps\mp\_utility::_id_4431(var_0);
    var_8 = _func_061(var_0);
    var_6 = 0;

    foreach(var_10 in var_8) {
      if(!maps\mp\_utility::_id_5679(var_10)) {
        continue;
      }
      var_11 = maps\mp\_utility::_id_1150(var_10);

      if(var_6 < var_2) {
        var_5[var_6] = var_11;
        var_6++;
        continue;
      }

      break;
    }
  } else
    var_7 = maps\mp\_utility::_id_4431(var_0);

  if(maps\mp\_utility::_id_579B() && (var_7 == "m712carry_mp" || var_7 == "raid_carryflag_mp"))
    var_7 = "m712_mp";

  var_13 = spawnStruct();
  var_13._id_A9E0 = var_7;
  var_13._id_1154 = var_5;
  var_13._id_A9F4 = var_3;
  var_13._id_A9BF = var_4;
  var_13._id_A9E1 = var_0;
  return var_13;
}

_id_5EA0(var_0, var_1) {
  if(!_id_1F59(var_0)) {
    return;
  }
  if(_id_1F55(self)) {
    var_2 = _func_2A5(self);
    setmatchdata("lives", var_0, "victim_motionstate", var_2);
  }

  if(_id_1F55(var_1)) {
    var_2 = _func_2A5(var_1);
    setmatchdata("lives", var_0, "attacker_motionstate", var_2);
  }
}

_id_5EA5(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(level._id_585D) {
    var_9 = common_scripts\utility::_id_98E7(isDefined(self.name), self.name, "");
    var_10 = "";
    var_11 = "";

    if(isDefined(var_2)) {
      if(isDefined(var_2._id_0A4B))
        var_10 = var_2._id_0A4B;

      if(isDefined(var_2.name))
        var_11 = var_2.name;
    }

    var_12 = common_scripts\utility::_id_98E7(isDefined(var_5), var_5, "");
    _func_0F6(self.origin, "script_zombie_playerdeath: iDamage %d, sMeansOfDeath %s, sHitLoc %s, victimCurrentWeapon %s, sKillersWeapon %s, attackerName %s, victimName %s, zombie_type %s, zombies_wave %d", var_3, var_4, var_7, var_8, var_12, var_11, var_9, var_10, level._id_A980);
    return;
  }

  if(!_id_1F55(self) || !_id_1F55(var_2) || !_id_1F59(var_0)) {
    return;
  }
  if(var_1 == var_2)
    _id_5E9F(var_0, var_2);

  _id_5EA0(var_0, var_2);

  if(isDefined(var_1) && isDefined(var_1._id_5CC6) && var_1._id_5CC6 != -1)
    var_13 = var_1._id_5CC6;
  else
    var_13 = var_2._id_5CC6;

  if(!isDefined(var_13))
    var_13 = -1;

  var_14 = maps\mp\_utility::_id_473D(var_5);
  setmatchdata("lives", var_0, "attacker_weapon_guid", var_14.guid);
  var_15 = _id_2E62(var_5, var_6);

  if(_func_12A("Weapon", var_15._id_A9E0))
    setmatchdata("lives", var_0, "attacker_weapon", var_15._id_A9E0);

  if(isDefined(var_2) && var_2 _meth_8680())
    setmatchdata("lives", var_0, "attacker_weapon_altmode", 1);

  if(maps\mp\_utility::iskillstreakweapon(var_15._id_A9E1)) {
    _id_5E96(var_0, "killstreak");

    if(isDefined(var_2._id_293B)) {
      var_16 = getmatchdata("killstreaks", var_2._id_293B, "kills_total");
      var_16++;
      setmatchdata("killstreaks", var_2._id_293B, "kills_total", maps\mp\_utility::_id_2315(var_16));
      setmatchdata("lives", var_0, "attacker_killstreak_index", var_2._id_293B);
    } else
      setmatchdata("lives", var_0, "attacker_killstreak_index", 255);
  } else
    setmatchdata("lives", var_0, "attacker_killstreak_index", 255);

  var_17 = getmatchtimepassed();
  setmatchdata("lives", self._id_5CC6, "death_time_ms", var_17);

  if(!isDefined(var_2._id_3C6C))
    var_2._id_3C6C = var_17;

  if(isDefined(self._id_3C6C))
    setmatchdata("lives", var_0, "first_kill_time_ms", self._id_3C6C);

  var_18 = _id_2E62(var_8, undefined);

  if(var_18._id_A9F4 != "exclusive" && !_func_367()) {
    if(maps\mp\_utility::iskillstreakweapon(var_18._id_A9E0)) {
      if(isDefined(self.primaryweapon)) {
        var_19 = maps\mp\_utility::_id_4431(self.primaryweapon);
        setmatchdata("lives", var_0, "victim_weapon", var_19);
      }
    } else
      setmatchdata("lives", var_0, "victim_weapon", var_18._id_A9E0);
  }

  var_20 = maps\mp\_utility::_id_473D(var_8);
  setmatchdata("lives", var_0, "victim_weapon_guid", var_20.guid);

  if(self _meth_8680())
    setmatchdata("lives", var_0, "victim_weapon_altmode", 1);

  if(isDefined(self._id_6FBA) && isDefined(self._id_6FBA[var_18._id_A9E1]))
    setmatchdata("lives", var_0, "victim_weapon_pickedup", 1);

  setmatchdata("lives", var_0, "means_of_death", var_4);
  var_21 = 2;
  var_22 = 0;
  var_23 = -1;
  var_24 = 0;
  var_25 = self._id_29B9;
  var_26 = self._id_29DA;
  var_27 = self._id_90AE;

  if(var_27 < 0)
    var_27 = (gettime() - level._id_5CC7[self._id_5CC6]) / 1000.0;

  var_28 = self._id_90AD;
  var_29 = self._id_9A16;
  var_30 = self._id_9A17;
  var_31 = 0;

  if(isPlayer(var_2)) {
    setmatchdata("lives", var_0, "attacker", var_2.clientid);

    if(var_13 == -1)
      setmatchdata("lives", var_0, "attacker_life_index", 65535);
    else
      setmatchdata("lives", var_0, "attacker_life_index", var_13);

    setmatchdata("lives", var_0, "attacker_pos", 0, int(var_2.origin[0]));
    setmatchdata("lives", var_0, "attacker_pos", 1, int(var_2.origin[1]));
    setmatchdata("lives", var_0, "attacker_pos", 2, int(var_2.origin[2]));
    setmatchdata("lives", var_0, "attacker_angles", 0, int(var_2.angles[0]));
    setmatchdata("lives", var_0, "attacker_angles", 1, int(var_2.angles[1]));
    setmatchdata("lives", var_0, "attacker_angles", 2, int(var_2.angles[2]));

    if(isDefined(var_2._id_2942) && var_2._id_2942 >= 0)
      setmatchdata("lives", var_0, "attacker_minimap_callout_index", var_2._id_2942);
    else
      setmatchdata("lives", var_0, "attacker_minimap_callout_index", 255);

    var_32 = anglesToForward((0, self.angles[1], 0));
    var_33 = self.origin - var_2.origin;
    var_33 = vectorNormalize((var_33[0], var_33[1], 0));
    var_21 = vectordot(var_32, var_33);
    var_34 = var_21 * -1;

    if(var_34 >= _func_0A7(getdvarint("cg_fov", 65)))
      var_22 = 1;

    if(var_4 == "MOD_EXPLOSIVE" || var_4 == "MOD_GRENADE" || var_4 == "MOD_GRENADE_SPLASH" || var_4 == "MOD_PROJECTILE_SPLASH" || var_4 == "MOD_PROJECTILE" || var_4 == "MOD_MELEE" || var_4 == "MOD_MELEE_ALT" || var_4 == "MOD_MELEE_DOG" || maps\mp\_utility::_id_5697(var_4, var_5) || var_4 == "MOD_SUICIDE" || var_4 == "MOD_IMPACT" || var_4 == "MOD_TRIGGER_HURT" || var_4 == "MOD_FALLING" || var_4 == "MOD_CRUSH" || isDefined(level._id_5A7D) && isDefined(level._id_5A7D[var_5]))
      var_22 = -1;

    if(isDefined(self._id_1189) && isDefined(self._id_1189[var_2.guid]) && isDefined(self._id_1189[var_2.guid]._id_3C67))
      var_23 = self._id_1189[var_2.guid]._id_3C67;

    var_24 = -1;

    if(isDefined(self._id_A491))
      var_24 = isDefined(self._id_A491[var_2.guid]) && self._id_A491[var_2.guid]._id_A493 == var_2._id_5CC6;

    var_31 = 180 - _func_0AA(clamp(var_21, -1, 1));
    setmatchdata("lives", var_0, "dot_of_death", var_21);

    if(isDefined(var_2._id_6FBA) && isDefined(var_2._id_6FBA[var_15._id_A9E1]))
      setmatchdata("lives", var_0, "attacker_weapon_pickedup", 1);

    if(isDefined(var_2._id_2943))
      setmatchdata("lives", var_0, "attacker_loadout_index", var_2._id_2943);
  } else {
    setmatchdata("lives", var_0, "attacker", 255);
    setmatchdata("lives", var_0, "attacker_life_index", 65535);
    setmatchdata("lives", var_0, "attacker_pos", 0, int(self.origin[0]));
    setmatchdata("lives", var_0, "attacker_pos", 1, int(self.origin[1]));
    setmatchdata("lives", var_0, "attacker_pos", 2, int(self.origin[2]));
    setmatchdata("lives", var_0, "attacker_angles", 0, int(self.angles[0]));
    setmatchdata("lives", var_0, "attacker_angles", 1, int(self.angles[1]));
    setmatchdata("lives", var_0, "attacker_angles", 2, int(self.angles[2]));
    setmatchdata("lives", var_0, "attacker_minimap_callout_index", 255);
  }

  setmatchdata("lives", var_0, "player_index", self.clientid);
  setmatchdata("lives", var_0, "victim_pos", 0, int(self.origin[0]));
  setmatchdata("lives", var_0, "victim_pos", 1, int(self.origin[1]));
  setmatchdata("lives", var_0, "victim_pos", 2, int(self.origin[2]));
  setmatchdata("lives", var_0, "victim_angles", 0, int(self.angles[0]));
  setmatchdata("lives", var_0, "victim_angles", 1, int(self.angles[1]));
  setmatchdata("lives", var_0, "victim_angles", 2, int(self.angles[2]));

  if(isDefined(self._id_2942) && self._id_2942 >= 0)
    setmatchdata("lives", var_0, "victim_minimap_callout_index", self._id_2942);
  else
    setmatchdata("lives", var_0, "victim_minimap_callout_index", 255);

  var_35 = "world";

  if(isPlayer(var_2))
    var_35 = var_2.name;

  var_36 = 1;
  var_37 = 0;
  var_38 = maps\mp\_utility::_id_566A(self);
  var_39 = 0;

  if(isPlayer(var_2))
    var_39 = maps\mp\_utility::_id_566A(var_2);

  var_40 = length(self.origin - var_2.origin);
  var_41 = 0;
  var_42 = 0.0;
  var_43 = -1;
  var_44 = -1;
  var_45 = gettime();

  if(isPlayer(var_2))
    var_42 = var_2 _meth_8345();

  var_46 = var_2.clientid;

  if(!isDefined(var_46))
    var_46 = -1;

  var_47 = 8.2;
  var_48 = 4.0;
  var_49 = 2.0;

  if(self._id_29A2.size > 1)
    var_36 = 0;

  if(isDefined(self._id_29A2[var_2 getentitynumber()]))
    var_37 = self._id_29A2[var_2 getentitynumber()]._id_6875;

  var_50 = self._id_A9F6;
  var_51 = weaponclass(var_50);

  if(issubstr(var_15._id_A9E0, "loot"))
    var_41 = 1;

  if(isDefined(self._id_5CC6) && isDefined(level._id_5CC7[self._id_5CC6]))
    var_43 = (var_45 - level._id_5CC7[self._id_5CC6]) / 1000.0;

  if(isDefined(level._id_5CC7[var_13]) && isPlayer(var_2))
    var_44 = (var_45 - level._id_5CC7[var_13]) / 1000.0;

  var_54 = [];
  var_55 = [];

  for(var_56 = 0; var_56 < 9; var_56++) {
    if(isDefined(self._id_5DFA) && isDefined(self._id_5DFA[var_56]) && self._id_5DFA[var_56] != 0)
      var_54[var_56] = _func_311(self._id_5DFA[var_56]);
    else
      var_54[var_56] = "none";

    if(isDefined(var_2._id_5DFA) && isDefined(var_2._id_5DFA[var_56]) && var_2._id_5DFA[var_56] != 0) {
      var_55[var_56] = _func_311(var_2._id_5DFA[var_56]);
      continue;
    }

    var_55[var_56] = "none";
  }

  _func_0F6(self.origin, "script_mp_playerdeath: player_name %s, life_id %d, angles %v, death_dot %f, is_killstreak %b, mod %s, gameTime %d, spawnToDeathTime %f, attackerAliveTime %f, attacker_life_id %d, perk1 %s, perk2 %s, perk3 %s, perk4 %s, perk5 %s, perk6 %s, headOnHead %d, angle %f, damagedAttacker %d, damageDealtThisLife %f, damageRecievedThisLife %f, spawnToDamageReceivedTime %f, spawnToDamageDealtTime %f, timeSpentSprintingThisLife %f, timeSpentSprintingToFirstEngagement %f, spawnVersion %f, firstDamageHeadOnHead %d", self.name, self._id_5CC6, self.angles, var_21, maps\mp\_utility::iskillstreakweapon(var_15._id_A9E1), var_4, var_45, var_43, var_44, var_13, var_54[0], var_54[1], var_54[2], var_54[3], var_54[4], var_54[5], var_22, var_31, var_24, var_25, var_26, var_27, var_28, var_29, var_30, level._id_90B4, var_23);
  _func_0F6(self.origin, "script_mp_weaponinfo: player_name %s, life_id %d, isbot %b, attacker_name %s, attacker %d, attacker_pos %v, distance %f, ads_fraction %f, is_killstreak %b, weapon_type %s, weapon_class %s, weapon_name %s, isLoot %b, attachment0 %s, attachment1 %s, attachment2 %s, numShots %d, soleAttacker %b, gameTime %d, attachment3 %s, attachment4 %s, attachment5 %s", self.name, self._id_5CC6, var_38, var_35, var_46, var_2.origin, var_40, var_42, maps\mp\_utility::iskillstreakweapon(var_15._id_A9E1), var_15._id_A9F4, var_15._id_A9BF, var_15._id_A9E0, var_41, var_15._id_1154[0], var_15._id_1154[1], var_15._id_1154[2], var_37, var_36, var_45, var_15._id_1154[3], var_15._id_1154[4], var_15._id_1154[5]);
  _func_0F6(self.origin, "script_mp_weaponinfo_ext: player_name %s, life_id %d, gametime %d, version %f, victimWeapon %s, victimWeaponClass %s, killerIsBot %b, vic_attachment0 %s, vic_attachment1 %s, vic_attachment2 %s, vic_attachment3 %s, vic_attachment4 %s, vic_attachment5 %s, mechanics_version %f", self.name, self._id_5CC6, var_45, var_47, var_18._id_A9E0, var_18._id_A9BF, var_39, var_18._id_1154[0], var_18._id_1154[1], var_18._id_1154[2], var_18._id_1154[3], var_18._id_1154[4], var_18._id_1154[5], var_49);

  if(isDefined(var_2._id_5DFA) && isDefined(var_2._id_5DFA[0]) && isDefined(var_2._id_5DFA[1]) && isDefined(var_2._id_5DFA[2]) && isDefined(var_2._id_5DFA[3]) && isDefined(var_2._id_5DFA[4]) && isDefined(var_2._id_5DFA[5]) && isDefined(var_2._id_5DFA[6]) && isDefined(var_2._id_5DFA[7]) && isDefined(var_2._id_5DFA[8]))
    _func_0F6(self.origin, "script_mp_divisions_perks: player_name %s, life_id %d, gameTime %d, perkVersion %f, attacker_life_id %d, perk1 %s, perk2 %s, perk3 %s, perk4 %s, perk5 %s, perk6 %s, perk7 %s, perk8 %s, perk9 %s, attacker_perk1 %s, attacker_perk2 %s, attacker_perk3 %s, attacker_perk4 %s, attacker_perk5 %s, attacker_perk6 %s, attacker_perk7 %s, attacker_perk8 %s, attacker_perk9 %s", self.name, self._id_5CC6, var_45, var_48, var_13, var_54[0], var_54[1], var_54[2], var_54[3], var_54[4], var_54[5], var_54[6], var_54[7], var_54[8], var_55[0], var_55[1], var_55[2], var_55[3], var_55[4], var_55[5], var_55[6], var_55[7], var_55[8]);

  if(!isDefined(level._id_6026))
    level._id_6026 = [];

  if(!isDefined(game["deathCount"]))
    game["deathCount"] = 1;
  else
    game["deathCount"]++;

  if(var_43 <= 3.0) {
    if(isDefined(self.pers["victimSpawnCount"]))
      self.pers["victimSpawnCount"]++;

    if(isDefined(var_2) && isDefined(var_2.pers) && isDefined(var_2.pers["causedVictimSpawnCount"]))
      var_2.pers["causedVictimSpawnCount"]++;

    if(!isDefined(game["trapSpawnDiedTooFastCount"]))
      game["trapSpawnDiedTooFastCount"] = 1;
    else
      game["trapSpawnDiedTooFastCount"]++;

    if(self._id_9070._id_9CFD == 0) {
      if(!isDefined(game["trapSpawnByAnyMeansCount"]))
        game["trapSpawnByAnyMeansCount"] = 1;
      else
        game["trapSpawnByAnyMeansCount"]++;

      if(isDefined(self.pers["badSpawnByAnyMeansCount"]))
        self.pers["badSpawnByAnyMeansCount"]++;

      if(isDefined(var_2) && isDefined(var_2.pers) && isDefined(var_2.pers["causedBadSpawnByAnyMeansCount"]))
        var_2.pers["causedBadSpawnByAnyMeansCount"]++;

      self._id_9070._id_9CFD = 1;
    }
  }

  if(isPlayer(var_2) && var_44 <= 3.0 && !(var_15._id_A9E0 == "sentry_minigun_mp")) {
    if(isDefined(var_2) && isDefined(var_2.pers["victimSpawnCount"]))
      var_2.pers["victimSpawnCount"]++;

    if(!isDefined(game["trapSpawnKilledTooFastCount"]))
      game["trapSpawnKilledTooFastCount"] = 1;
    else
      game["trapSpawnKilledTooFastCount"]++;

    if(var_2._id_9070._id_9CFD == 0) {
      if(!isDefined(game["trapSpawnByAnyMeansCount"]))
        game["trapSpawnByAnyMeansCount"] = 1;
      else
        game["trapSpawnByAnyMeansCount"]++;

      var_2.pers["badSpawnByAnyMeansCount"]++;
      var_2._id_9070._id_9CFD = 1;
    }
  }

  if(_func_3BC()) {
    var_57 = self.origin;

    if(isDefined(self.fighterspawningfunc))
      var_57 = (clamp(var_57[0], -32767, 32767), clamp(var_57[1], -32767, 32767), clamp(var_57[2], -32767, 32767));

    var_58 = [int(var_57[0]), int(var_57[1]), int(var_57[2])];
    var_59 = getmatchdata("lives", var_0, "attacker_life_index");
    var_60 = getmatchdata("lives", var_59, "player_index");
    var_61 = var_58;

    if(isPlayer(var_2)) {
      var_62 = var_2.origin;

      if(isDefined(var_2.fighterspawningfunc))
        var_62 = (clamp(var_62[0], -32767, 32767), clamp(var_62[1], -32767, 32767), clamp(var_62[2], -32767, 32767));

      var_61 = [int(var_62[0]), int(var_62[1]), int(var_62[2])];
    }

    self _meth_8681("dtel_death", ["death", ["life_index", var_0, "player_index", self.clientid, "death_pos", var_58, "death_time_ms", var_17, "victim_weapon_guid", var_20.guid, "attacker_life_index", var_59, "attacker_player_index", var_60, "attacker_pos", var_61, "attacker_weapon_guid", var_14.guid]]);
  }
}

_id_5EA4() {
  if(!_id_1F55(self)) {
    return;
  }
  setmatchdata("players", self.clientid, "score", maps\mp\_utility::getpersstat("score"));

  if(maps\mp\_utility::getpersstat("assists") > 255)
    setmatchdata("players", self.clientid, "assists", 255);
  else
    setmatchdata("players", self.clientid, "assists", maps\mp\_utility::getpersstat("assists"));

  if(maps\mp\_utility::getpersstat("longestStreak") > 255)
    setmatchdata("players", self.clientid, "longest_streak", 255);
  else
    setmatchdata("players", self.clientid, "longest_streak", maps\mp\_utility::getpersstat("longestStreak"));

  if(isDefined(self) && isDefined(self.pers) && isDefined(self.pers["validationInfractions"])) {
    if(maps\mp\_utility::getpersstat("validationInfractions") > 255)
      setmatchdata("players", self.clientid, "validation_infractions", 255);
    else
      setmatchdata("players", self.clientid, "validation_infractions", maps\mp\_utility::getpersstat("validationInfractions"));
  }

  var_0 = -1;
  var_1 = -1;
  var_2 = -1;
  var_3 = -1;
  var_4 = -1;

  if(isDefined(self.pers["spawnCount"]))
    var_0 = self.pers["spawnCount"];

  if(isDefined(self.pers["immediateActionSpawnCount"]))
    var_1 = self.pers["immediateActionSpawnCount"];

  if(isDefined(self.pers["victimSpawnCount"]))
    var_2 = self.pers["victimSpawnCount"];

  if(isDefined(self.pers["causedImmediateActionSpawnCount"]))
    var_3 = self.pers["causedImmediateActionSpawnCount"];

  if(isDefined(self.pers["causedVictimSpawnCount"]))
    var_4 = self.pers["causedVictimSpawnCount"];

  setmatchdata("players", self.clientid, "spawns", maps\mp\_utility::_id_2315(var_0));
  setmatchdata("players", self.clientid, "immediate_action_spawns", maps\mp\_utility::_id_2315(var_1));
  setmatchdata("players", self.clientid, "victim_spawns", maps\mp\_utility::_id_2315(var_2));
  setmatchdata("players", self.clientid, "immediate_actions_caused", maps\mp\_utility::_id_2315(var_3));
  setmatchdata("players", self.clientid, "victim_spawns_caused", maps\mp\_utility::_id_2315(var_4));

  if(isDefined(level._id_585D) && level._id_585D) {
    return;
  }
  _id_0513::_id_A196();
  _id_04CA::updatedivisionusagestats();
  var_5 = 0;

  foreach(var_11, var_7 in self.pers["mpMatchdataWeaponStats"]) {
    if(var_5 < level._id_60A7) {
      foreach(var_10, var_9 in var_7)
      setmatchdata("players", self.clientid, "weapon_stats", var_5, var_10, var_9);

      var_5++;
    }
  }

  setmatchdata("players", self.clientid, "kills", maps\mp\_utility::_id_2315(self.pers["kills"]));
  setmatchdata("players", self.clientid, "deaths", maps\mp\_utility::_id_2315(self.pers["deaths"]));
  var_12 = self getplayerdata(common_scripts\utility::_id_46A7(), "callingCardIndex");
  var_13 = self getplayerdata(common_scripts\utility::_id_46A7(), "activeEmblemSlot");
  setmatchdata("players", self.clientid, "calling_card_index", var_12);
  setmatchdata("players", self.clientid, "active_emblem_slot", var_13);
}

_id_36DB() {
  foreach(var_1 in level.players) {
    waitframe();

    if(!isDefined(var_1)) {
      continue;
    }
    _id_5EA7(var_1);

    if(isDefined(var_1._id_2E50) && var_1._id_2E50 && var_1 maps\mp\_utility::rankingenabled())
      var_1 setplayerdata(common_scripts\utility::_id_46AE(), "restXPGoal", var_1._id_2E50);

    if(isDefined(var_1.pers["weaponsUsed"])) {
      var_1 _id_32C6();
      var_2 = 0;

      if(var_1.pers["weaponsUsed"].size > 3) {
        for(var_3 = var_1.pers["weaponsUsed"].size - 1; var_3 > var_1.pers["weaponsUsed"].size - 3; var_3--) {
          var_1 setplayerdata(common_scripts\utility::_id_46A7(), "round", "weaponsUsed", var_2, var_1.pers["weaponsUsed"][var_3]);
          var_1 setplayerdata(common_scripts\utility::_id_46A7(), "round", "weaponXpEarned", var_2, var_1.pers["weaponXpEarned"][var_3]);
          var_2++;
        }
      } else {
        for(var_3 = var_1.pers["weaponsUsed"].size - 1; var_3 >= 0; var_3--) {
          var_1 setplayerdata(common_scripts\utility::_id_46A7(), "round", "weaponsUsed", var_2, var_1.pers["weaponsUsed"][var_3]);
          var_1 setplayerdata(common_scripts\utility::_id_46A7(), "round", "weaponXpEarned", var_2, var_1.pers["weaponXpEarned"][var_3]);
          var_2++;
        }
      }
    } else {
      var_1 setplayerdata(common_scripts\utility::_id_46A7(), "round", "weaponsUsed", 0, "none");
      var_1 setplayerdata(common_scripts\utility::_id_46A7(), "round", "weaponsUsed", 1, "none");
      var_1 setplayerdata(common_scripts\utility::_id_46A7(), "round", "weaponsUsed", 2, "none");
      var_1 setplayerdata(common_scripts\utility::_id_46A7(), "round", "weaponXpEarned", 0, 0);
      var_1 setplayerdata(common_scripts\utility::_id_46A7(), "round", "weaponXpEarned", 1, 0);
      var_1 setplayerdata(common_scripts\utility::_id_46A7(), "round", "weaponXpEarned", 2, 0);
    }

    var_4 = undefined;
    var_5 = 0;

    if(isDefined(game["challengeStruct"]) && isDefined(game["challengeStruct"]["challengesCompleted"]) && isDefined(game["challengeStruct"]["challengesCompleted"][var_1.guid]))
      var_5 = 1;

    if(var_5) {
      var_4 = game["challengeStruct"]["challengesCompleted"][var_1.guid];

      if(var_4.size > 0) {
        var_1 setplayerdata(common_scripts\utility::_id_46A7(), "round", "challengeNumCompleted", var_4.size);
        var_6 = maps\mp\_utility::_id_2314(var_4.size);
        setmatchdata("players", var_1.clientid, "challenges_completed", var_6);
      } else
        var_1 setplayerdata(common_scripts\utility::_id_46A7(), "round", "challengeNumCompleted", 0);
    } else
      var_1 setplayerdata(common_scripts\utility::_id_46A7(), "round", "challengeNumCompleted", 0);

    for(var_3 = 0; var_3 < 20; var_3++) {
      if(isDefined(var_4) && isDefined(var_4[var_3]) && var_4[var_3] != 8000) {
        var_1 setplayerdata(common_scripts\utility::_id_46A7(), "round", "challengesCompleted", var_3, var_4[var_3]);
        continue;
      }

      var_1 setplayerdata(common_scripts\utility::_id_46A7(), "round", "challengesCompleted", var_3, 0);
    }

    var_1 setplayerdata(common_scripts\utility::_id_46A7(), "round", "gameMode", level.gametype);
    var_1 setplayerdata(common_scripts\utility::_id_46A7(), "round", "map", _func_117(getDvar("1673")));
  }
}

_id_32C6() {
  var_0 = self.pers["weaponXpEarned"];
  var_1 = self.pers["weaponXpEarned"].size;

  for(var_2 = var_1 - 1; var_2 > 0; var_2--) {
    for(var_3 = 1; var_3 <= var_2; var_3++) {
      if(var_0[var_3 - 1] < var_0[var_3]) {
        var_4 = self.pers["weaponsUsed"][var_3];
        self.pers["weaponsUsed"][var_3] = self.pers["weaponsUsed"][var_3 - 1];
        self.pers["weaponsUsed"][var_3 - 1] = var_4;
        var_5 = self.pers["weaponXpEarned"][var_3];
        self.pers["weaponXpEarned"][var_3] = self.pers["weaponXpEarned"][var_3 - 1];
        self.pers["weaponXpEarned"][var_3 - 1] = var_5;
        var_0 = self.pers["weaponXpEarned"];
      }
    }
  }
}

_id_5EA7(var_0) {
  if(!isDefined(var_0.pers["maxPing"]) || !isDefined(var_0.pers["minPing"]) || !isDefined(var_0.pers["pingAccumulation"]) || !isDefined(var_0.pers["pingSampleCount"])) {
    return;
  }
  if(var_0.pers["pingSampleCount"] > 0 && var_0.pers["maxPing"] > 0) {
    var_1 = maps\mp\_utility::_id_2315(var_0.pers["pingAccumulation"] / var_0.pers["pingSampleCount"]);
    setmatchdata("players", var_0.clientid, "average_ping", var_1);
    setmatchdata("players", var_0.clientid, "max_ping", maps\mp\_utility::_id_2315(var_0.pers["maxPing"]));
    setmatchdata("players", var_0.clientid, "min_ping", maps\mp\_utility::_id_2315(var_0.pers["minPing"]));
  }
}

_id_3F9E() {
  level waittill("game_ended");

  foreach(var_1 in level.players) {
    var_1 _id_5EA4();

    if(!isalive(var_1)) {
      continue;
    }
    var_1 _id_5EA6(0);
  }

  foreach(var_1 in level.players) {
    if(var_1._id_9AB6 > 0) {
      var_4 = var_1 maps\mp\_utility::getpersstat("score") / (var_1._id_9AB6 / 60000);
      _func_228(var_1._id_01D6, var_4, var_1.team);
    }

    var_1._id_9AB6 = 0;
  }
}

_id_1F55(var_0) {
  if(_func_367())
    return 0;

  if(!isPlayer(var_0) || _func_1EF(var_0))
    return 0;

  return var_0.clientid < level._id_608C;
}

_id_1F56() {
  return getmatchdata("match_common", "event_count") < level._id_6083;
}

_id_1F57() {
  return getmatchdata("killstreak_count") < level._id_6087;
}

_id_1F58() {
  return getmatchdata("killstreak_available_count") < level._id_6087;
}

_id_1F59(var_0) {
  return isDefined(var_0) && var_0 < level.maxlives - 1;
}

_id_5EAF(var_0, var_1, var_2, var_3) {
  if(!_id_1F55(self)) {
    return;
  }
  if(maps\mp\_utility::iskillstreakweapon(var_0)) {
    return;
  }
  if(!isDefined(self.pers["mpWeaponStats"][var_0]))
    self.pers["mpWeaponStats"][var_0] = [];

  if(!isDefined(self.pers["mpWeaponStats"][var_0][var_1]))
    self.pers["mpWeaponStats"][var_0][var_1] = 0;

  var_4 = self.pers["mpWeaponStats"][var_0][var_1];
  var_4 = var_4 + var_2;
  self.pers["mpWeaponStats"][var_0][var_1] = var_4;

  if(isDefined(level._id_585D) && level._id_585D) {
    return;
  }
  var_5 = isbot(self) || istestclient(self);

  if(!var_5) {
    var_6 = maps\mp\_utility::_id_473D(var_3);
    var_7 = var_6.guid;

    if(isDefined(var_7) && var_7 != 0) {
      if(isDefined(self._id_2943) && isDefined(self._id_294A) && isDefined(self._id_294C)) {
        if(var_7 == self._id_294A || var_7 == self._id_294C) {
          if(var_1 == "headShots")
            var_1 = "headshots";
          else if(var_1 == "timeInUse")
            var_1 = "time_in_use_seconds";
          else if(var_1 == "hipfirekills")
            var_1 = "hipfire_kills";
          else if(var_1 == "experience")
            var_1 = "xp";
          else if(var_1 == "shots" || var_1 == "hits" || var_1 == "kills" || var_1 == "deaths") {} else
            return;

          var_8 = var_7 + "_" + self._id_2943;

          if(!isDefined(self.pers["mpMatchdataWeaponStats"][var_8])) {
            self.pers["mpMatchdataWeaponStats"][var_8] = [];
            self.pers["mpMatchdataWeaponStats"][var_8]["weapon_guid"] = var_7;
            self.pers["mpMatchdataWeaponStats"][var_8]["loadout_index"] = self._id_2943;
          }

          if(!isDefined(self.pers["mpMatchdataWeaponStats"][var_8][var_1]))
            self.pers["mpMatchdataWeaponStats"][var_8][var_1] = 0;

          self.pers["mpMatchdataWeaponStats"][var_8][var_1] = self.pers["mpMatchdataWeaponStats"][var_8][var_1] + var_2;
        }
      }
    }
  }
}

_id_1D40() {
  var_0 = [];
  var_1 = _func_27A("mp/statstable.csv");

  for(var_2 = 0; var_2 <= var_1; var_2++) {
    var_3 = _func_1AE("mp/statstable.csv", var_2, 0);

    if(!issubstr(var_3, "weapon_")) {
      continue;
    }
    if(var_3 == "weapon_other") {
      continue;
    }
    if(_func_1AE("mp/statstable.csv", var_2, 20) != "") {
      continue;
    }
    var_4 = _func_1AE("mp/statstable.csv", var_2, 2);

    if(var_4 == "") {
      continue;
    }
    var_0[var_0.size] = var_4;
  }

  return var_0;
}

_id_5E97() {
  if(!_id_1F55(self)) {
    return;
  }
  setmatchdata("players", self.clientid, "kills_confirmed", self.pers["confirmed"]);
}

_id_5E98() {
  if(!_id_1F55(self)) {
    return;
  }
  setmatchdata("players", self.clientid, "kills_denied", self.pers["denied"]);
}

_id_5E95() {
  if(isDefined(level._id_585D) && level._id_585D) {
    return;
  }
  if(getdvarint("2506") > 0) {
    var_0 = self getplayerdata(common_scripts\utility::_id_46AE(), "experience");
    setmatchdata("players", self.clientid, "start_xp", var_0);
    setmatchdata("players", self.clientid, "start_kills", self getplayerdata(common_scripts\utility::_id_46AE(), "kills"));
    setmatchdata("players", self.clientid, "start_deaths", self getplayerdata(common_scripts\utility::_id_46AE(), "deaths"));
    setmatchdata("players", self.clientid, "start_wins", self getplayerdata(common_scripts\utility::_id_46AE(), "wins"));
    setmatchdata("players", self.clientid, "start_losses", self getplayerdata(common_scripts\utility::_id_46AE(), "losses"));
    setmatchdata("players", self.clientid, "start_hits", self getplayerdata(common_scripts\utility::_id_46AE(), "hits"));
    setmatchdata("players", self.clientid, "start_misses", self getplayerdata(common_scripts\utility::_id_46AE(), "misses"));
    setmatchdata("players", self.clientid, "start_games_played", self getplayerdata(common_scripts\utility::_id_46AE(), "gamesPlayed"));
    setmatchdata("players", self.clientid, "start_time_played_total", self getplayerdata(common_scripts\utility::_id_46AE(), "timePlayedTotal"));
    setmatchdata("players", self.clientid, "start_score", self getplayerdata(common_scripts\utility::_id_46AE(), "score"));
    setmatchdata("players", self.clientid, "start_unlock_points", self getplayerdata(common_scripts\utility::_id_46AE(), "unlockPoints"));
    setmatchdata("players", self.clientid, "start_prestige", self getplayerdata(common_scripts\utility::_id_46AE(), "prestige"));
    setmatchdata("players", self.clientid, "start_gdf_rating", self getplayerdata(common_scripts\utility::_id_46AE(), "gdfRating"));
    setmatchdata("players", self.clientid, "start_gdf_variance", self getplayerdata(common_scripts\utility::_id_46AE(), "gdfVariance"));
    setmatchdata("players", self.clientid, "start_sos_rating", self getplayerdata(common_scripts\utility::_id_46AE(), "sosRating"));
    setmatchdata("players", self.clientid, "start_sos_weight", self getplayerdata(common_scripts\utility::_id_46AE(), "sosWeight"));
    setmatchdata("players", self.clientid, "start_division_xp", "infantry", self getplayerdata(common_scripts\utility::_id_46AE(), "divisionStats", "infantry", "experience"));
    setmatchdata("players", self.clientid, "start_division_xp", "airborne", self getplayerdata(common_scripts\utility::_id_46AE(), "divisionStats", "airborne", "experience"));
    setmatchdata("players", self.clientid, "start_division_xp", "armored", self getplayerdata(common_scripts\utility::_id_46AE(), "divisionStats", "armored", "experience"));
    setmatchdata("players", self.clientid, "start_division_xp", "mountain", self getplayerdata(common_scripts\utility::_id_46AE(), "divisionStats", "mountain", "experience"));
    setmatchdata("players", self.clientid, "start_division_xp", "expeditionary", self getplayerdata(common_scripts\utility::_id_46AE(), "divisionStats", "expeditionary", "experience"));
    setmatchdata("players", self.clientid, "start_division_xp", "resistance", self getplayerdata(common_scripts\utility::_id_46AE(), "divisionStats", "resistance", "experience"));
    setmatchdata("players", self.clientid, "start_division_xp", "grenadier", self getplayerdata(common_scripts\utility::_id_46AE(), "divisionStats", "grenadier", "experience"));
    setmatchdata("players", self.clientid, "start_division_xp", "commando", self getplayerdata(common_scripts\utility::_id_46AE(), "divisionStats", "commando", "experience"));
    setmatchdata("players", self.clientid, "start_division_xp", "scout", self getplayerdata(common_scripts\utility::_id_46AE(), "divisionStats", "scout", "experience"));
    setmatchdata("players", self.clientid, "start_division_xp", "artillery", self getplayerdata(common_scripts\utility::_id_46AE(), "divisionStats", "artillery", "experience"));
    setmatchdata("players", self.clientid, "start_division_level", "infantry", self getplayerdata(common_scripts\utility::_id_46AE(), "divisionStats", "infantry", "level"));
    setmatchdata("players", self.clientid, "start_division_level", "airborne", self getplayerdata(common_scripts\utility::_id_46AE(), "divisionStats", "airborne", "level"));
    setmatchdata("players", self.clientid, "start_division_level", "armored", self getplayerdata(common_scripts\utility::_id_46AE(), "divisionStats", "armored", "level"));
    setmatchdata("players", self.clientid, "start_division_level", "mountain", self getplayerdata(common_scripts\utility::_id_46AE(), "divisionStats", "mountain", "level"));
    setmatchdata("players", self.clientid, "start_division_level", "expeditionary", self getplayerdata(common_scripts\utility::_id_46AE(), "divisionStats", "expeditionary", "level"));
    setmatchdata("players", self.clientid, "start_division_level", "resistance", self getplayerdata(common_scripts\utility::_id_46AE(), "divisionStats", "resistance", "level"));
    setmatchdata("players", self.clientid, "start_division_level", "grenadier", self getplayerdata(common_scripts\utility::_id_46AE(), "divisionStats", "grenadier", "level"));
    setmatchdata("players", self.clientid, "start_division_level", "commando", self getplayerdata(common_scripts\utility::_id_46AE(), "divisionStats", "commando", "level"));
    setmatchdata("players", self.clientid, "start_division_level", "scout", self getplayerdata(common_scripts\utility::_id_46AE(), "divisionStats", "scout", "level"));
    setmatchdata("players", self.clientid, "start_division_level", "artillery", self getplayerdata(common_scripts\utility::_id_46AE(), "divisionStats", "artillery", "level"));
    setmatchdata("players", self.clientid, "start_division_prestige", "infantry", self getplayerdata(common_scripts\utility::_id_46AE(), "divisionStats", "infantry", "prestigeLevel"));
    setmatchdata("players", self.clientid, "start_division_prestige", "airborne", self getplayerdata(common_scripts\utility::_id_46AE(), "divisionStats", "airborne", "prestigeLevel"));
    setmatchdata("players", self.clientid, "start_division_prestige", "armored", self getplayerdata(common_scripts\utility::_id_46AE(), "divisionStats", "armored", "prestigeLevel"));
    setmatchdata("players", self.clientid, "start_division_prestige", "mountain", self getplayerdata(common_scripts\utility::_id_46AE(), "divisionStats", "mountain", "prestigeLevel"));
    setmatchdata("players", self.clientid, "start_division_prestige", "expeditionary", self getplayerdata(common_scripts\utility::_id_46AE(), "divisionStats", "expeditionary", "prestigeLevel"));
    setmatchdata("players", self.clientid, "start_division_prestige", "resistance", self getplayerdata(common_scripts\utility::_id_46AE(), "divisionStats", "resistance", "prestigeLevel"));
    setmatchdata("players", self.clientid, "start_division_prestige", "grenadier", self getplayerdata(common_scripts\utility::_id_46AE(), "divisionStats", "grenadier", "prestigeLevel"));
    setmatchdata("players", self.clientid, "start_division_prestige", "commando", self getplayerdata(common_scripts\utility::_id_46AE(), "divisionStats", "commando", "prestigeLevel"));
    setmatchdata("players", self.clientid, "start_division_prestige", "scout", self getplayerdata(common_scripts\utility::_id_46AE(), "divisionStats", "scout", "prestigeLevel"));
    setmatchdata("players", self.clientid, "start_division_prestige", "artillery", self getplayerdata(common_scripts\utility::_id_46AE(), "divisionStats", "artillery", "prestigeLevel"));
    var_1 = 12;
    var_2 = self getplayerdata(common_scripts\utility::_id_46AE(), "ranked_play_current_season");

    if(var_2 >= 0 && var_2 < var_1) {
      setmatchdata("players", self.clientid, "ranked_play_current_season", var_2);
      setmatchdata("players", self.clientid, "start_mmr_current", self getplayerdata(common_scripts\utility::_id_46AE(), "ranked_play_season_data", var_2, "mmr_current"));
    }
  }
}

_id_5E92() {
  if(isDefined(level._id_585D) && level._id_585D) {
    return;
  }
  if(getdvarint("2506") > 0) {
    var_0 = self getplayerdata(common_scripts\utility::_id_46AE(), "experience");
    setmatchdata("players", self.clientid, "end_xp", var_0);
    setmatchdata("players", self.clientid, "end_kills", self getplayerdata(common_scripts\utility::_id_46AE(), "kills"));
    setmatchdata("players", self.clientid, "end_deaths", self getplayerdata(common_scripts\utility::_id_46AE(), "deaths"));
    setmatchdata("players", self.clientid, "end_wins", self getplayerdata(common_scripts\utility::_id_46AE(), "wins"));
    setmatchdata("players", self.clientid, "end_losses", self getplayerdata(common_scripts\utility::_id_46AE(), "losses"));
    setmatchdata("players", self.clientid, "end_hits", self getplayerdata(common_scripts\utility::_id_46AE(), "hits"));
    setmatchdata("players", self.clientid, "end_misses", self getplayerdata(common_scripts\utility::_id_46AE(), "misses"));
    setmatchdata("players", self.clientid, "end_games_played", self getplayerdata(common_scripts\utility::_id_46AE(), "gamesPlayed"));
    setmatchdata("players", self.clientid, "end_time_played_total", self getplayerdata(common_scripts\utility::_id_46AE(), "timePlayedTotal"));
    setmatchdata("players", self.clientid, "end_score", self getplayerdata(common_scripts\utility::_id_46AE(), "score"));
    setmatchdata("players", self.clientid, "end_unlock_points", self getplayerdata(common_scripts\utility::_id_46AE(), "unlockPoints"));
    setmatchdata("players", self.clientid, "end_prestige", self getplayerdata(common_scripts\utility::_id_46AE(), "prestige"));
    setmatchdata("players", self.clientid, "end_gdf_rating", self getplayerdata(common_scripts\utility::_id_46AE(), "gdfRating"));
    setmatchdata("players", self.clientid, "end_gdf_variance", self getplayerdata(common_scripts\utility::_id_46AE(), "gdfVariance"));
    setmatchdata("players", self.clientid, "end_sos_rating", self getplayerdata(common_scripts\utility::_id_46AE(), "sosRating"));
    setmatchdata("players", self.clientid, "end_sos_weight", self getplayerdata(common_scripts\utility::_id_46AE(), "sosWeight"));
    setmatchdata("players", self.clientid, "end_division_xp", "infantry", self getplayerdata(common_scripts\utility::_id_46AE(), "divisionStats", "infantry", "experience"));
    setmatchdata("players", self.clientid, "end_division_xp", "airborne", self getplayerdata(common_scripts\utility::_id_46AE(), "divisionStats", "airborne", "experience"));
    setmatchdata("players", self.clientid, "end_division_xp", "armored", self getplayerdata(common_scripts\utility::_id_46AE(), "divisionStats", "armored", "experience"));
    setmatchdata("players", self.clientid, "end_division_xp", "mountain", self getplayerdata(common_scripts\utility::_id_46AE(), "divisionStats", "mountain", "experience"));
    setmatchdata("players", self.clientid, "end_division_xp", "expeditionary", self getplayerdata(common_scripts\utility::_id_46AE(), "divisionStats", "expeditionary", "experience"));
    setmatchdata("players", self.clientid, "end_division_xp", "resistance", self getplayerdata(common_scripts\utility::_id_46AE(), "divisionStats", "resistance", "experience"));
    setmatchdata("players", self.clientid, "end_division_xp", "grenadier", self getplayerdata(common_scripts\utility::_id_46AE(), "divisionStats", "grenadier", "experience"));
    setmatchdata("players", self.clientid, "end_division_xp", "commando", self getplayerdata(common_scripts\utility::_id_46AE(), "divisionStats", "commando", "experience"));
    setmatchdata("players", self.clientid, "end_division_xp", "scout", self getplayerdata(common_scripts\utility::_id_46AE(), "divisionStats", "scout", "experience"));
    setmatchdata("players", self.clientid, "end_division_xp", "artillery", self getplayerdata(common_scripts\utility::_id_46AE(), "divisionStats", "artillery", "experience"));
    setmatchdata("players", self.clientid, "end_division_level", "infantry", self getplayerdata(common_scripts\utility::_id_46AE(), "divisionStats", "infantry", "level"));
    setmatchdata("players", self.clientid, "end_division_level", "airborne", self getplayerdata(common_scripts\utility::_id_46AE(), "divisionStats", "airborne", "level"));
    setmatchdata("players", self.clientid, "end_division_level", "armored", self getplayerdata(common_scripts\utility::_id_46AE(), "divisionStats", "armored", "level"));
    setmatchdata("players", self.clientid, "end_division_level", "mountain", self getplayerdata(common_scripts\utility::_id_46AE(), "divisionStats", "mountain", "level"));
    setmatchdata("players", self.clientid, "end_division_level", "expeditionary", self getplayerdata(common_scripts\utility::_id_46AE(), "divisionStats", "expeditionary", "level"));
    setmatchdata("players", self.clientid, "end_division_level", "resistance", self getplayerdata(common_scripts\utility::_id_46AE(), "divisionStats", "resistance", "level"));
    setmatchdata("players", self.clientid, "end_division_level", "grenadier", self getplayerdata(common_scripts\utility::_id_46AE(), "divisionStats", "grenadier", "level"));
    setmatchdata("players", self.clientid, "end_division_level", "commando", self getplayerdata(common_scripts\utility::_id_46AE(), "divisionStats", "commando", "level"));
    setmatchdata("players", self.clientid, "end_division_level", "scout", self getplayerdata(common_scripts\utility::_id_46AE(), "divisionStats", "scout", "level"));
    setmatchdata("players", self.clientid, "end_division_level", "artillery", self getplayerdata(common_scripts\utility::_id_46AE(), "divisionStats", "artillery", "level"));
    setmatchdata("players", self.clientid, "end_division_prestige", "infantry", self getplayerdata(common_scripts\utility::_id_46AE(), "divisionStats", "infantry", "prestigeLevel"));
    setmatchdata("players", self.clientid, "end_division_prestige", "airborne", self getplayerdata(common_scripts\utility::_id_46AE(), "divisionStats", "airborne", "prestigeLevel"));
    setmatchdata("players", self.clientid, "end_division_prestige", "armored", self getplayerdata(common_scripts\utility::_id_46AE(), "divisionStats", "armored", "prestigeLevel"));
    setmatchdata("players", self.clientid, "end_division_prestige", "mountain", self getplayerdata(common_scripts\utility::_id_46AE(), "divisionStats", "mountain", "prestigeLevel"));
    setmatchdata("players", self.clientid, "end_division_prestige", "expeditionary", self getplayerdata(common_scripts\utility::_id_46AE(), "divisionStats", "expeditionary", "prestigeLevel"));
    setmatchdata("players", self.clientid, "end_division_prestige", "resistance", self getplayerdata(common_scripts\utility::_id_46AE(), "divisionStats", "resistance", "prestigeLevel"));
    setmatchdata("players", self.clientid, "end_division_prestige", "grenadier", self getplayerdata(common_scripts\utility::_id_46AE(), "divisionStats", "grenadier", "prestigeLevel"));
    setmatchdata("players", self.clientid, "end_division_prestige", "commando", self getplayerdata(common_scripts\utility::_id_46AE(), "divisionStats", "commando", "prestigeLevel"));
    setmatchdata("players", self.clientid, "end_division_prestige", "scout", self getplayerdata(common_scripts\utility::_id_46AE(), "divisionStats", "scout", "prestigeLevel"));
    setmatchdata("players", self.clientid, "end_division_prestige", "artillery", self getplayerdata(common_scripts\utility::_id_46AE(), "divisionStats", "artillery", "prestigeLevel"));
    var_1 = 12;
    var_2 = self getplayerdata(common_scripts\utility::_id_46AE(), "ranked_play_current_season");

    if(var_2 >= 0 && var_2 < var_1) {
      setmatchdata("players", self.clientid, "end_mmr_min", self getplayerdata(common_scripts\utility::_id_46AE(), "ranked_play_season_data", var_2, "mmr_min"));
      setmatchdata("players", self.clientid, "end_mmr_max", self getplayerdata(common_scripts\utility::_id_46AE(), "ranked_play_season_data", var_2, "mmr_max"));
      setmatchdata("players", self.clientid, "end_mmr_current", self getplayerdata(common_scripts\utility::_id_46AE(), "ranked_play_season_data", var_2, "mmr_current"));
      setmatchdata("players", self.clientid, "end_weight_current", self getplayerdata(common_scripts\utility::_id_46AE(), "ranked_play_season_data", var_2, "weight_current"));
      setmatchdata("players", self.clientid, "end_ranked_games_completed", self getplayerdata(common_scripts\utility::_id_46AE(), "ranked_play_season_data", var_2, "ranked_games_completed"));
      setmatchdata("players", self.clientid, "end_ranked_games_abandoned", self getplayerdata(common_scripts\utility::_id_46AE(), "ranked_play_season_data", var_2, "ranked_games_abandoned"));
    }

    if(isDefined(self.pers["rank"])) {
      var_3 = maps\mp\_utility::_id_2314(maps\mp\gametypes\_rank::_id_4652());
      setmatchdata("players", self.clientid, "end_rank", var_3);
    }
  }
}

_id_7B2D() {
  for(;;) {
    if(getdvarint("3833") == 0) {
      foreach(var_1 in level.players) {
        var_2 = 0;

        if(maps\mp\_utility::isreallyalive(var_1))
          var_2 = 1;

        if(istestclient(var_1)) {
          continue;
        }
        if(!isDefined(var_1.origin)) {
          continue;
        }
        if(isDefined(var_1.sessionstate) && var_1.sessionstate == "spectator") {
          continue;
        }
        var_3 = "disconnected?";

        if(isDefined(var_1.name))
          var_3 = var_1.name;

        var_4 = -1;

        if(isDefined(var_1.clientid))
          var_4 = var_1.clientid;

        var_5 = (-999, -999, -999);

        if(isDefined(var_1.angles))
          var_5 = var_1.angles;

        var_6 = "undefined";

        if(isDefined(var_1.team))
          var_6 = var_1.team;

        var_7 = gettime();

        if(common_scripts\utility::_id_562E(level._id_585D)) {
          var_8 = common_scripts\utility::_id_98E7(isDefined(level._id_A980), level._id_A980, 0);
          var_9 = common_scripts\utility::_id_562E(var_1._id_00E8);
          var_10 = common_scripts\utility::_id_98E7(isDefined(var_1._id_20D8), var_1._id_20D8, 0);
          var_11 = ["Jefferson", "Drostan", "Marie", "Olivia", "Hunter", "Mountaineer", "Urban Survivalist", "B.A.T. Agent", "B.A.T. Elite", "Assassin"][var_10];

          if(!isDefined(var_11))
            var_11 = "";

          _func_0F6(var_1.origin, "script_zombie_playerpos: player %s,angles %v, game_time_ms %d,playerTeam %s,characterIndex %d, characterName %s, is_alive %b, is_last_stand %b, zombies_wave %d", var_3, var_5, var_7, var_6, var_10, var_11, var_2, var_9, var_8);
          continue;
        }

        _func_0F6(var_1.origin, "script_mp_playerpos: player_name %s, angles %v, gameTime %d, playerTeam %s, is_alive %b", var_3, var_5, var_7, var_6, var_2);
      }
    }

    wait 0.2;
  }
}

_id_5EAE() {
  if(level._id_585D) {
    return;
  }
  level endon("game_ended");

  while(isDefined(game["roundsPlayed"]) && game["roundsPlayed"] < level._id_609D) {
    var_0 = getmatchtimepassed();
    setmatchdata("rounds", game["roundsPlayed"], "start_time_ms", var_0);
    setmatchdata("rounds", game["roundsPlayed"], "is_overtime", maps\mp\_utility::inovertime());

    if(_func_3BC())
      level.players[0] _meth_8681("dtel_round_start", ["round_start", ["time_ms", var_0, "axis_score", _func_155("axis"), "allies_score", _func_155("allies"), "is_overtime", maps\mp\_utility::inovertime()]]);

    level waittill("round_switch", var_1);
  }
}

_id_5E91(var_0, var_1, var_2) {
  if(level._id_585D) {
    return;
  }
  var_3 = getmatchtimepassed();

  if(var_0 < level._id_609D) {
    setmatchdata("rounds", var_0, "end_time_ms", var_3);
    setmatchdata("rounds", var_0, "axis_score", var_1);
    setmatchdata("rounds", var_0, "allies_score", var_2);
  }

  setmatchdata("allies_score", var_2);
  setmatchdata("axis_score", var_1);

  if(_func_3BC())
    level.players[0] _meth_8681("dtel_round_end", ["round_end", ["time_ms", var_3, "axis_score", var_1, "allies_score", var_2, "is_overtime", maps\mp\_utility::inovertime()]]);
}