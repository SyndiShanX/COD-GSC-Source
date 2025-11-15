/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: vehicle_scripts\hind_battle_carrier.gsc
***************************************************/

#using_animtree("vehicles");

main(var_0, var_1, var_2) {
  maps\_vehicle::build_template("hind_battle", var_0, var_1, var_2);
  maps\_vehicle::build_localinit(vehicle_scripts\hind_battle_oilrocks::init_local);
  maps\_vehicle::build_deathmodel("vehicle_battle_hind", "vehicle_battle_hind_destroyed_anim");
  maps\_vehicle::build_drive( % battle_hind_spinning_rotor, undefined, 0);
  maps\_vehicle::build_treadfx(var_2, "default", "fx/treadfx/heli_dust_default", 0);
  maps\_vehicle::build_life(3000, 2800, 3100);
  maps\_vehicle::build_team("axis");
  maps\_vehicle::build_aianims(::setanims, ::set_vehicle_anims);
  maps\_vehicle::build_light(var_2, "cockpit_blue_cargo01", "tag_light_cargo01", "fx/misc/aircraft_light_cockpit_red", "interior", 0.0);
  maps\_vehicle::build_light(var_2, "cockpit_blue_cockpit01", "tag_light_cockpit01", "fx/misc/aircraft_light_cockpit_blue", "interior", 0.1);
  maps\_vehicle::build_light(var_2, "white_blink", "tag_light_belly", "fx/misc/aircraft_light_white_blink", "running", 0.3);
  maps\_vehicle::build_light(var_2, "white_blink_tail", "tag_light_tail", "fx/misc/aircraft_light_red_blink", "running", 0.3);
  maps\_vehicle::build_light(var_2, "wingtip_green", "tag_light_L_wing", "fx/misc/aircraft_light_wingtip_green", "running", 0.2);
  maps\_vehicle::build_light(var_2, "wingtip_red", "tag_light_R_wing", "fx/misc/aircraft_light_wingtip_red", "running", 0.2);
  maps\_vehicle::build_light(var_2, "spot", "tag_passenger", "fx/misc/aircraft_light_hindspot", "spot", 0.0);
  maps\_vehicle::build_bulletshield(1);
  maps\_vehicle::build_is_helicopter();
  maps\_vehicle::build_turret("hind_turret_carrier", "tag_turret", "vehicle_apache_iw6_mg", undefined, "auto_nonai", 0.0, 20, -14);
  vehicle_scripts\hind_battle_oilrocks::set_death_anim_scene();
}