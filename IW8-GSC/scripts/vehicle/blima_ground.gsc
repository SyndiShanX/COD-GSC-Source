/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\vehicle\blima_ground.gsc
***********************************************/

function main(var_0, var_1, var_2) {
  scripts\common\vehicle_build::build_template("blima", var_0, var_1, var_2);
  scripts\common\vehicle_build::build_localinit(&init_local);
  scripts\common\vehicle_build::build_deathmodel("veh8_mil_air_blima");
  var_3 = [];
  GscBinSkip0(0x2e, "vehicle_battle_hind", "vfx/core/expl/helicopter_explosion_hind_chernobyl.vfx");
}

function setup_lights(var_0) {}

function init_local() {
  self.unload_hover_offset = 170;
  self.script_badplace = 0;
  scripts\common\vehicle::vehicle_lights_on("running");
  self.vehicleanimalias = "blima_ground";
  thread handle_scriptable_vfx();

  if(self.classname == "script_vehicle_blima_hi_res") {
    self attach("veh8_mil_air_blima_interior_vm");
    return;
  }
}

function handle_scriptable_vfx() {
  self endon("death");

  if(scripts\common\utility::issp() || scripts\common\utility::iscp()) {
    scripts\engine\utility::flag_wait("scriptables_ready");
    self setscriptablepartstate("engine", "on");
    return;
  }
}

#using_animtree("");

function setanims() {
  var_0 = [];

  for(var_1 = 0; var_1 < 8; var_1++) {
    var_0 = spawnStruct();
  }

  var_0[0].idle = % vh_blima_rappel_pilot;
  var_0[0].idle_anim = "vh_blima_rappel_pilot";
  var_0[1].idle = $vh_blima_rappel_copilot;
  var_0[1].idle_anim = "vh_blima_rappel_copilot";
  var_0[2].idle = % sdr_mp_veh_blima_ground_l1_idle;
  var_0[3].idle = % sdr_mp_veh_blima_ground_l2_idle;
  var_0[4].idle = % sdr_mp_veh_blima_ground_l3_idle;
  var_0[5].idle = % sdr_mp_veh_blima_ground_r1_idle;
  var_0[6].idle = % sdr_mp_veh_blima_ground_r2_idle;
  var_0[7].idle = % sdr_mp_veh_blima_ground_r3_idle;
  var_0[0].sittag = "tag_pilot1";
  var_0[1].sittag = "tag_pilot2";
  var_0[2].sittag = "tag_guy0";
  var_0[3].sittag = "tag_guy1";
  var_0[4].sittag = "tag_guy2";
  var_0[5].sittag = "tag_guy3";
  var_0[6].sittag = "tag_guy4";
  var_0[7].sittag = "tag_guy6";
  var_0[2].getout = % sdr_mp_veh_blima_ground_l1_exit;
  var_0[3].getout = % sdr_mp_veh_blima_ground_l2_exit;
  var_0[4].getout = % sdr_mp_veh_blima_ground_l3_exit;
  var_0[5].getout = % sdr_mp_veh_blima_ground_r1_exit;
  var_0[6].getout = % sdr_mp_veh_blima_ground_r2_exit;
  var_0[7].getout = % sdr_mp_veh_blima_ground_r3_exit;
  return var_0;
}

#using_animtree("vehicles");

function set_vehicle_anims(var_0) {
  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_0[var_1].vehicle_getoutanim = % vh_blima_rappel_heli_drop;
  }

  return var_0;
}

function unload_groups() {
  var_0 = [];
  GscBinSkip0(0x2e, "left", []);
}