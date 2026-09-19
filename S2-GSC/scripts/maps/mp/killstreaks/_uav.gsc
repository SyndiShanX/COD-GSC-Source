/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\killstreaks\_uav.gsc
************************************************/

init() {
  level._effect["uav_exit"] = loadfx("vfx/trail/smoketrail_uav");
  level._effect["uav_trail"] = loadfx("vfx/trail/smoketrail_uav");
  level._effect["counter_recon_hit"] = loadfx("vfx/explosion/rocket_explosion_airburst");
  level._id_5A61["uav"] = ::_id_9E3B;
  level._id_5A61["counter_uav"] = ::_id_9E25;
  level._id_5A61["advanced_uav"] = ::_id_9E22;
  level._id_5A7D["counter_recon_gun_mp"] = "counter_uav";
  _id_2834();
  _id_5309();
  level thread onplayerconnect();
  level thread _id_9BA9();

  if(getdvarint("scr_game_radarMode") == 1)
    level thread updatesweepinguavstatus();
}

_id_9FDD(var_0, var_1) {
  var_2 = randomint(360);
  var_3 = _id_46FC(var_0._id_01C8);
  var_4 = _id_46FD(var_0._id_01C8);
  var_5 = _func_0A7(var_2) * var_4;
  var_6 = _func_0A6(var_2) * var_4;
  var_7 = level._id_9FDF;

  if(var_0._id_01C8 == "counter_uav")
    var_7 = level._id_28BA;

  var_0 _meth_8055(var_7, "tag_origin", (var_5, var_6, var_3), (0, var_2 - 90, 0));
  var_0 _meth_805C();
  var_0 _meth_808C();
  waitframe();
  var_8 = var_0.origin;
  var_0 _meth_8057();

  if(0 && isDefined(var_0._id_620D))
    var_0._id_620D _meth_8352(3000, 1);

  var_9 = 2625.0;

  if(var_0._id_01C8 == "counter_uav") {
    var_9 = 4200.0;
    thread _id_2692(var_0);
  }

  if(var_0._id_01C8 == "uav")
    thread _id_9FD6(var_0, var_1);

  var_0.origin = var_0.origin + -1 * anglesToForward(var_0.angles) * var_9;
  var_0 _meth_82B1(var_8, 3);
  var_0 _meth_82BB(20, 0.05);
  var_0 _meth_808C();
  level notify("uav_update");
  var_0 maps\mp\gametypes\_hostmigration::_id_A74C("death", 3);

  if(isDefined(var_0))
    var_0 _meth_8055(var_7, "tag_origin");
}

_id_9FDE(var_0, var_1) {
  var_0 _meth_8057();
  var_2 = 2625.0;

  if(var_0._id_01C8 == "counter_uav")
    var_2 = 4200.0;

  if(var_0._id_01C8 == "uav")
    thread _id_9FD7(var_0, var_1);

  var_3 = var_0.origin + anglesToForward(var_0.angles) * var_2;
  _func_147(common_scripts\utility::_id_44F5("uav_exit"), var_0, "tag_origin");
  var_0 notify("leaving");
  var_0._id_5745 = 1;

  if(0 && isDefined(var_0._id_620D))
    var_0._id_620D _meth_8352(3000, 0);

  var_0 _meth_82B1(var_3, 3);
  var_0 _meth_82BB(-20, 1.0);
  var_0 maps\mp\gametypes\_hostmigration::_id_A74C("death", 2.0);
  var_4 = _id_46FB(var_0._id_01C8, var_0.team);

  if(isDefined(var_4)) {
    var_0 setModel(var_4);
    var_0 _meth_8450(1, 0, 1.0);
  }

  wait 1.0;
  var_0 _id_0527::_id_2DD3();

  if(0 && isDefined(var_0._id_620D))
    var_0._id_620D delete();

  var_0 _id_7D02();
  var_0 delete();
}

_id_46FC(var_0) {
  var_1 = 0;

  switch (maps\mp\_utility::_id_4571()) {
    case "mp_aachen_v2":
      var_1 = _func_0A4(2250, 2500);
      break;
    case "mp_battleship_2":
      var_1 = _func_0A4(1500, 2000);
      break;
    case "mp_carentan_s2":
      var_1 = _func_0A4(1750, 2250);
      break;
    case "mp_canon_farm":
      var_1 = _func_0A4(1750, 2000);
      break;
    case "mp_flak_tower":
      var_1 = _func_0A4(2500, 3000);
      break;
    case "mp_france_cannon":
      var_1 = _func_0A4(1750, 2000);
      break;
    case "mp_gibraltar_01":
    case "mp_gibraltar_02":
      var_1 = _func_0A4(2250, 2500);
      break;
    case "mp_london":
      var_1 = _func_0A4(1750, 2000);
      break;
    case "mp_sandbox_01":
      var_1 = _func_0A4(1400, 1850);
      break;
    case "mp_hub_scorestreak_training":
    case "mp_scorstreak_training":
    case "mp_paris_s2":
    case "mp_airship":
    case "mp_d_day":
    case "mp_forest_01":
      var_1 = _func_0A4(3000, 3250);
      break;
    default:
      var_1 = _func_0A4(2000, 2250);
      break;
  }

  if(isDefined(var_0) && var_0 == "counter_uav")
    var_1 = var_1 + 1500;

  return var_1;
}

_id_46FD(var_0) {
  var_1 = 0;

  switch (maps\mp\_utility::_id_4571()) {
    case "mp_aachen_v2":
      var_1 = 3250;
      break;
    case "mp_carentan_s2":
    case "mp_carentan_s2_winter":
      var_1 = 3500;
      break;
    case "mp_canon_farm":
      var_1 = 4000;
      break;
    case "mp_flak_tower":
      var_1 = 4250;
      break;
    case "mp_forest_01":
      var_1 = 3500;
      break;
    case "mp_paris_s2":
      var_1 = 2500;
      break;
    case "mp_prague":
      var_1 = 3250;
      break;
    case "mp_sandbox_01":
      var_1 = 2000;
      break;
    case "mp_hub_scorestreak_training":
    case "mp_gibraltar_01":
    case "mp_scorstreak_training":
    case "mp_london":
    case "mp_battleship_2":
    case "mp_wolfslair2":
    case "mp_wolfslair_free":
    case "mp_wolfslair":
    case "mp_france_village":
    case "mp_d_day":
    case "mp_gibraltar_02":
    default:
      var_1 = 3000;
      break;
  }

  if(isDefined(var_0) && var_0 == "counter_uav")
    var_1 = var_1 + 2000;

  return var_1;
}

_id_46FA(var_0, var_1) {
  if(level.gametype == "onevone")
    return 200000;

  if(isDefined(var_1) && var_1) {
    switch (var_0) {
      case "uav":
        return 35;
      case "counter_uav":
        return 40;
      case "advanced_uav":
        return 45;
    }
  } else {
    switch (var_0) {
      case "counter_uav":
      case "uav":
        return 30;
      case "advanced_uav":
        return 45;
    }
  }
}

_id_2692(var_0) {
  _id_0380::_id_288B("ks_counter_uav_enter", undefined, var_0);
  var_1 = _id_0380::_id_288D("ks_counter_uav_loop", undefined, var_0, 1.5);
  var_0 waittill("leaving");
  _id_0380::_stoplocalsound(var_1, 1.5);
  _id_0380::_id_2889("ks_counter_uav_exit", undefined, var_0.origin);
}

_id_9FD6(var_0, var_1) {
  if(isDefined(var_1))
    _id_0380::_id_288B("ks_uav_recon_plane_enter", [var_1], var_0);
}

_id_9FD7(var_0, var_1) {
  if(isDefined(var_1))
    _id_0380::_id_6844("ks_uav_recon_plane_exit", [var_1], var_0);
}

_id_9FDB(var_0, var_1, var_2, var_3) {
  self notify("death");
  _id_0527::_id_2DD3();

  if(0 && isDefined(self._id_620D))
    self._id_620D delete();

  _id_7D02();
  self _meth_805C();
  thread _id_2D56();
  _id_74E7();

  if(self._id_01C8 == "counter_uav") {
    var_4 = "counter_uav_destroyed";
    var_5 = "callout_destroyed_counter_uav";
    var_6 = "cuav_destroyed";
  } else {
    var_4 = "uav_destroyed";
    var_5 = "callout_destroyed_uav";
    var_6 = "uav_destroyed";
  }

  maps\mp\gametypes\_damage::_id_6B4B(var_0, var_1, var_2, var_3, var_4, var_6, var_5, 1);
}

_id_2D56() {
  waitframe();

  if(isDefined(self))
    self delete();
}

_id_74E7() {
  var_0 = self.team;
  var_1 = anglesToForward(self.angles);

  if(self._id_01C8 == "counter_uav") {
    if(var_0 == "allies") {
      if(isDefined(self._id_57FB)) {
        if(!isDefined(level._effect["counter_uav_explode_allies_chase"]))
          level._effect["counter_uav_explode_allies_chase"] = loadfx("vfx/explosion/vehicle_counter_uav_explosion_allies_chase");

        playFX(common_scripts\utility::_id_44F5("counter_uav_explode_allies_chase"), self.origin, var_1);
      } else {
        if(!isDefined(level._effect["counter_uav_explode_allies"]))
          level._effect["counter_uav_explode_allies"] = loadfx("vfx/explosion/vehicle_counter_uav_explosion_allies");

        playFX(common_scripts\utility::_id_44F5("counter_uav_explode_allies"), self.origin, var_1);
        _id_0380::_id_2889("ks_plane_destruct_explode", undefined, self.origin);
        _id_0380::_id_288D("ks_plane_destruct_deathspin_long", undefined, self);
      }
    } else if(isDefined(self._id_57FB)) {
      if(!isDefined(level._effect["counter_uav_explode_axis_chase"]))
        level._effect["counter_uav_explode_axis_chase"] = loadfx("vfx/explosion/vehicle_counter_uav_explosion_chase");

      playFX(common_scripts\utility::_id_44F5("counter_uav_explode_axis_chase"), self.origin, var_1);
    } else {
      if(!isDefined(level._effect["counter_uav_explode_axis"]))
        level._effect["counter_uav_explode_axis"] = loadfx("vfx/explosion/vehicle_counter_uav_explosion");

      playFX(common_scripts\utility::_id_44F5("counter_uav_explode_axis"), self.origin, var_1);
      _id_0380::_id_2889("ks_plane_destruct_explode", undefined, self.origin);
      _id_0380::_id_288D("ks_plane_destruct_deathspin_long", undefined, self);
    }
  } else if(var_0 == "allies") {
    if(isDefined(self._id_57FB)) {
      if(!isDefined(level._effect["uav_explode_allies_chase"]))
        level._effect["uav_explode_allies_chase"] = loadfx("vfx/explosion/vehicle_uav_explosion_allies_chase");

      playFX(common_scripts\utility::_id_44F5("uav_explode_allies_chase"), self.origin, var_1);
    } else {
      if(!isDefined(level._effect["uav_explode_allies"]))
        level._effect["uav_explode_allies"] = loadfx("vfx/explosion/vehicle_uav_explosion_allies");

      playFX(common_scripts\utility::_id_44F5("uav_explode_allies"), self.origin, var_1);
      _id_0380::_id_2889("ks_plane_destruct_explode", undefined, self.origin);
      _id_0380::_id_288D("ks_plane_destruct_deathspin_long", undefined, self);
    }
  } else if(isDefined(self._id_57FB)) {
    if(!isDefined(level._effect["uav_explode_axis_chase"]))
      level._effect["uav_explode_axis_chase"] = loadfx("vfx/explosion/vehicle_uav_explosion_chase");

    playFX(common_scripts\utility::_id_44F5("uav_explode_axis_chase"), self.origin, var_1);
  } else {
    if(!isDefined(level._effect["uav_explode_axis"]))
      level._effect["uav_explode_axis"] = loadfx("vfx/explosion/vehicle_uav_explosion");

    playFX(common_scripts\utility::_id_44F5("uav_explode_axis"), self.origin, var_1);
    _id_0380::_id_2889("ks_plane_destruct_explode", undefined, self.origin);
    _id_0380::_id_288D("ks_plane_destruct_deathspin_long", undefined, self);
  }
}

_id_9BA9() {
  level endon("game_ended");

  for(;;) {
    level waittill("uav_update");

    if(level.teambased) {
      _id_A188("allies");
      _id_A188("axis");
    } else
      _id_A187();

    level notify("radar_status_change");
  }
}

_id_463C(var_0, var_1, var_2, var_3) {
  var_4 = 0;
  var_5 = 0;
  var_6 = 0;

  if(level.teambased) {
    var_4 = level._id_08E6[var_0];
    var_6 = level._id_08CD[var_0];
    var_5 = level._id_08D3[maps\mp\_utility::getotherteam(var_0)];
  } else {
    var_4 = level._id_08E6[var_1.guid];
    var_6 = level._id_08CD[var_1.guid];

    foreach(var_8 in level.players) {
      if(var_8 == var_1) {
        continue;
      }
      var_5 = var_5 + level._id_08D3[var_8.guid];
    }
  }

  var_10 = var_4;

  if(var_6 > 0)
    var_10 = 3;

  if(getdvarint("scr_game_radarMode") == 1)
    var_10++;

  return int(clamp(var_10, _func_174(), _func_11B()));
}

_id_A188(var_0) {
  var_1 = _id_463C(var_0);
  _func_172(var_0, var_1);
  var_2 = level._id_08D3[maps\mp\_utility::getotherteam(var_0)];
  var_3 = 0;
  var_4 = var_1 > _func_11C();
  var_5 = var_1 >= _func_11D();
  var_6 = var_1 >= _func_11E();

  if(maps\mp\_utility::_id_579B() && common_scripts\utility::_id_562E(level._id_79C1))
    var_0 = maps\mp\_utility::getotherteam(var_0);

  if(var_3)
    _func_11F(var_0);
  else
    _func_120(var_0);

  _func_170(var_0, var_4);

  if(var_5)
    level._id_014C[var_0] = "fast_radar";
  else
    level._id_014C[var_0] = "normal_radar";

  foreach(var_8 in level.players) {
    if(var_8.team != var_0) {
      continue;
    }
    var_8._id_014C = level._id_014C[var_0];
    var_8._id_0089 = level._id_014C[maps\mp\_utility::getotherteam(var_0)];
    var_8._id_014D = var_6;
    var_8 _id_A09F(var_4);
  }
}

_id_A187() {
  foreach(var_1 in level.players) {
    var_2 = var_1 _id_463C(var_1.team, var_1);
    var_3 = 0;

    foreach(var_5 in level.players) {
      if(var_5 == var_1) {
        continue;
      }
      var_3 = var_3 + level._id_08D3[var_5.guid];
    }

    var_7 = 0;
    var_8 = var_2 > _func_11C();
    var_9 = var_2 >= _func_11D();
    var_10 = var_2 >= _func_11E();
    var_1._id_014E = var_2;
    var_1._id_00DD = var_7;
    var_1._id_00B7 = var_8;
    var_1._id_014D = var_10;
    var_1 _id_A09F(var_8);

    if(var_9) {
      var_1._id_014C = "fast_radar";
      continue;
    }

    var_1._id_014C = "normal_radar";
  }
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);

    if(!level.teambased) {
      level._id_08E6[var_0.guid] = 0;
      level._id_08D3[var_0.guid] = 0;
      level._id_08CD[var_0.guid] = 0;
      level._id_014C[var_0.guid] = "normal_radar";
    }

    if(getdvarint("2043", 0))
      var_0 _meth_82FF("ui_hide_minimap", 1);

    var_0 thread onplayerspawned();
  }
}

onplayerspawned() {
  self endon("disconnect");

  for(;;) {
    self waittill("spawned_player");
    var_0 = 0;

    if(level.teambased) {
      var_0 = level._id_08D3[maps\mp\_utility::getotherteam(self.team)];
      continue;
    }

    foreach(var_2 in level.players) {
      if(var_2 == self) {
        continue;
      }
      var_0 = var_0 + level._id_08D3[var_2.guid];
    }
  }
}

updatesweepinguavstatus() {
  level endon("game_ended");

  while(!isDefined(level._id_5139) || level._id_5139 > 5)
    waitframe();

  level thread sweepinguavhandlehostmigration();
  level notify("uav_update");

  for(;;) {
    level waittill("player_spawned");
    level notify("uav_update");
  }
}

sweepinguavhandlehostmigration() {
  level endon("game_ended");
  level endon("disconnect");

  for(;;) {
    level waittill("host_migration_begin");
    var_0 = maps\mp\gametypes\_hostmigration::_id_A782();

    if(level.gametype == "gun" || level.gametype == "blades" || level.gametype == "aon" || level.gametype == "oitc") {
      _func_035("scr_game_compassRadarUpdateTime", 9);
      setDvar("4648", 9);
    }

    level notify("uav_update");
  }
}

_id_9E3B(var_0) {
  return _id_9E3C("uav");
}

_id_9E25(var_0) {
  return _id_9E3C("counter_uav");
}

_id_9E22(var_0) {
  return _id_9E3C("advanced_uav");
}

_id_9E3C(var_0) {
  if(maps\mp\_utility::_id_5668() || var_0 != "counter_uav" && maps\mp\_utility::_id_5814())
    return 0;

  var_1 = self.team;

  if(maps\mp\_utility::_id_579B() && common_scripts\utility::_id_562E(level._id_79C1))
    var_1 = maps\mp\_utility::getotherteam(var_1);

  var_2 = 0;

  if(level.teambased && level._id_9FDA[var_1].size > 5 || !level.teambased && level._id_9FDA.size > 10) {
    self iprintlnbold(&"KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
    return 0;
  }

  _id_0485::_id_5E9A(var_0, self.origin);

  if(var_0 == "uav" && getdvarint("4263", 0)) {
    var_3 = _id_83BC(var_0);

    if(!isDefined(var_3) || !var_3)
      return 0;

    return 1;
  } else if(var_0 == "counter_uav") {
    var_4 = _id_4475();

    if(isDefined(var_4)) {
      var_4._id_57FB = 1;
      var_4 _meth_82C3(0);
      level thread _id_5C24(self, var_1, var_4);
      return 1;
    }
  }

  level thread _id_5C30(self, var_1, var_0);
  return 1;
}

_id_09A8(var_0, var_1) {
  if(0) {
    self._id_620D = _func_190("script_model", (0, 0, 0));
    self._id_620D setModel("tag_origin");
    self._id_620D _meth_8351(var_0, var_1, 15, 15);
    self._id_620D linktosynchronizedparent(self, "", (0, 0, 0), (0, 0, 0));
    self._id_620D _meth_805C();
  }
}

_id_5C30(var_0, var_1, var_2, var_3) {
  var_4 = spawn("script_model", level._id_9FDF gettagorigin("tag_origin"));
  var_4 _meth_8384(var_0);
  var_4 _meth_8012(1);
  var_4 _meth_805C();
  var_4 _meth_808C();
  var_5 = _id_46FF(var_2, var_1);
  var_6 = _id_46FB(var_2, var_1);

  if(isDefined(var_6))
    var_4 thread _id_39C7(var_6, var_5);
  else
    var_4 setModel(var_5);

  var_7 = _id_46F8(var_2, var_1);

  if(isDefined(var_7) && var_7 != "")
    var_4 _meth_8276(var_7);

  var_4 thread _id_74E6();
  var_4 thread maps\mp\gametypes\_damage::_id_8676(_id_0527::_id_4612(var_2), undefined, ::_id_9FDB, _id_0527::_id_6B9C, 1);

  if(level.gametype == "onevone")
    var_4 _meth_82C3(0);

  if(isDefined(var_3))
    var_4._id_6DA6 = 1;
  else
    var_4._id_0117 = var_0;

  var_4._id_5C2F = gettime();
  var_4._id_01C8 = var_2;
  var_4.team = var_1;
  var_4 common_scripts\utility::_id_5FA9(var_1, undefined, undefined, 1);
  var_4 thread _id_0527::_id_2818();
  var_4 thread _id_0527::_id_4ACE();
  var_4 _id_09FE();
  var_4 _id_0992(var_2);

  if(isDefined(var_3)) {
    foreach(var_9 in level.players) {
      if(isDefined(var_9.team) && var_9.team == var_1)
        var_4 _id_09A8(var_9, _id_46FE(var_2));
    }
  } else
    var_4 _id_09A8(var_4._id_0117, _id_46FE(var_2));

  level notify("uav_update");
  level thread _id_051E::_id_A0DC();
  thread _id_9FDD(var_4, var_0);
  var_4 thread _id_A186();
  var_4 thread _id_2397(var_2, var_0);
  var_11 = 0;

  if((!isDefined(var_3) || var_3 == 0) && isDefined(var_4._id_0117)) {
    var_4 thread _id_6BBA();
    var_11 = var_4._id_0117 maps\mp\_utility::_hasperk("specialty_improvedstreaks");
  }

  var_4 maps\mp\gametypes\_hostmigration::_id_A74C("death", _id_46FA(var_2, var_11));

  if(isDefined(var_4))
    var_4 notify("cleanup_uav");
}

_id_6BBA() {
  level endon("game_ended");
  self endon("cleanup_uav");
  self._id_0117 common_scripts\utility::_id_A70A("disconnect", "joined_team", "joined_spectators");
  self notify("cleanup_uav");
}

_id_2397(var_0, var_1) {
  level endon("game_ended");
  self waittill("cleanup_uav");

  if(var_0 == "counter_uav")
    var_2 = "cuav_ended";
  else
    var_2 = "uav_ended";

  if(isDefined(var_1))
    var_1 thread maps\mp\_utility::leaderdialogonplayer(var_2);

  _id_7CCC(var_0);
  level notify("uav_update");

  if(self._id_006A < self.maxhealth && !isDefined(self._id_57FB))
    thread _id_9FDE(self, var_1);
}

_id_A186() {
  self endon("death");

  for(;;) {
    level common_scripts\utility::_id_A732("joined_team", "uav_update");
    self _meth_805C();

    foreach(var_1 in level.players) {
      if(level.teambased) {
        if(var_1.team != self.team || 1) {
          self _meth_8005(var_1);

          if(0 && isDefined(self._id_620D))
            self._id_620D _meth_8005(var_1);
        }

        continue;
      }

      if(isDefined(self._id_0117) && var_1 == self._id_0117) {
        continue;
      }
      self _meth_8005(var_1);

      if(0 && isDefined(self._id_620D))
        self._id_620D _meth_8005(var_1);
    }
  }
}

_id_2834() {
  var_0 = getEntArray("minimap_corner", "targetname");

  if(var_0.size)
    var_1 = _id_050D::_id_3B89(var_0[0].origin, var_0[1].origin);
  else
    var_1 = (0, 0, 0);

  level._id_9FDF = spawn("script_model", var_1);
  level._id_9FDF setModel("c130_zoomrig");
  level._id_9FDF.angles = (0, 115, 0);
  level._id_9FDF _meth_805C();
  level._id_9FDF.targetname = "uavrig_script_model";
  var_2 = 20053.5 / _id_46FD();
  level._id_9FDF thread _id_7EF0(var_2);
  level._id_28BA = spawn("script_model", var_1);
  level._id_28BA setModel("c130_zoomrig");
  level._id_28BA.angles = (0, 115, 0);
  level._id_28BA _meth_805C();
  var_2 = 40107.0 / _id_46FD("counter_uav");
  level._id_28BA thread _id_7EF0(var_2);
}

_id_7EF0(var_0) {
  var_1 = 60;
  var_2 = -1 * var_0 * var_1;

  for(;;) {
    self _meth_82BA(var_2, var_1);
    wait(var_1);
  }
}

_id_74E6() {
  self endon("death");
  level endon("game_ended");
  _func_147(level._effect["uav_trail"], self, "tag_origin");
}

_id_39C7(var_0, var_1) {
  self endon("death");
  self setModel(var_0);
  self _meth_8450(0, 1, 1.0);
  wait 1.0;
  self setModel(var_1);
}

_id_46FF(var_0, var_1) {
  switch (var_0) {
    case "advanced_uav":
    case "uav":
      if(isDefined(var_1) && var_1 == "allies")
        return "usa_recon_pipercub_ai";
      else
        return "ger_recon_storch";
    case "counter_uav":
      if(isDefined(var_1) && var_1 == "allies") {
        return "usa_bomber_p61_blackwidow_vista";
        return;
      }

      return "ger_recon_messerschmitt100_vista";
      return;
  }
}

_id_46FB(var_0, var_1) {
  switch (var_0) {
    case "advanced_uav":
    case "uav":
      if(isDefined(var_1) && var_1 == "allies")
        return "usa_recon_pipercub_ai_fade";
      else
        return "ger_recon_storch_fade";
    case "counter_uav":
      if(isDefined(var_1) && var_1 == "allies") {
        return "usa_bomber_p61_blackwidow_vista_fade";
        return;
      }

      return "ger_recon_messerschmitt100_vista_fade";
      return;
  }
}

_id_46F8(var_0, var_1) {
  switch (var_0) {
    case "advanced_uav":
    case "uav":
      if(isDefined(var_1) && var_1 == "allies")
        return "ks_recon_usa";
      else
        return "ks_recon_ger";
    case "counter_uav":
      if(isDefined(var_1) && var_1 == "allies") {
        return "ks_counter_intelligence_usa";
        return;
      }

      return "ks_counter_intelligence_ger";
      return;
  }
}

_id_46F9(var_0, var_1) {
  switch (var_0) {
    case "advanced_uav":
    case "uav":
      if(isDefined(var_1) && var_1 == "allies")
        return "ks_recon_usa_animated";
      else
        return "ks_recon_ger_animated";
    case "counter_uav":
      if(isDefined(var_1) && var_1 == "allies") {
        return "ks_counter_intelligence_usa_animated";
        return;
      }

      return "ks_counter_intelligence_ger_animated";
      return;
  }
}

_id_46FE(var_0) {
  switch (var_0) {
    case "advanced_uav":
    case "uav":
      return "scorestreak_minimap_recon";
    case "counter_uav":
      return "scorestreak_minimap_fighter";
  }
}

_id_5309() {
  if(level.teambased) {
    level._id_014C["allies"] = "normal_radar";
    level._id_014C["axis"] = "normal_radar";
    level._id_08E6["allies"] = 0;
    level._id_08E6["axis"] = 0;
    level._id_08D3["allies"] = 0;
    level._id_08D3["axis"] = 0;
    level._id_08CD["allies"] = 0;
    level._id_08CD["axis"] = 0;
    level._id_9FDA["allies"] = [];
    level._id_9FDA["axis"] = [];
  } else {
    level._id_014C = [];
    level._id_08E6 = [];
    level._id_08D3 = [];
    level._id_08CD = [];
    level._id_9FDA = [];
  }

  level._id_9FD9 = 15;
  level._id_9FD8 = 0;
}

_id_09FE() {
  var_0 = self.team;

  if(level.teambased)
    level._id_9FDA[var_0][level._id_9FDA[var_0].size] = self;
  else
    level._id_9FDA[self._id_0117.guid + "_" + gettime()] = self;
}

_id_7D02() {
  self _meth_8012(0);
  var_0 = self.team;

  if(level.teambased)
    level._id_9FDA[var_0] = common_scripts\utility::_id_0F98(self, level._id_9FDA[var_0]);
  else
    level._id_9FDA = common_scripts\utility::_id_0F98(self, level._id_9FDA);
}

_id_0992(var_0) {
  _id_0A05(var_0, 1);

  if(var_0 == "counter_uav") {
    if(level.teambased)
      level._id_9850[maps\mp\_utility::getotherteam(self.team)] = 1;
    else
      level._id_2694 = self._id_0117;

    level thread _id_0528::_id_A0E0();
  }
}

_id_7CCC(var_0) {
  _id_0A05(var_0, -1);

  if(var_0 == "counter_uav") {
    if(level.teambased) {
      if(level._id_08D3[self.team] == 0)
        level._id_9850[maps\mp\_utility::getotherteam(self.team)] = 0;
    } else if(isDefined(self._id_0117) && level._id_08D3[self._id_0117.guid] == 0)
      level._id_2694 = undefined;

    level thread _id_0528::_id_A0E0();
  }
}

_id_0A05(var_0, var_1) {
  switch (var_0) {
    case "uav":
      if(level.teambased)
        level._id_08E6[self.team] = level._id_08E6[self.team] + var_1;
      else if(isDefined(self._id_0117))
        level._id_08E6[self._id_0117.guid] = level._id_08E6[self._id_0117.guid] + var_1;

      break;
    case "counter_uav":
      if(level.teambased)
        level._id_08D3[self.team] = level._id_08D3[self.team] + var_1;
      else if(isDefined(self._id_0117))
        level._id_08D3[self._id_0117.guid] = level._id_08D3[self._id_0117.guid] + var_1;

      break;
    case "advanced_uav":
      if(level.teambased)
        level._id_08CD[self.team] = level._id_08CD[self.team] + var_1;
      else if(isDefined(self._id_0117))
        level._id_08CD[self._id_0117.guid] = level._id_08CD[self._id_0117.guid] + var_1;

      break;
  }
}

_id_27DD() {
  if(!isDefined(self._id_9846)) {
    self._id_9846 = _func_19B(self);
    self._id_9846.x = -350;
    self._id_9846.y = -70;
    self._id_9846.alignx = "center";
    self._id_9846.aligny = "middle";
    self._id_9846._id_00C6 = "center";
    self._id_9846._id_01CA = "middle";
    self._id_9846.fontscale = 1.0;
    self._id_9846.alpha = 1.0;
    self._id_6C0C = _func_19B(self);
    self._id_6C0C.x = -320;
    self._id_6C0C.y = -70;
    self._id_6C0C.alignx = "center";
    self._id_6C0C.aligny = "middle";
    self._id_6C0C._id_00C6 = "center";
    self._id_6C0C._id_01CA = "middle";
    self._id_6C0C.fontscale = 1.0;
    self._id_6C0C.alpha = 1.0;
    thread _id_A0F6();
  }
}

_id_A0F6() {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    if(level.gametype == "onevone" || self _meth_844A("ui_hide_minimap")) {
      self._id_9846.alpha = 0.0;
      self._id_6C0C.alpha = 0.0;
    } else {
      self._id_9846.alpha = 1.0;
      self._id_6C0C.alpha = 1.0;
    }

    var_0 = _id_463C(self.team, self);
    var_1 = _id_463C(maps\mp\_utility::getotherteam(self.team), self);
    self._id_9846 setvalue(var_0);
    self._id_6C0C setvalue(var_1);
    level waittill("uav_update");
  }
}

_id_A09F(var_0) {
  if(getdvarint("2043", 0)) {
    if(var_0)
      self _meth_82FF("ui_hide_minimap", 0);
    else
      self _meth_82FF("ui_hide_minimap", 1);
  }
}

_id_83BC(var_0) {
  self endon("stop_location_selection");

  if(!isDefined(level._id_5FF0))
    level._id_5FF0 = 1024;

  var_1 = level._id_5FF0 / 4;

  if(level.splitscreen)
    var_1 = var_1 * 1.5;

  var_2 = 0;
  maps\mp\_utility::_id_05D4(var_0, "map_artillery_selector", var_2, var_1);
  thread _id_A6D8();
  self waittill("confirm_location", var_3, var_4);
  self _meth_82DD(0, 0.3);
  self notify("location_selection_complete");
  thread _id_A22E(var_3);
  return 1;
}

_id_A22E(var_0) {
  var_1 = level._id_9FD8;
  level._id_9FD8++;

  foreach(var_3 in level.players) {
    if(!isPlayer(var_3) || isbot(var_3) || istestclient(var_3)) {
      continue;
    }
    if(var_3.team != self.team) {
      continue;
    }
    var_3 thread _id_47A6(var_1, self, var_0);
  }

  thread _id_479B(var_1, self, var_0);
  wait 30;
  level notify("uav_locational_destroyed_" + var_1);

  foreach(var_3 in level.players) {
    if(!isPlayer(var_3) || isbot(var_3) || istestclient(var_3)) {
      continue;
    }
    if(var_3.team != self.team) {
      continue;
    }
    var_3 thread _id_7CF4(var_1);
  }
}

_id_47A6(var_0, var_1, var_2) {
  var_3 = spawn("script_model", var_2);
  var_3.team = var_1.team;
  var_3._id_283E = var_1;
  var_3._id_502A = var_0;
  var_3 _meth_8011(self);

  if(isDefined(self._id_7B4E)) {
    self._id_7B4E = common_scripts\utility::_id_0FA0(self._id_7B4E);

    if(self._id_7B4E.size >= level._id_9FD9) {
      level _id_04F1::_id_2D49(self._id_7B4E[0]);
      self._id_7B4E[0] = undefined;
    }

    self._id_7B4E = common_scripts\utility::_id_0FA0(self._id_7B4E);
  } else
    self._id_7B4E = [];

  self._id_7B4E[self._id_7B4E.size] = var_3;
  thread _id_A6B7(var_0);
}

_id_7CF4(var_0) {
  if(isDefined(self._id_7B4E)) {
    self._id_7B4E = common_scripts\utility::_id_0FA0(self._id_7B4E);

    foreach(var_2 in self._id_7B4E) {
      if(var_2._id_502A == var_0) {
        level _id_04F1::_id_2D49(var_2);
        var_2 = undefined;
      }
    }

    self._id_7B4E = common_scripts\utility::_id_0FA0(self._id_7B4E);
  }
}

_id_A6B7(var_0) {
  level endon("game_ended");
  level endon("uav_locational_destroyed_" + var_0);
  common_scripts\utility::_id_A70A("disconnect", "joined_team", "joined_spectators");
  _id_7CF4(var_0);
}

_id_A6D8() {
  self endon("location_selection_complete");
  self endon("disconnect");
  self waittill("stop_location_selection");
  self _meth_82DD(0, 0.3);

  if(maps\mp\gametypes\_hostmigration::_id_A782() > 0)
    self switchtoweapon(common_scripts\utility::_id_4550());
}

_id_479B(var_0, var_1, var_2) {
  level endon("game_ended");
  level endon("uav_locational_destroyed_" + var_0);

  for(;;) {
    level waittill("connected", var_3);

    if(!isPlayer(var_3) || isbot(var_3) || istestclient(var_3)) {
      continue;
    }
    if(var_3.team != var_1.team) {
      continue;
    }
    var_3 thread _id_47A6(var_0, var_1, var_2);
  }
}

_id_4475() {
  var_0 = undefined;
  var_1 = level._id_9FDA;

  if(level.teambased)
    var_1 = level._id_9FDA[maps\mp\_utility::getotherteam(self.team)];

  foreach(var_3 in var_1) {
    if(!isDefined(var_3) || isDefined(var_3._id_5745) || isDefined(var_3._id_57FB)) {
      continue;
    }
    if(isDefined(var_0) && var_0._id_01C8 == "counter_uav" && var_3._id_01C8 != "counter_uav") {
      continue;
    }
    if(!level.teambased && isDefined(var_3._id_0117) && var_3._id_0117 == self) {
      continue;
    }
    var_0 = var_3;
  }

  return var_0;
}

_id_5C24(var_0, var_1, var_2, var_3) {
  while(isDefined(var_2) && !var_2 _meth_806F())
    waitframe();

  if(!isDefined(var_2)) {
    level thread _id_5C30(var_0, var_1, "counter_uav");
    return;
  }

  level thread _id_9FDC(var_2);
  var_4 = anglestoright((0, var_2.angles[1], 0));
  var_5 = var_2.origin + var_4 * -3200;
  var_6 = spawn("script_model", var_5);
  var_6.angles = var_2.angles + (0, -55, 0);
  _id_0380::_id_288B("ks_counter_uav_chase", undefined, var_6);

  if(var_2._id_01C8 == "counter_uav")
    _id_0380::_id_288B("ks_counter_uav_chase_target_lg", undefined, var_2);
  else
    _id_0380::_id_288B("ks_counter_uav_chase_target_sm", undefined, var_2);

  wait 0.5;
  var_7 = _id_46FF("counter_uav", var_1);
  var_8 = _id_46FB("counter_uav", var_1);

  if(isDefined(var_8))
    var_6 setModel(var_8);
  else
    var_6 setModel(var_7);

  var_9 = "ks_counter_intelligence_ger_attack";

  if(var_1 == "allies")
    var_9 = "ks_counter_intelligence_usa_attack";

  var_6 _meth_8278(var_9, "finished_chase_anim");

  if(isDefined(var_3))
    var_6._id_6DA6 = 1;
  else
    var_6._id_0117 = var_0;

  var_6._id_5C2F = gettime();
  var_6._id_01C8 = "counter_uav";

  if(isDefined(var_3)) {
    foreach(var_11 in level.players) {
      if(isDefined(var_11.team) && var_11.team == var_1)
        var_6 _id_09A8(var_11, _id_46FE("counter_uav"));
    }
  } else
    var_6 _id_09A8(var_6._id_0117, _id_46FE("counter_uav"));

  if(isDefined(var_8))
    var_6 _meth_8450(0, 1, 1.0);

  wait 1.0;
  var_6 setModel(var_7);
  wait 1.66;
  var_6 thread _id_2695(var_2, var_1);
  var_6 common_scripts\utility::_id_A70A("death", "finished_chase_anim");

  if(isDefined(var_8)) {
    var_6 setModel(var_8);
    var_6 _meth_8450(1, 0, 0.5);
    wait 0.5;
  }

  if(0 && isDefined(var_6._id_620D))
    var_6._id_620D delete();

  var_6 delete();
}

_id_2695(var_0, var_1) {
  self endon("death");
  var_2 = (134, 9, 39);
  var_3 = (134, -9, 39);

  if(var_1 == "allies") {
    var_2 = (111, 17, 13);
    var_3 = (111, -17, 13);
  }

  var_4 = 2.8;

  if(var_0._id_01C8 == "counter_uav")
    var_4 = 5.0;

  var_5 = gettime();

  for(var_6 = 0; var_6 < var_4 * 1000; var_6 = gettime() - var_5) {
    var_7 = anglesToForward(self.angles);
    var_8 = vectorNormalize(var_0.origin - self.origin);
    var_9 = vectordot(var_7, var_8);
    var_10 = self.origin + _func_112(var_2, self.angles);
    var_11 = var_10 + var_7 * 8000;
    _func_1B5("counter_recon_gun_mp", var_10, var_11);
    var_10 = self.origin + _func_112(var_3, self.angles);
    var_11 = var_10 + var_7 * 8000;
    _func_1B5("counter_recon_gun_mp", var_10, var_11);
    _id_0380::_id_2889("ks_fighter_strike_npc", undefined, self.origin);

    if(var_9 > 0.995) {
      var_12 = var_0 gettagorigin("TAG_DEATH_FX");
      playFX(common_scripts\utility::_id_44F5("counter_recon_hit"), var_12);
    }

    wait 0.1;
  }

  var_0 _meth_82C3(1);
  var_0 _meth_8059(var_0.maxhealth * 10, var_0.origin, self._id_0117, self, "MOD_RIFLE_BULLET", "counter_recon_gun_mp");

  if(var_0._id_01C8 == "counter_uav") {
    var_13 = var_0.origin;
    _id_0380::_id_2889("ks_plane_destruct_explode", undefined, var_13);
    _id_0380::_id_288D("ks_plane_destruct_deathspin_long", undefined, var_0);
  } else
    _id_0380::_id_2889("ks_plane_destruct_explode", undefined, var_0.origin);

  _id_0380::_id_288D("ks_plane_destruct_deathspin_long", undefined, var_0);
}

_id_9FDC(var_0) {
  var_0 notify("leaving");
  var_0 notify("death");
  var_0 _id_7D02();
  var_0 _meth_8057();
  var_1 = _id_46F9(var_0._id_01C8, var_0.team);
  var_0 _meth_8278(var_1, "finished_chase_anim");

  if(0 && isDefined(var_0._id_620D))
    var_0._id_620D _meth_8352(3000, 0);

  var_0 common_scripts\utility::_id_A70A("death", "finished_chase_anim");
  waitframe();
  waitframe();

  if(isDefined(var_0)) {
    var_0 _id_0527::_id_2DD3();

    if(0 && isDefined(var_0._id_620D))
      var_0._id_620D delete();

    var_0 delete();
  }
}