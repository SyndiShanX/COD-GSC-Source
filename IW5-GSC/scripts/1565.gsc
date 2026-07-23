/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1565.gsc
**************************************/

#using_animtree("vehicles");

main(var_0, var_1, var_2) {
  maps\_vehicle::build_template("mi17_noai", var_0, var_1, var_2);
  maps\_vehicle::build_localinit(::init_local);
  maps\_vehicle::build_deathmodel("vehicle_mi17_woodland");
  maps\_vehicle::build_deathmodel("vehicle_mi17_woodland_fly");
  maps\_vehicle::build_deathmodel("vehicle_mi17_woodland_fly_cheap");
  maps\_vehicle::build_deathmodel("vehicle_mi17_woodland_landing");
  var_3 = [];
  var_3["vehicle_mi17_woodland"] = "explosions/helicopter_explosion_mi17_woodland";
  var_3["vehicle_mi17_woodland_fly"] = "explosions/helicopter_explosion_mi17_woodland_low";
  var_3["vehicle_mi17_woodland_fly_cheap"] = "explosions/helicopter_explosion_mi17_woodland_low";
  var_3["vehicle_mi17_woodland_landing"] = "explosions/helicopter_explosion_mi17_woodland_low";
  var_3["vehicle_mi-28_flying"] = "explosions/helicopter_explosion_mi17_woodland_low";
  maps\_vehicle::build_deathfx("fire/fire_smoke_trail_L", "tag_engine_right", "mi17_helicopter_dying_loop", 1, 0.05, 1, 0.5, 1);
  maps\_vehicle::build_deathfx("explosions/aerial_explosion", "tag_engine_right", "mi17_helicopter_secondary_exp", undefined, undefined, undefined, 2.5, 1);
  maps\_vehicle::build_deathfx("explosions/aerial_explosion", "tag_deathfx", "mi17_helicopter_secondary_exp", undefined, undefined, undefined, 4.0);
  maps\_vehicle::build_deathfx(var_3[var_0], undefined, "mi17_helicopter_crash", undefined, undefined, undefined, -1, undefined, "stop_crash_loop_sound");
  maps\_vehicle::build_drive(%mi17_heli_rotors, undefined, 0);
  maps\_vehicle::build_deathfx("explosions/grenadeexp_default", "tag_engine_left", "mi17_helicopter_hit", undefined, undefined, undefined, 0.2, 1);
  maps\_vehicle::build_deathfx("explosions/grenadeexp_default", "tag_engine_right", "mi17_helicopter_hit", undefined, undefined, undefined, 0.5, 1);
  maps\_vehicle::build_treadfx();
  maps\_vehicle::build_life(999, 500, 1500);
  maps\_vehicle::build_rumble("tank_rumble", 0.15, 4.5, 600, 1, 1);
  maps\_vehicle::build_team("axis");
  maps\_vehicle::build_bulletshield(1);
  var_4 = randomfloatrange(0, 1);
  var_5 = maps\_vehicle::get_light_model(var_0, var_2);
  maps\_vehicle::build_light(var_5, "cockpit_blue_cargo01", "tag_light_cargo01", "misc/aircraft_light_cockpit_red", "interior", 0.0);
  maps\_vehicle::build_light(var_5, "cockpit_blue_cockpit01", "tag_light_cockpit01", "misc/aircraft_light_cockpit_blue", "interior", 0.1);
  maps\_vehicle::build_light(var_5, "white_blink", "tag_light_belly", "misc/aircraft_light_white_blink", "running", var_4);
  maps\_vehicle::build_light(var_5, "white_blink_tail", "tag_light_tail", "misc/aircraft_light_red_blink", "running", var_4);
  maps\_vehicle::build_light(var_5, "wingtip_green", "tag_light_L_wing", "misc/aircraft_light_wingtip_green", "running", var_4);
  maps\_vehicle::build_light(var_5, "wingtip_red", "tag_light_R_wing", "misc/aircraft_light_wingtip_red", "running", var_4);
}

init_local() {
  self.originheightoffset = distance(self gettagorigin("tag_origin"), self gettagorigin("tag_ground"));
  self.fastropeoffset = 710;
  self.script_badplace = 0;
  maps\_vehicle::lights_on("running");
  maps\_vehicle::lights_on("interior");
}