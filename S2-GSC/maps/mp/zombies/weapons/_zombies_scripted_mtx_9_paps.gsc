/********************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\zombies\weapons\_zombies_scripted_mtx_9_paps.gsc
********************************************************************/

func_00D5() {
  lib_054D::func_7BC6(::scripted_mtx9_dmg);
  lib_0547::func_7BA9(::scripted_mtx9_on_death);
  common_scripts\utility::func_092C("zmb_dp28_green_impact", "vfx/zombie/zmb_dp28_green_impact");
  common_scripts\utility::func_092C("zmb_bomb_sphere", "vfx/zombie/prototype_fx/dlc4/zmb_bomb_sphere");
  common_scripts\utility::func_092C("zmb_godking_giestbomb", "vfx/zombie/zmb_godking_giestbomb");
  common_scripts\utility::func_092C("zmb_godking_giestbomb_prime", "vfx/zombie/zmb_godking_giestbomb_prime");
  common_scripts\utility::func_092C("zmb_godking_giestbomb2", "vfx/zombie/zmb_godking_giestbomb2");
  common_scripts\utility::func_092C("zmb_godking_giestbomb2_prime", "vfx/zombie/zmb_godking_giestbomb2_prime");
  common_scripts\utility::func_092C("zmb_giestbomb_exp_1shot", "vfx/zombie/prototype_fx/dlc4/zmb_giestbomb_exp_1shot");
  common_scripts\utility::func_092C("zmi_hc_rune_green", "vfx/zombie/prototype_fx/island/zmi_hc_rune_green");
  common_scripts\utility::func_092C("zmb_embers_wind_vortex", "vfx/map/mp_zombie_nest/zmb_embers_wind_vortex");
  level.bubble_bomb_dmg = maps\mp\gametypes\zombies::func_1E59(lib_0547::func_0A51("zombie_generic"), 20);
  level.dp38missiledamage = maps\mp\gametypes\zombies::func_1E59(lib_0547::func_0A51("zombie_generic"), 25);
  level.dp38cricetdamage = maps\mp\gametypes\zombies::func_1E59(lib_0547::func_0A51("zombie_generic"), 35);
  level.noisy_circket_vfx_time = [];
  level thread maps\mp\_utility::func_6F74(::emp_bubble_bomb_on_reload_empty);
  level thread maps\mp\_utility::func_6F74(::emp2_bubble_bomb_on_reload_empty);
  level thread maps\mp\_utility::func_6F74(::dp28_zm_fire_think);
  level thread maps\mp\_utility::func_6F74(::sdk_zm_fire_think);
}

required_weapon(param_00) {
  var_01 = self;
  var_02 = var_01 getcurrentweapon();
  if(lib_0569::func_55D4(var_02)) {
    var_02 = var_01 maps\mp\_events_z::set_last_checked_weapon(var_02);
    if(!lib_0547::func_5565(var_02, param_00)) {
      return 0;
    }
  } else {
    return 0;
  }

  return 1;
}

scripted_mtx9_dmg(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A) {
  if(!isDefined(param_05)) {
    return;
  }

  if(!isDefined(param_01)) {
    return;
  }

  if(!isPlayer(param_01)) {
    return;
  }

  if(lib_0569::func_55D4(param_05)) {
    var_0B = param_01 maps\mp\_events_z::set_last_checked_weapon(param_05);
  }
}

scripted_mtx9_on_death(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  if(!isDefined(param_04)) {
    return;
  }

  if(!isDefined(param_01)) {
    return;
  }

  if(!isPlayer(param_01)) {
    return;
  }

  if(issubstr(param_04, "bechowiec") && issubstr(param_04, "_pap_zm")) {
    if(!isDefined(param_01.bubbleshieldbuildup)) {
      param_01.bubbleshieldbuildup = 0;
    }

    if(!common_scripts\utility::func_562E(param_01.bubblecharged)) {
      param_01.bubbleshieldbuildup++;
      if(!common_scripts\utility::func_562E(self.var_2FDA) && !lib_0547::func_5565(self.var_0A4B, "zombie_fireman")) {
        func_865C("scripted_soul_eat", 0);
        lib_0378::func_8D74("aud_zombie_soul_absorb");
      }
    }

    if(param_01.bubbleshieldbuildup > 15) {
      param_01.bubbleshieldbuildup = 0;
      param_01 thread bubble_sheild_ready();
    }
  }

  if(issubstr(param_04, "charlton") && issubstr(param_04, "_pap_zm")) {
    var_09 = param_01 maps\mp\_events_z::set_last_checked_weapon(param_04);
    thread try_charlton_blackhole(self.var_0116, param_04);
  }
}

func_865C(param_00, param_01) {
  if(common_scripts\utility::func_562E(param_01)) {
    self.var_2A9D = param_00;
    return;
  }

  if(self.var_0BA4 != "traverse") {
    self.var_2A9D = param_00;
  }
}

bubble_sheild_ready() {
  var_00 = self;
  var_00 endon("disconnect");
  var_00.bubblecharged = 1;
  if(!isDefined(var_00.bubblestruct)) {
    var_00.bubblestruct = spawnStruct();
    var_00.bubblestruct.var_0116 = (0, 0, 0);
  }

  var_01 = lib_0547::func_8FBA(var_00.bubblestruct, "zmb_bren_pap_screen", var_00);
  triggerfx(var_01);
  while(!var_00 meleeButtonPressed()) {
    wait 0.05;
  }

  var_01 delete();
  var_00.bubblecharged = 0;
  var_00 thread maps\mp\zombies\consumables\inv_giest_shield::spawn_a_giest_bubble_shield(var_00.var_0116, 5);
}

emp_bubble_bomb_on_reload_empty() {
  var_00 = self;
  var_00 endon("disconnect");
  for(;;) {
    var_00 waittill("reload_start");
    var_00 attempt_reload_action(::spawn_bubble_bomb_on_player_small, "emp44_zm");
  }
}

emp2_bubble_bomb_on_reload_empty() {
  var_00 = self;
  var_00 endon("disconnect");
  for(;;) {
    var_00 waittill("reload_start");
    var_00 attempt_reload_action(::spawn_stunners, "erma_zm");
  }
}

spawn_bubble_bomb_on_player_small() {
  var_00 = self;
  var_00 thread run_reload_bombs();
}

spawn_stunners() {
  var_00 = self;
  var_00 thread run_reload_bombs(1);
}

run_reload_bombs(param_00) {
  var_01 = self;
  var_01 endon("disconnect");
  var_01 spawn_bubble_bomb("tag_weapon_right", self.var_0116 + (160, 0, 0), param_00);
  wait(0.4);
  var_01 spawn_bubble_bomb("tag_weapon_right", self.var_0116 + (0, 160, 0), param_00);
  wait(0.4);
  var_01 spawn_bubble_bomb("tag_weapon_right", self.var_0116 + (-80, -80, 0), param_00);
}

spawn_bubble_bomb(param_00, param_01, param_02) {
  var_03 = self;
  var_04 = "geist_bomb_artil";
  if(common_scripts\utility::func_562E(param_02)) {
    var_04 = "geist_bomb_artil2";
  }

  var_05 = get_bomb_start_pos(param_00);
  var_06 = magicartillery(var_04, var_03.var_0116, param_01, 1, var_05[2] + 42, var_03);
  var_06 thread geist_bombs_projectile_think(var_03, common_scripts\utility::func_562E(param_02));
}

get_bomb_start_pos(param_00) {
  var_01 = self gettagorigin(param_00);
  return var_01;
}

geist_bombs_projectile_think(param_00, param_01) {
  var_02 = self;
  lib_0378::func_8D74("aud_pap_wpn_emp44_bomb_reload", "spawn", var_02);
  var_02 waittill("explode", var_03);
  geist_bombs_static_think(var_03, param_00, param_01);
  if(isDefined(var_02)) {
    var_02 delete();
  }
}

geist_bombs_static_think(param_00, param_01, param_02) {
  var_03 = getgroundposition(param_00, 12);
  var_04 = common_scripts\utility::func_8FFC();
  var_04 method_805B();
  var_04.var_0116 = var_03 + (0, 0, 25);
  var_05 = "zmb_godking_giestbomb";
  if(param_02) {
    var_05 = "zmb_godking_giestbomb2";
  }

  var_06 = "zmb_godking_giestbomb_prime";
  if(param_02) {
    var_06 = "zmb_godking_giestbomb2_prime";
  }

  var_07 = spawnlinkedfx(common_scripts\utility::func_44F5(var_05), var_04, "TAG_ORIGIN");
  var_08 = spawnlinkedfx(common_scripts\utility::func_44F5(var_06), var_04, "TAG_ORIGIN");
  function_014E(var_07, 1);
  function_014E(var_08, 1);
  var_09 = 0.6;
  var_0A = 2.6;
  thread show_bomb_vfx(var_07, var_08, var_09, var_0A);
  lib_0378::func_8D74("aud_pap_wpn_emp44_bomb_reload", "activate", var_04);
  wait(var_09 + var_0A);
  if(!param_02) {
    playFXOnTag(common_scripts\utility::func_44F5("zmb_giestbomb_exp_1shot"), var_04, "TAG_ORIGIN");
  }

  lib_0378::func_8D74("aud_pap_wpn_emp44_bomb_reload", "explode", var_04);
  var_0B = lib_0547::func_408F();
  var_0C = level.var_744A;
  var_0D = common_scripts\utility::func_0F73(var_0B, var_0C);
  if(param_02) {
    param_01 maps\mp\zombies\weapons\_zombie_type_38::spawn_electro_blast(param_00, randomint(1) == 0);
  } else {
    foreach(var_0F in var_0D) {
      if(distance2d(var_0F.var_0116, param_00) <= 160) {
        var_0F dodamage(level.bubble_bomb_dmg, param_00, param_01, param_01, "MOD_EXPLOSIVE", "emp44_zm");
      }
    }
  }

  wait 0.05;
  if(isDefined(var_07)) {
    var_07 delete();
  }

  if(isDefined(var_08)) {
    var_08 delete();
  }

  var_04 delete();
}

show_bomb_vfx(param_00, param_01, param_02, param_03) {
  triggerfx(param_00);
  wait(param_02);
  triggerfx(param_01);
}

attempt_reload_action(param_00, param_01) {
  var_02 = self;
  var_02 endon("disconnect");
  if(!var_02 required_weapon(param_01)) {
    return;
  }

  if(weapon_clip_empty(param_01)) {
    var_02 childthread[[param_00]]();
    while(weapon_clip_empty(param_01)) {
      wait 0.05;
    }
  }
}

weapon_clip_empty(param_00) {
  var_01 = self;
  if(!lib_0547::func_5565(param_00, lib_0547::func_AAF9(var_01 getcurrentweapon()))) {
    return 1;
  }

  return var_01 getcurrentweaponclipammo() == 0;
}

try_charlton_blackhole(param_00, param_01) {
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
  var_02 = getgroundposition(param_00, 12);
  level.charlton_blackhole = common_scripts\utility::func_8FFC();
  level.charlton_blackhole method_805B();
  level.charlton_blackhole.var_0116 = var_02 + (0, 0, 4);
  level.charlton_blackhole.vfxent_radius = spawnlinkedfx(common_scripts\utility::func_44F5("zmb_embers_wind_vortex"), level.charlton_blackhole, "tag_origin");
  triggerfx(level.charlton_blackhole.vfxent_radius);
  level.charlton_blackhole lib_0378::func_8D74("aud_pap_wpn_charlton_vortex");
  level.charlton_blackhole thread spawn_blackhole();
  wait(5);
  if(isDefined(level.charlton_blackhole.vfxent_radius)) {
    level.charlton_blackhole.vfxent_radius delete();
  }

  if(isDefined(level.charlton_blackhole)) {
    level.charlton_blackhole notify("vortex_end");
    level.charlton_blackhole delete();
  }
}

spawn_blackhole() {
  var_00 = self;
  var_00 endon("vortex_end");
  while(isDefined(self)) {
    foreach(var_02 in lib_0547::func_408F()) {
      if(!isDefined(var_02.var_0A4B) || !common_scripts\utility::func_0F79(["zombie_generic", "zombie_berserker", "zombie_heavy", "zombie_exploder", "zombie_sizzler"], var_02.var_0A4B)) {
        continue;
      }

      if(distance(var_02.var_0116, var_00.var_0116) > 256) {
        continue;
      }

      var_00 pulse_drag_in_victim(var_02);
    }

    wait(0.2);
  }
}

pulse_drag_in_victim(param_00) {
  param_00 endon("death");
  self endon("death");
  var_01 = distance(self.var_0116, param_00.var_0116);
  var_02 = var_01 / 256;
  var_03 = 400 * var_02;
  var_04 = self.var_0116 - param_00.var_0116;
  var_04 = (var_04[0], var_04[1], 0);
  var_04 = var_03 * vectornormalize(var_04);
  var_04 = (var_04[0], var_04[1], 125 * var_02);
  param_00 setvelocity(var_04);
}

dp28_zm_fire_think() {
  self endon("disconnect");
  for(;;) {
    self waittill("missile_fire", var_00, var_01);
    if(issubstr(var_01, "dp28")) {
      if(isDefined(var_00)) {
        var_00 thread dp28_death_bolt(self, var_01);
      }
    }
  }
}

sdk_zm_fire_think() {
  self endon("disconnect");
  for(;;) {
    self waittill("weapon_fired", var_00);
    if(issubstr(var_00, "sdk") && is_paped(var_00)) {
      lib_0378::func_8D74("aud_pap_wpn_sdk_shottysnipe_fire", self getEye());
    }
  }
}

dp28_modify_projectile(param_00, param_01) {
  self.var_0117 = param_00;
  self method_8519(0, 0);
  if(param_01) {
    playFXOnTag(common_scripts\utility::func_44F5("zmi_hc_rune_green"), self, "tag_origin");
    lib_0378::func_8D74("aud_pap_wpn_crossbow_cricket_shot");
  }

  return self;
}

dp28_death_bolt(param_00, param_01) {
  var_02 = dp28_modify_projectile(param_00, is_paped(param_01));
  var_03 = is_paped(param_01);
  var_02 childthread do_zombie_damage_better(::missile_do_flight_damage);
  var_04 = var_02 common_scripts\utility::func_A715("missile_stuck", "death", "entitydeleted");
  if(var_04 == "missile_stuck") {
    wait 0.05;
  }

  var_02 notify("end_air_damage");
  if(var_04 == "missile_stuck") {
    wait(4);
    if(var_03) {
      var_02 thread dp28_noisy_cricket(param_00);
      var_02 thread common_scripts\utility::func_2CBE(0.15, ::delete);
    }
  }
}

is_paped(param_00) {
  if(issubstr(param_00, "_pap_zm")) {
    return 1;
  }

  return 0;
}

do_zombie_damage_better(param_00) {
  self endon("death");
  self endon("end_air_damage");
  self.hammer_old_pos = self.var_0116;
  while(isDefined(self)) {
    wait 0.05;
    waittillframeend;
    do_zombie_trace_damage(self.hammer_old_pos, self.var_0116, param_00);
    self.hammer_old_pos = self.var_0116;
  }
}

do_zombie_trace_damage(param_00, param_01, param_02) {
  var_03 = lib_0547::func_408F();
  foreach(var_05 in var_03) {
    var_06 = var_05.var_8302;
    var_07 = var_05.var_8303;
    var_08 = var_07 + 12;
    var_09 = var_08 * var_08;
    var_0A = sqrd_dist_between_segments(param_00, param_01, var_05.var_0116, var_05.var_0116 + (0, 0, var_06));
    if(var_0A[0] <= var_09) {
      [[param_02]](var_05, var_0A[1]);
    }
  }
}

missile_do_flight_damage(param_00, param_01) {
  if(lib_0547::func_5565(param_00.temporary_missile_flight_imunity, 1)) {
    return;
  }

  if(isDefined(param_00.var_0A4B)) {
    var_02 = lib_0547::func_0A51(param_00.var_0A4B);
    if(isDefined(var_02) && common_scripts\utility::func_562E(var_02.knockbyravensword)) {
      lib_0547::func_7D1B(self, param_00, "close", self.var_0117);
    }

    param_00 thread missile_set_temp_immunity();
    param_00 dodamage(level.dp38missiledamage, param_01, self.var_0117, self.var_0117, "MOD_EXPLOSIVE", "dp28_pap_zm");
  }
}

missile_set_temp_immunity() {
  self endon("death");
  self.temporary_missile_flight_imunity = 1;
  wait(0.85);
  self.temporary_missile_flight_imunity = undefined;
}

dp28_noisy_cricket(param_00) {
  var_01 = self;
  var_02 = var_01.var_0116;
  var_03 = 0;
  var_04 = lib_0547::func_408F();
  var_04 = function_01AC(var_04, var_02, 256);
  thread play_noisy_cricket_vfx(var_01);
  foreach(var_06 in var_04) {
    var_07 = 0;
    if(!isDefined(var_06.var_0A4B) || lib_0547::func_5565(var_06, param_00)) {
      continue;
    }

    if(!isDefined(var_06.var_0A4B) || !common_scripts\utility::func_0F79(["zombie_generic", "zombie_berserker", "zombie_heavy", "zombie_exploder", "zombie_sizzler"], var_06.var_0A4B)) {
      var_03 = 1;
    }

    if(distance2d(var_06.var_0116, var_02) <= 128) {
      if(common_scripts\utility::func_562E(var_03)) {
        var_06 dodamage(1800, param_00.var_0116, param_00, param_00, "MOD_EXPLOSIVE", "dp28_pap_zm");
      } else {
        var_06 dodamage(level.dp38cricetdamage, param_00.var_0116, param_00, param_00, "MOD_EXPLOSIVE", "dp28_pap_zm");
      }

      var_07 = 1;
    } else if(distance2d(var_06.var_0116, var_02) <= 192) {
      if(common_scripts\utility::func_562E(var_03)) {
        var_06 dodamage(1200, param_00.var_0116, param_00, param_00, "MOD_EXPLOSIVE", "dp28_pap_zm");
      } else {
        var_06 dodamage(level.dp38cricetdamage * 0.66, param_00.var_0116, param_00, param_00, "MOD_EXPLOSIVE", "dp28_pap_zm");
      }

      if(isDefined(var_06.var_0A4B)) {
        var_08 = lib_0547::func_0A51(var_06.var_0A4B);
        if(isDefined(var_08) && common_scripts\utility::func_562E(var_08.knockbybladebarbarossa)) {
          lib_0547::func_7D1B(param_00, var_06, "medium");
        }
      }

      var_07 = 1;
    } else if(distance2d(var_06.var_0116, var_02) <= 256) {
      if(common_scripts\utility::func_562E(var_03)) {
        var_06 dodamage(600, param_00.var_0116, param_00, param_00, "MOD_EXPLOSIVE", "dp28_pap_zm");
      } else {
        var_06 dodamage(level.dp38cricetdamage * 0.33, param_00.var_0116, param_00, param_00, "MOD_EXPLOSIVE", "dp28_pap_zm");
      }

      if(isDefined(var_06.var_0A4B)) {
        var_08 = lib_0547::func_0A51(var_06.var_0A4B);
        if(isDefined(var_08) && common_scripts\utility::func_562E(var_08.knockbybladebarbarossa)) {
          lib_0547::func_7D1B(param_00, var_06, "far");
        }
      }

      var_07 = 1;
    }

    if(isDefined(var_06.myshield) && var_07) {
      var_06.myshield dodamage(level.dp38cricetdamage * 0.33, param_00.var_0116, param_00, param_00, "MOD_EXPLOSIVE", "dp28_pap_zm");
    }
  }
}

play_noisy_cricket_vfx(param_00) {
  if(level.noisy_circket_vfx_time.size >= 2) {
    return;
  }

  var_01 = gettime();
  level.noisy_circket_vfx_time = common_scripts\utility::func_0F6F(level.noisy_circket_vfx_time, var_01);
  playFX(common_scripts\utility::func_44F5("zmb_dp28_green_impact"), param_00.var_0116);
  param_00 lib_0378::func_8D74("aud_pap_wpn_crossbow_cricket_explo");
  wait(1.25);
  level.noisy_circket_vfx_time = common_scripts\utility::func_0F93(level.noisy_circket_vfx_time, var_01);
}

sqrd_dist_between_segments(param_00, param_01, param_02, param_03) {
  var_04 = [];
  var_05 = 1E-06;
  var_06 = param_03 - param_02;
  var_07 = param_01 - param_00;
  var_08 = param_00 - param_02;
  var_09 = vectordot(var_06, var_06);
  var_0A = vectordot(var_07, var_07);
  var_0B = vectordot(var_07, var_06);
  var_0C = vectordot(var_06, var_08);
  var_0D = vectordot(var_07, var_08);
  var_0E = var_09 * var_0A - var_0B * var_0B;
  var_0F = 0;
  var_10 = 0;
  if(var_0E <= var_05) {
    if(var_0B > var_09) {
      var_0F = var_0D / var_0B;
    } else {
      var_0F = var_0C / var_09;
    }
  } else {
    var_0F = var_0C * var_0A - var_0B * var_0D / var_0E;
    var_10 = var_0B * var_0C - var_0D * var_09 / var_0E;
  }

  var_0F = clamp(var_0F, 0, 1);
  var_10 = clamp(var_10, 0, 1);
  var_11 = param_02 + var_06 * var_0F;
  var_12 = param_00 + var_07 * var_10;
  var_13 = var_12 - var_11;
  var_14 = vectordot(var_13, var_13);
  var_04[1] = var_12;
  var_04[2] = var_11;
  var_04[0] = var_14;
  return var_04;
}