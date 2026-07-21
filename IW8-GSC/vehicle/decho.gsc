/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: vehicle\decho.gsc
***********************************************/

#using_animtree("vehicles");

main(var_0, var_1, var_2) {
  scripts\common\vehicle_build::build_template("truck", var_0, var_1, var_2);
  scripts\common\vehicle_build::build_localinit(::init_local);
  scripts\common\vehicle_build::build_deathfx("vfx/iw8/veh/scriptables/vfx_veh_explosion_sedan.vfx", undefined, "car_explode");
  scripts\common\vehicle_build::build_deathfx("vfx/iw8/veh/scriptables/shared/vfx_veh_fire_linger_lrg.vfx", "tag_origin_animate", "fire_vehicle_med_flaming", undefined, undefined, 1, 0);
  scripts\common\vehicle_build::build_deathquake(1, 1.6, 500);
  scripts\common\vehicle_build::build_deathanimations(%veh8_common_pickup_expl_lf, %veh8_common_pickup_expl_rf, %veh8_common_pickup_expl_lb, %veh8_common_pickup_expl_rb);
  scripts\common\vehicle_build::build_radiusdamage((0, 0, 0), 500, 120, 20);
  scripts\common\vehicle_build::build_drive(%veh8_common_pickup_driving_idle_forward, %veh8_common_pickup_driving_idle_backward, 10);
  scripts\common\vehicle_build::build_treadfx(var_2, "sand", "vfx/iw8/level/highway/vfx_vehicle_treadfx_dust.vfx");
  scripts\common\vehicle_build::build_treadfx(var_2, "dirt", "vfx/iw8/level/highway/vfx_vehicle_treadfx_dirt.vfx");
  scripts\common\vehicle_build::build_life(2500);
  scripts\common\vehicle_build::build_team("allies");
  var_3 = "";
  var_4 = strtok(var_0, "_");
  var_5 = var_4[var_4.size - 1];
  var_6 = 0;

  if(var_5 == "estate") {
    var_4 = scripts\engine\utility::array_remove(var_4, var_5);
    var_5 = var_4[var_4.size - 1];
  }

  if(var_5 == "physics") {
    var_6 = 1;
    var_5 = var_4[var_4.size - 2];
  }

  if(var_5 != "decho" && var_5 != "rebel")
    var_3 = "_" + var_5;

  if(isendstr(var_3, "dirty"))
    var_3 = getsubstr(var_3, 0, var_3.size - 5);

  if(issubstr(var_2, "rebel")) {
    scripts\common\vehicle_build::build_aianims(::setanims_rebel, ::set_vehicle_anims_rebel, "decho_rebel");
    scripts\common\vehicle_build::build_unload_groups(::unload_groups_rebel);
    var_7 = "veh8_civ_lnd_decho_rebel_static_dst" + var_3;

    if(var_6)
      var_7 = var_7 + "_physics";

    scripts\common\vehicle_build::build_deathmodel(var_0, var_7);
    scripts\common\vehicle_build::build_turret("iw8_vehicle_mg_50cal", "tag_turret", "veh8_civ_lnd_decho_rebel_mg" + var_3, "auto_nonai", 0, 0);
  } else if(issubstr(var_2, "rus_police")) {
    scripts\common\vehicle_build::build_aianims(::setanims, ::set_vehicle_anims_police, "decho_police");
    scripts\common\vehicle_build::build_unload_groups(::unload_groups);
    scripts\common\vehicle_build::build_deathmodel(var_0, "veh8_civ_lnd_decho_rus_police_static_dst");
  } else {
    scripts\common\vehicle_build::build_aianims(::setanims, ::set_vehicle_anims_civ, "decho_civ");
    scripts\common\vehicle_build::build_unload_groups(::unload_groups);

    if(var_6)
      scripts\common\vehicle_build::build_deathmodel(var_0, "veh8_civ_lnd_decho_static_dst_physics");
    else
      scripts\common\vehicle_build::build_deathmodel(var_0, "veh8_civ_lnd_decho_static_dst" + var_3);
  }

  scripts\common\vehicle_build::build_light(var_2, "headlight_truck_left", "tag_light_front_left", "vfx/iw8/veh/system/vfx_veh_sys_headlight_decho_left", "headlights");
  scripts\common\vehicle_build::build_light(var_2, "headlight_truck_right", "tag_light_front_right", "vfx/iw8/veh/system/vfx_veh_sys_headlight_decho_right", "headlights");
  scripts\common\vehicle_build::build_light(var_2, "brakelight_truck_right", "tag_light_back_right", "vfx/iw8/veh/system/vfx_veh_sys_taillight_decho_right", "brakelights");
  scripts\common\vehicle_build::build_light(var_2, "brakelight_truck_left", "tag_light_back_left", "vfx/iw8/veh/system/vfx_veh_sys_taillight_decho_left", "brakelights");
}

init_local() {
  self.script_badplace = 1;

  if(issubstr(self.classname, "rebel"))
    self.vehicleanimalias = "decho";
  else if(issubstr(self.classname, "rus_police"))
    self.vehicleanimalias = "decho_rus_police";
  else
    self.vehicleanimalias = "decho_civ";

  waitframe();

  if(isDefined(self.mgturret) && isDefined(self.mgturret[0])) {
    var_0 = self.mgturret[0];
    var_1 = spawnStruct();
    var_1.startfuncs = [::turret_playerstartfunc];
    var_1.stopfuncs = [::turret_playerstopfunc];
    var_0 thread scripts\engine\utility::script_func("turret_watchPlayerUse", var_1);
    var_0.weapon = getcompleteweaponname(var_0.weaponinfo);
  }
}

turret_playerstartfunc() {
  level.player scripts\common\utility::allow_reload(0, "decho_turret");
  self setotherent(level.player);
  self setentityowner(level.player);
  self.owner = level.player;
  level.player remotecontrolturret(self);
}

turret_playerstopfunc() {
  level.player scripts\common\utility::allow_reload(1, "decho_turret");
  self setotherent(undefined);
  self setentityowner(undefined);
  self.owner = undefined;
  level.player remotecontrolturretoff(self);
  var_0 = self gettagangles("tag_flash");
  var_1 = getclosestpointonnavmesh(self.origin + anglesToForward(var_0) * 32);
  var_2 = (0, var_0[1], 0);
  level.player setOrigin(var_1);
  level.player setplayerangles(var_2);
}

set_vehicle_anims(var_0) {
  var_0[0].vehicle_getoutanim = % vh_decho_driver_exit_patrol;
  var_0[0].vehicle_getoutanim_clear = 0;
  var_0[0].vehicle_getoutanim_combat = % vh_decho_driver_exit_combat_idle;
  var_0[0].vehicle_getoutanim_combat_clear = 0;
  var_0[0].vehicle_getoutanim_combat_run = % vh_decho_driver_exit_combat_run;
  var_0[0].vehicle_getoutanim_combat_run_clear = 0;
  var_0[1].vehicle_getoutanim = % vh_decho_pass_exit_patrol;
  var_0[1].vehicle_getoutanim_clear = 0;
  var_0[1].vehicle_getoutanim_combat = % vh_decho_pass_exit_combat_idle;
  var_0[1].vehicle_getoutanim_combat_clear = 0;
  var_0[1].vehicle_getoutanim_combat_run = % vh_decho_pass_exit_combat_run;
  var_0[1].vehicle_getoutanim_combat_run_clear = 0;
  return var_0;
}

set_vehicle_anims_civ(var_0) {
  set_vehicle_anims(var_0);
  var_0[2].vehicle_getoutanim = % vh_decho_civ_pass3_exit_patrol;
  var_0[2].vehicle_getoutanim_clear = 0;
  var_0[2].vehicle_getoutanim_combat = % vh_decho_civ_pass3_exit_combat_idle;
  var_0[2].vehicle_getoutanim_combat_clear = 0;
  var_0[2].vehicle_getoutanim_combat_run = % vh_decho_civ_pass3_exit_combat_run;
  var_0[2].vehicle_getoutanim_combat_run_clear = 0;
  var_0[3].vehicle_getoutanim = % vh_decho_civ_pass4_exit_patrol;
  var_0[3].vehicle_getoutanim_clear = 0;
  var_0[3].vehicle_getoutanim_combat = % vh_decho_civ_pass4_exit_combat_idle;
  var_0[3].vehicle_getoutanim_combat_clear = 0;
  var_0[3].vehicle_getoutanim_combat_run = % vh_decho_civ_pass4_exit_combat_run;
  var_0[3].vehicle_getoutanim_combat_run_clear = 0;
  return var_0;
}

set_vehicle_anims_police(var_0) {
  set_vehicle_anims(var_0);
  var_0[2].vehicle_getoutanim = % vh_decho_police_trunk_exit_patrol;
  var_0[2].vehicle_getoutanim_clear = 0;
  var_0[2].vehicle_getoutanim_combat = % vh_decho_police_trunk_exit_combat_idle;
  var_0[2].vehicle_getoutanim_combat_clear = 0;
  var_0[2].vehicle_getoutanim_combat_run = % vh_decho_police_trunk_exit_combat_run;
  var_0[2].vehicle_getoutanim_combat_run_clear = 0;
  var_0[3].vehicle_getoutanim = % vh_decho_trunk_exit_patrol;
  var_0[3].vehicle_getoutanim_clear = 0;
  var_0[3].vehicle_getoutanim_combat = % vh_decho_trunk_exit_combat_idle;
  var_0[3].vehicle_getoutanim_combat_clear = 0;
  var_0[3].vehicle_getoutanim_combat_run = % vh_decho_trunk_exit_combat_run;
  var_0[3].vehicle_getoutanim_combat_run_clear = 0;
  return var_0;
}

set_vehicle_anims_rebel(var_0) {
  set_vehicle_anims(var_0);
  var_0[2].vehicle_getoutanim = % vh_decho_cab1_exit_patrol;
  var_0[2].vehicle_getoutanim_clear = 0;
  var_0[2].vehicle_getoutanim_combat = % vh_decho_cab1_exit_combat_idle;
  var_0[2].vehicle_getoutanim_combat_clear = 0;
  var_0[2].vehicle_getoutanim_combat_run = % vh_decho_cab1_exit_combat_run;
  var_0[2].vehicle_getoutanim_combat_run_clear = 0;
  var_0[3].vehicle_getoutanim = % vh_decho_cab2_exit_patrol;
  var_0[3].vehicle_getoutanim_clear = 0;
  var_0[3].vehicle_getoutanim_combat = % vh_decho_cab2_exit_combat_idle;
  var_0[3].vehicle_getoutanim_combat_clear = 0;
  var_0[3].vehicle_getoutanim_combat_run = % vh_decho_cab2_exit_combat_run;
  var_0[3].vehicle_getoutanim_combat_run_clear = 0;
  var_0[4].vehicle_getoutanim = % vh_decho_trunk_exit_patrol;
  var_0[4].vehicle_getoutanim_clear = 0;
  var_0[4].vehicle_getoutanim_combat = % vh_decho_trunk_exit_combat_idle;
  var_0[4].vehicle_getoutanim_combat_clear = 0;
  var_0[4].vehicle_getoutanim_combat_run = % vh_decho_trunk_exit_combat_run;
  var_0[4].vehicle_getoutanim_combat_run_clear = 0;
  return var_0;
}

setanims() {
  var_0 = [];

  for(var_1 = 0; var_1 < 4; var_1++)
    var_0[var_1] = spawnStruct();

  var_0[0].bhasgunwhileriding = 0;
  var_0[0].sittag = "TAG_DRIVER";
  var_0[1].sittag = "TAG_PASSENGER";
  var_0[2].sittag = "TAG_DETACH";
  var_0[3].sittag = "TAG_DETACH";
  var_0[0].death_no_ragdoll = 1;
  var_0[1].death_no_ragdoll = 1;
  var_0[2].death_no_ragdoll = 1;
  var_0[3].death_no_ragdoll = 1;
  return var_0;
}

setanims_rebel() {
  var_0 = setanims();

  for(var_1 = var_0.size; var_1 < 6; var_1++) {
    var_0[var_1] = spawnStruct();
    var_0[var_1].sittag = "TAG_DETACH";
  }

  var_0[var_1] = spawnStruct();
  var_0[var_1].bhasgunwhileriding = 0;
  var_0[var_1].sittag = "TAG_TURRET";
  var_0[var_1].mgturret = 0;
  var_0[var_1].death_no_ragdoll = 1;
  return var_0;
}

unload_groups() {
  var_0 = [];
  var_0["all"] = [];
  var_0["passengers"] = [];
  var_0["default"] = [];
  var_0["all"] = [0, 1, 2, 3];
  var_0["passengers"] = [1, 2, 3];
  var_0["default"] = var_0["all"];
  return var_0;
}

unload_groups_rebel() {
  var_0 = unload_groups();
  var_0["all"] = scripts\engine\utility::array_combine(var_0["all"], [4, 5, 6]);
  var_0["passengers"] = scripts\engine\utility::array_combine(var_0["passengers"], [4, 5]);
  var_0["default"] = var_0["all"];
  return var_0;
}