/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\vehicle.gsc
***********************************************/

function init_vehicles() {
  scripts\engine\utility::create_func_ref("fastrope_anim", &fastrope_anim);
  scripts\engine\utility::create_func_ref("vehicle_door_anim", &matchdata_logweaponstat);
  scripts\common\vehicle::init_vehicles();
}

function fastrope_anim(var0, var1, var2) {
  var0 dontinterpolate();
  var0 scriptmodelclearanim();
  var0 scriptmodelplayanimdeltamotionfrompos(getanimname(var1), var0.origin, var0.angles, var2);
}

function matchdata_logweaponstat(var0, var1) {
  if(isDefined(var0)) {
    var0 vehicleplayanim(var1, 0);
    return;
  }
}

function ref_1422b() {
  scripts\engine\utility::create_func_ref("set_vehicle_anims_apc", &ref_1310b);
  scripts\engine\utility::create_func_ref("set_vehicle_anims_asierra", &ref_1310c);
  scripts\engine\utility::create_func_ref("set_vehicle_anims_blima", &ref_1310d);
  scripts\engine\utility::create_func_ref("set_vehicle_anims_decho_civ", &ref_1310f);
  scripts\engine\utility::create_func_ref("set_vehicle_anims_decho_police", &ref_13110);
  scripts\engine\utility::create_func_ref("set_vehicle_anims_decho_rebel", &ref_13111);
  scripts\engine\utility::create_func_ref("set_vehicle_anims_mkilo", &ref_13112);
  scripts\engine\utility::create_func_ref("set_vehicle_anims_mkilo23_ai_infil", &ref_13113);
  scripts\engine\utility::create_func_ref("set_vehicle_anims_skilo", &ref_13116);
  scripts\engine\utility::create_func_ref("set_vehicle_anims_techo", &ref_13117);
  scripts\engine\utility::create_func_ref("set_vehicle_anims_tromeo", &ref_13118);
  scripts\engine\utility::create_func_ref("set_vehicle_anims_umike", &ref_13119);
  scripts\engine\utility::create_func_ref("set_vehicle_anims_vindia", &ref_1311a);
  scripts\engine\utility::create_func_ref("set_vehicle_anims_ralfa", &ref_13115);
  scripts\engine\utility::create_func_ref("use_turret", &ref_1405e);
}

#using_animtree("");

function ref_1310b(var0) {
  var0[0].vehicle_getoutanim = % vh_apc_org_unload_door_l;
  var0[0].vehicle_getoutanim_clear = 0;
  var0[2].vehicle_getoutanim = $vh_apc_org_unload_door_r;
  var0[2].vehicle_getoutanim_clear = 0;
  var0[4].vehicle_getoutanim = % vh_apc_org_unload_door_back;
  var0[4].vehicle_getoutanim_clear = 0;
  return var0;
}

function ref_1310c(var0) {
  var0[0].vehicle_getoutanim = % vh_asierra_driver_exit_patrol;
  var0[0].vehicle_getoutanim_clear = 0;
  var0[0].vehicle_getoutanim_combat = % vh_asierra_driver_exit_combat_idle;
  var0[0].vehicle_getoutanim_combat_clear = 0;
  var0[0].vehicle_getoutanim_combat_run = % vh_asierra_driver_exit_combat_run;
  var0[0].vehicle_getoutanim_combat_run_clear = 0;
  var0[1].vehicle_getoutanim = % vh_asierra_pass_exit_patrol;
  var0[1].vehicle_getoutanim_clear = 0;
  var0[1].vehicle_getoutanim_combat = % vh_asierra_pass_exit_combat_idle;
  var0[1].vehicle_getoutanim_combat_clear = 0;
  var0[1].vehicle_getoutanim_combat_run = % vh_asierra_pass_exit_combat_run;
  var0[1].vehicle_getoutanim_combat_run_clear = 0;
  var0[7].vehicle_getoutanim = % vh_asierra_bed_exit_patrol;
  var0[7].vehicle_getoutanim_clear = 0;
  var0[7].vehicle_getoutanim_combat = % vh_asierra_bed_exit_combat_idle;
  var0[7].vehicle_getoutanim_combat_clear = 0;
  var0[7].vehicle_getoutanim_combat_run = % vh_asierra_bed_exit_combat_idle;
  var0[7].vehicle_getoutanim_combat_run_clear = 0;
  return var0;
}

function ref_1310d(var0) {
  for(var1 = 0; var1 < var0.size; var1++) {
    var0[var1].vehicle_getoutanim = % vh_blima_rappel_heli_drop;
  }

  return var0;
}

function ref_13112(var0) {
  var0[0].vehicle_getoutanim = % vh_mkilo_driver_exit_patrol;
  var0[0].vehicle_getoutanim_clear = 0;
  var0[0].vehicle_getoutanim_combat = % vh_mkilo_driver_exit_combat_idle;
  var0[0].vehicle_getoutanim_combat_clear = 0;
  var0[0].vehicle_getoutanim_combat_run = % vh_mkilo_driver_exit_combat_run;
  var0[0].vehicle_getoutanim_combat_run_clear = 0;
  var0[1].vehicle_getoutanim = % vh_mkilo_pass_exit_patrol;
  var0[1].vehicle_getoutanim_clear = 0;
  var0[1].vehicle_getoutanim_combat = % vh_mkilo_pass_exit_combat_idle;
  var0[1].vehicle_getoutanim_combat_clear = 0;
  var0[1].vehicle_getoutanim_combat_run = % vh_mkilo_pass_exit_combat_run;
  var0[1].vehicle_getoutanim_combat_run_clear = 0;
  return var0;
}

function ref_13113(var0) {
  var0[0].vehicle_getoutanim = % vh_mkilo_driver_exit_patrol;
  var0[0].vehicle_getoutanim_clear = 0;
  var0[0].vehicle_getoutanim_combat = % vh_mkilo_driver_exit_combat_idle;
  var0[0].vehicle_getoutanim_combat_clear = 0;
  var0[0].vehicle_getoutanim_combat_run = % vh_mkilo_driver_exit_combat_run;
  var0[0].vehicle_getoutanim_combat_run_clear = 0;
  var0[1].vehicle_getoutanim = % vh_mkilo_pass_exit_patrol;
  var0[1].vehicle_getoutanim_clear = 0;
  var0[1].vehicle_getoutanim_combat = % vh_mkilo_pass_exit_combat_idle;
  var0[1].vehicle_getoutanim_combat_clear = 0;
  var0[1].vehicle_getoutanim_combat_run = % vh_mkilo_pass_exit_combat_run;
  var0[1].vehicle_getoutanim_combat_run_clear = 0;
  var0[2].vehicle_getoutanim = % vh_mp_mkilo23_backgate_exit;
  var0[2].vehicle_getoutanim_clear = 0;
  var0[3].vehicle_getoutanim = % vh_mp_mkilo23_backgate_exit;
  var0[3].vehicle_getoutanim_clear = 0;
  var0[4].vehicle_getoutanim = % vh_mp_mkilo23_backgate_exit;
  var0[4].vehicle_getoutanim_clear = 0;
  var0[5].vehicle_getoutanim = % vh_mp_mkilo23_backgate_exit;
  var0[5].vehicle_getoutanim_clear = 0;
  var0[6].vehicle_getoutanim = % vh_mp_mkilo23_backgate_exit;
  var0[6].vehicle_getoutanim_clear = 0;
  var0[7].vehicle_getoutanim = % vh_mp_mkilo23_backgate_exit;
  var0[7].vehicle_getoutanim_clear = 0;
  var0[8].vehicle_getoutanim = % vh_mp_mkilo23_backgate_exit;
  var0[8].vehicle_getoutanim_clear = 0;
  var0[9].vehicle_getoutanim = % vh_mp_mkilo23_backgate_exit;
  var0[9].vehicle_getoutanim_clear = 0;
  var0[10].vehicle_getoutanim = % vh_mp_mkilo23_backgate_exit;
  var0[10].vehicle_getoutanim_clear = 0;
  var0[11].vehicle_getoutanim = % vh_mp_mkilo23_backgate_exit;
  var0[11].vehicle_getoutanim_clear = 0;
  var0[12].vehicle_getoutanim = % vh_mp_mkilo23_backgate_exit;
  var0[12].vehicle_getoutanim_clear = 0;
  var0[13].vehicle_getoutanim = % vh_mp_mkilo23_backgate_exit;
  var0[13].vehicle_getoutanim_clear = 0;
  return var0;
}

function ref_13116(var0) {
  var0[0].vehicle_getoutanim = % vh_skilo_driver_exit_patrol;
  var0[0].vehicle_getoutanim_clear = 0;
  var0[0].vehicle_getoutanim_combat = % vh_skilo_driver_exit_combat_idle;
  var0[0].vehicle_getoutanim_combat_clear = 0;
  var0[0].vehicle_getoutanim_combat_run = % vh_skilo_driver_exit_combat_run;
  var0[0].vehicle_getoutanim_combat_run_clear = 0;
  var0[1].vehicle_getoutanim = % vh_skilo_passenger_exit_patrol;
  var0[1].vehicle_getoutanim_clear = 0;
  var0[1].vehicle_getoutanim_combat = % vh_skilo_passenger_exit_combat_idle;
  var0[1].vehicle_getoutanim_combat_clear = 0;
  var0[1].vehicle_getoutanim_combat_run = % vh_skilo_passenger_exit_combat_run;
  var0[1].vehicle_getoutanim_combat_run_clear = 0;
  var0[2].vehicle_getoutanim = % vh_skilo_pass3_exit_patrol;
  var0[2].vehicle_getoutanim_clear = 0;
  var0[2].vehicle_getoutanim_combat = % vh_skilo_pass3_exit_combat_idle;
  var0[2].vehicle_getoutanim_combat_clear = 0;
  var0[2].vehicle_getoutanim_combat_run = % vh_skilo_pass3_exit_combat_run;
  var0[2].vehicle_getoutanim_combat_run_clear = 0;
  return var0;
}

function ref_13117(var0) {
  var0[0].vehicle_getoutanim = % vh_techo_driver_exit_patrol;
  var0[0].vehicle_getoutanim_clear = 0;
  var0[0].vehicle_getoutanim_combat = % vh_techo_driver_exit_combat_idle;
  var0[0].vehicle_getoutanim_combat_clear = 0;
  var0[0].vehicle_getoutanim_combat_run = % vh_techo_driver_exit_combat_run;
  var0[0].vehicle_getoutanim_combat_run_clear = 0;
  var0[1].vehicle_getoutanim = % vh_techo_pass_exit_patrol;
  var0[1].vehicle_getoutanim_clear = 0;
  var0[1].vehicle_getoutanim_combat = % vh_techo_pass_exit_combat_idle;
  var0[1].vehicle_getoutanim_combat_clear = 0;
  var0[1].vehicle_getoutanim_combat_run = % vh_techo_pass_exit_combat_run;
  var0[1].vehicle_getoutanim_combat_run_clear = 0;
  var0[2].vehicle_getoutanim = % vh_techo_cab2_exit_patrol;
  var0[2].vehicle_getoutanim_clear = 0;
  var0[2].vehicle_getoutanim_combat = % vh_techo_cab2_exit_combat_idle;
  var0[2].vehicle_getoutanim_combat_clear = 0;
  var0[2].vehicle_getoutanim_combat_run = % vh_techo_cab2_exit_combat_run;
  var0[2].vehicle_getoutanim_combat_run_clear = 0;
  var0[3].vehicle_getoutanim = % vh_techo_cab1_exit_patrol;
  var0[3].vehicle_getoutanim_clear = 0;
  var0[3].vehicle_getoutanim_combat = % vh_techo_cab1_exit_combat_idle;
  var0[3].vehicle_getoutanim_combat_clear = 0;
  var0[3].vehicle_getoutanim_combat_run = % vh_techo_cab1_exit_combat_run;
  var0[3].vehicle_getoutanim_combat_run_clear = 0;
  var0[0].vehicle_getinanim = % reb_com_veh8_techo_fl_door_close;
  var0[0].vehicle_getinanim_clear = 0;
  var0[1].vehicle_getinanim = % reb_com_veh8_techo_fr_door_close;
  var0[1].vehicle_getinanim_clear = 0;
  var0[2].vehicle_getinanim = % reb_com_veh8_techo_bl_door_close;
  var0[2].vehicle_getinanim_clear = 0;
  var0[3].vehicle_getinanim = % reb_com_veh8_techo_br_door_close;
  var0[3].vehicle_getinanim_clear = 0;
  return var0;
}

function ref_1310e(var0) {
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

function ref_1310f(var0) {
  ref_1310e(var0);
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

function ref_13110(var0) {
  ref_1310e(var0);
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

function ref_13111(var0) {
  ref_1310e(var0);
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

function ref_13118(var0) {
  var0[0].vehicle_getoutanim = % vh_tromeo_front_exit_patrol;
  var0[0].vehicle_getoutanim_clear = 0;
  var0[0].vehicle_getoutanim_combat = % vh_tromeo_front_exit_combat_idle;
  var0[0].vehicle_getoutanim_combat_clear = 0;
  var0[0].vehicle_getoutanim_combat_run = % vh_tromeo_front_exit_combat_run;
  var0[0].vehicle_getoutanim_combat_run_clear = 0;
  var0[2].vehicle_getoutanim = % reb_com_veh8_techo_br_door_open;
  var0[2].vehicle_getoutanim_clear = 0;
  var0[3].vehicle_getoutanim = % reb_com_veh8_techo_bl_door_open;
  var0[3].vehicle_getoutanim_clear = 0;
  var0[0].vehicle_getinanim = % reb_com_veh8_techo_fl_door_close;
  var0[0].vehicle_getinanim_clear = 0;
  var0[1].vehicle_getinanim = % reb_com_veh8_techo_fr_door_close;
  var0[1].vehicle_getinanim_clear = 0;
  var0[2].vehicle_getinanim = % reb_com_veh8_techo_br_door_close;
  var0[2].vehicle_getinanim_clear = 0;
  var0[3].vehicle_getinanim = % reb_com_veh8_techo_bl_door_close;
  var0[3].vehicle_getinanim_clear = 0;
  return var0;
}

function ref_13119(var0) {
  var0[0].vehicle_getoutanim = % vh_umike_driver_exit_patrol;
  var0[0].vehicle_getoutanim_clear = 0;
  var0[0].vehicle_getoutanim_combat = % vh_umike_driver_exit_combat_idle;
  var0[0].vehicle_getoutanim_combat_clear = 0;
  var0[0].vehicle_getoutanim_combat_run = % vh_umike_driver_exit_combat_run;
  var0[0].vehicle_getoutanim_combat_run_clear = 0;
  var0[1].vehicle_getoutanim = % vh_umike_passenger_exit_patrol;
  var0[1].vehicle_getoutanim_clear = 0;
  var0[1].vehicle_getoutanim_combat = % vh_umike_passenger_exit_combat_idle;
  var0[1].vehicle_getoutanim_combat_clear = 0;
  var0[1].vehicle_getoutanim_combat_run = % vh_umike_passenger_exit_combat_run;
  var0[1].vehicle_getoutanim_combat_run_clear = 0;
  var0[2].vehicle_getoutanim = % vh_umike_bed_exit_combat_idle;
  var0[2].vehicle_getoutanim_clear = 0;
  return var0;
}

function ref_1311a(var0) {
  var0[0].vehicle_getoutanim = % vh_vindia_back_door_exit_combat_idle;
  var0[0].vehicle_getoutanim_clear = 0;
  var0[4].vehicle_getoutanim = % vh_vindia_left_door_exit_combat_idle;
  var0[4].vehicle_getoutanim_clear = 0;
  var0[5].vehicle_getoutanim = % vh_vindia_right_door_exit_combat_idle;
  var0[5].vehicle_getoutanim_clear = 0;
  return var0;
}

function ref_13114(var0) {
  var0[0].vehicle_getoutanim = % reb_com_veh8_decho_fl_door_open;
  var0[0].vehicle_getoutanim_clear = 0;
  var0[1].vehicle_getoutanim = % reb_com_veh8_decho_fr_door_open;
  var0[1].vehicle_getoutanim_clear = 0;
  return var0;
}

function ref_13115(var0) {
  var0[0].vehicle_getoutanim = % reb_com_veh8_techo_fl_door_open;
  var0[0].vehicle_getoutanim_clear = 0;
  var0[1].vehicle_getoutanim = % reb_com_veh8_techo_fr_door_open;
  var0[1].vehicle_getoutanim_clear = 0;
  var0[0].vehicle_getinanim = % reb_com_veh8_techo_fl_door_close;
  var0[0].vehicle_getinanim_clear = 0;
  var0[1].vehicle_getinanim = % reb_com_veh8_techo_fr_door_close;
  var0[1].vehicle_getinanim_clear = 0;
  return var0;
}

function ref_1405e(var0, var1) {
  scripts\asm\asm_bb::bb_requestturret(var0);
  scripts\asm\asm_bb::bb_requestturretpose(var1);
  var3 = var0 gettagorigin("tag_gunner");
  var4 = var0 gettagangles("tag_gunner");

  if(self islinked()) {
    self unlink();
  }

  self forceteleport(var3, var4);
  self linktoblendtotag(var0, "tag_gunner", 0);
}