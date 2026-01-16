/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: vehicle_scripts\_mig29.gsc
**************************************/

main(var_0, var_1, var_2) {
  maps\_vehicle::build_template("mig29", var_0, var_1, var_2);
  maps\_vehicle::build_localinit(::init_local);
  maps\_vehicle::build_deathmodel("vehicle_mig29");
  maps\_vehicle::build_deathmodel("vehicle_mig29_desert");
  maps\_vehicle::build_deathmodel("vehicle_av8b_harrier_jet");
  maps\_vehicle::build_deathmodel("vehicle_mig29_low");
  maps\_vehicle::build_treadfx();
  level._effect["engineeffect"] = loadfx("vfx/gameplay/vehicles/f18/vfx_f18_engine");
  level._effect["afterburner"] = loadfx("vfx/gameplay/vehicles/f18/vfx_f18_engine_afterburner");

  if(var_2 == "script_vehicle_mig29_low_cheap") {
    level._effect["contrail"] = loadfx("vfx/gameplay/smoke_trails/vfx_jet_contrail");
    maps\_vehicle::build_deathfx("vfx/gameplay/explosions/vehicle/vfx_lrg_air_exp", undefined, "explo_metal_rand");
  } else {
    level._effect["contrail"] = loadfx("fx/smoke/jet_contrail");
    maps\_vehicle::build_deathfx("fx/explosions/large_vehicle_explosion", undefined, "explo_metal_rand");
  }

  maps\_vehicle::build_life(999, 500, 1500);
  maps\_vehicle::build_rumble("mig_rumble", 0.1, 0.2, 11300, 0.05, 0.05);
  maps\_vehicle::build_team("allies");

  if(var_0 != "vehicle_av8b_harrier_jet") {
    var_3 = randomfloatrange(0, 1);
    maps\_vehicle::build_light(var_2, "wingtip_green", "tag_left_wingtip", "fx/misc/aircraft_light_wingtip_green", "running", var_3);
    maps\_vehicle::build_light(var_2, "wingtip_red", "tag_right_wingtip", "fx/misc/aircraft_light_wingtip_red", "running", var_3);
    maps\_vehicle::build_light(var_2, "white_blink", "tag_light_belly", "fx/misc/aircraft_light_white_blink", "running", var_3);
    maps\_vehicle::build_light(var_2, "landing_light01", "TAG_LIGHT_landing01", "fx/misc/light_mig29_landing", "landing", 0.0);
    maps\_vehicle::build_light(var_2, "landing_light02", "TAG_LIGHT_landing02", "fx/misc/light_mig29_landing", "landing", 0.0);
  }

  maps\_vehicle::build_is_airplane();
}

init_local() {
  thread playengineeffects();
  thread playcontrail();

  if(self.model != "vehicle_av8b_harrier_jet")
    maps\_vehicle::vehicle_lights_on("running");

  thread landing_gear_up();
}

set_vehicle_anims(var_0) {
  var_1 = "rope_test";
  precachemodel(var_1);
  return var_0;
}

#using_animtree("vehicles");

landing_gear_up() {
  self useanimtree(#animtree);
  self setanim( % mig_landing_gear_up);
}

setanims() {
  var_0 = [];

  for(var_1 = 0; var_1 < 1; var_1++)
    var_0[var_1] = spawnStruct();

  return var_0;
}

playengineeffects() {
  self endon("death");
  self endon("stop_engineeffects");
  maps\_utility::ent_flag_init("engineeffects");
  maps\_utility::ent_flag_set("engineeffects");
  var_0 = common_scripts\utility::getfx("engineeffect");

  for(;;) {
    maps\_utility::ent_flag_wait("engineeffects");
    playFXOnTag(var_0, self, "tag_engine_right");
    playFXOnTag(var_0, self, "tag_engine_left");
    maps\_utility::ent_flag_waitopen("engineeffects");
    stopFXOnTag(var_0, self, "tag_engine_left");
    stopFXOnTag(var_0, self, "tag_engine_right");
  }
}

playafterburner() {
  playFXOnTag(level._effect["afterburner"], self, "tag_engine_right");
  playFXOnTag(level._effect["afterburner"], self, "tag_engine_left");
}

playcontrail() {
  playFXOnTag(level._effect["contrail"], self, "tag_right_wingtip");
  playFXOnTag(level._effect["contrail"], self, "tag_left_wingtip");
}

playerisclose(var_0) {
  var_1 = playerisinfront(var_0);

  if(var_1)
    var_2 = 1;
  else
    var_2 = -1;

  var_3 = common_scripts\utility::flat_origin(var_0.origin);
  var_4 = var_3 + anglesToForward(common_scripts\utility::flat_angle(var_0.angles)) * (var_2 * 100000);
  var_5 = pointonsegmentnearesttopoint(var_3, var_4, level.player.origin);
  var_6 = distance(var_3, var_5);

  if(var_6 < 3000)
    return 1;
  else
    return 0;
}

playerisinfront(var_0) {
  var_1 = anglesToForward(common_scripts\utility::flat_angle(var_0.angles));
  var_2 = vectornormalize(common_scripts\utility::flat_origin(level.player.origin) - var_0.origin);
  var_3 = vectordot(var_1, var_2);

  if(var_3 > 0)
    return 1;
  else
    return 0;
}

plane_sound_node(var_0, var_1) {
  plane_sound_players("veh_mig29_dist_loop", "veh_mig29_sonic_boom");
}

plane_sound_players(var_0, var_1) {
  self waittill("trigger", var_2);
  var_2 endon("death");
  thread plane_sound_node();
  var_2 thread common_scripts\utility::play_loop_sound_on_entity(var_0);

  while(playerisinfront(var_2))
    wait 0.05;

  wait 0.5;
  var_2 thread common_scripts\utility::play_sound_in_space(var_1);
  var_2 waittill("reached_end_node");
  var_2 stop_sound(var_0);
  var_2 delete();
}

plane_bomb_node() {
  level._effect["plane_bomb_explosion1"] = loadfx("fx/explosions/airlift_explosion_large");
  level._effect["plane_bomb_explosion2"] = loadfx("fx/explosions/tanker_explosion");
  self waittill("trigger", var_0);
  var_0 endon("death");
  thread plane_bomb_node();
  var_1 = getEntArray(self.script_linkto, "script_linkname");
  var_1 = common_scripts\utility::get_array_of_closest(self.origin, var_1, undefined, var_1.size);
  var_2 = 0;
  wait(randomfloatrange(0.3, 0.8));

  for(var_3 = 0; var_3 < var_1.size; var_3++) {
    var_2++;

    if(var_2 == 3)
      var_2 = 1;

    var_1[var_3] thread maps\_utility::play_sound_on_entity("airstrike_explosion");
    playFX(level._effect["plane_bomb_explosion" + var_2], var_1[var_3].origin);
    wait(randomfloatrange(0.3, 1.2));
  }
}

plane_bomb_cluster() {
  self waittill("trigger", var_0);
  var_0 endon("death");
  var_1 = var_0;
  var_1 thread plane_bomb_cluster();
  var_2 = spawn("script_model", var_1.origin - (0, 0, 100));
  var_2.angles = var_1.angles;
  var_2 setModel("projectile_cbu97_clusterbomb");
  var_3 = anglesToForward(var_1.angles) * 2;
  var_4 = anglestoup(var_1.angles) * -0.2;
  var_5 = [];

  for(var_6 = 0; var_6 < 3; var_6++)
    var_5[var_6] = (var_3[var_6] + var_4[var_6]) / 2;

  var_5 = (var_5[0], var_5[1], var_5[2]);
  var_5 = var_5 * 7000;
  var_2 movegravity(var_5, 2.0);
  wait 1.2;
  var_7 = spawn("script_model", var_2.origin);
  var_7 setModel("tag_origin");
  var_7.origin = var_2.origin;
  var_7.angles = var_2.angles;
  wait 0.05;
  var_2 delete();
  var_2 = var_7;
  var_8 = var_2.origin;
  var_9 = var_2.angles;
  playFXOnTag(level.airstrikefx, var_2, "tag_origin");
  wait 1.6;
  var_10 = 12;
  var_11 = 5;
  var_12 = 55;
  var_13 = (var_12 - var_11) / var_10;

  for(var_6 = 0; var_6 < var_10; var_6++) {
    var_14 = anglesToForward(var_9 + (var_12 - var_13 * var_6, randomint(10) - 5, 0));
    var_15 = var_8 + var_14 * 10000;
    var_16 = bulletTrace(var_8, var_15, 0, undefined);
    var_17 = var_16["position"];
    radiusdamage(var_17 + (0, 0, 16), 512, 400, 30);

    if(var_6 % 3 == 0) {
      thread common_scripts\utility::play_sound_in_space("airstrike_explosion", var_17);
      playrumbleonposition("artillery_rumble", var_17);
      earthquake(0.7, 0.75, var_17, 1000);
    }

    wait(0.75 / var_10);
  }

  wait 1.0;
  var_2 delete();
}

stop_sound(var_0) {
  self notify("stop sound" + var_0);
}