/**************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\zombies\zombie_survival_common.gsc
**************************************************************/

init() {
  level._id_2986 = "mp/zombieEnemyWavesSurvival.csv";
  level._id_ACA3 = 1;
  level._id_7F24 = 9999;
  level._id_7F1B = 10;
  level._id_323A = 1;
  level.use_zombie_unresolved_collision = 1;
  level.blitz_react_dist_override = 22500;
  level.st_142418 = 1;
  level.zombiespawnfxcount = 0;
  level._id_08AF = _id_0547::razergunmaxammo;
  level.zmb_player_safe_teleport_on_perk_buy = 1;
  _func_032("ui_zm_intermission_swaptime_1", 6);
  _func_032("ui_zm_intermission_swaptime_2", 2);
  setDvar("2494", "0.12, 0, 0");
  thread _id_0544::init();
  level thread soundscripts\_snd_common_zmb_dlc3::snd_zmb_init_dlc3();
  level thread maps\mp\zombies\_zombies_audio_dlc2::initdlc2audio();
  level._id_902A = ::_id_902A;
  maps\mp\mp_zombie_nest_ee_wave_manipulation::main();
  thread srv_gameplay();
  common_scripts\utility::flag_init("ripsaw_punch_active");
  common_scripts\utility::flag_init("pap_fuse_placed");
  common_scripts\utility::flag_init("dlc2_melee_packable");
}

srv_allow_special_pap() {
  common_scripts\utility::flag_set("ripsaw_punch_active");
  common_scripts\utility::flag_set("teslagun_punch_active");
  common_scripts\utility::flag_set("dlc2_melee_packable");
}

srv_add_special_mystery() {
  _id_0548::_id_09C8("teslagun_zm", "none", "none", "none");
  _id_0548::_id_09C8("razergun_zm", "none", "none", "none");
  srvadduberwwtomystery();
}

srv_gameplay() {
  level waittill("player_spawned", var_0);
  level._id_0A41["zombie_generic"]["move_mode"] = ::srvupdatemovemode;
  level srvaddmeleetomystery();
}

srv_init_miniboss_rounds() {
  level._id_3C00 = 1;
  level._id_3BFF = 0;
  level._id_3BFE = 0;
  level._id_66A6 = 10;
  level.fireman_round_min = 10;
  level.fireman_round_max = 10;
  level._id_3BED = 0;
  level._id_3BF2 = 0;
  thread _id_0564::_id_3C10();
}

initsurvivalweapons() {
  thread _id_057D::_id_5162();
  level thread _id_0580::init();
  level thread maps\mp\zombies\weapons\_zombie_razer_gun::init();
  level thread maps\mp\zombies\weapons\_zombie_dlc2_melee::init();
  level maps\mp\zombies\weapons\_zombie_dlc3_melee::init();
  level thread maps\mp\zombies\weapons\_zombie_dlc3_melee::sword_delivery_init();
}

srvadduberwwtomystery() {
  _id_0548::_id_09C8("teslagun_zm_blood", "none", "none", "none");
  _id_0548::_id_09C8("teslagun_zm_death", "none", "none", "none");
  _id_0548::_id_09C8("teslagun_zm_moon", "none", "none", "none");
  _id_0548::_id_09C8("teslagun_zm_storm", "none", "none", "none");
}

srvaddmeleetomystery() {
  _id_0548::_id_09C8("zom_dlc2_3_zm", "none", "none", "none");
  _id_0548::_id_09C8("zom_dlc2_2_zm", "none", "none", "none");
  _id_0548::_id_09C8("zom_dlc2_1_zm", "none", "none", "none");
}

srvupdatemovemode() {
  var_0 = self._id_901F;
  return _id_054D::_id_957E(var_0 + 10);
}

srvroundstart() {
  if(level._id_A980 > 0 && level._id_A980 % 5 == 0)
    unlock_next_reciever();

  if(level._id_A980 > 0 && level._id_A980 % 5 == 0) {
    if(level._id_7F1B >= 2)
      level._id_7F1B--;
  }

  switch (level._id_A980) {
    case 10:
      _id_0548::_id_09C8("teslagun_zm", "none", "none", "none");
      _id_0548::_id_09C8("razergun_zm", "none", "none", "none");
      break;
    case 25:
      srvadduberwwtomystery();
      break;
  }
}

srvroundend() {}

srvshowpapfuse() {
  var_0 = common_scripts\utility::_id_46B5("srv_pap_fuse_loc", "targetname");

  if(isDefined(var_0)) {
    var_1 = spawn("script_model", var_0.origin);
    var_1.angles = var_0.angles;
    var_1 setModel("zmb_fuse_04");
    common_scripts\utility::flag_set("pap_fuse_placed");
    common_scripts\utility::flag_set("ripsaw_punch_active");
    common_scripts\utility::flag_set("teslagun_punch_active");
    common_scripts\utility::flag_set("dlc2_melee_packable");
  }
}

run_pack_a_punch_log() {
  if(isDefined(level.upgrade_machine_upgrade_func))
    level thread[[level.upgrade_machine_upgrade_func]]();
}

collect_souls_to_unlock_pack_a_punch() {
  var_0 = common_scripts\utility::_id_46B7("zmb_sg_pap_light_display", "targetname");
  var_1 = common_scripts\utility::_id_46B7("zmb_pack_key", "targetname");
  var_2 = common_scripts\utility::_id_46B7("zmb_sg_availablility_light_display", "targetname");
  var_3 = _func_21F("zmb_sg_reciver_scriptable", "targetname");

  foreach(var_5 in var_3)
  var_5 thread maps\mp\mp_zombie_nest_hilt_altar_reciever::_id_84DC();

  if(var_1.size < 3) {
    return;
  }
  level.pack_a_punc_pre_func = ::wait_for_pap_available;

  for(var_7 = 0; var_7 < var_1.size; var_7++) {
    common_scripts\utility::flag_init("zmb_sg_soul_collect_flag_" + var_1[var_7]._id_81E1);
    common_scripts\utility::flag_init("zmb_sg_soul_collect_ready_flag_" + var_1[var_7]._id_81E1);
  }

  common_scripts\utility::_id_0FB2(var_1, ::set_pack_key_unlocked);
  common_scripts\utility::_id_0FB2(var_0, ::handle_unlock_lights, "zmb_sg_soul_collect_flag_");
  common_scripts\utility::_id_0FB2(var_2, ::handle_unlock_lights, "zmb_sg_soul_collect_ready_flag_", "zmb_sg_soul_collect_flag_");
  maps\mp\_utility::_id_2CED(3, ::unlock_next_reciever);
  wait_for_pap_available();
  wait 0.5;
  level notify("pap_state_change");
  level thread maps\mp\_utility::_id_6F74(maps\mp\gametypes\_hud_message::_id_9102, "zm_pap_unlocked");
}

wait_for_pap_available() {
  var_0 = _func_18E("pack_a_punch_weapon_display", "targetname");
  var_0 _meth_8511();

  for(var_1 = 0; var_1 < 3; var_1++)
    common_scripts\utility::_id_3C9F("zmb_sg_soul_collect_flag_" + (var_1 + 1));
}

unlock_next_reciever() {
  if(!isDefined(level.zmb_pap_reciver_unlocks))
    level.zmb_pap_reciver_unlocks = 0;

  level.zmb_pap_reciver_unlocks++;
  var_0 = "zmb_sg_soul_collect_ready_flag_" + level.zmb_pap_reciver_unlocks;

  if(common_scripts\utility::_id_3C83(var_0))
    common_scripts\utility::flag_set(var_0);
}

handle_unlock_lights(var_0, var_1) {
  _id_0547::_id_A6F6();
  var_2 = self._id_81E1;
  var_3 = _id_0547::_id_8FBA(self, "zmb_nest_generator_bulb_red");
  _func_14C(var_3);
  common_scripts\utility::_id_3C9F(var_0 + self._id_81E1);
  var_3 delete();
  var_3 = _id_0547::_id_8FBA(self, "zmb_nest_generator_bulb_green");
  _func_14C(var_3);

  if(!isDefined(var_1)) {
    return;
  }
  common_scripts\utility::_id_3C9F(var_1 + self._id_81E1);
  var_3 delete();
  var_3 = _id_0547::_id_8FBA(self, "zmb_nest_generator_bulb_off");
  _func_14C(var_3);
}

set_pack_key_unlocked() {
  var_0 = self._id_81E1;
  var_1 = spawn("script_model", self.origin);
  var_1 setModel("tag_origin");
  common_scripts\utility::_id_3C9F("zmb_sg_soul_collect_ready_flag_" + self._id_81E1);
  var_2 = 400;

  if(common_scripts\utility::_id_562E(level.sg_pack_use_small_radius))
    var_2 = 256;

  var_1.ignoresighttrace = 1;
  var_1 maps\mp\mp_zombies_soul_collection::_id_170B(10, var_2, 70, "zmb_sg_soul_collect_ping_" + var_0, undefined, "tag_origin", undefined, "tag_origin");
  common_scripts\utility::flag_set("zmb_sg_soul_collect_flag_" + self._id_81E1);
  level thread maps\mp\gametypes\zombies::orders_and_contracts_report_event("geistcraft_device_powered");
}

_id_902A(var_0) {
  if(isDefined(var_0._id_82EC)) {
    switch (var_0._id_82EC) {
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
  var_0 = 0;

  foreach(var_2 in _id_0547::_id_408F()) {
    if(_id_0547::_id_5565(var_2._id_0A4B, "zombie_sizzler")) {
      continue;
    }
    if(common_scripts\utility::_id_562E(var_2.isonfire))
      var_0++;
  }

  if(var_0 < 4) {
    self.isonfire = 1;
    _id_0547::_id_A6F6();
    self _meth_8682(0, 100, 1, "none", 1);
  }
}

dirtspawnnotetrackhandler(var_0, var_1, var_2, var_3) {
  if(var_0 == "zom_spawn_event")
    thread zombiespawnfx("zmb_spawn_dirt");
}

mudspawnnotetrackhandler(var_0, var_1, var_2, var_3) {
  if(var_0 == "zom_spawn_event")
    thread zombiespawnfx("zmb_spawn_mud");
}

concretespawnnotetrackhandler(var_0, var_1, var_2, var_3) {
  if(var_0 == "zom_spawn_event")
    thread zombiespawnfx("zmb_spawn_concrete");
}

sandspawnnotetrackhandler(var_0, var_1, var_2, var_3) {
  if(var_0 == "zom_spawn_event")
    thread zombiespawnfx("zmb_spawn_sand");
}

waterspawnnotetrackhandler(var_0, var_1, var_2, var_3) {
  if(var_0 == "zom_spawn_event") {
    thread zombiespawnfx("zmb_spawn_water");
    thread zombiedripfx("zmb_spawn_water");
  }
}

zombiedripfx(var_0) {
  if(level._id_A980 >= 20) {
    return;
  }
  var_1 = "spawn_water_drip";

  if(isDefined(var_0))
    var_1 = var_0 + "_drip";

  var_2 = ["J_Shoulder_RI", "J_Shoulder_LE", "J_Hip_LE", "J_Hip_RI", "J_Head"];

  foreach(var_5 in var_2) {
    if(isDefined(self gettagorigin(var_5)))
      _id_0547::_id_74A5(common_scripts\utility::_id_44F5(var_1), self, var_5);
  }

  zombiedripfxcleanup(var_2, var_1);
}

zombiedripfxcleanup(var_0, var_1) {
  self endon("death");

  while(isDefined(self) && isalive(self)) {
    wait 0.1;

    if(!isDefined(self._id_53D9) || !self._id_53D9) {
      break;
    }
  }

  wait(_func_0A5(5.0, 15.0));

  if(!isDefined(self) || !isalive(self)) {
    return;
  }
  foreach(var_3 in var_0) {
    if(isDefined(self gettagorigin(var_3)))
      _id_0547::_id_9406(common_scripts\utility::_id_44F5(var_1), self, var_3);
  }
}

zombiespawnfx(var_0) {
  if(level.zombiespawnfxcount >= 12) {
    return;
  }
  var_1 = _func_14B(common_scripts\utility::_id_44F5(var_0), self.origin, anglesToForward(self.angles), anglestoup(self.angles));
  _func_14C(var_1);
  level.zombiespawnfxcount++;
  common_scripts\utility::waittill_notify_or_timeout("death", 2.0);
  level.zombiespawnfxcount--;
  var_1 delete();
}