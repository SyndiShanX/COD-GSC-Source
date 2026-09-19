/****************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\zombies\weapons\_zombies_scripted_mtx_9_paps.gsc
****************************************************************************/

init() {
  _id_054D::_id_7BC6(::scripted_mtx9_dmg);
  _id_0547::_id_7BA9(::scripted_mtx9_on_death);
  common_scripts\utility::_id_092C("zmb_dp28_green_impact", "vfx/zombie/zmb_dp28_green_impact");
  common_scripts\utility::_id_092C("zmb_bomb_sphere", "vfx/zombie/prototype_fx/dlc4/zmb_bomb_sphere");
  common_scripts\utility::_id_092C("zmb_godking_giestbomb", "vfx/zombie/zmb_godking_giestbomb");
  common_scripts\utility::_id_092C("zmb_godking_giestbomb_prime", "vfx/zombie/zmb_godking_giestbomb_prime");
  common_scripts\utility::_id_092C("zmb_godking_giestbomb2", "vfx/zombie/zmb_godking_giestbomb2");
  common_scripts\utility::_id_092C("zmb_godking_giestbomb2_prime", "vfx/zombie/zmb_godking_giestbomb2_prime");
  common_scripts\utility::_id_092C("zmb_giestbomb_exp_1shot", "vfx/zombie/prototype_fx/dlc4/zmb_giestbomb_exp_1shot");
  common_scripts\utility::_id_092C("zmi_hc_rune_green", "vfx/zombie/prototype_fx/island/zmi_hc_rune_green");
  common_scripts\utility::_id_092C("zmb_embers_wind_vortex", "vfx/map/mp_zombie_nest/zmb_embers_wind_vortex");
  level.bubble_bomb_dmg = maps\mp\gametypes\zombies::_id_1E59(_id_0547::_id_0A51("zombie_generic"), 20);
  level.dp38missiledamage = maps\mp\gametypes\zombies::_id_1E59(_id_0547::_id_0A51("zombie_generic"), 25);
  level.dp38cricetdamage = maps\mp\gametypes\zombies::_id_1E59(_id_0547::_id_0A51("zombie_generic"), 35);
  level.noisy_circket_vfx_time = [];
  level thread maps\mp\_utility::_id_6F74(::emp_bubble_bomb_on_reload_empty);
  level thread maps\mp\_utility::_id_6F74(::emp2_bubble_bomb_on_reload_empty);
  level thread maps\mp\_utility::_id_6F74(::dp28_zm_fire_think);
  level thread maps\mp\_utility::_id_6F74(::sdk_zm_fire_think);
}

required_weapon(var_0) {
  var_1 = self;
  var_2 = var_1 getcurrentweapon();

  if(_id_0569::_id_55D4(var_2)) {
    var_2 = var_1 maps\mp\_events_z::set_last_checked_weapon(var_2);

    if(!_id_0547::_id_5565(var_2, var_0))
      return 0;
  } else
    return 0;

  return 1;
}

scripted_mtx9_dmg(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(!isDefined(var_5)) {
    return;
  }
  if(!isDefined(var_1)) {
    return;
  }
  if(!isPlayer(var_1)) {
    return;
  }
  if(_id_0569::_id_55D4(var_5))
    var_11 = var_1 maps\mp\_events_z::set_last_checked_weapon(var_5);
}

scripted_mtx9_on_death(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!isDefined(var_4)) {
    return;
  }
  if(!isDefined(var_1)) {
    return;
  }
  if(!isPlayer(var_1)) {
    return;
  }
  if(issubstr(var_4, "bechowiec") && issubstr(var_4, "_pap_zm")) {
    if(!isDefined(var_1.bubbleshieldbuildup))
      var_1.bubbleshieldbuildup = 0;

    if(!common_scripts\utility::_id_562E(var_1.bubblecharged)) {
      var_1.bubbleshieldbuildup++;

      if(!common_scripts\utility::_id_562E(self._id_2FDA) && !_id_0547::_id_5565(self._id_0A4B, "zombie_fireman")) {
        _id_865C("scripted_soul_eat", 0);
        _id_0378::_id_8D74("aud_zombie_soul_absorb");
      }
    }

    if(var_1.bubbleshieldbuildup > 15) {
      var_1.bubbleshieldbuildup = 0;
      var_1 thread bubble_sheild_ready();
    }
  }

  if(issubstr(var_4, "charlton") && issubstr(var_4, "_pap_zm")) {
    var_9 = var_1 maps\mp\_events_z::set_last_checked_weapon(var_4);
    thread try_charlton_blackhole(self.origin, var_4);
  }
}

_id_865C(var_0, var_1) {
  if(common_scripts\utility::_id_562E(var_1))
    self._id_2A9D = var_0;
  else if(self._id_0BA4 != "traverse")
    self._id_2A9D = var_0;
}

bubble_sheild_ready() {
  var_0 = self;
  var_0 endon("disconnect");
  var_0.bubblecharged = 1;

  if(!isDefined(var_0.bubblestruct)) {
    var_0.bubblestruct = spawnStruct();
    var_0.bubblestruct.origin = (0, 0, 0);
  }

  var_1 = _id_0547::_id_8FBA(var_0.bubblestruct, "zmb_bren_pap_screen", var_0);
  _triggerfx(var_1);

  while(!var_0 meleebuttonpressed())
    waitframe();

  var_1 delete();
  var_0.bubblecharged = 0;
  var_0 thread maps\mp\zombies\consumables\inv_giest_shield::spawn_a_giest_bubble_shield(var_0.origin, 5);
}

emp_bubble_bomb_on_reload_empty() {
  var_0 = self;
  var_0 endon("disconnect");

  for(;;) {
    var_0 waittill("reload_start");
    var_0 attempt_reload_action(::spawn_bubble_bomb_on_player_small, "emp44_zm");
  }
}

emp2_bubble_bomb_on_reload_empty() {
  var_0 = self;
  var_0 endon("disconnect");

  for(;;) {
    var_0 waittill("reload_start");
    var_0 attempt_reload_action(::spawn_stunners, "erma_zm");
  }
}

spawn_bubble_bomb_on_player_small() {
  var_0 = self;
  var_0 thread run_reload_bombs();
}

spawn_stunners() {
  var_0 = self;
  var_0 thread run_reload_bombs(1);
}

run_reload_bombs(var_0) {
  var_1 = self;
  var_1 endon("disconnect");
  var_1 spawn_bubble_bomb("tag_weapon_right", self.origin + (160, 0, 0), var_0);
  wait 0.4;
  var_1 spawn_bubble_bomb("tag_weapon_right", self.origin + (0, 160, 0), var_0);
  wait 0.4;
  var_1 spawn_bubble_bomb("tag_weapon_right", self.origin + (-80, -80, 0), var_0);
}

spawn_bubble_bomb(var_0, var_1, var_2) {
  var_3 = self;
  var_4 = "geist_bomb_artil";

  if(common_scripts\utility::_id_562E(var_2))
    var_4 = "geist_bomb_artil2";

  var_5 = get_bomb_start_pos(var_0);
  var_6 = _func_1B6(var_4, var_3.origin, var_1, 1, var_5[2] + 42, var_3);
  var_6 thread geist_bombs_projectile_think(var_3, common_scripts\utility::_id_562E(var_2));
}

get_bomb_start_pos(var_0) {
  var_1 = self gettagorigin(var_0);
  return var_1;
}

geist_bombs_projectile_think(var_0, var_1) {
  var_2 = self;
  _id_0378::_id_8D74("aud_pap_wpn_emp44_bomb_reload", "spawn", var_2);
  var_2 waittill("explode", var_3);
  geist_bombs_static_think(var_3, var_0, var_1);

  if(isDefined(var_2))
    var_2 delete();
}

geist_bombs_static_think(var_0, var_1, var_2) {
  var_3 = _getgroundposition(var_0, 12);
  var_4 = common_scripts\utility::_id_8FFC();
  var_4 show();
  var_4.origin = var_3 + (0, 0, 25);
  var_5 = "zmb_godking_giestbomb";

  if(var_2)
    var_5 = "zmb_godking_giestbomb2";

  var_6 = "zmb_godking_giestbomb_prime";

  if(var_2)
    var_6 = "zmb_godking_giestbomb2_prime";

  var_7 = _spawnlinkedfx(common_scripts\utility::_id_44F5(var_5), var_4, "TAG_ORIGIN");
  var_8 = _spawnlinkedfx(common_scripts\utility::_id_44F5(var_6), var_4, "TAG_ORIGIN");
  setfxkillondelete(var_7, 1);
  setfxkillondelete(var_8, 1);
  var_9 = 0.6;
  var_10 = 2.6;
  thread show_bomb_vfx(var_7, var_8, var_9, var_10);
  _id_0378::_id_8D74("aud_pap_wpn_emp44_bomb_reload", "activate", var_4);
  wait(var_9 + var_10);

  if(!var_2)
    _playfxontag(common_scripts\utility::_id_44F5("zmb_giestbomb_exp_1shot"), var_4, "TAG_ORIGIN");

  _id_0378::_id_8D74("aud_pap_wpn_emp44_bomb_reload", "explode", var_4);
  var_11 = _id_0547::_id_408F();
  var_12 = level.players;
  var_13 = common_scripts\utility::_id_0F73(var_11, var_12);

  if(var_2)
    var_1 maps\mp\zombies\weapons\_zombie_type_38::spawn_electro_blast(var_0, randomint(1) == 0);
  else {
    foreach(var_15 in var_13) {
      if(_distance2d(var_15.origin, var_0) <= 160)
        var_15 dodamage(level.bubble_bomb_dmg, var_0, var_1, var_1, "MOD_EXPLOSIVE", "emp44_zm");
    }
  }

  waitframe();

  if(isDefined(var_7))
    var_7 delete();

  if(isDefined(var_8))
    var_8 delete();

  var_4 delete();
}

show_bomb_vfx(var_0, var_1, var_2, var_3) {
  _triggerfx(var_0);
  wait(var_2);
  _triggerfx(var_1);
}

attempt_reload_action(var_0, var_1) {
  var_2 = self;
  var_2 endon("disconnect");

  if(!var_2 required_weapon(var_1)) {
    return;
  }
  if(weapon_clip_empty(var_1)) {
    var_2 childthread[[var_0]]();

    while(weapon_clip_empty(var_1))
      waitframe();
  }
}

weapon_clip_empty(var_0) {
  var_1 = self;

  if(!_id_0547::_id_5565(var_0, _id_0547::_id_AAF9(var_1 getcurrentweapon())))
    return 1;

  return var_1 getcurrentweaponclipammo() == 0;
}

try_charlton_blackhole(var_0, var_1) {
  if(isDefined(level.charlton_blackhole)) {
    return;
  }
  if(isDefined(level.last_charlton_blackhole_time) && level.last_charlton_blackhole_time - gettime() > 10) {
    return;
  }
  if(randomint(100) > 10) {
    return;
  }
  level.last_charlton_blackhole_time = gettime();
  var_2 = _getgroundposition(var_0, 12);
  level.charlton_blackhole = common_scripts\utility::_id_8FFC();
  level.charlton_blackhole show();
  level.charlton_blackhole.origin = var_2 + (0, 0, 4);
  level.charlton_blackhole.vfxent_radius = _spawnlinkedfx(common_scripts\utility::_id_44F5("zmb_embers_wind_vortex"), level.charlton_blackhole, "tag_origin");
  _triggerfx(level.charlton_blackhole.vfxent_radius);
  level.charlton_blackhole _id_0378::_id_8D74("aud_pap_wpn_charlton_vortex");
  level.charlton_blackhole thread spawn_blackhole();
  wait 5;

  if(isDefined(level.charlton_blackhole.vfxent_radius))
    level.charlton_blackhole.vfxent_radius delete();

  if(isDefined(level.charlton_blackhole)) {
    level.charlton_blackhole notify("vortex_end");
    level.charlton_blackhole delete();
  }
}

spawn_blackhole() {
  var_0 = self;
  var_0 endon("vortex_end");

  while(isDefined(self)) {
    foreach(var_2 in _id_0547::_id_408F()) {
      if(!isDefined(var_2._id_0A4B) || !common_scripts\utility::_id_0F79(["zombie_generic", "zombie_berserker", "zombie_heavy", "zombie_exploder", "zombie_sizzler"], var_2._id_0A4B)) {
        continue;
      }
      if(distance(var_2.origin, var_0.origin) > 256) {
        continue;
      }
      var_0 pulse_drag_in_victim(var_2);
    }

    wait 0.2;
  }
}

pulse_drag_in_victim(var_0) {
  var_0 endon("death");
  self endon("death");
  var_1 = distance(self.origin, var_0.origin);
  var_2 = var_1 / 256;
  var_3 = 400 * var_2;
  var_4 = self.origin - var_0.origin;
  var_4 = (var_4[0], var_4[1], 0);
  var_4 = var_3 * vectorNormalize(var_4);
  var_4 = (var_4[0], var_4[1], 125 * var_2);
  var_0 setvelocity(var_4);
}

dp28_zm_fire_think() {
  self endon("disconnect");

  for(;;) {
    self waittill("missile_fire", var_0, var_1);

    if(issubstr(var_1, "dp28")) {
      if(isDefined(var_0))
        var_0 thread dp28_death_bolt(self, var_1);
    }
  }
}

sdk_zm_fire_think() {
  self endon("disconnect");

  for(;;) {
    self waittill("weapon_fired", var_0);

    if(issubstr(var_0, "sdk") && is_paped(var_0))
      _id_0378::_id_8D74("aud_pap_wpn_sdk_shottysnipe_fire", self getEye());
  }
}

dp28_modify_projectile(var_0, var_1) {
  self._id_0117 = var_0;
  self _meth_8519(0, 0);

  if(var_1) {
    _playfxontag(common_scripts\utility::_id_44F5("zmi_hc_rune_green"), self, "tag_origin");
    _id_0378::_id_8D74("aud_pap_wpn_crossbow_cricket_shot");
  }

  return self;
}

dp28_death_bolt(var_0, var_1) {
  var_2 = dp28_modify_projectile(var_0, is_paped(var_1));
  var_3 = is_paped(var_1);
  var_2 childthread do_zombie_damage_better(::missile_do_flight_damage);
  var_4 = var_2 common_scripts\utility::waittill_any_return("missile_stuck", "death", "entitydeleted");

  if(var_4 == "missile_stuck")
    waitframe();

  var_2 notify("end_air_damage");

  if(var_4 == "missile_stuck") {
    wait 4;

    if(var_3) {
      var_2 thread dp28_noisy_cricket(var_0);
      var_2 thread common_scripts\utility::_id_2CBE(0.15, ::delete);
    }
  }
}

is_paped(var_0) {
  if(issubstr(var_0, "_pap_zm"))
    return 1;

  return 0;
}

do_zombie_damage_better(var_0) {
  self endon("death");
  self endon("end_air_damage");

  for(self.hammer_old_pos = self.origin; isDefined(self); self.hammer_old_pos = self.origin) {
    waitframe();
    waittillframeend;
    do_zombie_trace_damage(self.hammer_old_pos, self.origin, var_0);
  }
}

do_zombie_trace_damage(var_0, var_1, var_2) {
  var_3 = _id_0547::_id_408F();

  foreach(var_5 in var_3) {
    var_6 = var_5._id_8302;
    var_7 = var_5._id_8303;
    var_8 = var_7 + 12;
    var_9 = var_8 * var_8;
    var_10 = sqrd_dist_between_segments(var_0, var_1, var_5.origin, var_5.origin + (0, 0, var_6));

    if(var_10[0] <= var_9)
      [[var_2]](var_5, var_10[1]);
  }
}

missile_do_flight_damage(var_0, var_1) {
  if(_id_0547::_id_5565(var_0.temporary_missile_flight_imunity, 1)) {
    return;
  }
  if(isDefined(var_0._id_0A4B)) {
    var_2 = _id_0547::_id_0A51(var_0._id_0A4B);

    if(isDefined(var_2) && common_scripts\utility::_id_562E(var_2.knockbyravensword))
      _id_0547::_id_7D1B(self, var_0, "close", self._id_0117);

    var_0 thread missile_set_temp_immunity();
    var_0 dodamage(level.dp38missiledamage, var_1, self._id_0117, self._id_0117, "MOD_EXPLOSIVE", "dp28_pap_zm");
  }
}

missile_set_temp_immunity() {
  self endon("death");
  self.temporary_missile_flight_imunity = 1;
  wait 0.85;
  self.temporary_missile_flight_imunity = undefined;
}

dp28_noisy_cricket(var_0) {
  var_1 = self;
  var_2 = var_1.origin;
  var_3 = 0;
  var_4 = _id_0547::_id_408F();
  var_4 = _sortbydistance(var_4, var_2, 256);
  thread play_noisy_cricket_vfx(var_1);

  foreach(var_6 in var_4) {
    var_7 = 0;

    if(!isDefined(var_6._id_0A4B) || _id_0547::_id_5565(var_6, var_0)) {
      continue;
    }
    if(!isDefined(var_6._id_0A4B) || !common_scripts\utility::_id_0F79(["zombie_generic", "zombie_berserker", "zombie_heavy", "zombie_exploder", "zombie_sizzler"], var_6._id_0A4B))
      var_3 = 1;

    if(_distance2d(var_6.origin, var_2) <= 128) {
      if(common_scripts\utility::_id_562E(var_3))
        var_6 dodamage(1800, var_0.origin, var_0, var_0, "MOD_EXPLOSIVE", "dp28_pap_zm");
      else
        var_6 dodamage(level.dp38cricetdamage, var_0.origin, var_0, var_0, "MOD_EXPLOSIVE", "dp28_pap_zm");

      var_7 = 1;
    } else if(_distance2d(var_6.origin, var_2) <= 192) {
      if(common_scripts\utility::_id_562E(var_3))
        var_6 dodamage(1200, var_0.origin, var_0, var_0, "MOD_EXPLOSIVE", "dp28_pap_zm");
      else
        var_6 dodamage(level.dp38cricetdamage * 0.66, var_0.origin, var_0, var_0, "MOD_EXPLOSIVE", "dp28_pap_zm");

      if(isDefined(var_6._id_0A4B)) {
        var_8 = _id_0547::_id_0A51(var_6._id_0A4B);

        if(isDefined(var_8) && common_scripts\utility::_id_562E(var_8.knockbybladebarbarossa))
          _id_0547::_id_7D1B(var_0, var_6, "medium");
      }

      var_7 = 1;
    } else if(_distance2d(var_6.origin, var_2) <= 256) {
      if(common_scripts\utility::_id_562E(var_3))
        var_6 dodamage(600, var_0.origin, var_0, var_0, "MOD_EXPLOSIVE", "dp28_pap_zm");
      else
        var_6 dodamage(level.dp38cricetdamage * 0.33, var_0.origin, var_0, var_0, "MOD_EXPLOSIVE", "dp28_pap_zm");

      if(isDefined(var_6._id_0A4B)) {
        var_8 = _id_0547::_id_0A51(var_6._id_0A4B);

        if(isDefined(var_8) && common_scripts\utility::_id_562E(var_8.knockbybladebarbarossa))
          _id_0547::_id_7D1B(var_0, var_6, "far");
      }

      var_7 = 1;
    }

    if(isDefined(var_6.myshield) && var_7)
      var_6.myshield dodamage(level.dp38cricetdamage * 0.33, var_0.origin, var_0, var_0, "MOD_EXPLOSIVE", "dp28_pap_zm");
  }
}

play_noisy_cricket_vfx(var_0) {
  if(level.noisy_circket_vfx_time.size >= 2) {
    return;
  }
  var_1 = gettime();
  level.noisy_circket_vfx_time = common_scripts\utility::_id_0F6F(level.noisy_circket_vfx_time, var_1);
  playFX(common_scripts\utility::_id_44F5("zmb_dp28_green_impact"), var_0.origin);
  var_0 _id_0378::_id_8D74("aud_pap_wpn_crossbow_cricket_explo");
  wait 1.25;
  level.noisy_circket_vfx_time = common_scripts\utility::_id_0F93(level.noisy_circket_vfx_time, var_1);
}

sqrd_dist_between_segments(var_0, var_1, var_2, var_3) {
  var_4 = [];
  var_5 = 0.000001;
  var_6 = var_3 - var_2;
  var_7 = var_1 - var_0;
  var_8 = var_0 - var_2;
  var_9 = vectordot(var_6, var_6);
  var_10 = vectordot(var_7, var_7);
  var_11 = vectordot(var_7, var_6);
  var_12 = vectordot(var_6, var_8);
  var_13 = vectordot(var_7, var_8);
  var_14 = var_9 * var_10 - var_11 * var_11;
  var_15 = 0;
  var_16 = 0;

  if(var_14 <= var_5) {
    if(var_11 > var_9)
      var_15 = var_13 / var_11;
    else
      var_15 = var_12 / var_9;
  } else {
    var_15 = (var_12 * var_10 - var_11 * var_13) / var_14;
    var_16 = (var_11 * var_12 - var_13 * var_9) / var_14;
  }

  var_15 = clamp(var_15, 0.0, 1.0);
  var_16 = clamp(var_16, 0.0, 1.0);
  var_17 = var_2 + var_6 * var_15;
  var_18 = var_0 + var_7 * var_16;
  var_19 = var_18 - var_17;
  var_20 = vectordot(var_19, var_19);
  var_4[1] = var_18;
  var_4[2] = var_17;
  var_4[0] = var_20;
  return var_4;
}