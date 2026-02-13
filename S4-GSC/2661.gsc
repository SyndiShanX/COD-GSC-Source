/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2661.gsc
*************************************************/

init() {
  level._effect["uav_exit"] = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
  level._effect["uav_trail"] = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
  level._effect["counter_recon_hit"] = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
  level thread _id_0A2C::_id_81DD();
  scripts\mp\killstreaks\killstreaks::_id_C26A("s2_uav", ::_id_F7A4);
}

_id_F8FC(var_0, var_1) {
  var_2 = randomint(360);
  var_3 = _id_6E19(var_0._id_04DE);
  var_4 = _id_6E1A(var_0._id_04DE);
  var_5 = cos(var_2) * var_4;
  var_6 = sin(var_2) * var_4;
  var_7 = level._id_F8FF;

  if(var_0._id_04DE == "counter_uav") {
    var_7 = level._id_4123;
  }

  var_0 linkto(var_7, "tag_origin", (var_5, var_6, var_3), (0, var_2 - 90, 0));
  var_0 hide();
  var_0 dontinterpolate();
  waitframe();
  var_8 = var_0.origin;
  var_0 unlink();

  if(0 && isDefined(var_0._id_9F23)) {
    var_0._id_9F23 _id_080C::_id_D557(3000, 1);
  }

  var_9 = 2625.0;

  if(var_0._id_04DE == "counter_uav") {
    var_9 = 4200.0;
    thread _id_3DA0(var_0);
  }

  if(var_0._id_04DE == "s2_uav") {
    thread _id_F8EF(var_0, var_1);
  }

  var_0.origin = var_0.origin + -1 * anglesToForward(var_0.angles) * var_9;
  var_0 moveto(var_8, 3);
  var_0 rotateroll(20, 0.05);
  var_0 dontinterpolate();
  level notify("uav_update");
  var_0 _id_080C::_id_108F6("death", 3);

  if(isDefined(var_0)) {
    var_0 linkto(var_7, "tag_origin");
  }
}

_id_F8FD(var_0, var_1) {
  var_0 unlink();
  var_2 = 2625.0;

  if(var_0._id_04DE == "counter_uav") {
    var_2 = 4200.0;
  }

  if(var_0._id_04DE == "s2_uav") {
    thread _id_F8F0(var_0, var_1);
  }

  var_3 = var_0.origin + anglesToForward(var_0.angles) * var_2;
  playFXOnTag(scripts\engine\utility::getfx("uav_exit"), var_0, "tag_origin");
  var_0 notify("leaving");
  var_0._id_8908 = 1;

  if(0 && isDefined(var_0._id_9F23)) {
    var_0._id_9F23 _id_080C::_id_D557(3000, 0);
  }

  var_0 moveto(var_3, 3);
  var_0 rotateroll(-20, 1.0);
  var_0 _id_080C::_id_108F6("death", 2.0);
  var_4 = _id_6E18(var_0._id_04DE, var_0.team);

  if(isDefined(var_4)) {
    var_0 setModel(var_4);
    var_0 _id_080C::_id_D6BF(1, 0, 1.0);
  }

  wait 1.0;
  var_0 _id_0A2D::_id_485A();

  if(0 && isDefined(var_0._id_9F23)) {
    var_0._id_9F23 delete();
  }

  var_0 _id_C539();
  var_0 delete();
}

_id_6E19(var_0) {
  var_1 = 0;

  switch (scripts\cp_mp\utility\game_utility::_id_6B2D()) {
    case "mp_aachen_v2":
      var_1 = randomintrange(2250, 2500);
      break;
    case "mp_battleship_2":
      var_1 = randomintrange(1500, 2000);
      break;
    case "mp_carentan_s2":
      var_1 = randomintrange(1750, 2250);
      break;
    case "mp_canon_farm":
      var_1 = randomintrange(1750, 2000);
      break;
    case "mp_flak_tower":
      var_1 = randomintrange(2500, 3000);
      break;
    case "mp_france_cannon":
      var_1 = randomintrange(1750, 2000);
      break;
    case "mp_gibraltar_01":
    case "mp_gibraltar_02":
      var_1 = randomintrange(2250, 2500);
      break;
    case "mp_london":
      var_1 = randomintrange(1750, 2000);
      break;
    case "mp_sandbox_01":
      var_1 = randomintrange(1400, 1850);
      break;
    case "mp_hub_scorestreak_training":
    case "mp_scorstreak_training":
    case "mp_paris_s2":
    case "mp_forest_01":
    case "mp_d_day":
    case "mp_airship":
      var_1 = randomintrange(3000, 3250);
      break;
    default:
      var_1 = randomintrange(2000, 2250);
      break;
  }

  if(isDefined(var_0) && var_0 == "counter_uav") {
    var_1 = var_1 + 1500;
  }

  return var_1;
}

_id_6E1A(var_0) {
  var_1 = 0;

  switch (scripts\cp_mp\utility\game_utility::_id_6B2D()) {
    case "mp_aachen_v2":
      var_1 = 3250;
      break;
    case "mp_carentan_s2_winter":
    case "mp_carentan_s2":
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
    case "mp_france_village":
    case "mp_d_day":
    case "mp_wolfslair2":
    case "mp_wolfslair_free":
    case "mp_wolfslair":
    case "mp_gibraltar_02":
    case "mp_battleship_2":
    default:
      var_1 = 3000;
      break;
  }

  if(isDefined(var_0) && var_0 == "counter_uav") {
    var_1 = var_1 + 2000;
  }

  return var_1;
}

_id_6E17(var_0, var_1) {
  if(level.gametype == "onevone") {
    return 200000;
  }

  if(isDefined(var_1) && var_1) {
    switch (var_0) {
      case "s2_uav":
        return 35;
      case "counter_uav":
        return 40;
      case "advanced_uav":
        return 45;
    }
  } else {
    switch (var_0) {
      case "s2_uav":
      case "counter_uav":
        return 30;
      case "advanced_uav":
        return 45;
    }
  }
}

_id_3DA0(var_0) {
  _id_080C::_id_40F5("ks_counter_uav_enter", undefined, var_0);
  var_1 = _id_080C::_id_40F6("ks_counter_uav_loop", undefined, var_0, 1.5);
  var_0 waittill("leaving");
  _id_080C::_id_40F7(var_1, 1.5);
  _id_080C::_id_40F4("ks_counter_uav_exit", undefined, var_0.origin);
}

_id_F8EF(var_0, var_1) {
  if(isDefined(var_1)) {
    _id_080C::_id_40F5("ks_uav_recon_plane_enter", [var_1], var_0);
  }
}

_id_F8F0(var_0, var_1) {
  if(isDefined(var_1)) {
    _id_080C::_id_A6DB("ks_uav_recon_plane_exit", [var_1], var_0);
  }
}

_id_F8FA(var_0, var_1, var_2, var_3) {
  self notify("death");
  _id_0A2D::_id_485A();

  if(0 && isDefined(self._id_9F23)) {
    self._id_9F23 delete();
  }

  _id_C539();
  self hide();
  thread _id_479B();
  _id_B915();

  if(self._id_04DE == "counter_uav") {
    var_4 = "counter_uav_destroyed";
    var_5 = "callout_destroyed_counter_uav";
    var_6 = "cuav_destroyed";
  } else {
    var_4 = "uav_destroyed";
    var_5 = "callout_destroyed_uav";
    var_6 = "uav_destroyed";
  }

  _id_080C::_id_AB18(var_0, var_1, var_2, var_3, var_4, var_6, var_5, 1);
}

_id_479B() {
  waitframe();

  if(isDefined(self)) {
    self delete();
  }
}

_id_B915() {
  var_0 = self.team;
  var_1 = anglesToForward(self.angles);

  if(self._id_04DE == "counter_uav") {
    if(var_0 == "allies") {
      if(isDefined(self._id_8A8E)) {
        if(!isDefined(level._effect["counter_uav_explode_allies_chase"])) {
          level._effect["counter_uav_explode_allies_chase"] = loadfx("vfx/explosion/vehicle_counter_uav_explosion_allies_chase");
        }

        playFX(scripts\engine\utility::getfx("counter_uav_explode_allies_chase"), self.origin, var_1);
      } else {
        if(!isDefined(level._effect["counter_uav_explode_allies"])) {
          level._effect["counter_uav_explode_allies"] = loadfx("vfx/explosion/vehicle_counter_uav_explosion_allies");
        }

        playFX(scripts\engine\utility::getfx("counter_uav_explode_allies"), self.origin, var_1);
        _id_080C::_id_40F4("ks_plane_destruct_explode", undefined, self.origin);
        _id_080C::_id_40F6("ks_plane_destruct_deathspin_long", undefined, self);
      }
    } else if(isDefined(self._id_8A8E)) {
      if(!isDefined(level._effect["counter_uav_explode_axis_chase"])) {
        level._effect["counter_uav_explode_axis_chase"] = loadfx("vfx/explosion/vehicle_counter_uav_explosion_chase");
      }

      playFX(scripts\engine\utility::getfx("counter_uav_explode_axis_chase"), self.origin, var_1);
    } else {
      if(!isDefined(level._effect["counter_uav_explode_axis"])) {
        level._effect["counter_uav_explode_axis"] = loadfx("vfx/explosion/vehicle_counter_uav_explosion");
      }

      playFX(scripts\engine\utility::getfx("counter_uav_explode_axis"), self.origin, var_1);
      _id_080C::_id_40F4("ks_plane_destruct_explode", undefined, self.origin);
      _id_080C::_id_40F6("ks_plane_destruct_deathspin_long", undefined, self);
    }
  } else if(var_0 == "allies") {
    if(isDefined(self._id_8A8E)) {
      if(!isDefined(level._effect["uav_explode_allies_chase"])) {
        level._effect["uav_explode_allies_chase"] = loadfx("vfx/explosion/vehicle_uav_explosion_allies_chase");
      }

      playFX(scripts\engine\utility::getfx("uav_explode_allies_chase"), self.origin, var_1);
    } else {
      if(!isDefined(level._effect["uav_explode_allies"])) {
        level._effect["uav_explode_allies"] = loadfx("vfx/explosion/vehicle_uav_explosion_allies");
      }

      playFX(scripts\engine\utility::getfx("uav_explode_allies"), self.origin, var_1);
      _id_080C::_id_40F4("ks_plane_destruct_explode", undefined, self.origin);
      _id_080C::_id_40F6("ks_plane_destruct_deathspin_long", undefined, self);
    }
  } else if(isDefined(self._id_8A8E)) {
    if(!isDefined(level._effect["uav_explode_axis_chase"])) {
      level._effect["uav_explode_axis_chase"] = loadfx("vfx/explosion/vehicle_uav_explosion_chase");
    }

    playFX(scripts\engine\utility::getfx("uav_explode_axis_chase"), self.origin, var_1);
  } else {
    if(!isDefined(level._effect["uav_explode_axis"])) {
      level._effect["uav_explode_axis"] = loadfx("vfx/explosion/vehicle_uav_explosion");
    }

    playFX(scripts\engine\utility::getfx("uav_explode_axis"), self.origin, var_1);
    _id_080C::_id_40F4("ks_plane_destruct_explode", undefined, self.origin);
    _id_080C::_id_40F6("ks_plane_destruct_deathspin_long", undefined, self);
  }
}

_id_F404() {
  level endon("game_ended");

  for(;;) {
    level waittill("uav_update");

    if(level.teambased) {
      _id_FD73("allies");
      _id_FD73("axis");
    } else
      _id_FD72();

    level notify("radar_status_change");
  }
}

_id_6CB5(var_0, var_1, var_2, var_3) {
  var_4 = 0;
  var_5 = 0;
  var_6 = 0;

  if(level.teambased) {
    var_4 = level._id_0F66[var_0];
    var_6 = level._id_0F37[var_0];
    var_5 = level._id_0F3D[scripts\mp\utility\game::_id_6BE2(var_0)];
  } else {
    var_4 = level._id_0F66[var_1.guid];
    var_6 = level._id_0F37[var_1.guid];

    foreach(var_8 in level.players) {
      if(var_8 == var_1) {
        continue;
      }
      var_5 = var_5 + level._id_0F3D[var_8.guid];
    }
  }

  var_10 = var_4;

  if(var_6 > 0) {
    var_10 = 3;
  }

  if(getdvarint("#x3e584d37a0bc09c7f") == 1) {
    var_10++;
  }

  return int(clamp(var_10, _func_00E4(), _func_00E3()));
}

_id_FD73(var_0) {
  var_1 = _id_6CB5(var_0);
  _func_01F7(var_0, var_1);
  var_2 = level._id_0F3D[scripts\mp\utility\game::_id_6BE2(var_0)];
  var_3 = 0;
  var_4 = var_1 > _func_00E0();
  var_5 = var_1 >= _func_00E2();
  var_6 = var_1 >= _func_00E1();

  if(_id_080C::_id_89D7() && _id_080C::_id_86F0(level._id_BF5B)) {
    var_0 = scripts\mp\utility\game::_id_6BE2(var_0);
  }

  if(var_3) {
    _func_001C(var_0);
  } else {
    _func_0254(var_0);
  }

  _func_01F6(var_0, var_4);

  if(var_5) {
    level.radarmode[var_0] = "fast_radar";
  } else {
    level.radarmode[var_0] = "normal_radar";
  }

  foreach(var_8 in level.players) {
    if(var_8.team != var_0) {
      continue;
    }
    var_8.radarmode = level.radarmode[var_0];
    var_8._id_5427 = level.radarmode[scripts\mp\utility\game::_id_6BE2(var_0)];
    var_8.radarshowenemydirection = var_6;
    var_8 _id_FB48(var_4);
  }
}

_id_FD72() {
  foreach(var_1 in level.players) {
    var_2 = var_1 _id_6CB5(var_1.team, var_1);
    var_3 = 0;

    foreach(var_5 in level.players) {
      if(var_5 == var_1) {
        continue;
      }
      var_3 = var_3 + level._id_0F3D[var_5.guid];
    }

    var_7 = 0;
    var_8 = var_2 > _func_00E0();
    var_9 = var_2 >= _func_00E2();
    var_10 = var_2 >= _func_00E1();
    var_1._id_0358 = var_2;
    var_1._id_024A = var_7;
    var_1.hasradar = var_8;
    var_1.radarshowenemydirection = var_10;
    var_1 _id_FB48(var_8);

    if(var_9) {
      var_1.radarmode = "fast_radar";
      continue;
    }

    var_1.radarmode = "normal_radar";
  }
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);

    if(!level.teambased) {
      level._id_0F66[var_0.guid] = 0;
      level._id_0F3D[var_0.guid] = 0;
      level._id_0F37[var_0.guid] = 0;
      level.radarmode[var_0.guid] = "normal_radar";
    }

    if(getdvarint("#x3af383f37c3a10748", 0)) {}

    var_0 thread onplayerspawned();
  }
}

onplayerspawned() {
  self endon("disconnect");

  for(;;) {
    self waittill("spawned_player");
    var_0 = 0;

    if(level.teambased) {
      var_0 = level._id_0F3D[scripts\mp\utility\game::_id_6BE2(self.team)];
      continue;
    }

    foreach(var_2 in level.players) {
      if(var_2 == self) {
        continue;
      }
      var_0 = var_0 + level._id_0F3D[var_2.guid];
    }
  }
}

_id_FD50() {
  level endon("game_ended");

  while(!isDefined(level._id_7EB0) || level._id_7EB0 > 5) {
    waitframe();
  }

  level thread _id_EC16();
  level notify("uav_update");

  for(;;) {
    level waittill("player_spawned");
    level notify("uav_update");
  }
}

_id_EC16() {
  level endon("game_ended");
  level endon("disconnect");

  for(;;) {
    level waittill("host_migration_begin");
    var_0 = _id_080C::waittillhostmigrationdone();

    if(level.gametype == "gun" || level.gametype == "blades" || level.gametype == "aon" || level.gametype == "oitc") {
      setdynamicdvar("#x3b3592e696710df6c", 9);
      setDvar("#x333af614343d69c10", 9);
    }

    level notify("uav_update");
  }
}

_id_F7A4(var_0) {
  return _id_F7A5(var_0, "s2_uav");
}

_id_F773(var_0) {
  return _id_F7A5(var_0, "s2_uav");
}

_id_F766(var_0) {
  return _id_F7A5(var_0, "s2_uav");
}

_id_F7A5(var_0, var_1) {
  var_2 = 0;

  if(isDefined(level._id_8DEB)) {
    if(!level[[level._id_8DEB]](var_0)) {
      return 0;
    }
  }

  if(isDefined(level._id_8DC6)) {
    if(!level[[level._id_8DC6]](var_0)) {
      return 0;
    }
  }

  if(scripts\mp\utility\game::_id_873C() || var_1 != "counter_uav" && _id_080C::_id_8ABD()) {
    return 0;
  }

  var_3 = self.team;

  if(_id_080C::_id_89D7() && _id_080C::_id_86F0(level._id_BF5B)) {
    var_3 = scripts\mp\utility\game::_id_6BE2(var_3);
  }

  var_4 = 0;

  if(level.teambased && level._id_F8F8[var_3].size > 5 || !level.teambased && level._id_F8F8.size > 10) {
    scripts\mp\hud_message::_id_DCC0("KILLSTREAKS/AIR_SPACE_TOO_CROWDED");
    return 0;
  }

  _id_080C::_id_97A4(var_1, self.origin);

  if(var_1 == "s2_uav" && getdvarint("#x39d86bd14e2279467", 0)) {
    var_5 = _id_D076(var_1);

    if(!isDefined(var_5) || !var_5) {
      return 0;
    }

    return 1;
  } else if(var_1 == "counter_uav") {
    var_6 = _id_698B();

    if(isDefined(var_6)) {
      var_6._id_8A8E = 1;
      var_6 setCanDamage(0);
      level thread _id_90EA(self, var_3, var_6);
      return 1;
    }
  }

  level thread _id_9103(self, var_3, var_1);
  return 1;
}

_id_109D(var_0, var_1) {
  if(0) {
    self._id_9F23 = _id_080C::_id_E289("script_model", (0, 0, 0));
    self._id_9F23 setModel("tag_origin");
    self._id_9F23 _id_080C::_id_D5AC(var_0, var_1, 15, 15);
    self._id_9F23 _id_080C::_id_9519(self, "", (0, 0, 0), (0, 0, 0));
    self._id_9F23 hide();
  }
}

_id_9103(var_0, var_1, var_2, var_3) {
  var_4 = spawn("script_model", level._id_F8FF gettagorigin("tag_origin"));
  var_4 _meth_82F9(var_0);
  var_4 _id_080C::_id_9B29(1);
  var_4 hide();
  var_4 dontinterpolate();
  var_5 = _id_6E1C(var_2, var_1);
  var_6 = _id_6E18(var_2, var_1);

  if(isDefined(var_6)) {
    var_4 thread _id_58B9(var_6, var_5);
  } else {
    var_4 setModel(var_5);
  }

  var_7 = _id_6E15(var_2, var_1);

  if(isDefined(var_7) && var_7 != "") {
    var_4 _meth_82CB(var_7);
  }

  var_4 thread _id_B903();
  var_4 thread _id_080C::_id_D542(_id_0A2D::_id_6C37(var_2), undefined, ::_id_F8FA, _id_0A2D::_id_AB96, 1);

  if(level.gametype == "onevone") {
    var_4 setCanDamage(0);
  }

  if(isDefined(var_3)) {
    var_4._id_AD9C = 1;
  } else {
    var_4.owner = var_0;
  }

  var_4._id_9102 = gettime();
  var_4._id_04DE = var_2;
  var_4._id_F904 = var_2;
  var_4.team = var_1;
  var_4 _id_080C::_id_99A1(var_1, undefined, undefined, 1);
  var_4 thread _id_0A2D::_id_4013();
  var_4 thread _id_0A2D::_id_745A();
  var_4 _id_1182();
  var_4 _id_1088(var_2);

  if(isDefined(var_3)) {
    foreach(var_9 in level.players) {
      if(isDefined(var_9.team) && var_9.team == var_1) {
        var_4 _id_109D(var_9, _id_6E1B(var_2));
      }
    }
  } else
    var_4 _id_109D(var_4.owner, _id_6E1B(var_2));

  level notify("uav_update");
  level thread _id_080C::_id_FBF4();
  thread _id_F8FC(var_4, var_0);
  var_4 thread _id_FD70();
  var_4 thread _id_38A4(var_2, var_0);
  var_11 = 0;

  if((!isDefined(var_3) || var_3 == 0) && isDefined(var_4.owner)) {
    var_4 thread _id_ABC6();
    var_11 = var_4.owner _id_080C::_hasperk("specialty_improvedstreaks");
  }

  var_4 _id_080C::_id_108F6("death", _id_6E17(var_2, var_11));

  if(isDefined(var_4)) {
    var_4 notify("cleanup_uav");
  }
}

_id_ABC6() {
  level endon("game_ended");
  self endon("cleanup_uav");
  self.owner scripts\engine\utility::_id_1087F("disconnect", "joined_team", "joined_spectators");
  self notify("cleanup_uav");
}

_id_38A4(var_0, var_1) {
  level endon("game_ended");
  self waittill("cleanup_uav");

  if(var_0 == "counter_uav") {
    var_2 = "cuav_ended";
  } else {
    var_2 = "uav_ended";
  }

  if(isDefined(var_1)) {
    var_1 thread _id_080C::_id_9137(var_2);
  }

  _id_C468(var_0);
  level notify("uav_update");

  if(self._id_014E < self.maxhealth && !isDefined(self._id_8A8E)) {
    thread _id_F8FD(self, var_1);
  }
}

_id_FD70() {
  self endon("death");

  for(;;) {
    level scripts\engine\utility::_id_108C5("joined_team", "uav_update");
    self hide();

    foreach(var_1 in level.players) {
      if(level.teambased) {
        if(var_1.team != self.team || 1) {
          self showtoplayer(var_1);

          if(0 && isDefined(self._id_9F23)) {
            self._id_9F23 showtoplayer(var_1);
          }
        }

        continue;
      }

      if(isDefined(self.owner) && var_1 == self.owner) {
        continue;
      }
      self showtoplayer(var_1);

      if(0 && isDefined(self._id_9F23)) {
        self._id_9F23 showtoplayer(var_1);
      }
    }
  }
}

_id_406B() {
  var_0 = getEntArray("minimap_corner", "targetname");

  if(var_0.size) {
    var_1 = _id_080C::_id_5AE1(var_0[0].origin, var_0[1].origin);
  } else {
    var_1 = (0, 0, 0);
  }

  level._id_F8FF = spawn("script_model", var_1);
  level._id_F8FF setModel("c130_zoomrig");
  level._id_F8FF.angles = (0, 115, 0);
  level._id_F8FF hide();
  level._id_F8FF._id_0481 = "uavrig_script_model";
  var_2 = 20053.5 / _id_6E1A();
  level._id_F8FF thread _id_C929(var_2);
  level._id_4123 = spawn("script_model", var_1);
  level._id_4123 setModel("c130_zoomrig");
  level._id_4123.angles = (0, 115, 0);
  level._id_4123 hide();
  var_2 = 40107.0 / _id_6E1A("counter_uav");
  level._id_4123 thread _id_C929(var_2);
}

_id_C929(var_0) {
  var_1 = 60;
  var_2 = -1 * var_0 * var_1;

  for(;;) {
    self rotateyaw(var_2, var_1);
    wait(var_1);
  }
}

_id_B903() {
  self endon("death");
  level endon("game_ended");
  playFXOnTag(level._effect["uav_trail"], self, "tag_origin");
}

_id_58B9(var_0, var_1) {
  self endon("death");
  self setModel(var_0);
  _id_080C::_id_D6BF(0, 1, 1.0);
  wait 1.0;
  self setModel(var_1);
}

_id_6E1C(var_0, var_1) {
  switch (var_0) {
    case "advanced_uav":
    case "s2_uav":
      if(isDefined(var_1) && var_1 == "allies") {
        return "usa_recon_pipercub_ai";
      } else {
        return "ger_recon_storch";
      }
    case "counter_uav":
      if(isDefined(var_1) && var_1 == "allies") {
        return "usa_bomber_p61_blackwidow_vista";
        return;
      }

      return "ger_recon_messerschmitt100_vista";
      return;
  }
}

_id_6E18(var_0, var_1) {
  switch (var_0) {
    case "advanced_uav":
    case "s2_uav":
      if(isDefined(var_1) && var_1 == "allies") {
        return "usa_recon_pipercub_ai_fade";
      } else {
        return "ger_recon_storch_fade";
      }
    case "counter_uav":
      if(isDefined(var_1) && var_1 == "allies") {
        return "usa_bomber_p61_blackwidow_vista_fade";
        return;
      }

      return "ger_recon_messerschmitt100_vista_fade";
      return;
  }
}

_id_6E15(var_0, var_1) {
  switch (var_0) {
    case "advanced_uav":
    case "s2_uav":
      if(isDefined(var_1) && var_1 == "allies") {
        return "ks_recon_usa";
      } else {
        return "ks_recon_ger";
      }
    case "counter_uav":
      if(isDefined(var_1) && var_1 == "allies") {
        return "ks_counter_intelligence_usa";
        return;
      }

      return "ks_counter_intelligence_ger";
      return;
  }
}

_id_6E16(var_0, var_1) {
  switch (var_0) {
    case "advanced_uav":
    case "s2_uav":
      if(isDefined(var_1) && var_1 == "allies") {
        return "ks_recon_usa_animated";
      } else {
        return "ks_recon_ger_animated";
      }
    case "counter_uav":
      if(isDefined(var_1) && var_1 == "allies") {
        return "ks_counter_intelligence_usa_animated";
        return;
      }

      return "ks_counter_intelligence_ger_animated";
      return;
  }
}

_id_6E1B(var_0) {
  switch (var_0) {
    case "advanced_uav":
    case "s2_uav":
      return "scorestreak_minimap_recon";
    case "counter_uav":
      return "scorestreak_minimap_fighter";
  }
}

_id_81EC() {
  if(level.teambased) {
    level.radarmode["allies"] = "normal_radar";
    level.radarmode["axis"] = "normal_radar";
    level._id_0F66["allies"] = 0;
    level._id_0F66["axis"] = 0;
    level._id_0F3D["allies"] = 0;
    level._id_0F3D["axis"] = 0;
    level._id_0F37["allies"] = 0;
    level._id_0F37["axis"] = 0;
    level._id_F8F8["allies"] = [];
    level._id_F8F8["axis"] = [];
  } else {
    level.radarmode = [];
    level._id_0F66 = [];
    level._id_0F3D = [];
    level._id_0F37 = [];
    level._id_F8F8 = [];
  }

  level._id_F8F7 = 15;
  level._id_F8F6 = 0;
}

_id_1182() {
  var_0 = self.team;

  if(level.teambased) {
    level._id_F8F8[var_0][level._id_F8F8[var_0].size] = self;
  } else {
    level._id_F8F8[self.owner.guid + "_" + gettime()] = self;
  }
}

_id_C539() {
  _id_080C::_id_9B29(0);
  var_0 = self.team;

  if(level.teambased) {
    level._id_F8F8[var_0] = _id_080C::_id_1BC2(self, level._id_F8F8[var_0]);
  } else {
    level._id_F8F8 = _id_080C::_id_1BC2(self, level._id_F8F8);
  }
}

_id_1088(var_0) {
  _id_119E(var_0, 1);

  if(var_0 == "counter_uav") {
    if(level.teambased) {
      level._id_EF69[scripts\mp\utility\game::_id_6BE2(self.team)] = 1;
    } else {
      level._id_3DA4 = self.owner;
    }

    level thread _id_080C::_id_FC01();
  }
}

_id_C468(var_0) {
  _id_119E(var_0, -1);

  if(var_0 == "counter_uav") {
    if(level.teambased) {
      if(level._id_0F3D[self.team] == 0) {
        level._id_EF69[scripts\mp\utility\game::_id_6BE2(self.team)] = 0;
      }
    } else if(isDefined(self.owner) && level._id_0F3D[self.owner.guid] == 0)
      level._id_3DA4 = undefined;

    level thread _id_080C::_id_FC01();
  }
}

_id_119E(var_0, var_1) {
  switch (var_0) {
    case "s2_uav":
      if(level.teambased) {
        level._id_0F66[self.team] = level._id_0F66[self.team] + var_1;
      } else if(isDefined(self.owner)) {
        level._id_0F66[self.owner.guid] = level._id_0F66[self.owner.guid] + var_1;
      }

      break;
    case "counter_uav":
      if(level.teambased) {
        level._id_0F3D[self.team] = level._id_0F3D[self.team] + var_1;
      } else if(isDefined(self.owner)) {
        level._id_0F3D[self.owner.guid] = level._id_0F3D[self.owner.guid] + var_1;
      }

      break;
    case "advanced_uav":
      if(level.teambased) {
        level._id_0F37[self.team] = level._id_0F37[self.team] + var_1;
      } else if(isDefined(self.owner)) {
        level._id_0F37[self.owner.guid] = level._id_0F37[self.owner.guid] + var_1;
      }

      break;
  }
}

_id_3FB4() {
  if(!isDefined(self._id_EF59)) {
    self._id_EF59 = newclienthudelem(self);
    self._id_EF59.x = -350;
    self._id_EF59.y = -70;
    self._id_EF59.alignx = "center";
    self._id_EF59.aligny = "middle";
    self._id_EF59.horzalign = "center";
    self._id_EF59.vertalign = "middle";
    self._id_EF59.fontscale = 1.0;
    self._id_EF59.alpha = 1.0;
    self._id_AC46 = newclienthudelem(self);
    self._id_AC46.x = -320;
    self._id_AC46.y = -70;
    self._id_AC46.alignx = "center";
    self._id_AC46.aligny = "middle";
    self._id_AC46.horzalign = "center";
    self._id_AC46.vertalign = "middle";
    self._id_AC46.fontscale = 1.0;
    self._id_AC46.alpha = 1.0;
    thread _id_FC2F();
  }
}

_id_FC2F() {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    if(level.gametype == "onevone" || self _meth_876E("ui_hide_minimap")) {
      self._id_EF59.alpha = 0.0;
      self._id_AC46.alpha = 0.0;
    } else {
      self._id_EF59.alpha = 1.0;
      self._id_AC46.alpha = 1.0;
    }

    var_0 = _id_6CB5(self.team, self);
    var_1 = _id_6CB5(scripts\mp\utility\game::_id_6BE2(self.team), self);
    self._id_EF59 _meth_83A3(var_0);
    self._id_AC46 _meth_83A3(var_1);
    level waittill("uav_update");
  }
}

_id_FB48(var_0) {
  if(getdvarint("#x3af383f37c3a10748", 0)) {
    if(var_0) {
      return;
    }
    return;
  }
}

_id_D076(var_0) {
  self endon("stop_location_selection");

  if(!isDefined(level._id_9AC7)) {
    level._id_9AC7 = 1024;
  }

  var_1 = level._id_9AC7 / 4;

  if(level.splitscreen) {
    var_1 = var_1 * 1.5;
  }

  var_2 = 0;
  _id_080C::_id_0B66(var_0, "map_artillery_selector", var_2, var_1);
  thread _id_10832();
  self waittill("confirm_location", var_3, var_4);
  self _meth_82EE(0, 0.3);
  self notify("location_selection_complete");
  thread _id_FEB5(var_3);
  return 1;
}

_id_FEB5(var_0) {
  var_1 = level._id_F8F6;
  level._id_F8F6++;

  foreach(var_3 in level.players) {
    if(!isPlayer(var_3) || isbot(var_3) || _func_03DA(var_3)) {
      continue;
    }
    if(var_3.team != self.team) {
      continue;
    }
    var_3 thread _id_6FCB(var_1, self, var_0);
  }

  thread _id_6FBD(var_1, self, var_0);
  wait 30;
  level notify("uav_locational_destroyed_" + var_1);

  foreach(var_3 in level.players) {
    if(!isPlayer(var_3) || isbot(var_3) || _func_03DA(var_3)) {
      continue;
    }
    if(var_3.team != self.team) {
      continue;
    }
    var_3 thread _id_C50A(var_1);
  }
}

_id_6FCB(var_0, var_1, var_2) {
  var_3 = spawn("script_model", var_2);
  var_3.team = var_1.team;
  var_3._id_4075 = var_1;
  var_3._id_7C8C = var_0;
  var_3 _meth_8222(self);

  if(isDefined(self._id_C16C)) {
    self._id_C16C = scripts\engine\utility::_id_1BD1(self._id_C16C);

    if(self._id_C16C.size >= level._id_F8F7) {
      level _id_080C::_id_4787(self._id_C16C[0]);
      self._id_C16C[0] = undefined;
    }

    self._id_C16C = scripts\engine\utility::_id_1BD1(self._id_C16C);
  } else
    self._id_C16C = [];

  self._id_C16C[self._id_C16C.size] = var_3;
  thread _id_1081B(var_0);
}

_id_C50A(var_0) {
  if(isDefined(self._id_C16C)) {
    self._id_C16C = scripts\engine\utility::_id_1BD1(self._id_C16C);

    foreach(var_2 in self._id_C16C) {
      if(var_2._id_7C8C == var_0) {
        level _id_080C::_id_4787(var_2);
        var_2 = undefined;
      }
    }

    self._id_C16C = scripts\engine\utility::_id_1BD1(self._id_C16C);
  }
}

_id_1081B(var_0) {
  level endon("game_ended");
  level endon("uav_locational_destroyed_" + var_0);
  scripts\engine\utility::_id_1087F("disconnect", "joined_team", "joined_spectators");
  _id_C50A(var_0);
}

_id_10832() {
  self endon("location_selection_complete");
  self endon("disconnect");
  self waittill("stop_location_selection");
  self _meth_82EE(0, 0.3);

  if(_id_080C::waittillhostmigrationdone() > 0) {
    self switchtoweapon(_id_080C::_id_6AF9());
  }
}

_id_6FBD(var_0, var_1, var_2) {
  level endon("game_ended");
  level endon("uav_locational_destroyed_" + var_0);

  for(;;) {
    level waittill("connected", var_3);

    if(!isPlayer(var_3) || isbot(var_3) || _func_03DA(var_3)) {
      continue;
    }
    if(var_3.team != var_1.team) {
      continue;
    }
    var_3 thread _id_6FCB(var_0, var_1, var_2);
  }
}

_id_698B() {
  var_0 = undefined;
  var_1 = level._id_F8F8;

  if(level.teambased) {
    var_1 = level._id_F8F8[scripts\mp\utility\game::_id_6BE2(self.team)];
  }

  foreach(var_3 in var_1) {
    if(!isDefined(var_3) || isDefined(var_3._id_8908) || isDefined(var_3._id_8A8E)) {
      continue;
    }
    if(isDefined(var_0) && var_0._id_04DE == "counter_uav" && var_3._id_04DE != "counter_uav") {
      continue;
    }
    if(!level.teambased && isDefined(var_3.owner) && var_3.owner == self) {
      continue;
    }
    var_0 = var_3;
  }

  return var_0;
}

_id_90EA(var_0, var_1, var_2, var_3) {
  while(isDefined(var_2) && !var_2 _meth_81CC()) {
    waitframe();
  }

  if(!isDefined(var_2)) {
    level thread _id_9103(var_0, var_1, "counter_uav");
    return;
  }

  level thread _id_F8FB(var_2);
  var_4 = anglestoright((0, var_2.angles[1], 0));
  var_5 = var_2.origin + var_4 * -3200;
  var_6 = spawn("script_model", var_5);
  var_6.angles = var_2.angles + (0, -55, 0);
  _id_080C::_id_40F5("ks_counter_uav_chase", undefined, var_6);

  if(var_2._id_04DE == "counter_uav") {
    _id_080C::_id_40F5("ks_counter_uav_chase_target_lg", undefined, var_2);
  } else {
    _id_080C::_id_40F5("ks_counter_uav_chase_target_sm", undefined, var_2);
  }

  wait 0.5;
  var_7 = _id_6E1C("counter_uav", var_1);
  var_8 = _id_6E18("counter_uav", var_1);

  if(isDefined(var_8)) {
    var_6 setModel(var_8);
  } else {
    var_6 setModel(var_7);
  }

  var_9 = "ks_counter_intelligence_ger_attack";

  if(var_1 == "allies") {
    var_9 = "ks_counter_intelligence_usa_attack";
  }

  var_6 _meth_82CC(var_9, "finished_chase_anim");

  if(isDefined(var_3)) {
    var_6._id_AD9C = 1;
  } else {
    var_6.owner = var_0;
  }

  var_6._id_9102 = gettime();
  var_6._id_04DE = "counter_uav";

  if(isDefined(var_3)) {
    foreach(var_11 in level.players) {
      if(isDefined(var_11.team) && var_11.team == var_1) {
        var_6 _id_109D(var_11, _id_6E1B("counter_uav"));
      }
    }
  } else
    var_6 _id_109D(var_6.owner, _id_6E1B("counter_uav"));

  if(isDefined(var_8)) {
    var_6 _id_080C::_id_D6BF(0, 1, 1.0);
  }

  wait 1.0;
  var_6 setModel(var_7);
  wait 1.66;
  var_6 thread _id_3DA6(var_2, var_1);
  var_6 scripts\engine\utility::_id_1087F("death", "finished_chase_anim");

  if(isDefined(var_8)) {
    var_6 setModel(var_8);
    var_6 _id_080C::_id_D6BF(1, 0, 0.5);
    wait 0.5;
  }

  if(0 && isDefined(var_6._id_9F23)) {
    var_6._id_9F23 delete();
  }

  var_6 delete();
}

_id_3DA6(var_0, var_1) {
  self endon("death");
  var_2 = (134, 9, 39);
  var_3 = (134, -9, 39);

  if(var_1 == "allies") {
    var_2 = (111, 17, 13);
    var_3 = (111, -17, 13);
  }

  var_4 = 2.8;

  if(var_0._id_04DE == "counter_uav") {
    var_4 = 5.0;
  }

  var_5 = gettime();

  for(var_6 = 0; var_6 < var_4 * 1000; var_6 = gettime() - var_5) {
    var_7 = anglesToForward(self.angles);
    var_8 = vectornormalize(var_0.origin - self.origin);
    var_9 = vectordot(var_7, var_8);
    var_10 = self.origin + rotatevector(var_2, self.angles);
    var_11 = var_10 + var_7 * 8000;
    _func_0143("counter_recon_gun_mp", var_10, var_11);
    var_10 = self.origin + rotatevector(var_3, self.angles);
    var_11 = var_10 + var_7 * 8000;
    _func_0143("counter_recon_gun_mp", var_10, var_11);
    _id_080C::_id_40F4("ks_fighter_strike_npc", undefined, self.origin);

    if(var_9 > 0.995) {
      var_12 = var_0 gettagorigin("TAG_DEATH_FX");
      playFX(scripts\engine\utility::getfx("counter_recon_hit"), var_12);
    }

    wait 0.1;
  }

  var_0 setCanDamage(1);
  var_0 dodamage(var_0.maxhealth * 10, var_0.origin, self.owner, self, "MOD_RIFLE_BULLET", "counter_recon_gun_mp");

  if(var_0._id_04DE == "counter_uav") {
    var_13 = var_0.origin;
    _id_080C::_id_40F4("ks_plane_destruct_explode", undefined, var_13);
    _id_080C::_id_40F6("ks_plane_destruct_deathspin_long", undefined, var_0);
  } else
    _id_080C::_id_40F4("ks_plane_destruct_explode", undefined, var_0.origin);

  _id_080C::_id_40F6("ks_plane_destruct_deathspin_long", undefined, var_0);
}

_id_F8FB(var_0) {
  var_0 notify("leaving");
  var_0 notify("death");
  var_0 _id_C539();
  var_0 unlink();
  var_1 = _id_6E16(var_0._id_04DE, var_0.team);
  var_0 _meth_82CC(var_1, "finished_chase_anim");

  if(0 && isDefined(var_0._id_9F23)) {
    var_0._id_9F23 _id_080C::_id_D557(3000, 0);
  }

  var_0 scripts\engine\utility::_id_1087F("death", "finished_chase_anim");
  waitframe();
  waitframe();

  if(isDefined(var_0)) {
    var_0 _id_0A2D::_id_485A();

    if(0 && isDefined(var_0._id_9F23)) {
      var_0._id_9F23 delete();
    }

    var_0 delete();
  }
}