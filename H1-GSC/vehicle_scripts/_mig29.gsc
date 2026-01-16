/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: vehicle_scripts\_mig29.gsc
********************************/

main(var_0, var_1, var_2) {
  maps\_vehicle::build_template("mig29", var_0, var_1, var_2);
  maps\_vehicle::build_localinit(::init_local);
  maps\_vehicle::build_deathmodel("vehicle_mig29_desert");
  maps\_vehicle::build_deathmodel("vehicle_av8b_harrier_jet");
  buildmig29fx("afterburner", "fx\fire\jet_afterburner");
  buildmig29fx("contrail", "fx\smoke\jet_contrail");
  buildmig29fx("contrail_02", "fx\smoke\jet_contrail_02");
  maps\_vehicle::build_deathfx("fx\explosions\large_vehicle_explosion", undefined, "explo_metal_rand");
  maps\_vehicle::build_life(999, 500, 1500);
  maps\_vehicle::build_rumble("mig_rumble", 0.1, 0.2, 11300, 0.05, 0.05);
  maps\_vehicle::build_team("allies");
  maps\_vehicle::build_is_airplane();
}

init_local() {
  thread playafterburner();
  thread playcontrail();
}

set_vehicle_anims(var_0) {
  var_1 = "rope_test";
  precachemodel(var_1);
  return var_0;
}

setanims() {
  var_0 = [];

  for (var_1 = 0; var_1 < 1; var_1++)
    var_0[var_1] = spawnstruct();

  return var_0;
}

playafterburner() {
  playfxontag(level._effect["afterburner"], self, "tag_engine_right");
  playfxontag(level._effect["afterburner"], self, "tag_engine_left");
}

playcontrail() {
  playfxontag(level._effect["contrail"], self, "tag_right_wingtip");
  playfxontag(level._effect["contrail_02"], self, "tag_left_wingtip");
}

playerisclose(var_0) {
  var_1 = playerisinfront(var_0);

  if(var_1)
    var_2 = 1;
  else
    var_2 = -1;

  var_3 = common_scripts\utility::flat_origin(var_0.origin);
  var_4 = var_3 + anglestoforward(common_scripts\utility::flat_angle(var_0.angles)) * (var_2 * 100000);
  var_5 = pointonsegmentnearesttopoint(var_3, var_4, level.player.origin);
  var_6 = distance(var_3, var_5);
  var_7 = 3000;

  if(isdefined(level.mig29_near_distance_override))
    var_7 = level.mig29_near_distance_override;

  return var_6 < var_7;
}

playerisinfront(var_0) {
  var_1 = anglestoforward(common_scripts\utility::flat_angle(var_0.angles));
  var_2 = vectornormalize(common_scripts\utility::flat_origin(level.player.origin) - var_0.origin);
  var_3 = vectordot(var_1, var_2);

  if(var_3 > 0)
    return 1;
  else
    return 0;
}

plane_sound_node() {
  self waittill("trigger", var_0);
  var_0 endon("death");
  thread plane_sound_node();
  var_0 thread common_scripts\utility::play_loop_sound_on_entity("veh_mig29_dist_loop");
  var_1 = 0;

  if(isdefined(self.script_parameters) && self.script_parameters == "play_additional_sound")
    var_1 = 1;

  var_0 thread plane_passby_sfx(var_1);

  while (playerisinfront(var_0))
    wait 0.05;

  wait 0.5;
  var_0 thread common_scripts\utility::play_sound_in_space("veh_mig29_sonic_boom");
  var_0 waittill("reached_end_node");
  var_0 stop_sound("veh_mig29_dist_loop");
  var_0 delete();
}

plane_passby_sfx(var_0) {
  self endon("death");
  self endon("reached_end_node");

  while (!playerisclose(self))
    wait 0.05;

  thread maps\_utility::play_sound_on_entity("veh_mig29_passby");

  if(var_0)
    thread maps\_utility::play_sound_on_entity("veh_mig29_passby_layer");
}

plane_bomb_node() {
  buildmig29fx("plane_bomb_explosion1", "fx\explosions\airlift_explosion_large");
  buildmig29fx("plane_bomb_explosion2", "fx\explosions\tanker_explosion");
  self waittill("trigger", var_0);
  var_0 endon("death");
  thread plane_bomb_node();
  var_1 = getentarray(self.script_linkto, "script_linkname");
  var_1 = common_scripts\utility::get_array_of_closest(self.origin, var_1, undefined, var_1.size);
  var_2 = 0;
  wait(randomfloatrange(0.3, 0.8));

  for (var_3 = 0; var_3 < var_1.size; var_3++) {
    var_2++;

    if(var_2 == 3)
      var_2 = 1;

    var_1[var_3] thread maps\_utility::play_sound_on_entity("airstrike_explosion");
    var_4 = "plane_bomb_explosion" + var_2;
    var_5 = level._effect[var_4];

    if(isdefined(level.plane_bomb_explosion_overrides) && isdefined(level.plane_bomb_explosion_overrides[var_4]))
      var_5 = level.plane_bomb_explosion_overrides[var_4];

    playfx(var_5, var_1[var_3].origin);
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
  var_2 setmodel("projectile_cbu97_clusterbomb");
  var_3 = anglestoforward(var_1.angles) * 2;
  var_4 = anglestoup(var_1.angles) * -0.2;
  var_5 = [];

  for (var_6 = 0; var_6 < 3; var_6++)
    var_5[var_6] = (var_3[var_6] + var_4[var_6]) / 2;

  var_5 = (var_5[0], var_5[1], var_5[2]);
  var_5 = var_5 * 7000;
  var_2 movegravity(var_5, 2.0);
  wait 1.2;
  var_7 = spawn("script_model", var_2.origin);
  var_7 setmodel("tag_origin");
  var_7.origin = var_2.origin;
  var_7.angles = var_2.angles;
  wait 0.05;
  var_2 delete();
  var_2 = var_7;
  var_8 = var_2.origin;
  var_9 = var_2.angles;
  playfxontag(level.airstrikefx, var_2, "tag_origin");
  wait 1.6;
  var_10 = 12;
  var_11 = 5;
  var_12 = 55;
  var_13 = (var_12 - var_11) / var_10;

  for (var_6 = 0; var_6 < var_10; var_6++) {
    var_14 = anglestoforward(var_9 + (var_12 - var_13 * var_6, randomint(10) - 5, 0));
    var_15 = var_8 + var_14 * 10000;
    var_16 = bullettrace(var_8, var_15, 0, undefined);
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

setmig29fxoverride(var_0, var_1) {
  if(!isdefined(level.mig29_fx_override))
    level.mig29_fx_override = [];

  level.mig29_fx_override[var_0] = var_1;
}

buildmig29fx(var_0, var_1) {
  if(isdefined(level.mig29_fx_override) && isdefined(level.mig29_fx_override[var_0]))
    var_1 = level.mig29_fx_override[var_0];

  level._effect[var_0] = loadfx(var_1);
}