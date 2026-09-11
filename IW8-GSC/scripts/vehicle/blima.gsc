/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\vehicle\blima.gsc
***********************************************/

function main(var0, var1, var2) {
  scripts\common\vehicle_build::build_template("blima", var0, var1, var2);
  scripts\common\vehicle_build::build_localinit(&init_local);
  scripts\common\vehicle_build::build_deathmodel("veh8_mil_air_blima");
  scripts\common\vehicle_build::build_deathfx("vfx/core/expl/grenadeexp_default.vfx", "tag_engine_left", "hind_helicopter_hit", undefined, undefined, undefined, 0.2, 1, undefined);
  scripts\common\vehicle_build::build_deathfx("vfx/core/expl/grenadeexp_default.vfx", "tail_rotor_jnt", undefined, undefined, undefined, undefined, 0.5, 1, undefined);
  scripts\common\vehicle_build::build_deathfx("vfx/core/expl/fire_smoke_trail_l.vfx", "tag_engine_left", undefined, undefined, undefined, 1, 0.5, 1, undefined);
  scripts\common\vehicle_build::build_radiusdamage((0, 0, 0), 500, 120, 20);
  scripts\common\vehicle_build::build_treadfx();
  scripts\common\vehicle_build::build_treadfx(var2, "default", "vfx/code/tread/heli_dust_default.vfx", 1);
  scripts\common\vehicle_build::build_life(3000, 2800, 3100);
  scripts\common\vehicle_build::build_team("allies");
  scripts\common\vehicle_build::build_aianims(&setanims, &set_vehicle_anims, "blima");
  scripts\common\vehicle_build::build_attach_models(&set_attached_models);
  var3 = randomfloatrange(0, 1);
  scripts\common\vehicle_build::build_light(var2, "cockpit_red_cargo01", "tag_light_cargo01", "vfx/misc/aircraft_light_cockpit_red", "interior", 0);
  scripts\common\vehicle_build::build_light(var2, "cockpit_red_cargo02", "tag_light_cargo02", "vfx/misc/aircraft_light_cockpit_red", "interior", 0);
  scripts\common\vehicle_build::build_light(var2, "cockpit_blue_cockpit01", "tag_light_cockpit01", "vfx/misc/aircraft_light_cockpit_blue", "interior", 0.1);
  scripts\common\vehicle_build::build_light(var2, "white_blink_belly", "tag_light_belly", "vfx/core/vehicles/aircraft_light_white_blink_lit", "running", var3);
  scripts\common\vehicle_build::build_light(var2, "red_blink_tail", "tag_light_tail", "vfx/core/vehicles/aircraft_light_red_blink_lit", "running", var3);
  scripts\common\vehicle_build::build_light(var2, "wingtip_green", "tag_light_L_wing", "vfx/core/vehicles/aircraft_light_wingtip_red_lit", "running", var3);
  scripts\common\vehicle_build::build_light(var2, "wingtip_red", "tag_light_R_wing", "vfx/core/vehicles/aircraft_light_wingtip_green_lit", "running", var3);
  scripts\common\vehicle_build::build_light(var2, "spot", "tag_passenger", "vfx/misc/aircraft_light_hindspot", "spot", 0);
  scripts\common\vehicle_build::build_unload_groups(&unload_groups);
  scripts\common\vehicle_build::build_bulletshield(1);
  scripts\common\vehicle_build::build_is_helicopter();
}

function setup_lights(var0) {}

function init_local() {
  self.unload_hover_offset = 570;
  self.script_badplace = 0;

  if(!scripts\engine\utility::is_equal(self.script_vehicle_lights_off, "running")) {
    scripts\common\vehicle::vehicle_lights_on("running");
  }

  self.vehicleanimalias = "blima";
  self.vehiclesetuprope = 1;
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
    self setscriptablepartstate("vector_field", "on");
    return;
  }
}

#using_animtree("");

function setanims() {
  var0 = [];

  for(var1 = 0; var1 < 10; var1++) {
    var0 = spawnStruct();
  }

  var0[0].idle = % vh_blima_rappel_pilot;
  var0[1].idle = $vh_blima_rappel_copilot;
  var0[2].idle = % vh_blima_rappel_soldier0_idle;
  var0[3].idle = % vh_blima_rappel_soldier1_idle;
  var0[4].idle = % vh_blima_rappel_soldier2_idle;
  var0[5].idle = % vh_blima_rappel_soldier3_idle;
  var0[6].idle = % vh_blima_rappel_soldier4_idle;
  var0[7].idle = % vh_blima_rappel_soldier6_idle;
  var0[8].idle = % vh_blima_rappel_soldier8_idle;
  var0[9].idle = % vh_blima_rappel_soldier9_idle;
  var0[0].sittag = "tag_pilot1";
  var0[1].sittag = "tag_pilot2";
  var0[2].sittag = "tag_guy0";
  var0[3].sittag = "tag_guy2";
  var0[4].sittag = "tag_guy4";
  var0[5].sittag = "tag_guy9";
  var0[6].sittag = "tag_guy9";
  var0[7].sittag = "tag_guy1";
  var0[8].sittag = "tag_guy3";
  var0[9].sittag = "tag_guy2";
  var0[2].getout = % vh_blima_rappel_soldier0_drop;
  var0[3].getout = % vh_blima_rappel_soldier1_drop;
  var0[4].getout = % vh_blima_rappel_soldier2_drop;
  var0[7].getout = % vh_blima_rappel_soldier6_drop;
  var0[8].getout = % vh_blima_rappel_soldier8_drop;
  var0[9].getout = % vh_blima_rappel_soldier9_drop;
  var0[0].death_no_ragdoll = 1;
  var0[1].death_no_ragdoll = 1;
  var0[2].ragdoll_getout_death = 1;
  var0[3].ragdoll_getout_death = 1;
  var0[4].ragdoll_getout_death = 1;
  var0[5].ragdoll_getout_death = 1;
  var0[6].ragdoll_getout_death = 1;
  var0[7].ragdoll_getout_death = 1;
  var0[8].ragdoll_getout_death = 1;
  var0[9].ragdoll_getout_death = 1;
  var0[2].ragdoll_fall_anim = % sdr_com_exposed_stand_death01_midbody_sm_8;
  var0[3].ragdoll_fall_anim = % sdr_com_exposed_stand_death01_midbody_sm_8;
  var0[4].ragdoll_fall_anim = % sdr_com_exposed_stand_death01_midbody_sm_8;
  var0[5].ragdoll_fall_anim = % sdr_com_exposed_stand_death01_midbody_sm_8;
  var0[6].ragdoll_fall_anim = % sdr_com_exposed_stand_death01_midbody_sm_8;
  var0[7].ragdoll_fall_anim = % sdr_com_exposed_stand_death01_midbody_sm_8;
  var0[8].ragdoll_fall_anim = % sdr_com_exposed_stand_death01_midbody_sm_8;
  var0[9].ragdoll_fall_anim = % sdr_com_exposed_stand_death01_midbody_sm_8;
  var0[2].fastroperig = "TAG_FastRope_LE";
  var0[3].fastroperig = "TAG_FastRope_LE";
  var0[4].fastroperig = "TAG_FastRope_LE";
  var0[5].fastroperig = "TAG_FastRope_LE";
  var0[6].fastroperig = "TAG_FastRope_RI";
  var0[7].fastroperig = "TAG_FastRope_RI";
  var0[8].fastroperig = "TAG_FastRope_RI";
  var0[9].fastroperig = "TAG_FastRope_RI";
  var0[5].setuprope = 1;
  var0[6].setuprope = 1;
  return var0;
}

#using_animtree("vehicles");

function set_vehicle_anims(var0) {
  for(var1 = 0; var1 < var0.size; var1++) {
    var0[var1].vehicle_getoutanim = % vh_blima_rappel_heli_drop;
  }

  return var0;
}

function unload_groups() {
  var0 = [];
  GscBinSkip0(0x2e, "left", []);
}

function set_attached_models() {
  var0 = [];
  GscBinSkip0(0x2e, "TAG_FastRope_LE", spawnStruct());
}