/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: vehicle_scripts\_apache.gsc
***************************************/

#using_animtree("vehicles");

main(var_0, var_1, var_2) {
  maps\_vehicle::build_template("apache", var_0, var_1, var_2);
  maps\_vehicle::build_localinit(::init_local);
  maps\_vehicle::build_deathmodel("vehicle_apache");
  maps\_vehicle::build_deathmodel("vehicle_apache_dark");
  var_3 = [];
  var_3["vehicle_apache"] = "fx/explosions/helicopter_explosion_apache";
  var_3["vehicle_apache_dark"] = "fx/explosions/helicopter_explosion_apache_dark";
  var_4 = [];
  var_4["vehicle_apache"] = "fx/explosions/aerial_explosion_apache_mp";
  var_4["vehicle_apache_dark"] = "fx/explosions/aerial_explosion_apache_dark_mp";
  var_4["script_vehicle_apache"] = "fx/explosions/aerial_explosion_apache_mp";
  var_4["script_vehicle_apache_dark"] = "fx/explosions/aerial_explosion_apache_dark_mp";
  var_4["script_vehicle_apache_mg"] = "fx/explosions/aerial_explosion_apache_mp";
  maps\_vehicle::build_drive(%bh_rotors, undefined, 0);
  var_5 = var_3[var_0];
  maps\_vehicle::build_deathfx("fx/explosions/helicopter_explosion_secondary_small", "tag_engine_left", "apache_helicopter_secondary_exp", undefined, undefined, undefined, 0.0, 1, undefined);
  maps\_vehicle::build_deathfx("fx/fire/fire_smoke_trail_L", "tag_engine_left", "apache_helicopter_dying_loop", 1, 0.05, 1, 0.5, 1, undefined);
  maps\_vehicle::build_deathfx("fx/explosions/helicopter_explosion_secondary_small", "tag_engine_left", "apache_helicopter_secondary_exp", undefined, undefined, undefined, 2.5, 1, undefined);
  maps\_vehicle::build_deathfx(var_5, undefined, "apache_helicopter_crash", undefined, undefined, undefined, -1, undefined, "stop_crash_loop_sound");
  maps\_vehicle::build_rocket_deathfx(var_4[var_0], "tag_deathfx", "apache_helicopter_crash", undefined, undefined, undefined, undefined, 1, undefined, 0, 5);
  maps\_vehicle::build_light(var_2, "wingtip_green", "tag_light_L_wing", "fx/misc/aircraft_light_wingtip_green", "running", 0);
  maps\_vehicle::build_light(var_2, "wingtip_red", "tag_light_R_wing", "fx/misc/aircraft_light_wingtip_red", "running", 0.05);
  maps\_vehicle::build_light(var_2, "white_blink", "tag_light_belly", "fx/misc/aircraft_light_white_blink", "running", 0.1);
  maps\_vehicle::build_light(var_2, "white_blink_tail", "tag_light_tail", "fx/misc/aircraft_light_red_blink", "running", 0.25);
  maps\_vehicle::build_life(999, 500, 1500);
  maps\_vehicle::build_treadfx(var_2, "default", "fx/treadfx/heli_dust_default", 0);
  maps\_vehicle::build_team("allies");

  if(isDefined(var_2) && issubstr(var_2, "_mg"))
    maps\_vehicle::build_turret("apache_turret", "tag_turret", "vehicle_apache_mg", undefined, "auto_nonai", 0.0, 20, -14);

  if(!issubstr(var_2, "_berlin")) {
    precacheitem("zippy_rockets_apache");
    precacheitem("zippy_rockets_apache_nodamage");
  }

  maps\_vehicle::build_is_helicopter();
}

init_local() {
  self.script_badplace = 0;
  maps\_vehicle::vehicle_lights_on("running");

  if(issubstr(self.classname, "_mg")) {
    self hidepart("turret_animate_jnt");
    self hidepart("tag_turret");
    self hidepart("tag_barrel");
    self hidepart("barrel_animate_jnt");
  }
}

set_vehicle_anims(var_0) {
  return var_0;
}

setanims() {
  var_0 = [];

  for(var_1 = 0; var_1 < 11; var_1++)
    var_0[var_1] = spawnStruct();

  var_0[0].getout_delete = 1;
  return var_0;
}