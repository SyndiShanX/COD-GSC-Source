/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\lbravo_ai_infil.gsc
***********************************************/

#using_animtree("vehicles");

main(model, type, classname) {
  scripts\common\vehicle_build::build_template("lbravo", model, type, classname);
  scripts\common\vehicle_build::build_localinit(::init_local);
  scripts\common\vehicle_build::build_deathmodel("veh8_mil_air_lbravo");
  scripts\common\vehicle_build::build_deathfx("vfx/core/expl/helicopter_explosion_little_bird.vfx", "tag_origin", "rocket_explode", undefined, undefined, undefined, 0.2, 1, undefined);
  scripts\common\vehicle_build::build_rocket_deathfx("vfx/iw8/prop/scriptables/vfx_vh8_mil_air_lbravo_debris.vfx", "tag_origin", "exp_helicopter_fuel", undefined, undefined, 0, randomfloatrange(1.5, 3), 0);
  scripts\common\vehicle_build::build_treadfx(classname, "default", "vfx/code/tread/heli_dust_sml.vfx", 1);
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
  _id_E4B7E99A96C8829F = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 8; _id_AC0E594AC96AA3A8++)
    _id_E4B7E99A96C8829F[_id_AC0E594AC96AA3A8] = spawnStruct();

  _id_E4B7E99A96C8829F[0].canshootinvehicle = 0;
  _id_E4B7E99A96C8829F[1].canshootinvehicle = 0;
  _id_E4B7E99A96C8829F[2].canshootinvehicle = 1;
  _id_E4B7E99A96C8829F[3].canshootinvehicle = 1;
  _id_E4B7E99A96C8829F[4].canshootinvehicle = 1;
  _id_E4B7E99A96C8829F[5].canshootinvehicle = 1;
  _id_E4B7E99A96C8829F[6].canshootinvehicle = 1;
  _id_E4B7E99A96C8829F[7].canshootinvehicle = 1;
  _id_E4B7E99A96C8829F[0].idle = % vh_blima_rappel_pilot;
  _id_E4B7E99A96C8829F[0].idle_anim = "vh_blima_rappel_pilot";
  _id_E4B7E99A96C8829F[1].idle = % vh_blima_rappel_copilot;
  _id_E4B7E99A96C8829F[1].idle_anim = "vh_blima_rappel_copilot";
  _id_E4B7E99A96C8829F[2].idle = % sdr_mp_veh_lbravo_ground_l1_idle;
  _id_E4B7E99A96C8829F[3].idle = % sdr_mp_veh_lbravo_ground_l2_idle;
  _id_E4B7E99A96C8829F[4].idle = % sdr_mp_veh_lbravo_ground_l3_idle;
  _id_E4B7E99A96C8829F[5].idle = % sdr_mp_veh_lbravo_ground_r1_idle;
  _id_E4B7E99A96C8829F[6].idle = % sdr_mp_veh_lbravo_ground_r2_idle;
  _id_E4B7E99A96C8829F[7].idle = % sdr_mp_veh_lbravo_ground_r3_idle;
  _id_E4B7E99A96C8829F[0].sittag = "tag_pilot1";
  _id_E4B7E99A96C8829F[1].sittag = "tag_pilot2";
  _id_E4B7E99A96C8829F[2].sittag = "tag_passenger1";
  _id_E4B7E99A96C8829F[3].sittag = "tag_passenger2";
  _id_E4B7E99A96C8829F[4].sittag = "tag_passenger3";
  _id_E4B7E99A96C8829F[5].sittag = "tag_passenger4";
  _id_E4B7E99A96C8829F[6].sittag = "tag_passenger5";
  _id_E4B7E99A96C8829F[7].sittag = "tag_passenger6";
  _id_E4B7E99A96C8829F[2].getout = % sdr_mp_veh_lbravo_ground_l1_exit;
  _id_E4B7E99A96C8829F[3].getout = % sdr_mp_veh_lbravo_ground_l2_exit;
  _id_E4B7E99A96C8829F[4].getout = % sdr_mp_veh_lbravo_ground_l3_exit;
  _id_E4B7E99A96C8829F[5].getout = % sdr_mp_veh_lbravo_ground_r1_exit;
  _id_E4B7E99A96C8829F[6].getout = % sdr_mp_veh_lbravo_ground_r2_exit;
  _id_E4B7E99A96C8829F[7].getout = % sdr_mp_veh_lbravo_ground_r3_exit;
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
  return _id_E4B7E99A96C8829F;
}

set_vehicle_anims(_id_E4B7E99A96C8829F) {}

unload_groups() {
  unload_groups = [];
  unload_groups["both"] = [];
  unload_groups["left"] = [];
  unload_groups["right"] = [];
  unload_groups["both"] = [2, 3, 4, 5, 6, 7];
  unload_groups["left"] = [2, 4, 6];
  unload_groups["right"] = [3, 5, 7];
  unload_groups["default"] = unload_groups["both"];
  return unload_groups;
}