/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\vehicle\veh9_mil_air_heli_medium.gsc
********************************************************/

#using_animtree("vehicles");

main(model, type, classname) {
  scripts\common\vehicle_build::build_template("heli_medium", model, type, classname);
  scripts\common\vehicle_build::build_localinit(::init_local);
  scripts\common\vehicle_build::build_deathmodel("veh9_mil_air_heli_medium_vehphys_sp");
  scripts\common\vehicle_build::build_radiusdamage((0, 0, 0), 500, 120, 20);
  mapname = getDvar("g_mapname");

  switch (mapname) {
    case "prison":
      scripts\common\vehicle_build::build_treadfx(classname, "default", "vfx/iw9/level/prison/heli_prison_default_ch.vfx", 1);
      break;
    case "tower":
      scripts\common\vehicle_build::build_treadfx(classname, "default", "vfx/iw9/level/tower/vfx_twr_heli_dust_snow.vfx", 1);
      break;
    default:
      scripts\common\vehicle_build::build_treadfx(classname, "default", "vfx/code/tread/heli_dust_default.vfx", 1);
      break;
  }

  scripts\common\vehicle_build::build_life(3000, 2800, 3100);
  scripts\common\vehicle_build::build_team("allies");
  scripts\common\vehicle_build::build_aianims(::setanims);
  scripts\common\vehicle_build::build_unload_groups(::unload_groups);
  _id_3CAA669E71B5CD31 = randomfloatrange(0, 1);
  scripts\common\vehicle_build::build_light(classname, "blinking_body", "tag_body", "vfx/iw9/veh/scriptables/vfx_veh_medium_bird_blinking_lights", "running", 0.0);
  scripts\common\vehicle_build::_id_2CF37D073C6BDE84(classname, "cockpit_red_cargo01", "tag_light_cargo01", "interior", 0.0);
  scripts\common\vehicle_build::_id_2CF37D073C6BDE84(classname, "cockpit_red_cargo02", "tag_light_cargo02", "interior", 0.0);
  scripts\common\vehicle_build::_id_2CF37D073C6BDE84(classname, "cockpit_blue_cockpit01", "tag_light_cockpit01", "interior", 0.1);
  scripts\common\vehicle_build::_id_2CF37D073C6BDE84(classname, "white_blink_belly", "tag_light_belly", "running", _id_3CAA669E71B5CD31);
  scripts\common\vehicle_build::_id_2CF37D073C6BDE84(classname, "red_blink_tail", "tag_light_tail", "running", _id_3CAA669E71B5CD31);
  scripts\common\vehicle_build::_id_2CF37D073C6BDE84(classname, "wingtip_green", "tag_light_L_wing", "running", _id_3CAA669E71B5CD31);
  scripts\common\vehicle_build::_id_2CF37D073C6BDE84(classname, "wingtip_red", "tag_light_R_wing", "running", _id_3CAA669E71B5CD31);
  scripts\common\vehicle_build::_id_2CF37D073C6BDE84(classname, "spot", "tag_passenger", "spot", 0.0);
  scripts\common\vehicle_build::build_unload_groups(::unload_groups);
  scripts\common\vehicle_build::build_bulletshield(1);
  scripts\common\vehicle_build::build_is_helicopter();
  scripts\common\vehicle_build::build_drive(%lbravo_rotors, undefined, 0, 3.0);
}

init_local() {
  self.unload_hover_offset = 120;
  self.unload_land_offset = 112;
  self.script_badplace = 0;

  if(!scripts\engine\utility::is_equal(self.script_vehicle_lights_off, "running"))
    scripts\common\vehicle::vehicle_lights_on("running");

  self.vehicleanimalias = "veh9_heli_medium";
  thread handle_scriptable_vfx();
}

handle_scriptable_vfx() {
  self endon("death");

  if(scripts\common\utility::issp() || scripts\common\utility::iscp()) {
    scripts\engine\utility::flag_wait("scriptables_ready");
    self setscriptablepartstate("engine", "on");
    self setscriptablepartstate("Exhaust", "on");
    self setscriptablepartstate("NaviLights", "on");
  }
}

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
  _id_E4B7E99A96C8829F[0].sittag = "tag_seat_0";
  _id_E4B7E99A96C8829F[1].sittag = "tag_seat_1";
  _id_E4B7E99A96C8829F[2].sittag = "tag_seat_2";
  _id_E4B7E99A96C8829F[3].sittag = "tag_seat_3";
  _id_E4B7E99A96C8829F[4].sittag = "tag_seat_4";
  _id_E4B7E99A96C8829F[5].sittag = "tag_seat_5";
  _id_E4B7E99A96C8829F[6].sittag = "tag_seat_6";
  _id_E4B7E99A96C8829F[7].sittag = "tag_seat_7";
  _id_E4B7E99A96C8829F[0].death_no_ragdoll = 1;
  _id_E4B7E99A96C8829F[1].death_no_ragdoll = 1;
  _id_E4B7E99A96C8829F[2].vehicle_death_ragdoll = 1;
  _id_E4B7E99A96C8829F[3].vehicle_death_ragdoll = 1;
  _id_E4B7E99A96C8829F[4].vehicle_death_ragdoll = 1;
  _id_E4B7E99A96C8829F[5].vehicle_death_ragdoll = 1;
  _id_E4B7E99A96C8829F[6].vehicle_death_ragdoll = 1;
  _id_E4B7E99A96C8829F[7].vehicle_death_ragdoll = 1;
  _id_E4B7E99A96C8829F[0].death_impulse = 1;
  _id_E4B7E99A96C8829F[1].death_impulse = 1;
  _id_E4B7E99A96C8829F[2].death_impulse = 1;
  _id_E4B7E99A96C8829F[3].death_impulse = 1;
  _id_E4B7E99A96C8829F[4].death_impulse = 1;
  _id_E4B7E99A96C8829F[5].death_impulse = 1;
  _id_E4B7E99A96C8829F[6].death_impulse = 1;
  _id_E4B7E99A96C8829F[7].death_impulse = 1;
  return _id_E4B7E99A96C8829F;
}

set_vehicle_anims(_id_E4B7E99A96C8829F) {}

unload_groups() {
  unload_groups = [];
  unload_groups["both"] = [];
  unload_groups["left"] = [];
  unload_groups["right"] = [];
  unload_groups["all"] = [0, 1, 2, 3, 4, 5, 6, 7];
  unload_groups["both"] = [2, 3, 4, 5, 6, 7];
  unload_groups["left"] = [2, 3, 4];
  unload_groups["right"] = [5, 6, 7];
  unload_groups["default"] = unload_groups["both"];
  return unload_groups;
}