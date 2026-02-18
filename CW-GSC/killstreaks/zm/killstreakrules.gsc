/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: killstreaks\zm\killstreakrules.gsc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\globallogic\globallogic_audio;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\killstreakrules_shared;
#using scripts\zm_common\zm_stats;
#namespace killstreakrules;

function init() {
  init_shared();
  level.var_956bde25 = &function_65739e7b;

  if(isDefined(level.var_7ed465e4)) {
    [[level.var_7ed465e4]]();
    return;
  }

  function_7256bae2();
  addkillstreaktorule("tank_robot", "tank_robot", 1, 1);
  addkillstreaktorule("ac130", "ac130", 1, 1);
  addkillstreaktorule("airstrike", "airsupport", 1, 1);
  addkillstreaktorule("airstrike", "vehicle", 1, 1);
  addkillstreaktorule("ammo_station", "turret", 1, 1);
  addkillstreaktorule("armor_station", "turret", 1, 1);
  addkillstreaktorule("artillery", "firesupport", 1, 1);
  addkillstreaktorule("artillery_barrage", "artillery_barrage", 1, 1);
  addkillstreaktorule("auto_tow", "turret", 1, 1);
  addkillstreaktorule("autoturret", "turret", 1, 1);
  addkillstreaktorule("chopper_gunner", "chopper_gunner", 1, 1);
  addkillstreaktorule("combat_robot", "combatrobot", 1, 1);
  addkillstreaktorule("counteruav", "counteruav", 1, 1);
  addkillstreaktorule("counteruav", "targetableent", 1, 1);
  addkillstreaktorule("dart", "dart", 1, 1);
  addkillstreaktorule("ability_dog", "ability_dog", 1, 1);
  addkillstreaktorule("drone_squadron", "drone_squadron", 1, 1);
  addkillstreaktorule("drone_strike", "drone_strike", 1, 1);
  addkillstreaktorule("helicopter", "chopper", 1, 1);
  addkillstreaktorule("helicopter", "chopperInTheAir", 1, 0);
  addkillstreaktorule("helicopter", "playercontrolledchopper", 0, 1);
  addkillstreaktorule("helicopter", "targetableent", 1, 1);
  addkillstreaktorule("helicopter", "vehicle", 1, 1);
  addkillstreaktorule("helicopter_comlink", "chopper", 1, 1);
  addkillstreaktorule("helicopter_comlink", "chopperInTheAir", 1, 0);
  addkillstreaktorule("helicopter_comlink", "targetableent", 1, 1);
  addkillstreaktorule("helicopter_comlink", "vehicle", 1, 1);
  addkillstreaktorule("helicopter_comlink", "helicopter_comlink", 1, 1);
  addkillstreaktorule("overwatch_helicopter", "chopper", 1, 1);
  addkillstreaktorule("overwatch_helicopter", "chopperInTheAir", 1, 0);
  addkillstreaktorule("overwatch_helicopter", "targetableent", 1, 1);
  addkillstreaktorule("overwatch_helicopter", "vehicle", 1, 1);
  addkillstreaktorule("helicopter_guard", "chopper", 1, 1);
  addkillstreaktorule("helicopter_guard", "chopperInTheAir", 1, 0);
  addkillstreaktorule("helicopter_guard", "targetableent", 1, 1);
  addkillstreaktorule("helicopter_guard", "vehicle", 1, 1);
  addkillstreaktorule("helicopter_guard", "helicopter_guard", 1, 1);
  addkillstreaktorule("attack_helicopter", "chopperInTheAir", 1, 0);
  addkillstreaktorule("attack_helicopter", "playercontrolledchopper", 1, 1);
  addkillstreaktorule("attack_helicopter", "targetableent", 1, 1);
  addkillstreaktorule("attack_helicopter", "vehicle", 1, 1);
  addkillstreaktorule("helicopter_player_firstperson", "vehicle", 1, 1);
  addkillstreaktorule("helicopter_player_firstperson", "chopperInTheAir", 1, 1);
  addkillstreaktorule("helicopter_player_firstperson", "playercontrolledchopper", 1, 1);
  addkillstreaktorule("helicopter_player_firstperson", "targetableent", 1, 1);
  addkillstreaktorule("helicopter_x2", "chopper", 1, 1);
  addkillstreaktorule("helicopter_x2", "chopperInTheAir", 1, 0);
  addkillstreaktorule("helicopter_x2", "playercontrolledchopper", 0, 1);
  addkillstreaktorule("helicopter_x2", "targetableent", 1, 1);
  addkillstreaktorule("helicopter_x2", "vehicle", 1, 1);
  addkillstreaktorule("m202_flash", "weapon", 1, 1);
  addkillstreaktorule("m220_tow", "weapon", 1, 1);
  addkillstreaktorule("m220_tow_drop", "supplydrop", 1, 1);
  addkillstreaktorule("m220_tow_drop", "vehicle", 1, 1);
  addkillstreaktorule("m220_tow_killstreak", "weapon", 1, 1);
  addkillstreaktorule("m32", "weapon", 1, 1);
  addkillstreaktorule("m32_drop", "weapon", 1, 1);
  addkillstreaktorule("microwave_turret", "turret", 1, 1);
  addkillstreaktorule("minigun", "weapon", 1, 1);
  addkillstreaktorule("minigun_drop", "weapon", 1, 1);
  addkillstreaktorule("mini_turret", "turret", 1, 1);
  addkillstreaktorule("missile_drone", "missiledrone", 1, 1);
  addkillstreaktorule("missile_swarm", "missileswarm", 1, 1);
  addkillstreaktorule("mortar", "firesupport", 1, 1);
  addkillstreaktorule("mp40_drop", "weapon", 1, 1);
  addkillstreaktorule("napalm_strike", "airsupport", 1, 1);
  addkillstreaktorule("napalm_strike", "vehicle", 1, 1);
  addkillstreaktorule("planemortar", "planemortar", 1, 1);
  addkillstreaktorule("qrdrone", "qrdrone", 1, 1);
  addkillstreaktorule("qrdrone", "vehicle", 1, 1);
  addkillstreaktorule("uav", "uav", 1, 1);
  addkillstreaktorule("uav", "targetableent", 1, 1);
  addkillstreaktorule("ultimate_turret", "turret", 1, 1);
  addkillstreaktorule("ultimate_turret", "ultimate_turret", 1, 1);
  addkillstreaktorule("satellite", "satellite", 1, 1);
  addkillstreaktorule("raps", "raps", 1, 1);
  addkillstreaktorule("rcbomb", "rcxd", 1, 1);
  addkillstreaktorule("recon_car", "recon_car", 1, 1);
  addkillstreaktorule("recon_plane", "recon_plane", 1, 1);
  addkillstreaktorule("remote_missile", "targetableent", 1, 1);
  addkillstreaktorule("remote_missile", "remote_missile", 1, 1);
  addkillstreaktorule("remote_mortar", "remotemortar", 1, 1);
  addkillstreaktorule("remote_mortar", "targetableent", 1, 1);
  addkillstreaktorule("sentinel", "sentinel", 1, 1);
  addkillstreaktorule("spawnbeacon", "spawnbeacon", 1, 1);
  addkillstreaktorule("straferun", "straferun", 1, 1);
  addkillstreaktorule("jetfighter", "jetfighter", 1, 1);
  addkillstreaktorule("hoverjet", "hoverjet", 1, 1);
  addkillstreaktorule("supply_drop", "supplydrop", 1, 1);
  addkillstreaktorule("supply_drop", "targetableent", 1, 1);
  addkillstreaktorule("supply_drop", "vehicle", 1, 1);
  addkillstreaktorule("supply_station", "supplydrop", 1, 1);
  addkillstreaktorule("supply_station", "targetableent", 1, 1);
  addkillstreaktorule("supply_station", "vehicle", 1, 1);
  addkillstreaktorule("swat_team", "swat_team", 1, 1);
  addkillstreaktorule("tow_turret_drop", "supplydrop", 1, 1);
  addkillstreaktorule("tow_turret_drop", "vehicle", 1, 1);
  addkillstreaktorule("turret_drop", "supplydrop", 1, 1);
  addkillstreaktorule("turret_drop", "vehicle", 1, 1);
}

function private function_7256bae2() {
  createrule("tank_robot", 2, 1);
  createrule("ac130", 1, 1);
  createrule("airsupport", 1, 1);
  createrule("ammo_station", 8, 4);
  createrule("armor_station", 8, 4);
  createrule("artillery_barrage", 1, 1);
  createrule("combatrobot", 4, 2);
  createrule("chopper", 2, 1);
  createrule("chopper_gunner", 1, 1);
  createrule("chopperInTheAir", 2, 1);
  createrule("counteruav", 6, 3);
  createrule("dart", 4, 2);
  createrule("ability_dog", 1, 1);
  createrule("drone_squadron", 4, 2);
  createrule("drone_strike", 1, 1);
  createrule("firesupport", 1, 1);
  createrule("helicopter_comlink", 2, 1);
  createrule("helicopter_guard", 2, 1);
  createrule("missiledrone", 3, 3);
  createrule("missileswarm", 1, 1);
  createrule("planemortar", 1, 1);
  createrule("playercontrolledchopper", 1, 1);
  createrule("qrdrone", 3, 2);
  createrule("uav", 50, 25);
  createrule("raps", 2, 1);
  createrule("rcxd", 4, 2);
  createrule("recon_car", 4, 2);
  createrule("recon_plane", 2, 1);
  createrule("remote_missile", 2, 1);
  createrule("remotemortar", 1, 1);
  createrule("satellite", 2, 1);
  createrule("sentinel", 4, 2);
  createrule("spawnbeacon", 1, 2);
  createrule("straferun", 1, 1);
  createrule("jetfighter", 2, 1);
  createrule("hoverjet", 1, 1);
  createrule("supplydrop", 4, 4);
  createrule("swat_team", 4, 2);
  createrule("targetableent", 32, 32);
  createrule("turret", 8, 4);
  createrule("ultimate_turret", 8, 4);
  createrule("vehicle", 7, 7);
  createrule("weapon", 12, 6);
}

function function_65739e7b(hardpointtype, team, isemped) {
  if(isDefined(level.killstreaks[team]) && isDefined(level.killstreaks[team].notavailabletext)) {
    self iprintlnbold(level.killstreaks[team].notavailabletext);

    if(!isDefined(self.currentkillstreakdialog)) {
      return;
    }

    if(!isDefined(level.killstreaks[team].script_bundle)) {
      return;
    }

    if(level.killstreaks[team].script_bundle.var_a9b0c301 === 1) {
      self globallogic_audio::play_taacom_dialog("groundspaceFull");
    }

    if(level.killstreaks[team].script_bundle.var_65d707d0 === 1 && isemped === 0) {
      self globallogic_audio::play_taacom_dialog("airspaceFull");
    }

    if(level.killstreaks[team].script_bundle.var_65d707d0 === 1 && function_2912fa8()) {}
  }
}

function function_2912fa8(kstype) {
  var_1be6aa23 = level flag::get("in_dark_side");

  if(is_true(self.var_16735873) || is_true(level.var_fe6ca5e8) || var_1be6aa23) {
    return 1;
  }

  if(isDefined(level.var_1f616ecc[kstype])) {
    return self[[level.var_1f616ecc[kstype]]]();
  }

  return 0;
}

function function_71e94a3b(kstype) {
  if(self function_2912fa8(kstype)) {
    return false;
  }

  if(isDefined(level.var_662dc783)) {
    return !is_true(self[[level.var_662dc783]](kstype));
  }

  return true;
}

function function_24241971() {
  nearby_ai = getentitiesinradius(self.origin, 128, 15);

  if(isarray(nearby_ai) && nearby_ai.size >= 5) {
    self zm_stats::increment_challenge_stat(#"hash_1c0f761ca8920f0b");
  }
}