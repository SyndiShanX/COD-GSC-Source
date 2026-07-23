/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1641.gsc
**************************************/

main(var_0, var_1, var_2) {
  maps\_vehicle::build_template("ss_n_12", var_0, var_1, var_2);
  maps\_vehicle::build_localinit(::init_local);
  maps\_vehicle::build_deathmodel(var_0);
  level._effect["engineeffect"] = loadfx("fire/jet_afterburner");
  level._effect["contrail"] = loadfx("smoke/smoke_geotrail_ssnMissile_trail");
  level._effect["contrail12"] = loadfx("smoke/smoke_geotrail_ssnMissile12_trail");
  maps\_vehicle::build_deathfx("explosions/large_vehicle_explosion", undefined, "explo_metal_rand", undefined, undefined, undefined, undefined, undefined, undefined, 0);
  maps\_vehicle::build_life(999, 500, 1500);
  maps\_vehicle::build_rumble("mig_rumble", 0.1, 0.2, 11300, 0.05, 0.05);
  maps\_vehicle::build_team("allies");
}

init_local() {
  if(self.classname == "script_vehicle_s300_pmu2") {
    self.tag = "tag_fx";
  }
  thread playengineeffects();
  thread handle_death();
  thread _id_443D();
  maps\_vehicle::lights_on("running");
}

set_vehicle_anims(var_0) {
  var_1 = "rope_test";
  precachemodel(var_1);
  return var_0;
}

setanims() {
  var_0 = [];

  for(var_1 = 0; var_1 < 1; var_1++) {
    var_0[var_1] = spawnStruct();
  }
  return var_0;
}

playengineeffects(var_0) {
  if(isDefined(self.tag)) {
    var_0 = self.tag;
  }
  if(!isDefined(var_0)) {
    var_0 = "tag_tail";
  }
  self endon("death");
  self endon("stop_engineeffects");
  maps\_utility::ent_flag_init("engineeffects");
  maps\_utility::ent_flag_set("engineeffects");
  var_1 = common_scripts\utility::getfx("engineeffect");

  for(;;) {
    maps\_utility::ent_flag_wait("engineeffects");
    playFXOnTag(var_1, self, var_0);
    maps\_utility::ent_flag_waitopen("engineeffects");
    stopFXOnTag(var_1, self, var_0);
  }
}

handle_death() {
  self waittill("death");

  if(isDefined(self.tag1)) {
    self.tag1 delete();
  }
}

playcontrail(var_0) {
  if(isDefined(self.tag)) {
    var_0 = self.tag;
  }
  if(!isDefined(var_0)) {
    var_0 = "tag_tail";
  }
  self.tag1 = add_contrail(var_0);
  var_1 = common_scripts\utility::getfx("contrail");
  self endon("death");
  maps\_utility::ent_flag_init("contrails");
  maps\_utility::ent_flag_set("contrails");

  for(;;) {
    maps\_utility::ent_flag_wait("contrails");
    wait 0.65;
    playFXOnTag(var_1, self.tag1, "tag_origin");
    maps\_utility::ent_flag_waitopen("contrails");
    stopFXOnTag(var_1, self.tag1, "tag_origin");
  }
}

_id_443D(var_0) {
  if(isDefined(self.tag)) {
    var_0 = self.tag;
  }
  if(!isDefined(var_0)) {
    var_0 = "tag_tail";
  }
  self.tag1 = add_contrail(var_0);
  var_1 = common_scripts\utility::getfx("contrail12");
  self endon("death");
  maps\_utility::ent_flag_init("contrails");
  maps\_utility::ent_flag_set("contrails");

  for(;;) {
    maps\_utility::ent_flag_wait("contrails");
    wait 0.65;
    playFXOnTag(var_1, self.tag1, "tag_origin");
    maps\_utility::ent_flag_waitopen("contrails");
    stopFXOnTag(var_1, self.tag1, "tag_origin");
  }
}

add_contrail(var_0) {
  var_1 = common_scripts\utility::spawn_tag_origin();
  var_1.origin = self gettagorigin(var_0);
  var_1.angles = self gettagangles(var_0);
  var_2 = spawnStruct();
  var_2.entity = var_1;
  var_2.forward = 0;
  var_2.up = 0;
  var_2.right = 0;
  var_2.yaw = 0;
  var_2.pitch = 0;
  var_2 maps\_utility::flashbanggettimeleftsec();
  var_1 linkTo(self, var_0);
  return var_1;
}

playerisclose(var_0) {
  var_1 = playerisinfront(var_0);

  if(var_1) {
    var_2 = 1;
  } else {
    var_2 = -1;
  }
  var_3 = common_scripts\utility::flat_origin(var_0.origin);
  var_4 = var_3 + anglesToForward(common_scripts\utility::flat_angle(var_0.angles)) * (var_2 * 100000);
  var_5 = pointonsegmentnearesttopoint(var_3, var_4, level.player.origin);
  var_6 = distance(var_3, var_5);

  if(var_6 < 3000) {
    return 1;
  } else {
    return 0;
  }
}

playerisinfront(var_0) {
  var_1 = anglesToForward(common_scripts\utility::flat_angle(var_0.angles));
  var_2 = vectorNormalize(common_scripts\utility::flat_origin(level.player.origin) - var_0.origin);
  var_3 = vectordot(var_1, var_2);

  if(var_3 > 0) {
    return 1;
  } else {
    return 0;
  }
}

plane_sound_node() {
  self waittill("trigger", var_0);
  var_0 endon("death");
  thread plane_sound_node();
  var_0 thread common_scripts\utility::play_loop_sound_on_entity("veh_f15_dist_loop");

  while(playerisinfront(var_0)) {
    wait 0.05;
  }
  wait 0.5;
  var_0 thread common_scripts\utility::play_sound_in_space("veh_f15_sonic_boom");
  var_0 waittill("reached_end_node");
  var_0 stop_sound("veh_f15_dist_loop");
  var_0 delete();
}

stop_sound(var_0) {
  self notify("stop sound" + var_0);
}