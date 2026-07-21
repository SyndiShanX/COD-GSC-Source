/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: vehicle\vindia.gsc
***********************************************/

#using_animtree("vehicles");

main(var_0, var_1, var_2) {
  scripts\common\vehicle_build::build_template("vindia", var_0, var_1, var_2);
  scripts\common\vehicle_build::build_localinit(::init_local);
  scripts\common\vehicle_build::build_deathfx("vfx/iw8_mp/killstreak/vfx_tank_death_exp.vfx", "tag_origin", "veh_gen_armored_expl_destr");
  scripts\common\vehicle_build::build_deathfx("vfx/iw8/level/lab/vfx_temp_lrg_veh_death.vfx", "tag_origin");
  scripts\common\vehicle_build::build_deathquake(1, 1.6, 500);
  scripts\common\vehicle_build::build_radiusdamage((0, 0, 0), 500, 120, 20);
  scripts\common\vehicle_build::build_drive(%vh_apc_driving_idle_forward, %vh_apc_driving_idle_backward, 10);
  scripts\common\vehicle_build::build_life(999, 500, 1500);
  scripts\common\vehicle_build::build_team("axis");
  scripts\common\vehicle_build::build_aianims(::setanims, ::set_vehicle_anims, "vindia");
  scripts\common\vehicle_build::build_unload_groups(::unload_groups);

  if(issubstr(var_2, "_a1")) {
    level._effect["vindia_turret_spot"] = loadfx("vfx/iw8/veh/light/vfx_vindia_turret_light.vfx");
    scripts\common\vehicle_build::build_deathmodel(var_0, "veh8_mil_lnd_vindia_a1_dst");
    scripts\common\vehicle_build::build_mainturret("tur_bradley", "tag_turret", "veh8_mil_lnd_vindia_a1_turret", "auto_nonai", 0, 0);
    scripts\common\vehicle_build::build_turret("tur_gun_lighttank", "tag_turret", "veh8_civ_lnd_decho_rebel_mg", "auto_nonai", 0, 0, (0, 0, 0), undefined, 1);
  } else {
    scripts\common\vehicle_build::build_deathmodel(var_0, "veh8_mil_lnd_vindia_a2_dst");
    scripts\common\vehicle_build::build_turret("tur_gun_lighttank", "tag_turret", "veh8_civ_lnd_decho_rebel_mg", "auto_nonai", 0, 0, (0, 0, 0), undefined);
  }

  scripts\common\vehicle_build::build_deathanimations(%veh8_common_pickup_expl_tag_origin_3, %veh8_common_pickup_expl_tag_origin_3, %veh8_common_pickup_expl_tag_origin_3, %veh8_common_pickup_expl_tag_origin_3);
  scripts\common\vehicle_build::build_treadfx(var_2, "sand", "vfx/iw8/level/highway/vfx_vehicle_treadfx_dust.vfx");
  scripts\common\vehicle_build::build_treadfx(var_2, "dirt", "vfx/iw8/level/highway/vfx_vehicle_treadfx_dirt.vfx");
  scripts\common\vehicle_build::build_light(var_2, "headlight_L", "tag_light_front_left", "vfx/misc/car_headlight_truck_L", "headlights", 0.0);
  scripts\common\vehicle_build::build_light(var_2, "headlight_R", "tag_light_front_right", "vfx/misc/car_headlight_truck_R", "headlights", 0.0);
  scripts\common\vehicle_build::build_light(var_2, "brakelight_L", "tag_light_back_left", "vfx/misc/car_brakelight_truck_L", "headlights", 0.0);
  scripts\common\vehicle_build::build_light(var_2, "brakelight_R", "tag_light_back_right", "vfx/misc/car_brakelight_truck_R", "headlights", 0.0);
}

init_local() {
  self.vehicle_skipdeathphysics = 1;
  self.vehicleanimalias = "vindia";
  scripts\engine\utility::ent_flag_init("no_riders_until_unload");

  if(self.classname == "script_vehicle_iw8_vindia_a1")
    thread setup_turret_a1();
  else
    thread setup_turret_a2();
}

setup_turret_a1() {
  self.script_turretmain = 0;
  self.script_turretmg = 0;

  while(!isDefined(self.mgturret))
    waitframe();

  self.mainturret makeunusable();
  playFXOnTag(scripts\engine\utility::getfx("vindia_turret_spot"), self.mainturret, "tag_front_turret_light");

  if(!isDefined(self.mainturret.script_delay_min))
    self.mainturret.script_delay_min = 1.0;

  if(!isDefined(self.mainturret.script_delay_max))
    self.mainturret.script_delay_max = 3;

  if(!isDefined(self.mainturret.script_burst_min))
    self.mainturret.script_burst_min = 0.75;

  if(!isDefined(self.mainturret.script_burst_max))
    self.mainturret.script_burst_max = 2;

  if(!isDefined(self.mainturret.script_burst_fire_rate))
    self.mainturret.script_burst_fire_rate = 0.25;
}

setup_turret_a2() {}

#using_animtree("generic_human");

setanims() {
  var_0 = [];

  for(var_1 = 0; var_1 < 6; var_1++) {
    var_0[var_1] = spawnStruct();
    var_0[var_1].sittag = "tag_detach";
  }

  var_0[0].idle = % reb_vh_vindia_guy1_idle_search01;
  var_0[1].idle = % reb_vh_vindia_guy2_idle_search01;
  var_0[2].idle = % reb_vh_vindia_guy3_idle_search01;
  var_0[3].idle = % reb_vh_vindia_guy4_idle_search01;
  var_0[4].idle = % reb_vh_vindia_guy5_idle_search01;
  var_0[5].idle = % reb_vh_vindia_guy6_idle_search01;
  var_0[0].getout = % reb_vh_vindia_guy1_exit_combat_idle;
  var_0[1].getout = % reb_vh_vindia_guy2_exit_combat_idle;
  var_0[2].getout = % reb_vh_vindia_guy3_exit_combat_idle;
  var_0[3].getout = % reb_vh_vindia_guy4_exit_combat_idle;
  var_0[4].getout = % reb_vh_vindia_guy5_exit_combat_idle;
  var_0[5].getout = % reb_vh_vindia_guy6_exit_combat_idle;
  return var_0;
}

#using_animtree("vehicles");

set_vehicle_anims(var_0) {
  var_0[0].vehicle_getoutanim = % vh_vindia_back_door_exit_combat_idle;
  var_0[0].vehicle_getoutanim_clear = 0;
  var_0[4].vehicle_getoutanim = % vh_vindia_left_door_exit_combat_idle;
  var_0[4].vehicle_getoutanim_clear = 0;
  var_0[5].vehicle_getoutanim = % vh_vindia_right_door_exit_combat_idle;
  var_0[5].vehicle_getoutanim_clear = 0;
  return var_0;
}

unload_groups() {
  var_0 = [];
  var_1 = "all";
  var_0[var_1] = [];
  var_0[var_1][var_0[var_1].size] = 0;
  var_0[var_1][var_0[var_1].size] = 1;
  var_0[var_1][var_0[var_1].size] = 2;
  var_0[var_1][var_0[var_1].size] = 3;
  var_0[var_1][var_0[var_1].size] = 4;
  var_0[var_1][var_0[var_1].size] = 5;
  var_1 = "left";
  var_0[var_1] = [];
  var_0[var_1][var_0[var_1].size] = 0;
  var_0[var_1][var_0[var_1].size] = 1;
  var_1 = "right";
  var_0[var_1] = [];
  var_0[var_1][var_0[var_1].size] = 2;
  var_0[var_1][var_0[var_1].size] = 3;
  var_1 = "back";
  var_0[var_1] = [];
  var_0[var_1][var_0[var_1].size] = 4;
  var_0[var_1][var_0[var_1].size] = 5;
  var_0["default"] = var_0["all"];
  return var_0;
}

mainturret_attack() {
  scripts\common\vehicle_code::_mainturreton();
  self.mainturret thread scripts\engine\utility::script_func("burst_fire_unmanned");
}

mainturret_idle() {
  scripts\common\vehicle_code::_mainturretoff();
  self.mainturret notify("stop_burst_fire_unmanned");
}