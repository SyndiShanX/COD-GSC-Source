/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\vehicle\decho.gsc
***********************************************/

#using_animtree("");

function main(var0, var1, var2) {
  scripts\common\vehicle_build::build_template("truck", var0, var1, var2);
  scripts\common\vehicle_build::build_localinit(&init_local);
  scripts\common\vehicle_build::build_deathfx("vfx/iw8/veh/scriptables/vfx_veh_explosion_sedan.vfx", undefined, "car_explode");
  scripts\common\vehicle_build::build_deathfx("vfx/iw8/veh/scriptables/shared/vfx_veh_fire_linger_lrg.vfx", "tag_origin_animate", "fire_vehicle_med_flaming", undefined, undefined, 1, 0);
  scripts\common\vehicle_build::build_deathquake(1, 1.6, 500);
  scripts\common\vehicle_build::build_deathanimations(%veh8_common_pickup_expl_lf, %veh8_common_pickup_expl_rf, $veh8_common_pickup_expl_lb, %veh8_common_pickup_expl_rb);
  scripts\common\vehicle_build::build_radiusdamage((0, 0, 0), 500, 120, 20);
  scripts\common\vehicle_build::build_drive(%veh8_common_pickup_driving_idle_forward, %veh8_common_pickup_driving_idle_backward, 10);
  scripts\common\vehicle_build::build_treadfx(var2, "sand", "vfx/iw8/level/highway/vfx_vehicle_treadfx_dust.vfx");
  scripts\common\vehicle_build::build_treadfx(var2, "dirt", "vfx/iw8/level/highway/vfx_vehicle_treadfx_dirt.vfx");
  scripts\common\vehicle_build::build_life(2500);
  scripts\common\vehicle_build::build_team("allies");
  var3 = "";
  var4 = strtok(var0, "_");
  var5 = var4[var4.size - 1];
  var6 = 0;

  if(var5 == "estate") {
    var4 = scripts\engine\utility::array_remove(var4, var5);
    var5 = var4[var4.size - 1];
  }

  if(var5 == "physics") {
    var6 = 1;
    var5 = var4[var4.size - 2];
  }

  if(var5 != "decho" && var5 != "rebel") {
    var3 = "_" + var5;
  }

  if(isendstr(var3, "dirty")) {
    var3 = getsubstr(var3, 0, var3.size - 5);
  }

  if(issubstr(var2, "rebel")) {
    scripts\common\vehicle_build::build_aianims(&setanims_rebel, &set_vehicle_anims_rebel, "decho_rebel");
    scripts\common\vehicle_build::build_unload_groups(&unload_groups_rebel);
    var7 = "veh8_civ_lnd_decho_rebel_static_dst" + var3;

    if(var6) {
      var7 += "_physics";
    }

    scripts\common\vehicle_build::build_deathmodel(var0, var7);
    scripts\common\vehicle_build::build_turret("iw8_vehicle_mg_50cal", "tag_turret", "veh8_civ_lnd_decho_rebel_mg" + var3, "auto_nonai", 0, 0);
  } else if(issubstr(var2, "rus_police")) {
    scripts\common\vehicle_build::build_aianims(&setanims, &set_vehicle_anims_police, "decho_police");
    scripts\common\vehicle_build::build_unload_groups(&unload_groups);
    scripts\common\vehicle_build::build_deathmodel(var0, "veh8_civ_lnd_decho_rus_police_static_dst");
  } else {
    scripts\common\vehicle_build::build_aianims(&setanims, &set_vehicle_anims_civ, "decho_civ");
    scripts\common\vehicle_build::build_unload_groups(&unload_groups);

    if(var6) {
      scripts\common\vehicle_build::build_deathmodel(var0, "veh8_civ_lnd_decho_static_dst_physics");
    } else {
      scripts\common\vehicle_build::build_deathmodel(var0, "veh8_civ_lnd_decho_static_dst" + var3);
    }
  }

  scripts\common\vehicle_build::build_light(var2, "headlight_truck_left", "tag_light_front_left", "vfx/iw8/veh/system/vfx_veh_sys_headlight_decho_left", "headlights");
  scripts\common\vehicle_build::build_light(var2, "headlight_truck_right", "tag_light_front_right", "vfx/iw8/veh/system/vfx_veh_sys_headlight_decho_right", "headlights");
  scripts\common\vehicle_build::build_light(var2, "brakelight_truck_right", "tag_light_back_right", "vfx/iw8/veh/system/vfx_veh_sys_taillight_decho_right", "brakelights");
  scripts\common\vehicle_build::build_light(var2, "brakelight_truck_left", "tag_light_back_left", "vfx/iw8/veh/system/vfx_veh_sys_taillight_decho_left", "brakelights");
}

function init_local() {
  self.script_badplace = 1;

  if(issubstr(self.classname, "rebel")) {
    self.vehicleanimalias = "decho";
  } else if(issubstr(self.classname, "rus_police")) {
    self.vehicleanimalias = "decho_rus_police";
  } else {
    self.vehicleanimalias = "decho_civ";
  }

  waitframe();

  if(isDefined(self.mgturret) && isDefined(self.mgturret[0])) {
    var0 = self.mgturret[0];
    var1 = spawnStruct();
    var1.startfuncs = [ &turret_playerstartfunc];
    var1.stopfuncs = [ &turret_playerstopfunc];
    var0 thread scripts\engine\utility::script_func("turret_watchPlayerUse", var1);
    var0.weapon = getcompleteweaponname(var0.weaponinfo);
    return;
  }
}

function turret_playerstartfunc() {
  level.player scripts\common\utility::allow_reload(0, "decho_turret");
  self setotherent(level.player);
  self setentityowner(level.player);
  self.owner = level.player;
  level.player remotecontrolturret(self);
}

function turret_playerstopfunc() {
  level.player scripts\common\utility::allow_reload(1, "decho_turret");
  self setotherent(undefined);
  self setentityowner(undefined);
  self.owner = undefined;
  level.player remotecontrolturretoff(self);
  var0 = self gettagangles("tag_flash");
  var1 = getclosestpointonnavmesh(self.origin + anglesToForward(var0) * 32);
  var2 = (0, var0[1], 0);
  level.player setOrigin(var1);
  level.player setplayerangles(var2);
}

function set_vehicle_anims(var0) {
  var0[0].vehicle_getoutanim = % vh_decho_driver_exit_patrol;
  var0[0].vehicle_getoutanim_clear = 0;
  var0[0].vehicle_getoutanim_combat = % vh_decho_driver_exit_combat_idle;
  var0[0].vehicle_getoutanim_combat_clear = 0;
  var0[0].vehicle_getoutanim_combat_run = % vh_decho_driver_exit_combat_run;
  var0[0].vehicle_getoutanim_combat_run_clear = 0;
  var0[1].vehicle_getoutanim = % vh_decho_pass_exit_patrol;
  var0[1].vehicle_getoutanim_clear = 0;
  var0[1].vehicle_getoutanim_combat = % vh_decho_pass_exit_combat_idle;
  var0[1].vehicle_getoutanim_combat_clear = 0;
  var0[1].vehicle_getoutanim_combat_run = % vh_decho_pass_exit_combat_run;
  var0[1].vehicle_getoutanim_combat_run_clear = 0;
  return var0;
}

function set_vehicle_anims_civ(var0) {
  set_vehicle_anims(var0);
  var0[2].vehicle_getoutanim = % vh_decho_civ_pass3_exit_patrol;
  var0[2].vehicle_getoutanim_clear = 0;
  var0[2].vehicle_getoutanim_combat = % vh_decho_civ_pass3_exit_combat_idle;
  var0[2].vehicle_getoutanim_combat_clear = 0;
  var0[2].vehicle_getoutanim_combat_run = % vh_decho_civ_pass3_exit_combat_run;
  var0[2].vehicle_getoutanim_combat_run_clear = 0;
  var0[3].vehicle_getoutanim = % vh_decho_civ_pass4_exit_patrol;
  var0[3].vehicle_getoutanim_clear = 0;
  var0[3].vehicle_getoutanim_combat = % vh_decho_civ_pass4_exit_combat_idle;
  var0[3].vehicle_getoutanim_combat_clear = 0;
  var0[3].vehicle_getoutanim_combat_run = % vh_decho_civ_pass4_exit_combat_run;
  var0[3].vehicle_getoutanim_combat_run_clear = 0;
  return var0;
}

function set_vehicle_anims_police(var0) {
  set_vehicle_anims(var0);
  var0[2].vehicle_getoutanim = % vh_decho_police_trunk_exit_patrol;
  var0[2].vehicle_getoutanim_clear = 0;
  var0[2].vehicle_getoutanim_combat = % vh_decho_police_trunk_exit_combat_idle;
  var0[2].vehicle_getoutanim_combat_clear = 0;
  var0[2].vehicle_getoutanim_combat_run = % vh_decho_police_trunk_exit_combat_run;
  var0[2].vehicle_getoutanim_combat_run_clear = 0;
  var0[3].vehicle_getoutanim = % vh_decho_trunk_exit_patrol;
  var0[3].vehicle_getoutanim_clear = 0;
  var0[3].vehicle_getoutanim_combat = % vh_decho_trunk_exit_combat_idle;
  var0[3].vehicle_getoutanim_combat_clear = 0;
  var0[3].vehicle_getoutanim_combat_run = % vh_decho_trunk_exit_combat_run;
  var0[3].vehicle_getoutanim_combat_run_clear = 0;
  return var0;
}

function set_vehicle_anims_rebel(var0) {
  set_vehicle_anims(var0);
  var0[2].vehicle_getoutanim = % vh_decho_cab1_exit_patrol;
  var0[2].vehicle_getoutanim_clear = 0;
  var0[2].vehicle_getoutanim_combat = % vh_decho_cab1_exit_combat_idle;
  var0[2].vehicle_getoutanim_combat_clear = 0;
  var0[2].vehicle_getoutanim_combat_run = % vh_decho_cab1_exit_combat_run;
  var0[2].vehicle_getoutanim_combat_run_clear = 0;
  var0[3].vehicle_getoutanim = % vh_decho_cab2_exit_patrol;
  var0[3].vehicle_getoutanim_clear = 0;
  var0[3].vehicle_getoutanim_combat = % vh_decho_cab2_exit_combat_idle;
  var0[3].vehicle_getoutanim_combat_clear = 0;
  var0[3].vehicle_getoutanim_combat_run = % vh_decho_cab2_exit_combat_run;
  var0[3].vehicle_getoutanim_combat_run_clear = 0;
  var0[4].vehicle_getoutanim = % vh_decho_trunk_exit_patrol;
  var0[4].vehicle_getoutanim_clear = 0;
  var0[4].vehicle_getoutanim_combat = % vh_decho_trunk_exit_combat_idle;
  var0[4].vehicle_getoutanim_combat_clear = 0;
  var0[4].vehicle_getoutanim_combat_run = % vh_decho_trunk_exit_combat_run;
  var0[4].vehicle_getoutanim_combat_run_clear = 0;
  return var0;
}

function setanims() {
  var0 = [];

  for(var1 = 0; var1 < 4; var1++) {
    var0 = spawnStruct();
  }

  var0[0].bhasgunwhileriding = 0;
  var0[0].sittag = "TAG_DRIVER";
  var0[1].sittag = "TAG_PASSENGER";
  var0[2].sittag = "TAG_DETACH";
  var0[3].sittag = "TAG_DETACH";
  var0[0].death_no_ragdoll = 1;
  var0[1].death_no_ragdoll = 1;
  var0[2].death_no_ragdoll = 1;
  var0[3].death_no_ragdoll = 1;
  return var0;
}

function setanims_rebel() {
  var0 = setanims();

  for(var1 = var0.size; var1 < 6; var1++) {
    var0 = spawnStruct();
    var0[var1].sittag = "TAG_DETACH";
  }

  var0 = spawnStruct();
  var0[var1].bhasgunwhileriding = 0;
  var0[var1].sittag = "TAG_TURRET";
  var0[var1].mgturret = 0;
  var0[var1].death_no_ragdoll = 1;
  return var0;
}

function unload_groups() {
  var0 = [];
  GscBinSkip0(0x2e, "all", []);
}

function unload_groups_rebel() {
  var0 = unload_groups();
  GscBinSkip0(0x2e, "all", scripts\engine\utility::array_combine(var0["all"], [4, 5, 6]));
}