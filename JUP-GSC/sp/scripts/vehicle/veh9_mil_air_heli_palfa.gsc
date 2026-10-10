/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\vehicle\veh9_mil_air_heli_palfa.gsc
**********************************************************/

#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_aianim;
#using scripts\common\vehicle_build;
#using scripts\engine\utility;
#namespace veh9_mil_air_heli_palfa;

function main(model, type, classname) {
  build_template("palfa", model, type, classname);
  build_localinit(&init_local);
  build_deathmodel("veh9_mil_air_heli_palfa_vehphys_sp");
  build_deathfx("vfx/core/expl/grenadeexp_default.vfx", "tag_engine_left", "veh9_dmg_mil_air_heli_palfa_explode_hit", undefined, undefined, undefined, 0.2, 1, undefined);
  build_deathfx("vfx/core/expl/grenadeexp_default.vfx", "tail_rotor_jnt", undefined, undefined, undefined, undefined, 0.5, 1, undefined);
  build_deathfx("vfx/core/expl/fire_smoke_trail_l.vfx", "tag_engine_left", undefined, undefined, undefined, 1, 0.5, 1, undefined);
  build_radiusdamage((0, 0, 0), 500, 120, 20);
  build_treadfx();
  build_treadfx(classname, "default", "vfx/code/tread/heli_dust_default.vfx", 1);
  build_life(3000, 2800, 3100);
  build_team("allies");
  build_aianims(&setanims, &set_vehicle_anims, "blima");
  randomstartdelay = randomfloatrange(0, 1);
  build_light(classname, "cockpit_red_cargo01", "tag_light_cargo01", "vfx/misc/aircraft_light_cockpit_red", "interior", 0);
  build_light(classname, "cockpit_red_cargo02", "tag_light_cargo02", "vfx/misc/aircraft_light_cockpit_red", "interior", 0);
  build_light(classname, "cockpit_blue_cockpit01", "tag_light_cockpit01", "vfx/misc/aircraft_light_cockpit_blue", "interior", 0.1);
  build_light(classname, "white_blink_belly", "tag_light_belly", "vfx/core/vehicles/aircraft_light_white_blink_lit", "running", randomstartdelay);
  build_light(classname, "red_blink_tail", "tag_light_tail", "vfx/core/vehicles/aircraft_light_red_blink_lit", "running", randomstartdelay);
  build_light(classname, "wingtip_green", "tag_light_L_wing", "vfx/core/vehicles/aircraft_light_wingtip_red_lit", "running", randomstartdelay);
  build_light(classname, "wingtip_red", "tag_light_R_wing", "vfx/core/vehicles/aircraft_light_wingtip_green_lit", "running", randomstartdelay);
  build_light(classname, "spot", "tag_passenger", "vfx/misc/aircraft_light_hindspot", "spot", 0);
  build_unload_groups(&unload_groups);
  build_bulletshield(1);
  build_is_helicopter();
}

function init_local() {
  self.unload_hover_offset = 570;
  self.unload_land_offset = 165;
  self.script_badplace = 0;

  if(!scripts\engine\utility::is_equal(self.script_vehicle_lights_off, "running")) {
    scripts\common\vehicle::vehicle_lights_on("running");
  }

  self.vehicleanimalias = "blima";
  self.vehiclesetuprope = 1;
  thread handle_scriptable_vfx();
}

function handle_scriptable_vfx() {
  self endon("death");

  if(utility::issp() || utility::iscp()) {
    scripts\engine\utility::flag_wait("scriptables_ready");
    self setscriptablepartstate("engine", "on");
    self setscriptablepartstate("vector_field", "on");
  }
}

function setanims() {
  positions = [];

  for(i = 0; i < 10; i++) {
    positions[i] = spawnStruct();
  }

  return positions;
}

function set_vehicle_anims(positions) {}

function unload_groups() {
  unload_groups = [];
  return unload_groups;
}