/******************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\zombies\zombie_survival_common.gsc
******************************************************/

func_00D5() {
  level.var_2986 = "mp/zombieEnemyWavesSurvival.csv";
  level.var_ACA3 = 1;
  level.var_7F24 = 9999;
  level.var_7F1B = 10;
  level.var_323A = 1;
  level.use_zombie_unresolved_collision = 1;
  level.blitz_react_dist_override = 22500;
  level.st_142418 = 1;
  level.zombiespawnfxcount = 0;
  level.var_8AF = ::lib_0547::razergunmaxammo;
  level.zmb_player_safe_teleport_on_perk_buy = 1;
  setomnvar("ui_zm_intermission_swaptime_1", 6);
  setomnvar("ui_zm_intermission_swaptime_2", 2);
  setDvar("2494", "0.12, 0, 0");
  thread maps\mp\zombies\_zombies_money::func_D5();
  level thread soundscripts\_snd_common_zmb_dlc3::snd_zmb_init_dlc3();
  level thread maps\mp\zombies\_zombies_audio_dlc2::initdlc2audio();
  level.var_902A = ::func_902A;
  maps\mp\mp_zombie_nest_ee_wave_manipulation::func_F9();
  thread srv_gameplay();
  common_scripts\utility::func_3C87("ripsaw_punch_active");
  common_scripts\utility::func_3C87("pap_fuse_placed");
  common_scripts\utility::func_3C87("dlc2_melee_packable");
}

srv_allow_special_pap() {
  common_scripts\utility::func_3C8F("ripsaw_punch_active");
  common_scripts\utility::func_3C8F("teslagun_punch_active");
  common_scripts\utility::func_3C8F("dlc2_melee_packable");
}

srv_add_special_mystery() {
  maps\mp\zombies\_zombies_magicbox::func_9C8("teslagun_zm", "none", "none", "none");
  maps\mp\zombies\_zombies_magicbox::func_9C8("razergun_zm", "none", "none", "none");
  srvadduberwwtomystery();
}

srv_gameplay() {
  level waittill("player_spawned", var_00);
  level.var_A41["zombie_generic"]["move_mode"] = ::srvupdatemovemode;
  level srvaddmeleetomystery();
}

srv_init_miniboss_rounds() {
  level.var_3C00 = 1;
  level.var_3BFF = 0;
  level.var_3BFE = 0;
  level.var_66A6 = 10;
  level.fireman_round_min = 10;
  level.fireman_round_max = 10;
  level.var_3BED = 0;
  level.var_3BF2 = 0;
  thread lib_0564::func_3C10();
}

initsurvivalweapons() {
  thread lib_057D::func_5162();
  level thread lib_0580::func_D5();
  level thread maps\mp\zombies\weapons\_zombie_razer_gun::func_D5();
  level thread maps\mp\zombies\weapons\_zombie_dlc2_melee::func_D5();
  level maps\mp\zombies\weapons\_zombie_dlc3_melee::func_D5();
  level thread maps\mp\zombies\weapons\_zombie_dlc3_melee::sword_delivery_init();
}

srvadduberwwtomystery() {
  maps\mp\zombies\_zombies_magicbox::func_9C8("teslagun_zm_blood", "none", "none", "none");
  maps\mp\zombies\_zombies_magicbox::func_9C8("teslagun_zm_death", "none", "none", "none");
  maps\mp\zombies\_zombies_magicbox::func_9C8("teslagun_zm_moon", "none", "none", "none");
  maps\mp\zombies\_zombies_magicbox::func_9C8("teslagun_zm_storm", "none", "none", "none");
}

srvaddmeleetomystery() {
  maps\mp\zombies\_zombies_magicbox::func_9C8("zom_dlc2_3_zm", "none", "none", "none");
  maps\mp\zombies\_zombies_magicbox::func_9C8("zom_dlc2_2_zm", "none", "none", "none");
  maps\mp\zombies\_zombies_magicbox::func_9C8("zom_dlc2_1_zm", "none", "none", "none");
}

srvupdatemovemode() {
  var_00 = self.var_901F;
  return lib_054D::func_957E(var_00 + 10);
}

srvroundstart() {
  if(level.var_A980 > 0 && level.var_A980 % 5 == 0) {
    unlock_next_reciever();
  }

  if(level.var_A980 > 0 && level.var_A980 % 5 == 0) {
    if(level.var_7F1B >= 2) {
      level.var_7F1B--;
    }
  }

  switch (level.var_A980) {
    case 10:
      maps\mp\zombies\_zombies_magicbox::func_9C8("teslagun_zm", "none", "none", "none");
      maps\mp\zombies\_zombies_magicbox::func_9C8("razergun_zm", "none", "none", "none");
      break;

    case 25:
      srvadduberwwtomystery();
      break;
  }
}

srvroundend() {}

srvshowpapfuse() {
  var_00 = common_scripts\utility::func_46B5("srv_pap_fuse_loc", "targetname");
  if(isDefined(var_00)) {
    var_01 = spawn("script_model", var_00.var_116);
    var_01.var_1D = var_00.var_1D;
    var_01 setModel("zmb_fuse_04");
    common_scripts\utility::func_3C8F("pap_fuse_placed");
    common_scripts\utility::func_3C8F("ripsaw_punch_active");
    common_scripts\utility::func_3C8F("teslagun_punch_active");
    common_scripts\utility::func_3C8F("dlc2_melee_packable");
  }
}

run_pack_a_punch_log() {
  if(isDefined(level.upgrade_machine_upgrade_func)) {
    level thread[[level.upgrade_machine_upgrade_func]]();
  }
}

collect_souls_to_unlock_pack_a_punch() {
  var_00 = common_scripts\utility::func_46B7("zmb_sg_pap_light_display", "targetname");
  var_01 = common_scripts\utility::func_46B7("zmb_pack_key", "targetname");
  var_02 = common_scripts\utility::func_46B7("zmb_sg_availablility_light_display", "targetname");
  var_03 = function_021F("zmb_sg_reciver_scriptable", "targetname");
  foreach(var_05 in var_03) {
    var_05 thread maps\mp\mp_zombie_nest_hilt_altar_reciever::func_84DC();
  }

  if(var_01.size < 3) {
    return;
  }

  level.pack_a_punc_pre_func = ::wait_for_pap_available;
  for(var_07 = 0; var_07 < var_01.size; var_07++) {
    common_scripts\utility::func_3C87("zmb_sg_soul_collect_flag_" + var_01[var_07].var_81E1);
    common_scripts\utility::func_3C87("zmb_sg_soul_collect_ready_flag_" + var_01[var_07].var_81E1);
  }

  common_scripts\utility::func_FB2(var_01, ::set_pack_key_unlocked);
  common_scripts\utility::func_FB2(var_00, ::handle_unlock_lights, "zmb_sg_soul_collect_flag_");
  common_scripts\utility::func_FB2(var_02, ::handle_unlock_lights, "zmb_sg_soul_collect_ready_flag_", "zmb_sg_soul_collect_flag_");
  maps\mp\_utility::func_2CED(3, ::unlock_next_reciever);
  wait_for_pap_available();
  wait(0.5);
  level notify("pap_state_change");
  level thread maps\mp\_utility::func_6F74(::maps\mp\gametypes\_hud_message::func_9102, "zm_pap_unlocked");
}

wait_for_pap_available() {
  var_00 = getent("pack_a_punch_weapon_display", "targetname");
  var_00 method_8511();
  for(var_01 = 0; var_01 < 3; var_01++) {
    common_scripts\utility::func_3C9F("zmb_sg_soul_collect_flag_" + var_01 + 1);
  }
}

unlock_next_reciever() {
  if(!isDefined(level.zmb_pap_reciver_unlocks)) {
    level.zmb_pap_reciver_unlocks = 0;
  }

  level.zmb_pap_reciver_unlocks++;
  var_00 = "zmb_sg_soul_collect_ready_flag_" + level.zmb_pap_reciver_unlocks;
  if(common_scripts\utility::func_3C83(var_00)) {
    common_scripts\utility::func_3C8F(var_00);
  }
}

handle_unlock_lights(param_00, param_01) {
  lib_0547::func_A6F6();
  var_02 = self.var_81E1;
  var_03 = lib_0547::func_8FBA(self, "zmb_nest_generator_bulb_red");
  triggerfx(var_03);
  common_scripts\utility::func_3C9F(param_00 + self.var_81E1);
  var_03 delete();
  var_03 = lib_0547::func_8FBA(self, "zmb_nest_generator_bulb_green");
  triggerfx(var_03);
  if(!isDefined(param_01)) {
    return;
  }

  common_scripts\utility::func_3C9F(param_01 + self.var_81E1);
  var_03 delete();
  var_03 = lib_0547::func_8FBA(self, "zmb_nest_generator_bulb_off");
  triggerfx(var_03);
}

set_pack_key_unlocked() {
  var_00 = self.var_81E1;
  var_01 = spawn("script_model", self.var_116);
  var_01 setModel("tag_origin");
  common_scripts\utility::func_3C9F("zmb_sg_soul_collect_ready_flag_" + self.var_81E1);
  var_02 = 400;
  if(common_scripts\utility::func_562E(level.sg_pack_use_small_radius)) {
    var_02 = 256;
  }

  var_01.ignoresighttrace = 1;
  var_01 maps\mp\mp_zombies_soul_collection::func_170B(10, var_02, 70, "zmb_sg_soul_collect_ping_" + var_00, undefined, "tag_origin", undefined, "tag_origin");
  common_scripts\utility::func_3C8F("zmb_sg_soul_collect_flag_" + self.var_81E1);
  level thread maps\mp\gametypes\zombies::orders_and_contracts_report_event("geistcraft_device_powered");
}

func_902A(param_00) {
  if(isDefined(param_00.var_82EC)) {
    switch (param_00.var_82EC) {
      case "spawn_dirt":
        return::dirtspawnnotetrackhandler;

      case "spawn_concrete":
        return::concretespawnnotetrackhandler;

      case "spawn_mud":
        return::mudspawnnotetrackhandler;

      case "spawn_sand":
        return::sandspawnnotetrackhandler;

      case "spawn_water":
        return::waterspawnnotetrackhandler;

      case "spawn_fire":
        thread try_catch_on_fire();
        return undefined;
    }
  }
}

try_catch_on_fire() {
  self endon("death");
  var_00 = 0;
  foreach(var_02 in lib_0547::func_408F()) {
    if(lib_0547::func_5565(var_02.var_A4B, "zombie_sizzler")) {
      continue;
    }

    if(common_scripts\utility::func_562E(var_02.isonfire)) {
      var_00++;
    }
  }

  if(var_00 < 4) {
    self.isonfire = 1;
    lib_0547::func_A6F6();
    self setonfire(0, 100, 1, "none", 1);
  }
}

dirtspawnnotetrackhandler(param_00, param_01, param_02, param_03) {
  if(param_00 == "zom_spawn_event") {
    thread zombiespawnfx("zmb_spawn_dirt");
  }
}

mudspawnnotetrackhandler(param_00, param_01, param_02, param_03) {
  if(param_00 == "zom_spawn_event") {
    thread zombiespawnfx("zmb_spawn_mud");
  }
}

concretespawnnotetrackhandler(param_00, param_01, param_02, param_03) {
  if(param_00 == "zom_spawn_event") {
    thread zombiespawnfx("zmb_spawn_concrete");
  }
}

sandspawnnotetrackhandler(param_00, param_01, param_02, param_03) {
  if(param_00 == "zom_spawn_event") {
    thread zombiespawnfx("zmb_spawn_sand");
  }
}

waterspawnnotetrackhandler(param_00, param_01, param_02, param_03) {
  if(param_00 == "zom_spawn_event") {
    thread zombiespawnfx("zmb_spawn_water");
    thread zombiedripfx("zmb_spawn_water");
  }
}

zombiedripfx(param_00) {
  if(level.var_A980 >= 20) {
    return;
  }

  var_01 = "spawn_water_drip";
  if(isDefined(param_00)) {
    var_01 = param_00 + "_drip";
  }

  var_02 = ["J_Shoulder_RI", "J_Shoulder_LE", "J_Hip_LE", "J_Hip_RI", "J_Head"];
  foreach(var_05 in var_02) {
    if(isDefined(self gettagorigin(var_05))) {
      lib_0547::func_74A5(common_scripts\utility::func_44F5(var_01), self, var_05);
    }
  }

  zombiedripfxcleanup(var_02, var_01);
}

zombiedripfxcleanup(param_00, param_01) {
  self endon("death");
  while(isDefined(self) && isalive(self)) {
    wait(0.1);
    if(!isDefined(self.var_53D9) || !self.var_53D9) {
      break;
    }
  }

  wait(randomfloatrange(5, 15));
  if(!isDefined(self) || !isalive(self)) {
    return;
  }

  foreach(var_03 in param_00) {
    if(isDefined(self gettagorigin(var_03))) {
      lib_0547::func_9406(common_scripts\utility::func_44F5(param_01), self, var_03);
    }
  }
}

zombiespawnfx(param_00) {
  if(level.zombiespawnfxcount >= 12) {
    return;
  }

  var_01 = spawnfx(common_scripts\utility::func_44F5(param_00), self.var_116, anglesToForward(self.var_1D), anglestoup(self.var_1D));
  triggerfx(var_01);
  level.zombiespawnfxcount++;
  common_scripts\utility::func_A74B("death", 2);
  level.zombiespawnfxcount--;
  var_01 delete();
}