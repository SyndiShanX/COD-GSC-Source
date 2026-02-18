/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: killstreaks\zm\ultimate_turret.gsc
***********************************************/

#using scripts\core_common\battlechatter;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\globallogic\globallogic_audio;
#using scripts\core_common\math_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\system_shared;
#using scripts\core_common\throttle_shared;
#using scripts\core_common\values_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\killstreaks\ultimate_turret_shared;
#using scripts\weapons\deployable;
#using scripts\zm_common\zm_utility;
#namespace ultimate_turret;

function private autoexec __init__system__() {
  system::register(#"ultimate_turret", &preinit, undefined, undefined, #"killstreaks");
}

function private preinit() {
  level.var_729a0937 = &function_4b645b3f;
  level.var_bbc796bf = &turret_destroyed;
  level.var_a3ec798a = &turretscanning;
  level.var_6f2028c7 = 0;
  level.var_11d9ab7c = new class_c6c0e94();
  [[level.var_11d9ab7c]] - > initialize(#"ultimate_turret_zm", 1, float(function_60d95f53()) / 1000);
  init_shared();
  deployable::register_deployable(getweapon("ultimate_turret"), &function_53028023, undefined, #"mp/sentry_deploy", #"hash_37605398dce96965");
  callback::on_vehicle_spawned(&function_bf97d10);
  callback::on_deleted(&function_634677dd);
}

function function_634677dd() {
  if(self.vehicletype === # "hash_d57fa1b1aacffc7") {
    level.var_6f2028c7--;
    level.var_6f2028c7 = math::clamp(level.var_6f2028c7, 0, 4);
  }
}

function function_bf97d10(params) {
  if(self.vehicletype === # "hash_d57fa1b1aacffc7") {
    self.var_4a64e878 = 1;
    val::set(#"ultimate_turret_zm", "takedamage", 0);
    level.var_6f2028c7++;
    level.var_6f2028c7 = math::clamp(level.var_6f2028c7, 0, 4);
  }
}

function function_4b645b3f(killstreaktype) {
  self globallogic_audio::play_taacom_dialog("timeout", killstreaktype);
}

function turret_destroyed(attacker, weapon) {
  profilestart();

  if(isDefined(attacker)) {
    attacker battlechatter::function_eebf94f6("ultimate_turret", weapon);
    attacker stats::function_e24eec31(weapon, #"hash_3f3d8a93c372c67d", 1);
  }

  profilestop();
}

function function_53028023(v_origin, v_angles, player) {
  if(level.var_6f2028c7 < 4 && (!zm_utility::is_classic() || zm_utility::check_point_in_playable_area(player) && zm_utility::check_point_in_enabled_zone(player, 1)) && ispointonnavmesh(player)) {
    return true;
  }

  return false;
}

function turretscanning() {
  veh = self;
  veh endon(#"death", #"death_started", #"end_turret_scanning");
  wait 0.8;
  veh playSound(#"mpl_turret_startup");
  veh playLoopSound(#"hash_69240c6db92da5bf");
  s_bundle = killstreaks::get_script_bundle("ultimate_turret");
  veh.maxsightdistsqrd = sqr(isDefined(s_bundle.var_2aeadfa0) ? s_bundle.var_2aeadfa0 : 3500);
  veh thread function_9d831b2f();

  while(true) {
    veh.maxsightdistsqrd = sqr(isDefined(s_bundle.var_2aeadfa0) ? s_bundle.var_2aeadfa0 : 3500);

    if(self.isjammed === 1 || self.isstunned === 1) {
      waitframe(1);
      continue;
    }

    if(is_valid_target(veh.e_current_target)) {
      function_16ccb771(veh.e_current_target);
    } else {
      function_d103a3d0();
    }

    aim_at_target(isDefined(veh.var_c27dadc8) ? veh.var_c27dadc8 : veh.e_current_target);
    self function_a76ab7f7();
  }
}

function function_a76ab7f7() {
  [[level.var_11d9ab7c]] - > waitinqueue(self);
}