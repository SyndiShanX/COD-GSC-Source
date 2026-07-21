/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: common\lbravo_ai_infil.gsc
***********************************************/

#using_animtree("vehicles");

main(var_0, var_1, var_2) {
  scripts\common\vehicle_build::build_template("lbravo", var_0, var_1, var_2);
  scripts\common\vehicle_build::build_localinit(::init_local);
  scripts\common\vehicle_build::build_deathmodel("veh8_mil_air_lbravo");
  scripts\common\vehicle_build::build_deathfx("vfx/core/expl/helicopter_explosion_little_bird.vfx", "tag_origin", "rocket_explode", undefined, undefined, undefined, 0.2, 1, undefined);
  scripts\common\vehicle_build::build_rocket_deathfx("vfx/iw8/prop/scriptables/vfx_vh8_mil_air_lbravo_debris.vfx", "tag_origin", "exp_helicopter_fuel", undefined, undefined, 0, randomfloatrange(1.5, 3), 0);
  scripts\common\vehicle_build::build_treadfx(var_2, "default", "vfx/code/tread/heli_dust_default.vfx", 1);
  scripts\common\vehicle_build::build_life(800);
  scripts\common\vehicle_build::build_team("axis");
  scripts\common\vehicle_build::build_aianims(::setanims);
  scripts\common\vehicle_build::build_unload_groups(::unload_groups);
  scripts\common\vehicle_build::build_bulletshield(1);
  scripts\common\vehicle_build::build_is_helicopter();

  if(scripts\common\utility::issp())
    scripts\common\vehicle_build::build_drive(%mi28_rotors, undefined, 0, 3.0);
  else
    scripts\common\vehicle_build::build_drive(%bh_rotors, undefined, 0, 3.0);
}

init_local() {
  self.unload_land_offset = 112;
  self.unload_hover_offset = 120;
  self.script_badplace = 1;
  scripts\common\vehicle::vehicle_lights_on("running");
  thread handle_scriptable_vfx();
  self.vehicleanimalias = "lbravo_ai_infil";
  self.vehicledisableturningwhileshooting = 1;
}

handle_scriptable_vfx() {
  self endon("death");

  if(scripts\common\utility::issp() || scripts\common\utility::iscp()) {
    scripts\engine\utility::flag_wait("scriptables_ready");
    self setscriptablepartstate("engine", "on");
  }
}

#using_animtree("generic_human");

setanims() {
  var_0 = [];

  for(var_1 = 0; var_1 < 8; var_1++)
    var_0[var_1] = spawnStruct();

  var_0[0].canshootinvehicle = 0;
  var_0[1].canshootinvehicle = 0;
  var_0[2].canshootinvehicle = 1;
  var_0[3].canshootinvehicle = 1;
  var_0[4].canshootinvehicle = 1;
  var_0[5].canshootinvehicle = 1;
  var_0[6].canshootinvehicle = 1;
  var_0[7].canshootinvehicle = 1;
  var_0[0].idle = % vh_blima_rappel_pilot;
  var_0[0].idle_anim = "vh_blima_rappel_pilot";
  var_0[1].idle = % vh_blima_rappel_copilot;
  var_0[1].idle_anim = "vh_blima_rappel_copilot";
  var_0[2].idle = % sdr_mp_veh_lbravo_ground_l1_idle;
  var_0[3].idle = % sdr_mp_veh_lbravo_ground_l2_idle;
  var_0[4].idle = % sdr_mp_veh_lbravo_ground_l3_idle;
  var_0[5].idle = % sdr_mp_veh_lbravo_ground_r1_idle;
  var_0[6].idle = % sdr_mp_veh_lbravo_ground_r2_idle;
  var_0[7].idle = % sdr_mp_veh_lbravo_ground_r3_idle;
  var_0[0].sittag = "tag_pilot1";
  var_0[1].sittag = "tag_pilot2";
  var_0[2].sittag = "tag_passenger1";
  var_0[3].sittag = "tag_passenger2";
  var_0[4].sittag = "tag_passenger3";
  var_0[5].sittag = "tag_passenger4";
  var_0[6].sittag = "tag_passenger5";
  var_0[7].sittag = "tag_passenger6";
  var_0[2].getout = % sdr_mp_veh_lbravo_ground_l1_exit;
  var_0[3].getout = % sdr_mp_veh_lbravo_ground_l2_exit;
  var_0[4].getout = % sdr_mp_veh_lbravo_ground_l3_exit;
  var_0[5].getout = % sdr_mp_veh_lbravo_ground_r1_exit;
  var_0[6].getout = % sdr_mp_veh_lbravo_ground_r2_exit;
  var_0[7].getout = % sdr_mp_veh_lbravo_ground_r3_exit;
  level.scr_animtree["lbravo_ai_infil_solider"] = #animtree;
  level.scr_anim["lbravo_ai_infil_solider"]["sdr_mp_veh_lbravo_ground_l1_idle"] = % sdr_mp_veh_lbravo_ground_l1_idle;
  level.scr_animname["lbravo_ai_infil_solider"]["sdr_mp_veh_lbravo_ground_l1_idle"] = "sdr_mp_veh_lbravo_ground_l1_idle";
  level.animlength["lbravo_ai_infil_solider"]["sdr_mp_veh_lbravo_ground_l1_idle"] = getanimlength(level.scr_anim["lbravo_ai_infil_solider"]["sdr_mp_veh_lbravo_ground_l1_idle"]);
  level.scr_anim["lbravo_ai_infil_solider"]["sdr_mp_veh_lbravo_ground_l2_idle"] = % sdr_mp_veh_lbravo_ground_l2_idle;
  level.scr_animname["lbravo_ai_infil_solider"]["sdr_mp_veh_lbravo_ground_l2_idle"] = "sdr_mp_veh_lbravo_ground_l2_idle";
  level.animlength["lbravo_ai_infil_solider"]["sdr_mp_veh_lbravo_ground_l2_idle"] = getanimlength(level.scr_anim["lbravo_ai_infil_solider"]["sdr_mp_veh_lbravo_ground_l2_idle"]);
  level.scr_anim["lbravo_ai_infil_solider"]["sdr_mp_veh_lbravo_ground_l3_idle"] = % sdr_mp_veh_lbravo_ground_l3_idle;
  level.scr_animname["lbravo_ai_infil_solider"]["sdr_mp_veh_lbravo_ground_l3_idle"] = "sdr_mp_veh_lbravo_ground_l3_idle";
  level.animlength["lbravo_ai_infil_solider"]["sdr_mp_veh_lbravo_ground_l3_idle"] = getanimlength(level.scr_anim["lbravo_ai_infil_solider"]["sdr_mp_veh_lbravo_ground_l3_idle"]);
  level.scr_anim["lbravo_ai_infil_solider"]["sdr_mp_veh_lbravo_ground_r1_idle"] = % sdr_mp_veh_lbravo_ground_r1_idle;
  level.scr_animname["lbravo_ai_infil_solider"]["sdr_mp_veh_lbravo_ground_r1_idle"] = "sdr_mp_veh_lbravo_ground_r1_idle";
  level.animlength["lbravo_ai_infil_solider"]["sdr_mp_veh_lbravo_ground_r1_idle"] = getanimlength(level.scr_anim["lbravo_ai_infil_solider"]["sdr_mp_veh_lbravo_ground_r1_idle"]);
  level.scr_anim["lbravo_ai_infil_solider"]["sdr_mp_veh_lbravo_ground_r2_idle"] = % sdr_mp_veh_lbravo_ground_r2_idle;
  level.scr_animname["lbravo_ai_infil_solider"]["sdr_mp_veh_lbravo_ground_r2_idle"] = "sdr_mp_veh_lbravo_ground_r2_idle";
  level.animlength["lbravo_ai_infil_solider"]["sdr_mp_veh_lbravo_ground_r2_idle"] = getanimlength(level.scr_anim["lbravo_ai_infil_solider"]["sdr_mp_veh_lbravo_ground_r2_idle"]);
  level.scr_anim["lbravo_ai_infil_solider"]["sdr_mp_veh_lbravo_ground_r3_idle"] = % sdr_mp_veh_lbravo_ground_r3_idle;
  level.scr_animname["lbravo_ai_infil_solider"]["sdr_mp_veh_lbravo_ground_r3_idle"] = "sdr_mp_veh_lbravo_ground_r3_idle";
  level.animlength["lbravo_ai_infil_solider"]["sdr_mp_veh_lbravo_ground_r3_idle"] = getanimlength(level.scr_anim["lbravo_ai_infil_solider"]["sdr_mp_veh_lbravo_ground_r3_idle"]);
  level.scr_anim["lbravo_ai_infil_solider"]["sdr_mp_veh_lbravo_ground_l1_exit"] = % sdr_mp_veh_lbravo_ground_l1_exit;
  level.scr_animname["lbravo_ai_infil_solider"]["sdr_mp_veh_lbravo_ground_l1_exit"] = "sdr_mp_veh_lbravo_ground_l1_exit";
  level.animlength["lbravo_ai_infil_solider"]["sdr_mp_veh_lbravo_ground_l1_exit"] = getanimlength(level.scr_anim["lbravo_ai_infil_solider"]["sdr_mp_veh_lbravo_ground_l1_exit"]);
  level.scr_anim["lbravo_ai_infil_solider"]["sdr_mp_veh_lbravo_ground_l2_exit"] = % sdr_mp_veh_lbravo_ground_l2_exit;
  level.scr_animname["lbravo_ai_infil_solider"]["sdr_mp_veh_lbravo_ground_l2_exit"] = "sdr_mp_veh_lbravo_ground_l2_exit";
  level.animlength["lbravo_ai_infil_solider"]["sdr_mp_veh_lbravo_ground_l2_exit"] = getanimlength(level.scr_anim["lbravo_ai_infil_solider"]["sdr_mp_veh_lbravo_ground_l2_exit"]);
  level.scr_anim["lbravo_ai_infil_solider"]["sdr_mp_veh_lbravo_ground_l3_exit"] = % sdr_mp_veh_lbravo_ground_l3_exit;
  level.scr_animname["lbravo_ai_infil_solider"]["sdr_mp_veh_lbravo_ground_l3_exit"] = "sdr_mp_veh_lbravo_ground_l3_exit";
  level.animlength["lbravo_ai_infil_solider"]["sdr_mp_veh_lbravo_ground_l3_exit"] = getanimlength(level.scr_anim["lbravo_ai_infil_solider"]["sdr_mp_veh_lbravo_ground_l3_exit"]);
  level.scr_anim["lbravo_ai_infil_solider"]["sdr_mp_veh_lbravo_ground_r1_exit"] = % sdr_mp_veh_lbravo_ground_r1_exit;
  level.scr_animname["lbravo_ai_infil_solider"]["sdr_mp_veh_lbravo_ground_r1_exit"] = "sdr_mp_veh_lbravo_ground_r1_exit";
  level.animlength["lbravo_ai_infil_solider"]["sdr_mp_veh_lbravo_ground_r1_exit"] = getanimlength(level.scr_anim["lbravo_ai_infil_solider"]["sdr_mp_veh_lbravo_ground_r1_exit"]);
  level.scr_anim["lbravo_ai_infil_solider"]["sdr_mp_veh_lbravo_ground_r2_exit"] = % sdr_mp_veh_lbravo_ground_r2_exit;
  level.scr_animname["lbravo_ai_infil_solider"]["sdr_mp_veh_lbravo_ground_r2_exit"] = "sdr_mp_veh_lbravo_ground_r2_exit";
  level.animlength["lbravo_ai_infil_solider"]["sdr_mp_veh_lbravo_ground_r2_exit"] = getanimlength(level.scr_anim["lbravo_ai_infil_solider"]["sdr_mp_veh_lbravo_ground_r2_exit"]);
  level.scr_anim["lbravo_ai_infil_solider"]["sdr_mp_veh_lbravo_ground_r3_exit"] = % sdr_mp_veh_lbravo_ground_r3_exit;
  level.scr_animname["lbravo_ai_infil_solider"]["sdr_mp_veh_lbravo_ground_r3_exit"] = "sdr_mp_veh_lbravo_ground_r3_exit";
  level.animlength["lbravo_ai_infil_solider"]["sdr_mp_veh_lbravo_ground_r3_exit"] = getanimlength(level.scr_anim["lbravo_ai_infil_solider"]["sdr_mp_veh_lbravo_ground_r3_exit"]);
  return var_0;
}

set_vehicle_anims(var_0) {}

unload_groups() {
  var_0 = [];
  var_0["both"] = [];
  var_0["left"] = [];
  var_0["right"] = [];
  var_0["both"] = [2, 3, 4, 5, 6, 7];
  var_0["left"] = [2, 4, 6];
  var_0["right"] = [3, 5, 7];
  var_0["default"] = var_0["both"];
  return var_0;
}