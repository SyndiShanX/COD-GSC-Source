/**************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\moonjackal\moonjackal_dogfight.gsc
**************************************************************/

_id_5881() {
  scripts\engine\utility::flag_init("takeoff_runway_blocker");
  scripts\engine\utility::flag_init("start_runway_lights");
  scripts\engine\utility::flag_init("start_ally_engines");
  scripts\engine\utility::flag_init("did_supply_or_kills");
  scripts\engine\utility::flag_init("flag_stop_spawning_jackals");
  scripts\engine\utility::flag_init("flag_death_while_locked");
  scripts\engine\utility::flag_init("dogfight_done");
  scripts\engine\utility::flag_init("missileboats_arrived");
  scripts\engine\utility::flag_init("missileboat_phase_1");
  scripts\engine\utility::flag_init("missileboat_phase_2");
  scripts\engine\utility::flag_init("missileboat_phase_3");
  scripts\engine\utility::flag_init("missileboat_killed");
  scripts\engine\utility::flag_init("missileboat_done");
}

_id_5890() {}

_id_589C() {
  precachemodel("building_turret_tower_01_dest");
}

_id_AA65() {
  level._id_AA64 = 1;
}

_id_AA9A() {
  level._id_10C6E = _id_7CA4();
  level._id_AA81 = getEntArray("launch_jackals", "targetname");
}

_id_AA86() {
  thread _id_F9E1();
  thread _id_AA71();
  thread _id_F8B7();
  scripts\sp\maps\moonjackal\moonjackal_util::_id_AB9F(0, 0);

  if(scripts\engine\utility::is_true(level._id_AA64)) {
    visionsetnaked("moonjackal_hangar", 0.0);
    thread setup_hangar_lights();
    _id_0BDC::_id_137D6();
    wait 1;
  } else {
    visionsetnaked("moonjackal_hangar_open", 0.0);
    level._id_A056.mount_instant_hud_boot_delay = 12;
    scripts\sp\utility::_id_13705();
  }

  launch_hangar_light_change();
  scripts\engine\utility::flag_set("start_ally_engines");
  thread _id_AAA1();
  thread _id_AA7E();
  thread _id_AA7D();

  if(!isDefined(level._id_5A10))
    thread _id_AA6C();

  scripts\sp\utility::_id_6EEB();
  thread _id_AA4D();
  thread _id_3962();
  _id_F941();
  _id_FA72();
  level waittill("player_runway_takeoff");
  thread _id_0E4B::_id_8DEA();
  thread scripts\sp\maps\moonjackal\moonjackal_util::sunsettings_dogfight(3);
  thread scripts\sp\maps\moonjackal\moonjackal_util::_id_3C44(level._id_111D0.final_sunangles, 7);
  thread scripts\sp\maps\moonjackal\moonjackal_util::_id_3C47(level._id_111D0.final_sunoffset, 7);
  level._id_D127 _id_0BDC::_id_A151(0);
  wait 5;
}

launch_hangar_light_change() {
  if(scripts\engine\utility::is_true(level._id_AA64)) {
    var_0 = getEntArray("script_light_flicker", "targetname");
    visionsetnaked("moonjackal_hangar_open", 0.05);
    wait 0.5;

    foreach(var_2 in var_0)
    var_2 thread scripts\sp\lights::_id_AB83(0, 0.05);

    wait 1.0;
  }

  scripts\engine\utility::flag_set("start_runway_lights");
  thread _id_AA4C();
  wait 1;
}

setup_hangar_lights() {
  wait 0.2;
  visionsetnaked("moonjackal_hangar", 0.0);
  level notify("mn_launch_jacklights_on_1");
  level notify("mn_launch_jacklights_on_2");
  level notify("mn_launch_jacklights_on_3");
  level notify("mn_launch_jacklights_on_4");
}

_id_AA7E() {
  wait 3.5;
  var_0 = getEnt("intro_jackal_un1", "targetname");
  var_1 = getEnt("intro_jackal_un2", "targetname");
  var_2 = getEnt("intro_jackal_un3", "targetname");
  var_3 = getEnt("intro_jackal_ca1", "targetname");
  var_4 = getEnt("intro_jackal_ca2", "targetname");
  var_5 = getEnt("intro_jackal_ca3", "targetname");
  var_6 = getEnt("intro_jackal_ca4", "targetname");
  thread _id_9ABE(0.3, "intro_jackal_un1", 3.3);
  thread _id_9ABE(1.4, "intro_jackal_ca1");
  thread _id_9ABE(1.9, "intro_jackal_ca4");
  thread _id_9ABE(2.8, "intro_jackal_ca2");
  thread _id_9ABE(5.0, "intro_jackal_un2", undefined, 1);
  thread _id_9ABE(5.7, "intro_jackal_ca3", 3.15, undefined, 0.1);
  thread _id_9ABE(7.7, "intro_jackal_un3");
}

_id_9ABE(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_0) && var_0 > 0)
    wait(var_0);

  var_5 = getEnt(var_1, "targetname");

  if(!isDefined(var_5)) {
    return;
  }
  var_6 = var_5 thread scripts\sp\utility::_id_10808();
  var_6 _id_0BDC::_id_19A9();
  var_7 = getcsplineidarray(var_6.target);
  var_6 thread _id_0BDC::_id_A1EF(var_7[randomint(var_7.size)]);
  var_6 _id_0BDC::_id_19AE("shoot_at_will");

  if(scripts\engine\utility::is_true(var_3)) {
    var_6 _id_0BDC::_id_19AF(100, 100, 100);
    level._id_9AC7 = var_6;
  }

  if(isDefined(var_4) && isDefined(level._id_9AC7))
    var_6 scripts\engine\utility::delaythread(var_4, _id_0B76::_id_1992, "tag_origin", level._id_9AC7);

  if(isDefined(var_2)) {
    wait(var_2);
    var_6._id_9930 = 1;
    var_6 notify("death");
  } else
    var_6 waittill("end_spline");

  wait 1.0;

  if(isDefined(var_6) && isalive(var_6))
    var_6 delete();
}

_id_F9E1() {
  var_0 = getEnt("player_jackal", "targetname");
  level._id_D127 = var_0;

  if(scripts\engine\utility::is_true(level._id_AA64))
    var_0 _id_0BDC::_id_F48D("default_landed");
  else
    var_0 _id_0BDC::_id_F48D("instant_land");

  var_0 _id_0BDC::_id_F5BD("runway");

  if(!scripts\engine\utility::is_true(level._id_AA64))
    _id_0BDC::_id_10CD1(var_0, undefined, "land", "runway");

  var_0 _id_0BDC::_id_A151(1);

  if(scripts\sp\utility::_id_93A6())
    thread _id_0BD9::_id_FA4F();

  thread settle_land_anim();
  scripts\engine\utility::flag_wait("start_runway_lights");
  _id_0BDB::_id_11481();
}

#using_animtree("jackal");

settle_land_anim() {
  _id_0BDC::_id_137DA();
  wait 0.05;
  level.player _meth_8489("body", %jackal_pilot_landed_state_idle, 0, %jackal_vehicle_landed_state_idle_plr);
  wait 5;
  level.player _meth_8489("blendout", %jackal_vehicle_maneuver_juke_r, 0);
}

_id_AAA1() {
  wait 0.5;
  scripts\sp\utility::_id_1034D("mn_jck_plr_nozzlesaregoodenginesgood");
  scripts\sp\utility::_id_10350("moon_omr_coastguardsgett");
  scripts\sp\utility::_id_10350("moon_eth_tigrisneedsairi");
  scripts\sp\utility::_id_10350("moon_slt_onestepatatimeb");
  scripts\sp\utility::_id_10350("moon_slt_wesecurethebase");
  scripts\sp\utility::_id_1034D("mn_jck_plr_allteamsweregofor");
  scripts\engine\utility::flag_set("takeoff_runway_blocker");
  level.player playSound("jackal_warmup2_plr");
  thread _id_AAA2();
  level waittill("player_runway_takeoff");
  scripts\sp\utility::_id_10350("mn_jck_un1_onethreefullafterburner");
  scripts\sp\utility::_id_10350("mn_jck_slt_scaronetwoaway");
  scripts\sp\utility::_id_1034D("mn_jck_plr_theonlywayweresaving");
}

_id_AAA2() {
  level endon("player_runway_takeoff");
  var_0 = 0;

  for(var_1 = ["mn_jck_eth_thosemenneedourhelp", "mn_jck_slt_needmywingmanouthere"]; var_0 < var_1.size; var_0++) {
    wait(randomintrange(8, 14) + var_0 * 2);
    scripts\sp\utility::_id_10350(scripts\engine\utility::random(var_1));
  }
}

_id_AA71() {
  var_0 = getcsplineid("launch_enemy_entrace");
  var_1 = scripts\engine\utility::getStruct("launch_enemy_attack_start", "targetname");
  var_2 = scripts\engine\utility::spawn_tag_origin();
  var_2.origin = var_1.origin;
  var_2.angles = var_1.angles;
  var_3 = getcsplineid("launch_enemy_entrace2");
  var_4 = scripts\engine\utility::getStruct("launch_enemy_attack_start2", "targetname");
  var_5 = scripts\engine\utility::spawn_tag_origin();
  var_5.origin = var_4.origin;
  var_5.angles = var_4.angles;
  var_6 = [];

  while(!isDefined(level._id_26EB))
    wait 0.05;

  var_6 = _id_7A75(var_6);
  var_6 = _id_7A75(var_6);
  var_6[0] vehicle_teleport(var_1.origin, var_1.angles);
  var_6[0] linkTo(var_2);
  var_6[1] vehicle_teleport(var_4.origin, var_4.angles);
  var_6[1] linkTo(var_5);
  level waittill("player_off_ramp");
  wait 1.65;
  var_6[0] thread _id_AA73();
  var_6[0] thread _id_E7B5(var_0, var_2);
  var_6[1] thread _id_E7B5(var_3, var_5);
}

_id_E7B5(var_0, var_1) {
  self endon("death");
  self unlink();
  self._id_51E6 = 0;
  thread _id_AA72();
  _id_0BDC::_id_A1EF(var_0);
  _id_0BDC::_id_1986();
  var_1 delete();
  self.ignoreme = 0;
}

_id_7A75(var_0) {
  var_1 = undefined;

  for(;;) {
    foreach(var_3 in level._id_26EB._id_FE2D) {
      if(!isDefined(var_3)) {
        continue;
      }
      if(!isDefined(var_3._id_A532))
        continue;
      else if(var_3._id_A532)
        continue;
      else if(scripts\engine\utility::array_contains(var_0, var_3)) {
        continue;
      }
      if(var_3 _id_0BDC::_id_9BCF()) {
        continue;
      }
      var_4 = _id_0B76::_id_7A60(var_3.origin);

      if(var_4 > 0.7) {
        continue;
      }
      var_1 = var_3;
    }

    if(isDefined(var_1)) {
      break;
    }

    wait 0.05;
  }

  var_1.ignoreme = 1;
  self._id_51E6 = 0;
  var_1 _id_0BDC::_id_19A2();
  var_0 = scripts\engine\utility::array_add(var_0, var_1);
  return var_0;
}

_id_AA72() {
  level endon("return_player_control");
  var_0 = 550;
  var_1 = 300;
  var_2 = 6000;
  var_3 = -1000;

  for(;;) {
    var_4 = level._id_D127.origin + anglesToForward(level._id_D127.angles) * var_3;
    var_5 = level._id_D127.origin + anglesToForward(level._id_D127.angles) * var_2;
    var_6 = pointonsegmentnearesttopoint(var_4, var_5, self.origin);
    var_7 = distance(var_4, var_6);
    var_8 = scripts\sp\math::_id_C097(0, abs(var_2) + abs(var_3), var_7);
    var_9 = scripts\sp\math::_id_6A8E(var_0, var_1, var_8);
    _id_0BDC::_id_19AB(var_9);
    wait 0.05;
  }
}

_id_AA73() {
  var_0 = spawnVehicle("veh_mil_air_un_jackal_02", "player_sled", "jackal_un", level._id_D127.origin, level._id_D127.angles);
  var_0 hide();
  var_0 notsolid();
  var_0 linkTo(level._id_D127, "tag_origin", (3000, 0, 400), (0, 0, 0));
  var_0 makeentitysentient("allies", 0);
  _id_0BDC::_id_19B5(var_0);
  wait 2;
  _id_0BDC::_id_19AE("shoot_forever");
  wait 2;
  _id_0BDC::_id_198A();
  _id_0BDC::_id_19AE("shoot_at_will");
}

_id_F8B3() {
  if(!isDefined(level._id_EAD6)) {
    level._id_EAD6 = _id_10732("salter_arena_jackal");
    level._id_DE1C = _id_10732("ally_1_arena_jackal");
    level._id_DE1F = _id_10732("ally_2_arena_jackal");
  }
}

_id_10732(var_0) {
  var_1 = getEnt(var_0, "targetname");
  var_2 = var_1 scripts\sp\utility::_id_10808();
  var_2 _id_C988();
  var_2._id_51E6 = 1;
  return var_2;
}

_id_AA7D() {
  wait 0.5;
  level._id_D127.ignoreme = 1;
  level._id_EAD6.ignoreme = 1;
  level._id_DE1C.ignoreme = 1;
  level._id_DE1F.ignoreme = 1;
  level waittill("player_runway_takeoff");
  level._id_D127.ignoreme = 0;
  level._id_EAD6.ignoreme = 0;
  level._id_DE1C.ignoreme = 0;
  level._id_DE1F.ignoreme = 0;
}

_id_F8B7() {
  var_0 = getEntArray("launch_jackals", "targetname");
  var_0 = scripts\engine\utility::array_remove(var_0, level._id_D127);
  level._id_EAD6 = var_0[1];
  level._id_DE1C = var_0[0];
  level._id_DE1F = var_0[2];
  level._id_EAD6 thread _id_1D00(0, 0);
  level._id_DE1C thread _id_1D00(1.0, 0.25);
  level._id_DE1F thread _id_1D00(0.0, 0.15, 1);
}

_id_E04E() {
  var_0 = getEntArray("launch_jackals", "targetname");

  foreach(var_2 in var_0)
  var_2 delete();
}

_id_FA72() {
  _id_12A8A("misc_turret_ground_med_cannon_un", 0);
  _id_12A8A("misc_turret_ground_small_cannon_un", 0);
  _id_12A8A("misc_turret_ground_small_missile_un", 0);
  var_0 = getEntArray("trigger_attack_turrets", "targetname");

  foreach(var_2 in var_0)
  var_2 thread _id_A0B7();
}

_id_12A8A(var_0, var_1) {
  while(var_1 > 0) {
    var_2 = scripts\engine\utility::random(level._id_864B[var_0].turrets);
    level._id_864B[var_0].turrets = scripts\engine\utility::array_remove(level._id_864B[var_0].turrets, var_2);
    var_2 notify("death");
    var_1--;
  }
}

_id_A0B7() {
  self endon("death");

  for(;;) {
    self waittill("trigger", var_0);

    if(var_0.classname != "script_vehicle_jackal_enemy" || isDefined(var_0._id_12758)) {
      continue;
    }
    if(isDefined(var_0._blackboard) && var_0._blackboard.animscriptedactive) {
      continue;
    }
    var_1 = getEntArray(self.target, "targetname");
    var_1 = scripts\engine\utility::array_removeundefined(var_1);
    var_2 = scripts\engine\utility::random(var_1);
    var_0 thread _id_A0B6(var_2);
    wait(randomfloatrange(0.2, 0.5));
  }
}

_id_A0B6(var_0) {
  self endon("death");

  if(!isDefined(var_0)) {
    return;
  }
  if(vectordot(anglesToForward(self.angles), vectorNormalize(var_0.origin - self.origin)) < 0.2) {
    return;
  }
  var_1 = distance(level._id_D127.origin, var_0.origin);
  var_2 = vectordot(anglesToForward(level._id_D127.angles), vectorNormalize(var_0.origin - level._id_D127.origin));

  if(var_1 > 90000 || var_2 < -0.2) {
    return;
  }
  self._id_12758 = 1;
  var_3 = 30;

  if(randomint(100) < var_3) {
    var_4 = scripts\engine\utility::random(["tag_flash_right", "tag_flash_left"]);

    if(var_2 > 0.3 && var_1 < 30000)
      var_5 = var_0;
    else {
      var_5 = scripts\engine\utility::spawn_tag_origin();
      var_5._id_5F27 = 1;
      var_6 = vectorNormalize((randomfloatrange(-1, 1), randomfloatrange(-1, 1), randomfloatrange(-1, 1)));
      var_6 = var_6 * randomfloatrange(300, 1500);
      var_5.origin = var_0.origin + var_6;
    }

    if(isDefined(var_5))
      thread _id_0B76::_id_1992(var_4, var_5);
  } else
    _id_0BDC::_id_1984(var_0);

  wait 2;
  self._id_12758 = undefined;
}

_id_1D00(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = 0;

  self.ignoreme = 1;
  _id_0BDC::_id_6B4C("landed_mode");
  _id_0BDC::_id_A167();
  thread _id_6DCA();
  scripts\engine\utility::flag_wait("start_ally_engines");
  wait 1.0;
  wait(var_0);
  thread _id_1CFD(var_2);
  level waittill("player_clear_for_launch");
  _id_13676();
  wait(var_1);
  _id_0BDC::_id_6B4C("fly", 1);
  thread _id_0C20::_id_A3B7("launch_mode");
  self playSound("scn_moonjack_launch_jackal_npc");
  thread scripts\sp\vehicle_paths::_id_845A();
  thread _id_1D02();
  self notify("ally_jackal_go");

  if(self == level._id_DE1C)
    thread scripts\sp\utility::_id_10350("mn_jck_un1_onethreelaunchin");

  self waittill("off_ramp");
  self waittill("return_player_control");
  _id_0BDC::_id_A19F();
  self.ignoreme = 0;
  wait 6;
  _id_0BDC::_id_F43D("ai");
  _id_0BDC::_id_6B4C("fly");
  thread _id_0C20::_id_A3B7("fly");
  wait 0.05;
  _id_C98A();
  _id_0BDC::_id_1998();
}

_id_1CFE(var_0) {
  if(!var_0)
    scripts\sp\utility::_id_75C4("jackal_runway_wash_charge", "tag_origin");
}

_id_1D06(var_0) {
  if(!var_0)
    scripts\sp\utility::_id_75F8("jackal_runway_wash_charge", "tag_origin");

  scripts\sp\utility::_id_75C4("jackal_runway_wash_takeoff", "tag_origin");
  wait 0.75;
  scripts\sp\utility::_id_75F8("jackal_runway_wash_takeoff", "tag_origin");
}

_id_1D02() {
  var_0 = spawnStruct();
  var_0.speed = 0;
  var_0 _id_1CFB(self);
  var_0 _id_1D03(self);
  var_0 _id_1D01(self);
}

_id_1CFB(var_0) {
  self.speed = 5;
  var_1 = 15;
  var_2 = 400;

  while(self.speed < var_2) {
    var_0 _id_0BDC::_id_19AB(self.speed);
    self.speed = self.speed + var_1;
    wait 0.05;
  }
}

_id_1D03(var_0) {
  level endon("return_player_control");
  var_1 = 500;
  var_2 = 300;
  var_3 = 7000;
  var_4 = -2000;

  for(;;) {
    var_5 = level._id_D127.origin + anglesToForward(level._id_D127.angles) * var_4;
    var_6 = level._id_D127.origin + anglesToForward(level._id_D127.angles) * var_3;
    var_7 = pointonsegmentnearesttopoint(var_5, var_6, var_0.origin);
    var_8 = distance(var_5, var_7);
    var_9 = scripts\sp\math::_id_C097(0, abs(var_3) + abs(var_4), var_8);
    self.speed = scripts\sp\math::_id_6A8E(var_1, var_2, var_9);
    var_0 _id_0BDC::_id_19AB(self.speed);
    wait 0.05;
  }
}

_id_1D01(var_0) {
  var_1 = 500;

  while(self.speed < var_1) {
    self.speed = self.speed + 3;
    var_0 _id_0BDC::_id_19AB(self.speed);
  }

  wait 6;
  var_0 _id_0BDC::_id_19AB(420);
}

_id_13676() {
  level endon("player_runway_takeoff");
  wait 0.5;
}

_id_AA6C() {
  thread _id_A2D3();
  var_0 = scripts\engine\utility::getStructArray("struct_fx_air_suck_vent", "targetname");
  level._id_5A10 = spawnStruct();
  level._id_5A10._id_13296 = [];

  foreach(var_2 in var_0) {
    var_3 = scripts\engine\utility::spawn_tag_origin();
    var_3.origin = var_2.origin;
    var_3.angles = var_2.angles;
    level._id_5A10._id_13296[level._id_5A10._id_13296.size] = var_3;
  }

  var_5 = scripts\engine\utility::getStruct("struct_fx_air_suck_door", "targetname");
  var_3 = scripts\engine\utility::spawn_tag_origin();
  var_3.origin = var_5.origin;
  var_3.angles = var_5.angles;
  level._id_5A10._id_5978 = var_3;
  wait 0.05;

  foreach(var_7 in level._id_5A10._id_13296)
  playFXOnTag(level._effect["vfx_moon_airlock_fog_ambient"], var_7, "tag_origin");

  level waittill("notify_vents_suck");

  foreach(var_7 in level._id_5A10._id_13296) {
    stopFXOnTag(level._effect["vfx_moon_airlock_fog_ambient"], var_7, "tag_origin");
    playFXOnTag(level._effect["vfx_moon_airlock_suck_in"], var_7, "tag_origin");
  }

  level.player playSound("scn_moon_airlock_depressurize_lr");
  level waittill("notify_door_suck");
  playFXOnTag(level._effect["vfx_moon_airlock_wind_tunnel_bigger"], level._id_5A10._id_5978, "tag_origin");
  wait 10;

  foreach(var_7 in level._id_5A10._id_13296)
  var_7 delete();

  level._id_5A10._id_5978 delete();
}

_id_A2D3() {
  wait 0.1;
  level._id_EAD6 thread _id_FBAC();
  var_0 = scripts\engine\utility::spawn_tag_origin(level._id_EAD6.origin + (0, 0, -19), level._id_EAD6.angles);
  var_0 linkTo(level._id_EAD6);
  playFXOnTag(level._effect["vfx_jackal_nitrogen_rcs_preflight"], var_0, "TAG_ORIGIN");
  level._id_DE1C thread _id_FBAC();
  var_1 = scripts\engine\utility::spawn_tag_origin(level._id_DE1C.origin + (0, 0, -19), level._id_DE1C.angles);
  var_1 linkTo(level._id_DE1C);
  playFXOnTag(level._effect["vfx_jackal_nitrogen_rcs_preflight"], var_1, "TAG_ORIGIN");
  wait 8;
  var_0 delete();
  var_1 delete();
}

_id_FBAC() {
  scripts\engine\utility::delaythread(2, scripts\sp\utility::play_sound_on_tag, "jackal_nitrogen_blast_series_02", "tag_spotlight");
  scripts\engine\utility::delaythread(3.5, scripts\sp\utility::play_sound_on_tag, "jackal_nitrogen_blast_dbl_03", "tag_flash");
  scripts\engine\utility::delaythread(4, scripts\sp\utility::play_sound_on_tag, "jackal_nitrogen_blast_single_01", "tag_spotlight");
  scripts\engine\utility::delaythread(4.5, scripts\sp\utility::play_sound_on_tag, "jackal_nitrogen_blast_dbl_long_02", "tag_flash");
  scripts\engine\utility::delaythread(2.2, scripts\sp\utility::play_sound_on_tag, "jackal_nitrogen_blast_series_01", "tag_enginebottom_left");
  scripts\engine\utility::delaythread(2.6, scripts\sp\utility::play_sound_on_tag, "jackal_nitrogen_blast_dbl_01", "tag_enginebottom_left");
  scripts\engine\utility::delaythread(3.3, scripts\sp\utility::play_sound_on_tag, "jackal_nitrogen_blast_dbl_03", "tag_enginebottom_right");
  scripts\engine\utility::delaythread(3.9, scripts\sp\utility::play_sound_on_tag, "jackal_nitrogen_blast_single_02", "tag_enginebottom_left");
  scripts\engine\utility::delaythread(4.2, scripts\sp\utility::play_sound_on_tag, "jackal_nitrogen_blast_dbl_02", "tag_enginebottom_right");
  scripts\engine\utility::delaythread(4.6, scripts\sp\utility::play_sound_on_tag, "jackal_nitrogen_blast_dbl_long_01", "tag_enginebottom_left");
}

_id_AA4D() {
  thread _id_0BDC::_id_D527("scn_moon_hangar_airlock_init", level._id_5A10._id_5978.origin);
  thread _id_0BDC::_id_D527("scn_moon_hangar_lights_on", level._id_5A10._id_5978.origin);
  wait 0.05;
  wait 3;
  level notify("notify_vents_suck");
  var_0 = getEntArray("jackalhangardoor", "targetname");

  if(!isDefined(var_0) || var_0.size < 1) {
    return;
  }
  var_1 = scripts\engine\utility::getclosest(level.player.origin, var_0);
  level notify("notify_door_suck");
  var_2 = 5.5;
  var_1 movez(450, var_2);
  thread sunlight_door_open();
  level.player playSound("scn_moonjack_hangar_door_open");
  var_1 playLoopSound("scn_moonjack_hangar_door_lp");
  thread _id_AA6A();
  wait(var_2);
  level.player playSound("scn_moonjack_hangar_door_stop");
  var_1 stoploopsound("scn_moonjack_hangar_door_lp");
  level waittill("player_runway_takeoff");
  level.player playSound("scn_moonjack_launch_plr");
  setglobalsoundcontext("atmosphere", "space", 2);
  wait 0.5;
  var_1 movez(-450, var_2);
  wait 1;
}

sunlight_door_open() {
  thread scripts\sp\maps\moonjackal\moonjackal_util::_id_3C44(level._id_111D0.hangar_sunangles, 0);
  thread scripts\sp\maps\moonjackal\moonjackal_util::_id_3C47(level._id_111D0.hangar_sunoffset, 0);
  var_0 = 0.5;
  thread scripts\sp\maps\moonjackal\moonjackal_util::_id_AB9F(var_0, 150);
  wait(var_0);
  var_1 = 3;
  visionsetnaked("moonjackal", var_1);
  thread scripts\sp\maps\moonjackal\moonjackal_util::_id_AB9F(var_1, level._id_111D0.hangar_intensity);
}

_id_AA4C() {
  var_0 = scripts\engine\utility::getStruct("struct_jackal_hangar_light", "targetname");
  level._id_1B1C = scripts\engine\utility::spawn_tag_origin();
  level._id_1B1C.origin = var_0.origin;
  var_1 = 1.1;
  var_2 = 7;
  level._id_1B1C playLoopSound("hangar_airlock_alarm_init");

  while(var_2 > 0) {
    playFX(level._effect["vfx_airlock_jackal_light"], var_0.origin, anglesToForward(var_0.angles), anglestoup(var_0.angles));
    wait(var_1);
    var_2--;
  }

  level._id_1B1C _meth_8278(0, 0.2);
  wait 0.2;
  level._id_1B1C stopsounds();
  level._id_1B1C delete();
}

_id_AA6A() {
  wait 1;
  level notify("notify_jackal_cleared");
}

_id_58A1() {
  level._id_10C6E = _id_7CA4();
  scripts\sp\maps\moonjackal\moonjackal_util::sunsettings_dogfight();
  scripts\sp\utility::_id_241F();
  _id_E04E();
  _id_589B("player_jackal");
  scripts\sp\utility::_id_6EEB();
}

_id_5895() {
  scripts\sp\maps\moonjackal\moonjackal_util::sunsettings_dogfight();
  level._id_10C6E = _id_7CA4();
  scripts\sp\utility::_id_28D8();
  scripts\sp\utility::_id_6EEB();
}

_id_589B(var_0, var_1) {
  if(!scripts\engine\utility::is_true(var_1))
    _id_F941();

  _id_FA72();
  thread _id_3962();
  var_2 = getEnt(var_0, "targetname");
  var_3 = scripts\engine\utility::getStruct("player_jackal_startpoint", "targetname");
  var_2 vehicle_teleport(var_3.origin, var_3.angles);
  _id_0BDC::_id_10CD1(var_2, undefined, "fly");
  wait 0.1;
  var_2 _id_0BDC::_id_A0BE();
  wait 2;
  var_2 _id_0BDC::_id_A0BE(0);
}

_id_5897() {
  setglobalsoundcontext("atmosphere", "space", 2);
  wait 3.1;
  thread _id_58B3();
  _id_0BDC::_id_A321(0.5);
  _id_0BDC::_id_A31E(0.0);
  _id_0BDC::_id_A1A9(0);
  _id_0BDC::_id_A1AB("enemy_lockon");
  _id_0BDC::_id_A1AB("enemy_missileVolley");
  _id_0BDC::_id_A1AB("enemy_hoverheat_missiles");
  scripts\sp\utility::_id_266A("dogfight_1_start");
  scripts\sp\utility::_id_CF8D();
  scripts\sp\utility::_id_28D8();
  setmusicstate("mx_188_moonjackal_combatmood_b_temp");
  thread _id_2152();
  thread _id_12AD8();
  wait 5;
  thread _id_9AF1();
  thread _id_58AB();
  _id_588C(1);
  wait 0.2;
  thread scripts\sp\utility::_id_1034D("mn_jck_plr_gotya");
  wait 1;
  scripts\sp\utility::_id_266A("dogfight_1_midpoint");
  _id_588C(1);
  scripts\engine\utility::flag_set("dogfight_done");
}

_id_12AD8() {
  _id_588C(2);
  scripts\sp\utility::_id_CF8B();
  wait 1.0;
  thread scripts\sp\utility::_id_1034D("mn_jck_plr_twodown");
  wait 1;
  thread scripts\sp\utility::_id_10350("mn_jck_slt_thatallimon4");
  scripts\sp\utility::_id_CF8D();
}

_id_58B3() {
  wait 3.0;
  scripts\sp\maps\moonjackal\moonjackal_util::_id_EF4B("mn_jck_un1_tallyfourtallyfourskelters");
  scripts\sp\maps\moonjackal\moonjackal_util::_id_EF4B("mn_jck_plr_weaponsfreeengagetheskelters");
  scripts\sp\maps\moonjackal\moonjackal_util::_id_EF4B("mn_jck_omr_brookskashimafocusallantiair");
  thread _id_5871();
}

_id_5871() {
  level endon("next area");
  level endon("all_missileboats_destroyed");

  for(;;) {
    var_0 = ["mn_jck_brk_theseguysarefast", "mn_jck_ksh_theyreoutflyingouraa", "mn_jck_brk_anotherturretdown", "mn_jck_ksh_werelosinggroundsupport", "mn_jck_brk_lostturret6b", "mn_jck_ksh_turret2edown", "mn_jck_brk_turret4adown", "mn_jck_ksh_4coffline", "mn_jck_brk_tower4lostallits", "mn_jck_brk_gotone", "mn_jck_ksh_missilesloose", "mn_jck_brk_skelterdown", "mn_jck_ksh_gothim", "mn_jck_brk_bogeydown", "mn_jck_ksh_missilesout", "mn_jck_brk_missilesloose", "mn_jck_ksh_foxthree", "mn_jck_brk_effortflared", "mn_jck_ksh_cantgetpasttheircountermeasures", "mn_jck_slt_keepthoseskeltersoffthe", "mn_jck_omr_protectthoseturretstowers"];
    var_0 = scripts\engine\utility::array_randomize(var_0);

    for(var_1 = 0; var_1 < var_0.size; var_1++) {
      wait(randomintrange(4, 10));
      var_2 = scripts\sp\maps\moonjackal\moonjackal_util::_id_EF4B(var_0[var_1]);

      if(var_2)
        var_0 = scripts\engine\utility::array_remove(var_0, var_0[var_1]);

      if(var_0.size == 0)
        return;
    }
  }
}

_id_5892() {
  scripts\sp\utility::_id_CF8B();
  setglobalsoundcontext("atmosphere", "space", 2);
  scripts\sp\utility::_id_266A("dogfight_lockon_start");
  scripts\sp\utility::_id_1034D("mn_jck_plr_keepitupscarswere");
  scripts\sp\utility::_id_10350("mn_jck_slt_theyhavereinforcementsstaystarp");
  _id_5890();
  scripts\sp\utility::_id_CF8D();
  scripts\sp\utility::_id_6EEB();
  _id_587E();
  scripts\sp\utility::_id_CF8B();
  scripts\sp\utility::_id_1034D("mn_jck_plr_theyhavehomingmissilestigris");
  wait 0.5;
  thread scripts\sp\utility::_id_10350("mn_jck_tnav_wehaveamissilesupply");
  thread _id_B834();
  _id_0BDC::_id_A162();
  _id_0BDC::_id_A154();
  wait 1;
  _id_10FD7();
  _id_5899();

  if(_id_1362F() == 1) {
    scripts\engine\utility::delaythread(8, _id_0BDC::_id_A154, 0);
    scripts\sp\utility::_id_10350("mn_jck_tnav_dropzonemarkedsupplydrone");
    level._id_D127 waittill("missiles_restocked");
    thread _id_0BD6::_id_B7F3();
    level._id_B833 = undefined;
    wait 1.5;
    scripts\sp\utility::_id_1034D("mn_jck_plr_lockedandloadedscarshit");
  }

  setmusicstate("mx_204_moonjackal_combatmood_a_temp");
  scripts\sp\utility::_id_266A("dogfight_lockon_midpoint");
  scripts\sp\utility::_id_CF8D();
  _id_588C(1);
  _id_58A3();
  scripts\sp\utility::_id_CF8B();
  scripts\sp\utility::_id_10350("mn_jck_fer_reyeswhatsthesitrepdown");
  scripts\sp\utility::_id_1034D("mn_jck_plr_werealmostdonedownhere");
  scripts\sp\utility::_id_266A("dogfight_lockon_midpoint2");
  _id_588C(1);
  scripts\sp\utility::_id_1034D("mn_jck_plr_scarsjustafewmore");
  level._id_26EB thread _id_58A0();
  scripts\sp\utility::_id_CF8D();
}

_id_1362F() {
  thread _id_1362E();
  thread _id_135E4();
  scripts\engine\utility::flag_wait("did_supply_or_kills");

  if(scripts\engine\utility::is_true(level._id_54B2))
    return 0;

  return 0;
}

_id_1362E() {
  level endon("kill_wait_for_supply");
  level._id_D127 waittill("drone_dropzone_marked");
  scripts\engine\utility::flag_set("did_supply_or_kills");
  level._id_54B2 = 1;
  level notify("kill_wait_for_kills");
}

_id_135E4() {
  level endon("kill_wait_for_kills");
  _id_588C(10);
  scripts\engine\utility::flag_set("did_supply_or_kills");
  level._id_B833 = undefined;
  level._id_10260 = 1;
  level notify("kill_wait_for_supply");
}

_id_587E() {
  thread _id_587F(30);
  level endon("enemy_missilevolley_timeout");
  _id_0BDC::_id_A1AB("enemy_lockon");
  _id_0BDC::_id_A1AA("enemy_missileVolley_notPicky", _id_0BD1::_id_682D, _id_0BD1::_id_6829, _id_0BD1::_id_682C);
  scripts\sp\utility::_id_13792("enemy_missileVolley_notPicky", 0);
  _id_10FD7();
  level notify("enemy_missilevolley_triggered");
  scripts\sp\utility::_id_13793();
  _id_0BDC::_id_A1AB("enemy_missileVolley", 0);
  _id_0BDC::_id_A1AD("enemy_missileVolley_notPicky");
  wait 1;
}

_id_587F(var_0) {
  level endon("enemy_missilevolley_triggered");
  wait(var_0);
  level notify("enemy_missilevolley_timeout");
}

_id_B834() {
  level._id_D127 endon("drone_dropzone_marked");
  level endon("did_supply_or_kills");
  wait 6.0;
  scripts\sp\maps\moonjackal\moonjackal_util::_id_EF4B("mn_jck_tnav_supplydroneonstandbymark");
  wait 5.0;

  for(var_0 = 0; var_0 < 4; var_0++) {
    scripts\sp\maps\moonjackal\moonjackal_util::_id_EF4B("mn_jck_tnav_sirweneedyourcoordinates");
    wait(5 + var_0 * 5);
  }
}

_id_9AF1() {
  _id_0BDC::_id_A1AB("enemy_lockon", 0);
  scripts\sp\utility::_id_13792("enemy_lockon", 0);
  _id_10FD7();
  thread _id_5896();
  scripts\sp\utility::_id_13793();
  level notify("lockon_sequence_done");
}

_id_5896() {
  level endon("lockon_sequence_done");
  var_0 = ["mn_jck_plr_ivegotonelockedon", "mn_jck_plr_imtagged", "mn_jck_eth_werelocked"];
  var_1 = ["mn_jck_slt_useyourboostersreyes", "mn_jck_slt_fasterreyesoutrunhim", "mn_jck_eth_siruseyourafterburners", "mn_jck_slt_enemyonyoursix"];
  var_2 = ["mn_jck_eth_missilesinboundflares", "mn_jck_eth_werehituseyourcountermeasures", "mn_jck_eth_keephimoffyou", "mn_jck_plr_gotanotheronmytail"];
  var_3 = randomint(var_0.size - 1);

  if(var_3 < var_0.size - 1)
    scripts\sp\maps\moonjackal\moonjackal_util::_id_EF4B(var_0[var_3]);
  else
    scripts\sp\maps\moonjackal\moonjackal_util::_id_EF4B(var_0[var_3]);

  wait 1;

  for(;;) {
    if(level._id_D127._id_93D2.size > 0) {
      var_3 = randomint(var_2.size - 1);
      scripts\sp\maps\moonjackal\moonjackal_util::_id_EF4B(var_2[var_3]);
    } else {
      var_3 = randomint(var_1.size - 1);
      scripts\sp\maps\moonjackal\moonjackal_util::_id_EF4B(var_1[var_3]);
    }

    wait(randomfloatrange(2, 4));
  }
}

_id_5899() {
  level._id_B833 = 1;
  _id_0BD6::_id_621A();
}

_id_58A3() {
  scripts\engine\utility::flag_set("flag_stop_spawning_jackals");
}

_id_58A0() {
  while(self._id_FE2D.size > 0) {
    self._id_FE2D = scripts\engine\utility::array_removeundefined(self._id_FE2D);

    foreach(var_1 in self._id_FE2D) {
      if(!isDefined(var_1)) {
        continue;
      }
      var_2 = vectordot(anglesToForward(level.player getplayerangles()), vectorNormalize(var_1.origin - _id_0BDC::_id_7BBA()));

      if(var_2 < 0.3) {
        var_1 notify("death");
        wait(randomfloatrange(2.0, 4.0));
        break;
      }

      wait 0.05;
    }
  }
}

_id_F941() {
  thread _id_A12E();
  _id_F8B3();
  level._id_26EB = spawnStruct();
  level._id_1D0A = spawnStruct();
  level._id_26EB thread _id_B2E3("axis_arena_jackals", 17, 8);
  level._id_1D0A thread _id_B2E3("ally_arena_jackals", 2, 1, 1);
}

_id_A12E() {
  level._id_A0C0 = 0;
  level._id_A06E = 0;
}

_id_ACF7() {
  self endon("death");

  for(;;)
    wait 0.05;
}

_id_3962() {
  level._id_3666 = _id_FD5A("ca_carrier", "cac1");
  level._id_3667 = _id_FD5A("ca_destroyer_01", "ca1");
  level._id_3668 = _id_FD5A("ca_destroyer_02", "ca2");
  level._id_3669 = _id_FD5A("ca_destroyer_03", "ca3");
  level._id_118A8 = _id_FD5A("un_tigris", "tigris");
  level._id_39F8 = [level._id_3666, level._id_3667, level._id_3668, level._id_3669];
  level._id_118A8 scripts\sp\maps\moonjackal\moonjackal_util::capitalship_dontcastshadows_moonjackal();
  level._id_3666 scripts\sp\maps\moonjackal\moonjackal_util::capitalship_dontcastshadows_moonjackal();
  level._id_3667 scripts\sp\maps\moonjackal\moonjackal_util::capitalship_dontcastshadows_moonjackal();
  level._id_3668 scripts\sp\maps\moonjackal\moonjackal_util::capitalship_dontcastshadows_moonjackal();
  level._id_3669 scripts\sp\maps\moonjackal\moonjackal_util::capitalship_dontcastshadows_moonjackal();
  level._id_118A8 _id_0BB6::_id_3966(1, 1, level._id_3666, level._id_3667, level._id_3668, level._id_3669);
  level._id_3666 _id_0BB6::_id_3966(1, 0, level._id_118A8);
  level._id_3667 _id_0BB6::_id_3966(1, 0, level._id_118A8);
  level._id_3668 _id_0BB6::_id_3966(1, 1, level._id_118A8);
  level._id_3669 _id_0BB6::_id_3966(1, 1, level._id_118A8);

  foreach(var_1 in level._id_864B["misc_turret_ground_med_cannon_un"].turrets) {
    if(!isDefined(var_1)) {
      continue;
    }
    var_1 _id_0F29::_id_8646(level._id_3666, 1);
    var_1 _id_0F29::_id_8646(level._id_3667, 1);
    var_1 _id_0F29::_id_8646(level._id_3668, 1);
    var_1 _id_0F29::_id_8646(level._id_3669, 1);
    var_1._id_1152C = "random";
    var_1._id_C013 = 1;
    wait(randomfloatrange(0.3, 3));
  }
}

_id_FD5A(var_0, var_1) {
  var_2 = scripts\sp\vehicle::_id_1080D(var_0);
  var_2.delete_on_death = 1;
  var_2 scripts\sp\vehicle::_id_8441();
  var_2 thread scripts\sp\maps\moonjackal\moonjackal_util::_id_13248();
  var_2 _id_0BB8::_id_39CD("idle");
  var_2 _id_0BB8::_id_39D0("off");
  var_2 castdistantshadows();
  var_2 _id_0BB6::_id_398A(1);
  var_2._id_12FBA = 1;
  return var_2;
}

_id_BB30() {
  thread _id_10CD0();

  for(;;) {
    _id_0BD6::_id_B35F();
    wait 10;
  }
}

_id_10CD0() {
  var_0 = getEnt("player_jackal", "targetname");
  _id_0BDC::_id_10CD1(var_0, undefined, "strike_mode");
  var_0 _id_0BDC::_id_A0BE();
  wait 2;
  var_0 _id_0BDC::_id_A0BE(0);
}

_id_A23E() {
  self endon("entitydeleted");

  for(;;) {
    wait 10;
    self notify("spline_junction");
  }
}

_id_B2E3(var_0, var_1, var_2, var_3) {
  self endon("stop_spawning_jackals");
  self._id_FE2D = [];
  var_4 = getEntArray(var_0, "targetname");
  var_5 = 0;

  foreach(var_7 in var_4) {
    wait 0.05;

    if(var_5 >= var_1) {
      break;
    }

    var_7 scripts\sp\utility::_id_1747(::_id_ABEF, self);

    if(isDefined(var_2) && var_2 > 0) {
      self._id_5948 = 1;
      var_2 = var_2 - 1;
    }

    var_7 scripts\sp\utility::_id_1747(::_id_C988);
    var_7 scripts\sp\utility::_id_1747(::_id_A13E);

    if(level._id_A056._id_1630.size >= 26) {
      continue;
    }
    var_8 = var_7 scripts\sp\utility::_id_10808();
    var_5++;
  }

  wait 4;

  for(;;) {
    self._id_FE2D = scripts\engine\utility::array_removeundefined(self._id_FE2D);

    if(self._id_FE2D.size < var_1 && level._id_A056._id_1630.size < 26 && !scripts\engine\utility::flag("flag_stop_spawning_jackals")) {
      foreach(var_7 in var_4) {
        var_11 = vectordot(anglesToForward(level.player getplayerangles()), vectorNormalize(var_7.origin - _id_0BDC::_id_7BBA()));

        if(var_11 < 0.3) {
          var_8 = var_7 scripts\sp\utility::_id_10808();
          wait 4;
          break;
        }

        wait 0.05;
      }
    }

    wait 0.2;
  }
}

_id_A13E() {}

_id_C988() {
  _id_C98A();
  wait 0.1;

  if(!isDefined(self._id_A420)) {
    return;
  }
  foreach(var_1 in self._id_A420)
  var_1 _id_C98A();
}

_id_C98A() {
  if(isDefined(self._id_5948)) {
    _id_0BDC::_id_19B1(1);
    _id_0BDC::_id_1990(0);
  } else {
    var_0 = "patrol_" + self.team;
    var_1 = "evade_" + self.team;
    _id_0BDC::_id_19B3("patrol", var_0);
    _id_0BDC::_id_19B3("escape", var_1);
    _id_0BDC::_id_1990(1);
  }

  _id_0BDC::_id_19AE("shoot_at_will");

  if(self.team == "allies") {
    return;
  }
  thread _id_1780(self);
  return;
}

_id_12A07() {
  self endon("death");

  for(;;) {
    var_0 = self gettagorigin("j_mainroot_ship");
    var_1 = self gettagorigin("tag_flash");
    var_2 = self gettagorigin("tag_flash_2");
    var_3 = self gettagangles("tag_flash");
    var_4 = self gettagangles("tag_flash_2");

    if(isDefined(self.enemy)) {
      var_5 = vectorNormalize(self.enemy.origin - var_0);
      var_5 = var_5 * 2000;
    }

    wait 0.05;
  }
}

_id_ABEF(var_0) {
  self._id_A532 = 1;
  var_0._id_FE2D = scripts\engine\utility::array_add(var_0._id_FE2D, self);
  wait 0.1;

  if(isDefined(self._id_A420)) {
    var_0._id_FE2D = scripts\engine\utility::array_combine(var_0._id_FE2D, self._id_A420);
    wait 2.0;
    var_1 = getEntArray(self._id_EEC4, "targetname");

    foreach(var_3 in var_1)
    var_3 delete();

    self._id_EEC4 = undefined;
  }

  wait 1;
  self._id_A532 = 0;
}

_id_1780(var_0) {
  foreach(var_2 in level._id_864B["misc_turret_ground_small_cannon_un"].turrets) {
    var_2 _id_0F29::_id_8646(var_0, 1);
    wait(randomfloatrange(0.0, 0.15));
  }

  foreach(var_2 in level._id_864B["misc_turret_ground_small_missile_un"].turrets) {
    var_2 _id_0F29::_id_8646(var_0, 1);
    wait(randomfloatrange(0.0, 0.15));
  }
}

_id_B2DE(var_0) {
  self._id_FE2D = [];
  var_1 = getEntArray(var_0, "targetname");
  var_2 = 0;

  foreach(var_4 in var_1) {
    var_5 = var_4 scripts\sp\utility::_id_10808();
    self._id_FE2D = scripts\engine\utility::array_add(self._id_FE2D, var_5);
  }
}

_id_BB2A() {
  thread _id_10CD0();
  thread _id_10794("ally_arena_jackals", 15);
}

_id_BB2B() {
  thread _id_10CD0();
  thread _id_10794("axis_arena_jackals", 11);
}

_id_10794(var_0, var_1) {
  var_2 = [];
  var_3 = getEntArray(var_0, "targetname");

  while(var_2.size < var_1) {
    foreach(var_5 in var_3) {
      var_5 scripts\sp\utility::_id_1747(_id_0BDC::_id_1990, 1);
      var_6 = var_5 scripts\sp\utility::_id_10808();
      var_2 = scripts\engine\utility::array_add(var_2, var_6);

      if(var_2.size >= var_1) {
        break;
      }
    }

    wait 1;
  }
}

_id_D914() {
  for(;;) {
    wait 0.5;
    iprintln("axis\t= " + level._id_26EB._id_FE2D.size);
    iprintln("allies = " + level._id_1D0A._id_FE2D.size);
  }
}

_id_58AB() {
  level endon("stop_lockon_tutorial");
  var_0 = 0;
  var_1 = 3.0;
  var_2 = 0;
  var_3 = 1;
  var_4 = -9999999;
  var_5 = 0;

  for(;;) {
    var_6 = level.player _meth_848A();
    var_7 = gettime();

    if(isDefined(var_6) && isDefined(var_6[0]) && var_6[1] == 0 && var_7 - var_4 > 2000) {
      scripts\engine\utility::flag_set("jackal_ads_hint");
      scripts\sp\utility::_id_56BA("jackal_ads");
    } else if(scripts\engine\utility::flag("jackal_ads_hint")) {
      var_4 = var_7;
      scripts\engine\utility::flag_clear("jackal_ads_hint");
    }

    if(isDefined(var_6) && isDefined(var_6[0]) && var_6[1] > 0.5) {
      break;
    }

    if(isDefined(var_6) && var_6[1] == 1 && !var_5)
      var_5 = 1;

    wait 0.05;
  }

  scripts\engine\utility::flag_clear("jackal_ads_hint");
}

_id_10FD7() {
  level notify("stop_lockon_tutorial");
  scripts\engine\utility::flag_clear("jackal_ads_hint");
}

_id_58AC() {
  self notify("no_longer_locked");
  self endon("no_longer_locked");
  thread _id_58AD();
  self waittill("death", var_0);

  if(isDefined(var_0) && var_0 == level._id_D127)
    scripts\engine\utility::flag_set("flag_death_while_locked");
}

_id_58AD() {
  self endon("no_longer_locked");
  self endon("death");

  for(;;) {
    var_0 = level.player _meth_848A();

    if(!isDefined(var_0)) {
      break;
    }

    if(var_0[0] != self) {
      break;
    }

    if(var_0[1] < 1) {
      break;
    }

    wait 0.05;
  }

  self notify("no_longer_locked");
}

_id_58AA() {
  var_0 = 2.0;
  var_1 = 0.0;
  scripts\engine\utility::flag_init("jackal_assault_hint");
  scripts\engine\utility::flag_set("jackal_assault_hint");
  scripts\sp\utility::_id_56BA("jackal_assault");

  while(level._id_D127.spaceship_mode != "hover")
    wait 0.05;

  scripts\engine\utility::flag_clear("jackal_assault_hint");
  wait 0.3;
  scripts\engine\utility::flag_init("jackal_strike_hint");
  scripts\engine\utility::flag_set("jackal_strike_hint");
  scripts\sp\utility::_id_56BA("jackal_strike");

  while(level._id_D127.spaceship_mode != "fly")
    wait 0.05;

  scripts\engine\utility::flag_clear("jackal_strike_hint");
}

_id_58B1() {
  scripts\engine\utility::flag_set("jackal_weapon_switch_hint");
  scripts\sp\utility::_id_56BA("jackal_weapon_switch");

  for(;;) {
    if(level.player buttonPressed("BUTTON_Y")) {
      break;
    }

    wait 0.05;
  }

  scripts\engine\utility::flag_clear("jackal_weapon_switch_hint");
  wait 0.3;
}

_id_588C(var_0) {
  var_1 = level._id_A056._id_63A3;

  while(level._id_A056._id_63A3 - var_1 < var_0)
    wait 0.5;
}

_id_5877(var_0) {
  while(level._id_26EB._id_FE2D.size > var_0) {
    level._id_26EB._id_FE2D = scripts\engine\utility::array_removeundefined(level._id_26EB._id_FE2D);
    wait 0.05;
  }
}

_id_58A2(var_0, var_1) {
  level notify("notify_new_battle_spot");
  level endon("notify_new_battle_spot");
  scripts\engine\utility::flag_clear("jackal_return_to_battle_hint");
  var_2 = scripts\engine\utility::getStruct(var_0, "script_noteworthy");

  for(;;) {
    if(_id_58A5(var_2, var_1))
      _id_589F(var_2, var_1);

    wait 1;
  }
}

_id_58A5(var_0, var_1) {
  var_2 = distance(level._id_D127.origin, var_0.origin);

  if(var_2 > var_1)
    return 1;
  else
    return 0;
}

_id_589F(var_0, var_1) {
  scripts\engine\utility::flag_set("jackal_return_to_battle_hint");
  objective_add(scripts\sp\utility::_id_C264("OBJ_RETURN"), "active", &"JACKAL_RETURN_TO_BATTLE", var_0.origin);
  objective_state(scripts\sp\utility::_id_C264("OBJ_RETURN"), "current");

  for(;;) {
    if(!_id_58A5(var_0, var_1)) {
      break;
    }

    wait 0.5;
  }

  objective_state(scripts\sp\utility::_id_C264("OBJ_RETURN"), "done");
  scripts\engine\utility::flag_clear("jackal_return_to_battle_hint");
}

_id_5852() {
  var_0 = 0.95;
  thread _id_0BDC::_id_116A8("You do a ship Assault mission in orbit above the moon, ", var_0);
  thread _id_0BDC::_id_116A8("and return to the Retribution.", var_0, 40);
  setslowmotion(1, 0.1, 0.5);
  wait(var_0);
  setslowmotion(0.1, 1, 1.0);
  thread scripts\sp\hud_util::_id_6AA3(0.2, "black");
  thread _id_4072();
  thread _id_737D();
  wait 2;
  thread _id_404D();
  wait 3;
  thread scripts\sp\hud_util::_id_6A99(0.2, "black");
  scripts\sp\utility::_id_BF95();
}

_id_737D() {
  level.player freezecontrols(1);
  _id_0BDC::_id_A226();
  setomnvar("ui_hide_hud", 1);
  _id_0BDC::_id_A19D(1);
  _id_0BDC::_id_D16C(level._id_D127.origin, 1, 0, 0, 1);
  level.player _id_0BDC::_id_A287(1);
}

_id_4072() {
  level._id_26EB notify("stop_spawning_jackals");

  foreach(var_1 in level._id_26EB._id_FE2D)
  var_1 notify("death");
}

_id_404D() {
  level._id_1D0A notify("stop_spawning_jackals");

  foreach(var_1 in level._id_1D0A._id_FE2D)
  var_1 delete();
}

_id_D8F9() {
  for(;;) {
    iprintln(level._id_A056._id_63A3);
    wait 0.05;
  }
}

_id_B873() {
  level._id_10C6E = _id_7CA4();
  scripts\sp\maps\moonjackal\moonjackal_util::sunsettings_dogfight();
  scripts\sp\utility::_id_241F();
  _id_E04E();
  _id_589B("player_jackal");
  scripts\sp\utility::_id_28D8();
  scripts\sp\utility::_id_6EEB();
}

_id_B860() {
  var_0 = [];
  setglobalsoundcontext("atmosphere", "space", 2);
  _id_58A3();

  if(isDefined(level._id_26EB)) {
    level._id_26EB notify("stop_spawning_jackals");

    foreach(var_2 in level._id_26EB._id_FE2D) {
      if(isDefined(var_2) && level._id_26EB._id_FE2D.size > 3) {
        var_2 _meth_81D0();
        continue;
      }

      var_0 = scripts\engine\utility::array_add(var_0, var_2);
    }
  }

  scripts\sp\utility::_id_266A("missleboat_start");
  scripts\sp\utility::_id_1034D("mn_jck_plr_almostthere");
  wait 2;
  thread _id_408F();
  var_4 = getscriptablearray("destruction_scriptable", "targetname");
  var_5 = getEntArray("moon_turret_tower", "targetname");
  level._id_6DDF = ["missileboat_start_tower_volume_a", "missileboat_start_tower_volume_b"];
  var_6 = [];

  if(isDefined(level._id_DE1C))
    var_6[var_6.size] = level._id_DE1C;

  if(isDefined(level._id_DE1F))
    var_6[var_6.size] = level._id_DE1F;

  level._id_B87E = [];
  thread _id_B852(var_6, var_5);
  thread _id_B859("axis_arena_missile_boat_01", var_5, var_4);
  wait 1.5;
  _id_B859("axis_arena_missile_boat_02", var_5, var_4);
  scripts\engine\utility::flag_set("missileboats_arrived");
  _id_0BDC::_id_A321(0);

  while(!isDefined(level._id_D127._id_1152E) && level._id_B87E.size > 0)
    wait 0.05;

  wait 1.0;

  if(level._id_B87E.size > 0) {
    level._id_EAD6 thread _id_B86D();
    level._id_DE1C thread _id_B866();

    if(isDefined(level._id_DE1F) && isalive(level._id_DE1F))
      level._id_DE1F thread _id_B867(var_0);

    scripts\sp\utility::_id_CF8D();
    level waittill("all_missileboats_destroyed");
    level._id_EAD6 _id_0BDC::_id_1988();
    level._id_EAD6 thread _id_0BDC::_id_1990(1);

    if(isDefined(level._id_DE1C._blackboard._id_EF72))
      level._id_DE1C _id_0BDC::_id_1988();

    level._id_DE1C thread _id_0BDC::_id_1990(1);
  }

  scripts\engine\utility::flag_set("missileboat_done");
  level notify("stop_arena_scriptable_exploder");
  level waittill("celebration vo done");
}

_id_B859(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::getStructArray("missileboat_ftl_point", "targetname");
  var_4 = scripts\engine\utility::array_randomize(var_3);
  var_5 = 0;
  var_6 = undefined;
  var_7 = 225000000;
  var_8 = 625000000;
  var_9 = level._id_D127.spaceship_vel;
  var_10 = undefined;
  var_11 = 0;

  while(!isDefined(var_6)) {
    while(!isDefined(var_6)) {
      var_9 = level._id_D127.spaceship_vel;
      var_12 = length(var_9) / 100;
      var_3 = scripts\engine\utility::array_sort_with_func(var_3, ::_id_9B45);

      foreach(var_4 in var_3) {
        var_14 = distancesquared(level._id_D127.origin, var_4.origin);
        var_15 = vectorNormalize(var_4.origin - level._id_D127.origin);
        var_10 = var_15 * 10000 + level._id_D127.origin;

        if(_id_0B76::_id_7A60(var_10) > 0.9 && (var_14 > var_7 * var_12 && var_14 < var_8 * var_12)) {
          if(!isDefined(var_4.used)) {
            var_4.used = var_0;
            var_6 = var_4;
            break;
          }
        }
      }

      wait 0.05;
    }

    wait 0.5;
    var_11 = scripts\common\trace::ray_trace_passed(level._id_D127.origin, var_4.origin, level._id_D127);

    if(_id_0B76::_id_7A60(var_10) <= 0.9 || isDefined(var_4.used) && var_4.used != var_0 || !var_11) {
      var_6 = undefined;
      var_4.used = undefined;
    }
  }

  var_17 = scripts\engine\utility::spawn_tag_origin(var_6.origin, var_6.angles);
  var_18 = getEnt(var_0, "targetname");
  var_18.origin = var_6.origin;
  var_18.angles = var_6.angles;
  var_19 = scripts\sp\vehicle::_id_1080C(var_0);
  var_19 endon("death");
  var_19 endon("missileboat_destroyed");
  var_19 thread _id_B84B();
  var_19 _meth_8554(200, 10, 1, 1500, 20, 5, 0.5);

  if(soundexists("capitalship_npc_enemy_ftl_in"))
    var_19 playSound("capitalship_npc_enemy_ftl_in");

  var_19 hide();
  var_19._id_74A6 = 1;
  level._id_B87E = scripts\engine\utility::array_add(level._id_B87E, var_19);

  if(level._id_B87E.size < 2)
    var_5 = 1;

  _id_0BDC::_id_A35D(level._id_B87E);
  wait 0.05;
  var_19 _id_0BB8::_id_39D0("off");
  var_19 _id_0BB8::_id_39CD("off");
  var_19 _id_0BB8::_id_39CE("off");
  var_19 _id_0BB8::_id_397D();
  var_19 _id_0BB8::_id_39C6();
  var_19 _id_0BB6::_id_39EE(1);

  while(!isDefined(var_19._id_65CD))
    scripts\engine\utility::waitframe();

  var_20 = var_19 _id_B85B(1);

  foreach(var_22 in var_20)
  var_22 hide();

  var_19 thread _id_0BB1::_id_7476();
  var_19 setneargoalnotifydist(2000);
  var_19 _meth_845F(600, 5000, 20, 10);

  if(var_5)
    var_24 = 13000;
  else
    var_24 = 9000;

  var_25 = anglesToForward(var_18.angles);
  var_25 = vectorNormalize(var_25);
  var_26 = var_25 * var_24 + var_18.origin;
  var_19 _meth_8455(var_26);
  wait 0.1;
  var_19 _meth_845F(175, 150, 30, 20);
  wait 0.15;
  var_19 show();
  var_19._id_74A6 = undefined;
  var_19 _id_0BB6::_id_39EE(0);
  var_19 _id_0BB8::_id_39D0("off");
  var_19 _id_0BB8::_id_39CD("launch");
  var_19 scripts\engine\utility::delaythread(0.9, _id_0BB8::_id_39CD, "idle");
  var_19 _id_0BB8::_id_39CE("off");
  var_19 _id_0BB8::_id_397E();
  var_19 _id_0BB8::_id_39C8();
  var_19 thread scripts\engine\utility::play_loop_sound_on_entity("ajak_engine_lfe");
  var_20 = var_19 _id_B85B(1);

  foreach(var_22 in var_20)
  var_22 show();

  var_19 waittill("near_goal");
  var_19 _meth_845F(100, 175, 30, 20);
  var_25 = anglesToForward((0, var_19.angles[1], 0));
  var_25 = vectorNormalize(var_25);
  var_26 = var_25 * 6000 + var_19.origin;
  var_19 _meth_8455(var_26, 1);
  var_19 notify("ftl_complete");
  var_17 delete();

  while((length(var_19.spaceship_vel) > 100 || level._id_B87E.size < 2) && (!scripts\engine\utility::flag("missileboat_killed") || length(var_19.spaceship_vel) > 100))
    wait 0.1;

  var_29 = undefined;
  var_30 = undefined;

  foreach(var_32 in level._id_B87E) {
    if(var_32 == var_19) {
      var_29 = var_32;
      continue;
    }

    var_30 = var_32;
  }

  if(level._id_6DDF.size > 1) {
    var_34 = undefined;
    var_35 = undefined;
    var_36 = undefined;
    var_37 = undefined;
    var_38 = getEnt(level._id_6DDF[0] + "1", "script_noteworthy");
    var_39 = distancesquared(var_29.origin, var_38.origin);

    if(isDefined(var_30)) {
      var_40 = distancesquared(var_30.origin, var_38.origin);

      if(var_39 > var_40)
        var_35 = var_29;
      else
        var_35 = var_30;

      var_38 = getEnt(level._id_6DDF[1] + "1", "script_noteworthy");
      var_41 = distancesquared(var_29.origin, var_38.origin);
      var_42 = distancesquared(var_30.origin, var_38.origin);

      if(var_41 > var_42)
        var_36 = var_29;
      else
        var_36 = var_30;

      if(var_35 == var_36 && var_35 == var_29) {
        if(var_39 < var_41)
          var_37 = 1;
        else
          var_37 = 0;
      } else if(var_35 == var_29)
        var_37 = 1;
      else if(var_36 == var_29)
        var_37 = 0;
      else if(var_40 < var_42)
        var_37 = 0;
      else
        var_37 = 1;
    } else {
      var_38 = getEnt(level._id_6DDF[1] + "1", "script_noteworthy");
      var_41 = distancesquared(var_29.origin, var_38.origin);

      if(var_39 < var_41)
        var_37 = 1;
      else
        var_37 = 0;
    }

    var_43 = level._id_6DDF[var_37];
    level._id_6DDF = scripts\engine\utility::array_remove(level._id_6DDF, level._id_6DDF[var_37]);
  } else
    var_43 = level._id_6DDF[0];

  var_19 thread _id_B863(var_1, var_43, var_2);
}

_id_9B45(var_0, var_1) {
  var_2 = scripts\sp\utility::_id_7951(level._id_D127.origin, level._id_D127.angles, var_0.origin);
  var_3 = scripts\sp\utility::_id_7951(level._id_D127.origin, level._id_D127.angles, var_1.origin);

  if(var_2 >= var_3)
    return 1;
  else
    return 0;
}

_id_B852(var_0, var_1) {
  level._id_D127 endon("death");

  while(level._id_B87E.size < 1)
    wait 0.05;

  wait 1.0;
  scripts\sp\utility::_id_10350("mn_jck_un2_shitgunships");
  wait 0.5;
  scripts\sp\utility::_id_1034D("mn_jck_plr_scarstheysentajaksdown");
  wait 1;
  scripts\sp\utility::_id_10350("mn_jck_slt_copytheyaregoingfor");
  level waittill("tower_hit");
  scripts\sp\utility::_id_10350("mn_jck_brk_towerfiveishit");
  wait 1;
  scripts\sp\utility::_id_1034D("mn_jck_plr_allteamsengagethosegunships");
  thread _id_B861();
  thread _id_B85D();
}

_id_B861() {
  level endon("all_missileboats_destroyed");

  while(!isDefined(level._id_D127._id_1152E))
    wait 0.05;

  level._id_D127._id_1152E endon("all_turrets_dead");
  var_0 = ["mn_jck_eth_theyrelaunchingwarheads", "mn_jck_eth_flaresflares", "mn_jck_slt_missilesinboundmissilesinbound", "mn_jck_un2_countermeasures", "mn_jck_slt_missilesintheair", "mn_jck_un2_flaresout", "mn_jck_slt_missilesincoming", "mn_jck_un2_flaresawayflaresaway", "mn_jck_slt_wegotmissilesinbound", "mn_jck_un2_countermeasuresdeployed"];

  for(;;) {
    if(level._id_D127._id_93D2.size > 0) {
      var_1 = randomint(var_0.size - 1);
      var_2 = scripts\sp\maps\moonjackal\moonjackal_util::_id_EF4B(var_0[var_1]);

      if(var_2)
        var_0 = scripts\engine\utility::array_remove(var_0, var_0[var_1]);

      if(var_0.size == 0)
        return;
    }

    wait(randomintrange(5, 10));
  }
}

_id_B85D() {
  level endon("all_missileboats_destroyed");
  self endon("ftl_now");
  self endon("all_turrets_dead");

  while(!isDefined(level._id_D127._id_1152E))
    wait 0.5;

  scripts\sp\utility::_id_1034D("mn_jck_plr_targettheirweaponsystems");
  var_0 = ["mn_jck_eth_focusfireontheirturrets", "mn_jck_omr_weneedmorefirepoweron", "mn_jck_slt_carefuloftheflakcannons", "mn_jck_omr_watchthatflakkeepmoving", "mn_jck_brk_scarthreetwostayactive", "mn_jck_slt_turretsareonyoustay"];
  var_0 = scripts\engine\utility::array_randomize(var_0);
  var_1 = 0;

  while(var_1 < var_0.size) {
    if(level._id_D127._id_93D2.size < 1) {
      scripts\sp\utility::_id_10350(var_0[var_1]);
      var_1++;
    }

    wait(randomintrange(5, 10) + var_1);
  }
}

_id_B85A() {
  self endon("death");
  level endon("all_missileboats_destroyed");
  self endon("ftl_now");
  var_0 = self;
  var_1 = "long";
  var_2 = [];
  var_3 = 0;
  var_4 = 0;

  for(;;) {
    while(!isDefined(level._id_D127._id_1152E))
      scripts\engine\utility::waitframe();

    if(level._id_D127._id_1152E == var_0) {
      var_5 = ["mn_jck_eth_goodhitsirturretdestroyed", "mn_jck_slt_makingprogresskeepi"];
      var_1 = "long";
    } else {
      var_5 = ["mn_jck_eth_targetdestroyed"];
      var_1 = "short";
    }

    if(level._id_D127._id_1152E == var_0) {
      var_6 = var_0._id_8B50["cap_hardpoint_missile_barrage"];
      var_7 = var_0._id_8B51["cap_hardpoint_missile_barrage"];
      var_2 = scripts\engine\utility::array_combine(var_6, var_7);

      if(var_3 == 0)
        var_3 = var_2.size;
      else if(var_2.size < 1) {
        break;
      } else if(var_2.size != var_3 && var_4 < var_5.size) {
        scripts\sp\utility::_id_10350(var_5[var_4], 1);
        var_3 = var_2.size;
        var_4++;
      }

      if(var_0._id_10D90 == 1) {
        break;
      }
    }

    wait 1;
  }

  if(var_1 != "short") {
    scripts\sp\utility::_id_10350("mn_jck_slt_enemyweaponsoffline", 1);
    scripts\sp\utility::_id_10350("mn_jck_eth_theirenginesareigniting", 1);
    scripts\sp\utility::_id_10350("mn_jck_eth_theyrepreparingtojump", 1);
    scripts\sp\utility::_id_10350("mn_jck_slt_dontletthemgetaway", 1);
    scripts\sp\utility::_id_10350("mn_jck_slt_hitemhitem", 1);
  }
}

_id_B854() {
  self endon("death");
  level endon("all_missileboats_destroyed");
  self endon("ftl_now");
  self endon("all_turrets_dead");
  var_0 = self;

  while(!isDefined(level._id_D127._id_1152E))
    scripts\engine\utility::waitframe();

  if(level._id_D127._id_1152E == var_0)
    var_1 = ["mn_jck_slt_oneenginedowntakeo", "mn_jck_slt_staywithhimreyes"];
  else
    var_1 = ["mn_jck_un2_wevealmostgothim", "mn_jck_slt_hittheirengineseveryth"];

  var_2 = var_0._id_65CE;

  for(;;) {
    while(!isDefined(level._id_D127._id_1152E))
      scripts\engine\utility::waitframe();

    if(level._id_D127._id_1152E == var_0) {
      if(var_0._id_65CE < 1) {
        break;
      }

      if(var_0._id_65CE < 2 && var_2 != var_0._id_65CE) {
        scripts\sp\maps\moonjackal\moonjackal_util::_id_EF4B(var_1[0]);
        var_2 = var_0._id_65CE;
        wait(randomintrange(4, 7));
      } else {
        scripts\sp\maps\moonjackal\moonjackal_util::_id_EF4B(var_1[1]);
        break;
      }
    }

    wait 1;
  }

  var_3 = undefined;

  foreach(var_5 in level._id_B87E) {
    if(var_5 != var_0)
      var_3 = var_5;
  }

  var_0 thread _id_6A0C(var_3);
}

_id_B849() {
  self endon("death");
  var_0 = self;
  var_1 = 0;
  var_2 = 0;
  var_3 = 0;
  var_4 = 1;

  if(!isDefined(level._id_D127._id_1152E))
    level._id_D127._id_1152E = var_0;

  for(;;) {
    while(isDefined(level._id_D127._id_1152E) && level._id_D127._id_1152E != var_0) {
      var_3 = distancesquared(level._id_D127.origin, var_0.origin);

      if(var_3 < 900000000 && !var_1) {
        var_1 = 1;
        var_4 = 1;
        break;
      } else if(var_3 > 900000000)
        var_1 = 0;

      if(isDefined(var_0._id_12B8B) && var_0._id_12B8B)
        var_2 = var_2 + 1.0;

      if(var_2 >= 2.0 && !var_1) {
        var_4 = 1;
        break;
      }

      if(!isDefined(level._id_D127._id_1152E)) {
        break;
      }

      wait 0.5;

      if(var_2 > 0)
        var_2 = var_2 - 0.1;
    }

    if(var_4)
      level._id_D127._id_1152E = var_0;

    var_2 = 0;
    var_4 = 0;
    wait 1.0;
  }
}

_id_B863(var_0, var_1, var_2) {
  self endon("missileboat_destroyed");
  var_3 = self;
  var_4 = undefined;
  var_5 = undefined;
  var_6 = 1;
  var_7 = 20;

  for(var_8 = 1; var_8 <= 6; var_8++) {
    var_4 = undefined;
    var_5 = undefined;
    var_9 = 0;
    var_5 = getEnt(var_1 + var_8, "script_noteworthy");

    foreach(var_11 in var_0) {
      if(!isDefined(var_11)) {
        var_0 = scripts\engine\utility::array_remove(var_0, var_11);
        continue;
      }

      if(var_11 istouching(var_5))
        var_4 = var_11;
    }

    var_3._id_3F26 = var_4;
    var_4 thread _id_B877(var_3);
    var_13 = [var_4];

    foreach(var_15 in var_2) {
      if(!isDefined(var_15)) {
        var_2 = scripts\engine\utility::array_remove(var_2, var_15);
        continue;
      }
    }

    var_3 thread _id_0BB1::_id_F486(var_5, var_13, undefined, var_2);

    while(!var_3._id_2409) {
      if(isDefined(var_4._id_52D0) && !var_4._id_52D0) {
        wait 0.05;
        continue;
      }

      break;
    }

    if(var_6) {
      var_3 thread _id_B849();
      scripts\engine\utility::flag_set("missileboat_phase_1");
      var_3 thread _id_B85A();
      var_3 thread _id_B854();
      var_6 = 0;
    }

    if(isDefined(var_4._id_52D0) && !var_4._id_52D0) {
      var_17 = scripts\engine\utility::get_array_of_closest(var_3.origin, var_2, undefined, var_7);
      scripts\engine\utility::array_thread(var_17, ::_id_B848, var_3);
      var_4 waittill("tower_destroyed");
    }

    var_3 notify("tower_destroyed");
    var_3 notify("targeting_player");
    var_3 thread _id_B87C();
    var_3 thread _id_B879();

    if(var_8 == 1) {
      while(!isDefined(level._id_D127._id_1152E))
        scripts\engine\utility::waitframe();

      if(level._id_D127._id_1152E == var_3 && isalive(level._id_DE1F)) {
        if(!isDefined(level._id_DE1F.marked_for_death))
          thread _id_B868(var_3);

        var_13 = [level._id_DE1F];
        var_13 = scripts\engine\utility::array_combine(var_13, var_2);
        level._id_DE1F.marked_for_death = 1;
      } else {
        var_13 = [level._id_D127];
        var_13 = scripts\engine\utility::array_combine(var_13, var_2);
      }
    }

    var_13 = [level._id_D127];
    var_3 thread _id_0BB1::_id_F486(var_5, var_13);
    var_3 waittill("missileboat_next_stage");
    var_4 = undefined;
    var_5 = undefined;
    scripts\sp\utility::_id_266A("missleboat_midpoint");
  }
}

_id_B868(var_0) {
  level._id_DE1F endon("death");
  scripts\sp\utility::_id_10350("mn_jck_un1_gotamissileonmy", 1);
  wait 2;
  scripts\sp\utility::_id_10350("mn_jck_un1_onethreebugoutbugout", 1);
  var_0 waittill("missileboat_next_stage");
  wait 2;

  if(isalive(level._id_DE1F))
    level._id_DE1F _meth_81D0();
}

_id_B848(var_0) {
  var_0 endon("missileboat_next_stage");
  var_0 endon("death");
  self waittill("death");
  wait 1.0;

  for(;;) {
    self waittill("damage");

    if(randomint(100) > 50)
      playFX(scripts\engine\utility::getfx("vfx_ground_explosion"), self.origin);
  }
}

_id_B84B() {
  var_0 = undefined;

  foreach(var_2 in level._id_B87E) {
    if(var_2 != self)
      var_0 = var_2;
  }

  _id_B84A();

  if(scripts\engine\utility::flag("missileboat_killed")) {
    level._id_B87E = [];
    level notify("all_missileboats_destroyed");
    level.player earthquakeforplayer(0.5, 2, level._id_D127.origin, 20000);
    scripts\sp\utility::_id_6EEA();
    scripts\sp\utility::_id_28D7();
    scripts\sp\utility::_id_CF8B();

    if(isDefined(self) && self._id_10D90) {
      wait 2.0;
      scripts\sp\utility::_id_1034D("mn_jck_plr_arghwelosthim");
      scripts\sp\utility::_id_10350("mn_jck_un1_hahadamn");
      wait 0.25;
    } else {
      wait 0.2;
      scripts\sp\utility::_id_10350("mn_jck_un2_hellyeah");
      scripts\sp\utility::_id_10350("mn_jck_slt_goodkillraider");
      wait 0.25;
    }

    scripts\sp\utility::_id_10350("mn_jck_omr_wedidit");
    level notify("celebration vo done");
  } else {
    scripts\engine\utility::flag_set("missileboat_killed");
    _id_0BDC::_id_A1AD("missile_drone");
    level._id_D127._id_1152E = undefined;
    level._id_B87E = scripts\engine\utility::array_remove(level._id_B87E, self);
    thread scripts\sp\utility::_id_10350("mn_jck_omr_niceonecaptain");

    while(!isDefined(level._id_D127._id_1152E))
      scripts\engine\utility::waitframe();

    if(isalive(level._id_DE1F))
      level._id_DE1F _meth_81D0();

    var_4 = 0;
    var_5 = 999999999;

    while(isalive(level._id_D127._id_1152E) && var_4 < 0.4 && var_5 > -1794967296) {
      wait 0.5;

      if(isDefined(level._id_D127._id_1152E) && isalive(level._id_D127._id_1152E)) {
        var_5 = distancesquared(level._id_D127.origin, level._id_D127._id_1152E.origin);
        var_4 = scripts\sp\utility::_id_7951(level._id_D127.origin, level._id_D127.angles, level._id_D127._id_1152E.origin);
      }
    }

    wait 1;

    while(!isDefined(level._id_D127._id_1152E))
      scripts\engine\utility::waitframe();

    level._id_D127._id_1152E thread _id_0B76::_id_39C3(7);
    scripts\sp\utility::_id_10350("mn_jck_eth_onegunshipremainingsir");

    if(isDefined(level._id_D127._id_1152E) && isalive(level._id_D127._id_1152E)) {
      var_6 = distancesquared(level._id_D127.origin, level._id_D127._id_1152E.origin);

      if(var_6 > 1600000000) {
        scripts\sp\utility::_id_10350("mn_jck_slt_reyesgiveusahand");
        scripts\sp\utility::_id_1034D("mn_jck_plr_rogerthat");
      }
    }
  }
}

_id_B84A() {
  self endon("missileboat_destroyed");
  self endon("death");
  level endon("all_missileboats_destroyed");
  var_0 = self;
  var_1 = 0;
  var_2 = undefined;
  var_3 = undefined;
  var_4 = 1;
  var_0 scripts\engine\utility::waittill_any("tower_destroyed", "engine_destroyed");

  if(isDefined(var_0._id_3F26)) {
    var_0._id_3F26 notify("tower_destroyed");
    var_0 notify("missileboat_next_stage");
  }

  while(!isDefined(level._id_D127._id_1152E))
    scripts\engine\utility::waitframe();

  if(level._id_D127._id_1152E == var_0) {
    var_5 = ["mn_jck_eth_captaintheenemyshipis", "mn_jck_eth_hesonthemoveagain"];
    var_6 = ["mn_jck_brk_tower3down", "mn_jck_slt_damnitweneedthatship"];
    scripts\sp\utility::_id_10350("mn_jck_brk_shitwelosttowerfive", 1);
  } else {
    var_5 = ["mn_jck_omr_hesonthemoveget", "mn_jck_slt_theyretargetinganothertower"];
    var_6 = ["mn_jck_brk_welosttowerone", "mn_jck_slt_gethimhesdestroyingthe"];
  }

  while(isDefined(var_0) && scripts\engine\utility::array_contains(level._id_B87E, var_0)) {
    if(level._id_B87E.size > 1 || var_4 == 0) {
      var_0 thread _id_B856(var_1);
      var_2 = var_0 scripts\engine\utility::waittill_any_return("engine_door_destroyed", "engine_destroyed", "missileboat_destroyed", "half_turrets_destroyed", "fight_timeout");

      if(isDefined(var_2) && var_2 == "missileboat_destroyed") {
        break;
      }
    }

    var_0 notify("missileboat_next_stage");

    if(var_5.size > 0) {
      thread scripts\sp\maps\moonjackal\moonjackal_util::_id_EF4B(var_5[0]);
      var_5 = scripts\engine\utility::array_remove(var_5, var_5[0]);
    }

    var_1++;
    var_0 scripts\engine\utility::waittill_any("tower_destroyed", "engine_destroyed", "half_turrets_destroyed");

    if(isDefined(var_0._id_3F26))
      var_0._id_3F26 notify("tower_destroyed");

    var_4 = 0;

    if(var_6.size > 0) {
      thread scripts\sp\maps\moonjackal\moonjackal_util::_id_EF4B(var_6[0]);
      var_6 = scripts\engine\utility::array_remove(var_6, var_6[0]);
    }
  }
}

_id_6A0C(var_0) {
  self endon("exposed_engine_vo");
  self endon("death");
  level endon("all_missileboats_destroyed");
  self waittill("engine_door_destroyed");

  if(isDefined(var_0))
    var_0 notify("exposed_engine_vo");

  scripts\sp\utility::_id_10350("mn_jck_slt_theirenginesexposed", 1);
  scripts\sp\utility::_id_10350("mn_jck_slt_getfireontheirengines", 1);
}

_id_B856(var_0) {
  self endon("missileboat_destroyed");
  var_1 = 2 + var_0;
  var_2 = 5 + var_0;
  wait(randomfloatrange(var_1, var_2));
  self notify("fight_timeout");
}

_id_B879() {
  self endon("missileboat_next_stage");

  while(isDefined(self)) {
    var_0 = self._id_8B50["cap_hardpoint_missile_barrage"];
    var_1 = self._id_8B51["cap_hardpoint_missile_barrage"];
    var_2 = scripts\engine\utility::array_combine(var_0, var_1);
    wait 1.0;

    if(var_2.size <= 12) {
      self notify("half_turrets_destroyed");
      break;
    }
  }
}

_id_B87C() {
  self endon("missileboat_next_stage");
  var_0 = distancesquared(level._id_D127.origin, self.origin);

  while(var_0 < 400000000)
    wait 0.5;

  self notify("player_left_battle");
}

_id_B877(var_0) {
  var_1 = self;
  var_1.health = 99999999;
  var_1._id_EDD7 = 2000;
  var_2 = 1;
  var_3 = 1995;
  var_1._id_52D0 = 0;
  var_1 setCanDamage(1);

  for(;;) {
    var_1 waittill("damage", var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
    var_1.health = var_1.health + var_4;

    if(isPlayer(var_5) || var_5 == level._id_D127) {
      continue;
    }
    playFX(scripts\engine\utility::getfx("vfx_tower_impact"), var_7);

    if(!isDefined(var_5) || !isDefined(var_5.class) || isDefined(var_5.class) && var_5.class != "cannon_missile_ca_hardpoint") {
      continue;
    }
    level notify("tower_hit");

    if(scripts\engine\utility::flag("missileboat_phase_1")) {
      var_14 = distance(level._id_D127.origin, var_5.origin);

      if(var_14 < 30000)
        var_1._id_EDD7 = var_1._id_EDD7 - 1;
      else if(var_2) {
        var_1 thread _id_11A68(5);
        var_2 = 0;
      }

      if(var_1._id_EDD7 < var_3) {
        scripts\engine\utility::flag_clear("missileboat_phase_1");
        scripts\engine\utility::flag_set("missileboat_phase_2");
        wait 1;

        foreach(var_16 in level._id_26EB._id_FE2D) {
          if(isDefined(var_16) && level._id_26EB._id_FE2D.size > 3) {
            level._id_26EB._id_FE2D = scripts\engine\utility::array_remove(level._id_26EB._id_FE2D, var_16);
            var_16 _meth_81D0();
          }
        }

        break;
      }
    } else if(scripts\engine\utility::flag("missileboat_phase_2")) {
      var_14 = distance(level._id_D127.origin, var_5.origin);

      if(var_14 > 30000)
        var_3 = 1985;
      else
        var_3 = 1995;

      var_1._id_EDD7 = var_1._id_EDD7 - 1;

      if(var_2) {
        var_1 thread _id_11A68(5);
        var_2 = 0;
      }

      if(var_1._id_EDD7 < var_3) {
        scripts\engine\utility::flag_clear("missileboat_phase_2");
        scripts\engine\utility::flag_set("missileboat_phase_3");
        break;
      }
    } else if(scripts\engine\utility::flag("missileboat_phase_3")) {
      var_14 = distance(level._id_D127.origin, var_5.origin);

      if(var_14 > 30000)
        var_3 = 1985;
      else
        var_3 = 1995;

      var_1._id_EDD7 = var_1._id_EDD7 - 1;

      if(var_2) {
        var_1 thread _id_11A68(5);
        var_2 = 0;
      }

      if(var_1._id_EDD7 < var_3) {
        break;
      }
    }
  }

  playFXOnTag(scripts\engine\utility::getfx("vfx_building_turret_tower_expl"), var_1, "tag_origin");
  var_18 = [];

  foreach(var_20 in level._id_10C6E) {
    var_21 = distance(var_20.origin, var_1.origin);

    if(var_21 < 7000) {
      var_20 _meth_81D0();
      level._id_10C6E = scripts\engine\utility::array_remove(level._id_10C6E, var_20);
      var_18 = scripts\engine\utility::array_add(var_18, var_20);
    }
  }

  var_1 setModel("building_turret_tower_01_dest");
  wait 0.5;
  var_1 notify("tower_destroyed");
  var_1._id_52D0 = 1;

  foreach(var_20 in var_18) {
    if(isDefined(var_20._id_10382))
      var_20._id_10382 delete();

    var_20 delete();
  }

  playFX(scripts\engine\utility::getfx("vfx_building_turret_tower_smolder"), var_1.origin + (0, 0, 3800));
}

_id_11A68(var_0, var_1) {
  self endon("death");
  var_2 = 0;

  if(!isDefined(var_1))
    var_1 = 0;

  while(var_2 < var_0) {
    scripts\sp\utility::_id_F40A("friendly", 1, 0);

    if(!var_1)
      self playSound("jackal_scan_ship");

    wait 0.25;
    self hudoutlinedisable();
    var_2++;
    wait 0.15;
  }
}

_id_B86D() {
  self endon("death");
  level endon("all_missileboats_destroyed");
  _id_0BDC::_id_19A9();
  _id_0BDC::_id_19AE("shoot_at_will");
  self.ignoreall = 1;
  var_0 = 1;

  for(var_1 = undefined; level._id_B87E.size > 0; var_0 = 0) {
    while(!isDefined(level._id_D127._id_1152E))
      scripts\engine\utility::waitframe();

    level._id_B87E = scripts\engine\utility::array_removeundefined(level._id_B87E);

    if(level._id_B87E.size > 1) {
      foreach(var_3 in level._id_B87E) {
        if(var_3 != level._id_D127._id_1152E) {
          var_1 = var_3;
          continue;
        }

        continue;
      }
    } else if(isDefined(level._id_D127._id_1152E))
      var_1 = level._id_D127._id_1152E;
    else
      break;

    self._id_1152E = var_1;
    thread _id_0BDC::_id_19B5(var_1);
    var_5 = vectorNormalize(var_1.origin - level._id_D127.origin);
    var_5 = var_5 * 5000 + var_1.origin + (0, 0, 1500);
    var_6 = distancesquared(self.origin, var_5);

    if(var_6 > 400000000)
      _id_0BDC::_id_19AB(700, 100);
    else
      _id_0BDC::_id_19AB(200, 50);

    self setneargoalnotifydist(1000);
    self _meth_8455(var_5);

    if(!scripts\engine\utility::flag("missileboat_killed"))
      self waittill("near_goal");

    while(!isDefined(level._id_D127._id_1152E))
      scripts\engine\utility::waitframe();

    level._id_B87E = scripts\engine\utility::array_removeundefined(level._id_B87E);

    if(level._id_B87E.size > 1) {
      foreach(var_3 in level._id_B87E) {
        if(var_3 != level._id_D127._id_1152E) {
          var_1 = var_3;
          continue;
        }

        continue;
      }
    } else if(isDefined(level._id_D127._id_1152E))
      var_1 = level._id_D127._id_1152E;
    else
      break;

    self._id_1152E = var_1;
    thread _id_0BDC::_id_19B5(var_1);
    var_9 = var_1 _id_B85B();
    var_10 = _id_0B76::_id_7A60(var_1.origin);

    if(var_9.size > 0 && var_10 > 0.8)
      _id_0B76::_id_1993(var_9, "tag_flash");

    if(!var_0) {
      var_11 = [];

      foreach(var_13 in var_1._id_65CD) {
        var_11 = scripts\engine\utility::array_add(var_11, var_13._id_2F00[0]);
        var_11 = scripts\engine\utility::array_add(var_11, var_13._id_101B0[0]);
        var_11 = scripts\engine\utility::array_add(var_11, var_13._id_119EA[0]);
      }

      var_11 = scripts\engine\utility::array_randomize(var_11);

      if(isDefined(var_11[0]) && var_1._id_8CCA > 51) {
        var_11[0]._id_EF52 = 0;
        var_11[0] _id_0B76::_id_54DE(15000, var_11[0].origin, self, self.weapon);
        var_11 = scripts\engine\utility::array_remove(var_11, var_11[0]);

        if(scripts\engine\utility::flag("missileboat_killed")) {
          foreach(var_16 in var_11) {
            if(isDefined(var_16) && var_1._id_8CCA > 51) {
              var_16._id_EF52 = 0;
              var_16 _id_0B76::_id_54DE(15000, var_16.origin, level._id_D127, level._id_D127._id_13BF7.weapon);
              var_11 = scripts\engine\utility::array_remove(var_11, var_16);
            }
          }
        }
      } else {
        _id_0BDC::_id_19B0("hover");
        _id_0BDC::_id_19B2("face enemy");
        var_11 = scripts\engine\utility::array_removeundefined(var_11);
      }
    }

    if(scripts\engine\utility::flag("missileboat_killed")) {
      wait 1.5;
      continue;
    }

    wait(randomfloatrange(2, 4));
  }
}

_id_B866() {
  self endon("death");
  level endon("all_missileboats_destroyed");
  _id_0BDC::_id_19A9();
  _id_0BDC::_id_19AE("shoot_at_will");
  self.ignoreall = 1;
  var_0 = 1;
  var_1 = undefined;

  while(!isDefined(level._id_D127._id_1152E))
    scripts\engine\utility::waitframe();

  level._id_B87E = scripts\engine\utility::array_removeundefined(level._id_B87E);

  if(level._id_B87E.size > 1) {
    foreach(var_3 in level._id_B87E) {
      if(var_3 != level._id_D127._id_1152E) {
        var_1 = var_3;
        continue;
      }

      continue;
    }
  } else if(isDefined(level._id_D127._id_1152E))
    var_1 = level._id_D127._id_1152E;

  while(level._id_B87E.size > 0) {
    while(!isDefined(level._id_D127._id_1152E))
      scripts\engine\utility::waitframe();

    level._id_B87E = scripts\engine\utility::array_removeundefined(level._id_B87E);

    if(level._id_B87E.size > 1) {
      foreach(var_3 in level._id_B87E) {
        if(var_3 != level._id_D127._id_1152E) {
          var_1 = var_3;
          continue;
        }

        continue;
      }
    } else if(isDefined(level._id_D127._id_1152E))
      var_1 = level._id_D127._id_1152E;
    else
      break;

    self._id_1152E = var_1;
    thread _id_0BDC::_id_19B5(var_1);
    var_7 = vectorNormalize(var_1.origin - level._id_D127.origin);
    var_7 = var_7 * 5000 + var_1.origin + (0, 0, 1500);
    var_8 = distancesquared(self.origin, var_7);

    if(var_8 > 400000000)
      _id_0BDC::_id_19AB(700, 100);
    else
      _id_0BDC::_id_19AB(200, 50);

    if(var_0)
      thread scripts\sp\utility::_id_10350("mn_jck_un2_twotwoinboundhot");

    self setneargoalnotifydist(1000);
    self _meth_8455(var_7);
    self waittill("near_goal");

    while(!isDefined(level._id_D127._id_1152E))
      scripts\engine\utility::waitframe();

    level._id_B87E = scripts\engine\utility::array_removeundefined(level._id_B87E);

    if(level._id_B87E.size > 1) {
      foreach(var_3 in level._id_B87E) {
        if(var_3 != level._id_D127._id_1152E) {
          var_1 = var_3;
          continue;
        }

        continue;
      }
    } else if(isDefined(level._id_D127._id_1152E))
      var_1 = level._id_D127._id_1152E;
    else
      break;

    self._id_1152E = var_1;
    thread _id_0BDC::_id_19B5(var_1);
    var_11 = var_1 _id_B85B();

    if(var_0) {
      _id_0BDC::_id_19B0("hover");
      _id_0BDC::_id_19B2("face enemy");
    }

    var_12 = _id_0B76::_id_7A60(var_1.origin);

    if(var_11.size > 0 && var_12 > 0.8)
      _id_0B76::_id_1993(var_11, "tag_flash");

    if(scripts\engine\utility::flag("missileboat_killed"))
      wait 1;
    else
      wait(randomfloatrange(3, 6));

    var_0 = 0;
  }
}

_id_B867(var_0) {
  level endon("all_missileboats_destroyed");
  self endon("death");
  thread _id_DE26();
  _id_0BDC::_id_19A9();
  _id_0BDC::_id_19AE("shoot_at_will");
  _id_0BDC::_id_19AF(0, 0, 0);
  self.ignoreall = 1;
  var_1 = 1;
  var_2 = level._id_D127._id_1152E;

  while(isDefined(self)) {
    while(!isDefined(level._id_D127._id_1152E))
      scripts\engine\utility::waitframe();

    if(var_2 != level._id_D127._id_1152E) {
      thread _id_0BDC::_id_19B5(level._id_D127._id_1152E);
      var_2 = level._id_D127._id_1152E;
    }

    var_3 = vectorNormalize(level._id_D127._id_1152E.origin - level._id_D127.origin);
    var_3 = var_3 * 5000 + level._id_D127._id_1152E.origin + (0, 0, 1500);
    var_4 = distancesquared(self.origin, var_3);

    if(var_4 > 400000000)
      _id_0BDC::_id_19AB(700, 100);
    else
      _id_0BDC::_id_19AB(200, 50);

    if(var_1)
      thread scripts\sp\utility::_id_10350("mn_jck_un1_rogonethreeinbound");

    self setneargoalnotifydist(3000);
    self _meth_8455(var_3);
    self waittill("near_goal");

    while(!isDefined(level._id_D127._id_1152E))
      scripts\engine\utility::waitframe();

    var_5 = level._id_D127._id_1152E _id_B85B();
    var_6 = _id_0B76::_id_7A60(level._id_D127._id_1152E.origin);

    if(var_5.size > 0 && var_6 > 0.8)
      _id_0B76::_id_1993(var_5, "tag_flash");

    if(var_1) {
      _id_0BDC::_id_19B0("hover");
      _id_0BDC::_id_19B2("face enemy");
      wait 0.25;
    } else
      wait(randomfloatrange(5, 10));

    var_1 = 0;

    if(!isDefined(self)) {
      break;
    }

    if(isDefined(self._id_51E6) && self._id_51E6)
      self._id_51E6 = 0;
  }
}

_id_DE26() {
  self waittill("death");
  scripts\sp\utility::_id_10350("mn_jck_un1_aaagghhhhh");
  wait 2;
  scripts\sp\maps\moonjackal\moonjackal_util::_id_EF4B("mn_jck_un2_onethreeisdownonethreeis");
}

_id_B85B(var_0) {
  var_1 = self;
  var_2 = [];

  if(!isDefined(var_1))
    return var_2;

  if(isDefined(var_1.turrets["cap_turret_small_constant"]))
    var_2 = scripts\engine\utility::array_combine(var_2, var_1.turrets["cap_turret_small_constant"]);

  var_2 = scripts\engine\utility::array_combine(var_2, var_1._id_8B51["cap_hardpoint_missile_barrage"]);
  var_2 = scripts\engine\utility::array_combine(var_2, var_1._id_8B50["cap_hardpoint_missile_barrage"]);
  var_3 = var_2;

  if(!isDefined(var_1._id_65CD))
    return var_2;

  foreach(var_5 in var_1._id_65CD) {
    var_2 = scripts\engine\utility::array_add(var_2, var_5._id_2F00[0]);
    var_2 = scripts\engine\utility::array_add(var_2, var_5._id_101B0[0]);
    var_2 = scripts\engine\utility::array_add(var_2, var_5._id_119EA[0]);
    var_2 = scripts\engine\utility::array_add(var_2, var_5._id_4651);
  }

  if(isDefined(var_0) && var_0)
    var_7 = var_2;
  else {
    if(var_3.size < 14)
      var_2 = scripts\engine\utility::array_remove_array(var_2, var_3);

    var_2 = scripts\engine\utility::array_randomize(var_2);
    var_8 = randomintrange(2, 5);
    var_7 = [];

    for(var_9 = 0; var_9 < var_8; var_9++) {
      if(isDefined(var_2[var_9])) {
        var_7 = scripts\engine\utility::array_add(var_7, var_2[var_9]);
        continue;
      }

      break;
    }
  }

  return var_7;
}

_id_2152() {
  var_0 = scripts\engine\utility::getStructArray("jackal_arena_scriptable_struct", "targetname");
  var_1 = spawn("script_origin", (0, 0, 0));
  level endon("stop_arena_scriptable_exploder");

  for(;;) {
    wait(randomfloatrange(1, 3));
    var_2 = 0;

    foreach(var_4 in var_0) {
      if(var_4 _id_0BDC::_id_9C1B(0.85)) {
        var_1 moveTo(var_4.origin + (0, 0, 100), 0.05);
        wait 0.05;
        radiusdamage(var_1.origin, 5000, 1000, 1000);
        thread scripts\engine\utility::play_sound_in_space("scn_moonjackal_random_explos", var_4.origin + (0, 0, 100));
        wait 0.05;
        var_0 = scripts\engine\utility::array_remove(var_0, var_4);
        break;
      } else {
        var_2 = var_2 + 1;

        if(var_2 >= 20 && scripts\engine\utility::cointoss()) {
          break;
        }
      }
    }
  }
}

_id_408F() {
  scripts\engine\utility::flag_wait("missileboat_killed");
  scripts\engine\utility::flag_set("flag_stop_spawning_jackals");

  if(isDefined(level._id_26EB)) {
    level._id_26EB notify("stop_spawning_jackals");

    foreach(var_1 in level._id_A056._id_191E) {
      if(isDefined(var_1))
        var_1 thread _id_50BF(randomfloatrange(0, 3));
    }
  }

  wait 3.0;
  thread scripts\sp\maps\moonjackal\moonjackal_transition::_id_BB4C();
}

_id_6DCA() {
  self setanimknob(%jackal_vehicle_landed_to_launch, 1, 0.2, 10);
}

_id_1CFD(var_0) {
  var_1 = getnotetracktimes(%jackal_vehicle_landed_to_launch, "engine_boot");
  wait(var_1[0] * getanimlength(%jackal_vehicle_landed_to_launch));
  _id_1CFE(var_0);
  self waittill("ally_jackal_go");
  _id_1D06(var_0);
}

_id_50BF(var_0) {
  wait(var_0);

  if(!isDefined(self) || !isalive(self)) {
    return;
  }
  if(_id_0B76::_id_7A60(self.origin) < 0.7 && !scripts\engine\utility::cointoss())
    self delete();
  else
    self _meth_81D0();
}

_id_7CA4() {
  var_0 = [];
  var_1 = level._id_864B["misc_turret_ground_small_cannon_un"].turrets;
  var_0 = scripts\engine\utility::array_combine(var_0, var_1);
  var_2 = level._id_864B["misc_turret_ground_med_cannon_un"].turrets;
  var_0 = scripts\engine\utility::array_combine(var_0, var_2);
  var_3 = level._id_864B["misc_turret_ground_small_missile_un"].turrets;
  var_0 = scripts\engine\utility::array_combine(var_0, var_3);
  return var_0;
}