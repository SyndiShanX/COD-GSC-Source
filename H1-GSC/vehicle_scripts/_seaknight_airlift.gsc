/**************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: vehicle_scripts\_seaknight_airlift.gsc
**************************************************/

#using_animtree("vehicles");

main(var_0, var_1, var_2) {
  maps\_vehicle::build_template("seaknight_airlift", var_0, var_1, var_2);
  maps\_vehicle::build_localinit(::init_local);
  maps\_vehicle::build_deathmodel("vehicle_ch46e");
  maps\_vehicle::build_deathfx("fx\explosions\large_vehicle_explosion", undefined, "explo_metal_rand");
  maps\_vehicle::build_treadfx();
  maps\_vehicle::build_life(999, 500, 1500);
  maps\_vehicle::build_team("allies");
  maps\_vehicle::build_drive( % sniper_escape_ch46_rotors, undefined, 0);
  maps\_vehicle::build_light(var_2, "cockpit_red_cargo_1", "tag_fx_light_cargo02", "vfx\lights\airlift\seaknight_light_back_red", "back", 0.0);
  maps\_vehicle::build_light(var_2, "cockpit_L_godray1", "tag_fx_L_window_1", "vfx\lights\airlift\seaknight_godray", "interior", 0.0);
  maps\_vehicle::build_light(var_2, "cockpit_L_godray2", "tag_fx_L_window_2", "vfx\lights\airlift\seaknight_godray", "interior", 0.0);
  maps\_vehicle::build_light(var_2, "cockpit_L_godray3", "tag_fx_L_window_3", "vfx\lights\airlift\seaknight_godray", "interior", 0.0);
  maps\_vehicle::build_light(var_2, "cockpit_L_godray4", "tag_fx_L_window_4", "vfx\lights\airlift\seaknight_godray", "interior", 0.0);
  maps\_vehicle::build_light(var_2, "cockpit_L_godray5", "tag_fx_window_gun", "vfx\lights\airlift\seaknight_godray", "interior", 0.0);
  maps\_vehicle::build_light(var_2, "cockpit_blue_cockpit_1", "tag_light_cockpit01", "fx\misc\aircraft_light_cockpit_blue_airlift", "interior", 0.1);
  maps\_vehicle::build_light(var_2, "cockpit_red_cargo_2", "tag_fx_light_cargo02", "vfx\lights\airlift\seaknight_light_back_red", "back2", 0.0);
  maps\_vehicle::build_light(var_2, "cockpit_R_godray1", "tag_fx_R_window_1", "vfx\lights\airlift\seaknight_godray", "interior2", 0.0);
  maps\_vehicle::build_light(var_2, "cockpit_R_godray2", "tag_fx_R_window_2", "vfx\lights\airlift\seaknight_godray", "interior2", 0.0);
  maps\_vehicle::build_light(var_2, "cockpit_R_godray3", "tag_fx_R_window_3", "vfx\lights\airlift\seaknight_godray", "interior2", 0.0);
  maps\_vehicle::build_light(var_2, "cockpit_R_godray4", "tag_fx_R_window_4", "vfx\lights\airlift\seaknight_godray", "interior2", 0.0);
  maps\_vehicle::build_light(var_2, "cockpit_blue_cockpit_2", "tag_light_cockpit01", "fx\misc\aircraft_light_cockpit_blue_airlift", "interior2", 0.1);
  maps\_vehicle::build_light(var_2, "white_blink", "tag_light_belly", "fx\misc\aircraft_light_red_blink", "running", 0.0);
  maps\_vehicle::build_light(var_2, "white_blink_tail", "tag_light_tail", "fx\misc\aircraft_light_red_blink", "running", 0.3);
  maps\_vehicle::build_light(var_2, "wingtip_green1", "tag_light_L_wing1", "fx\misc\aircraft_light_wingtip_green", "running", 0.0);
  maps\_vehicle::build_light(var_2, "wingtip_green2", "tag_light_L_wing2", "fx\misc\aircraft_light_wingtip_green", "running", 0.0);
  maps\_vehicle::build_light(var_2, "wingtip_red1", "tag_light_R_wing1", "fx\misc\aircraft_light_wingtip_red", "running", 0.2);
  maps\_vehicle::build_light(var_2, "wingtip_red2", "tag_light_R_wing2", "fx\misc\aircraft_light_wingtip_red", "running", 0.0);
  maps\_vehicle::build_light(var_2, "cockpit_red_cargo_3", "tag_fx_light_cargo02", "vfx\lights\airlift\seaknight_light_back_red_rescue", "back3", 0.0);
  maps\_vehicle::build_is_helicopter();
  precachemodel("vehicle_ch46e_opened_door_interior_b");
  precachemodel("vehicle_ch46e_wires");
  thread set_attached_models();
}

init_local() {
  self.originheightoffset = distance(self gettagorigin("tag_origin"), self gettagorigin("tag_ground"));
  self.fastropeoffset = 652;
  self.script_badplace = 0;
}

set_vehicle_anims(var_0) {
  var_0[1].vehicle_getoutanim = % ch46_doors_open;
  var_0[1].vehicle_getoutanim_clear = 0;
  var_0[1].vehicle_getinanim = % ch46_doors_close;
  var_0[1].vehicle_getinanim_clear = 0;
  var_0[1].vehicle_getoutsound = "seaknight_door_open";
  var_0[1].vehicle_getinsound = "seaknight_door_close";
  return var_0;
}

setanims() {
  var_0 = [];

  for (var_1 = 0; var_1 < 0; var_1++)
    var_0[var_1] = spawnstruct();

  return var_0;
}

unload_groups() {}

set_attached_models() {
  while (!isdefined(level.seaknight))
    wait 0.05;

  var_0 = spawn("script_model", level.seaknight.origin);
  var_0 setmodel("vehicle_ch46e_opened_door_interior_b");
  var_0.origin = level.seaknight gettagorigin("body_animate_jnt");
  var_0.angles = level.seaknight.angles;
  var_0 linkto(level.seaknight, "body_animate_jnt");
  var_0 = spawn("script_model", level.seaknight.origin);
  var_0 setmodel("vehicle_ch46e_wires");
  var_0.origin = level.seaknight gettagorigin("body_animate_jnt");
  var_0.angles = level.seaknight.angles;
  var_0 linkto(level.seaknight, "body_animate_jnt");
}