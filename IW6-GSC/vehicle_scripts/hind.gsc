/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: vehicle_scripts\hind.gsc
*****************************************************/

#using_animtree("vehicles");

main(var_0, var_1, var_2) {
  maps\_vehicle::build_template("hind_battle", var_0, var_1, var_2);
  maps\_vehicle::build_localinit(::init_local);
  maps\_vehicle::build_deathmodel("vehicle_battle_hind");
  maps\_vehicle::build_deathmodel("vehicle_battle_hind_alpha_rotors");
  var_3 = [];
  var_3["vehicle_battle_hind"] = "fx/explosions/helicopter_explosion_hind_chernobyl";
  var_3["vehicle_battle_hind_low"] = "fx/explosions/helicopter_explosion_hind_chernobyl";
  var_3["vehicle_battle_hind_no_lod"] = "fx/explosions/helicopter_explosion_hind_chernobyl";
  var_3["vehicle_battle_hind_alpha_rotors"] = "fx/explosions/helicopter_explosion_hind_chernobyl";
  var_4 = [];
  var_4["vehicle_battle_hind"] = "fx/explosions/aerial_explosion_hind_chernobyl";
  var_4["vehicle_battle_hind_low"] = "fx/explosions/aerial_explosion_hind_chernobyl";
  var_4["vehicle_battle_hind_no_lod"] = "fx/explosions/aerial_explosion_hind_chernobyl";
  var_4["vehicle_battle_hind_alpha_rotors"] = "fx/explosions/aerial_explosion_hind_chernobyl";
  maps\_vehicle::build_drive(%battle_hind_spinning_rotor, undefined, 0);
  var_5 = var_3[var_0];
  maps\_vehicle::build_deathfx("fx/explosions/grenadeexp_default", "tag_engine_left", "hind_helicopter_hit", undefined, undefined, undefined, 0.2, 1, undefined);
  maps\_vehicle::build_deathfx("fx/explosions/grenadeexp_default", "tail_rotor_jnt", "hind_helicopter_secondary_exp", undefined, undefined, undefined, 0.5, 1, undefined);
  maps\_vehicle::build_deathfx("fx/fire/fire_smoke_trail_L", "tail_rotor_jnt", "hind_helicopter_dying_loop", 1, 0.05, 1, 0.5, 1, undefined);

  if(issubstr(var_2, "_sand")) {
    maps\_vehicle::build_deathfx("vfx/gameplay/vehicle_destruction/air/vfx_aerl_expl_bhind_", "tag_deathfx", "hind_helicopter_crash", undefined, undefined, undefined, undefined, 0, "stop_crash_loop_sound");
    maps\_vehicle::build_rocket_deathfx("vfx/gameplay/vehicle_destruction/air/vfx_aerl_expl_bhind_", "tag_deathfx", "hind_helicopter_crash", undefined, undefined, undefined, undefined, 1, undefined, 0);
  } else if(!issubstr(var_2, "_final")) {
    maps\_vehicle::build_deathfx("fx/explosions/aerial_explosion", "tag_engine_right", "hind_helicopter_secondary_exp", undefined, undefined, undefined, 2.5, 1, undefined);
    maps\_vehicle::build_deathfx("fx/explosions/aerial_explosion", "tag_deathfx", "hind_helicopter_secondary_exp", undefined, undefined, undefined, 4.0, undefined, undefined);
    maps\_vehicle::build_deathfx(var_5, "tag_deathfx", "hind_helicopter_crash", undefined, undefined, undefined, -1, undefined, "stop_crash_loop_sound");
    maps\_vehicle::build_rocket_deathfx(var_4[var_0], "tag_deathfx", "hind_helicopter_crash", undefined, undefined, undefined, undefined, 1, undefined, 0);
  }

  maps\_vehicle::build_treadfx(var_2, "default", "fx/treadfx/heli_dust_default", 0);
  maps\_vehicle::build_life(3000, 2800, 3100);
  maps\_vehicle::build_team("axis");
  maps\_vehicle::build_aianims(::setanims, ::set_vehicle_anims);
  var_6 = randomfloatrange(0, 1);
  maps\_vehicle::build_light(var_2, "cockpit_blue_cargo01", "tag_light_cargo01", "fx/misc/aircraft_light_cockpit_red", "interior", 0.0);
  maps\_vehicle::build_light(var_2, "cockpit_blue_cockpit01", "tag_light_cockpit01", "fx/misc/aircraft_light_cockpit_blue", "interior", 0.1);
  maps\_vehicle::build_light(var_2, "white_blink", "tag_light_belly", "fx/misc/aircraft_light_white_blink", "running", var_6);
  maps\_vehicle::build_light(var_2, "white_blink_tail", "tag_light_tail", "fx/misc/aircraft_light_red_blink", "running", var_6);
  maps\_vehicle::build_light(var_2, "wingtip_green", "tag_light_L_wing", "fx/misc/aircraft_light_wingtip_green", "running", var_6);
  maps\_vehicle::build_light(var_2, "wingtip_red", "tag_light_R_wing", "fx/misc/aircraft_light_wingtip_red", "running", var_6);
  maps\_vehicle::build_light(var_2, "spot", "tag_passenger", "fx/misc/aircraft_light_hindspot", "spot", 0.0);
  maps\_vehicle::build_bulletshield(1);
  maps\_vehicle::build_is_helicopter();
}

init_local() {
  self.script_badplace = 0;
  maps\_vehicle::vehicle_lights_on("running");
}