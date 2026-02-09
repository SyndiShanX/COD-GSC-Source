/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1641.gsc
**************************************/

main(var_0, var_1, var_2) {
  maps\_vehicle::_id_2AC2("ss_n_12", var_0, var_1, var_2);
  maps\_vehicle::_id_2AD2(::_id_2B1D);
  maps\_vehicle::_id_2ABE(var_0);
  level._effect["engineeffect"] = loadfx("fire/jet_afterburner");
  level._effect["contrail"] = loadfx("smoke/smoke_geotrail_ssnMissile_trail");
  level._effect["contrail12"] = loadfx("smoke/smoke_geotrail_ssnMissile12_trail");
  maps\_vehicle::_id_2A02("explosions/large_vehicle_explosion", undefined, "explo_metal_rand", undefined, undefined, undefined, undefined, undefined, undefined, 0);
  maps\_vehicle::_id_2ACE(999, 500, 1500);
  maps\_vehicle::_id_29F5("mig_rumble", 0.1, 0.2, 11300, 0.05, 0.05);
  maps\_vehicle::_id_2AC6("allies");
}

_id_2B1D() {
  if(self.classname == "script_vehicle_s300_pmu2") {
    self.tag = "tag_fx";
  }
  thread _id_443A();
  thread _id_4008();
  thread _id_443D();
  maps\_vehicle::_id_2AB3("running");
}

_id_3A9C(var_0) {
  var_1 = "rope_test";
  precachemodel(var_1);
  return var_0;
}

_id_3A9D() {
  var_0 = [];

  for(var_1 = 0; var_1 < 1; var_1++) {
    var_0[var_1] = spawnStruct();
  }
  return var_0;
}

_id_443A(var_0) {
  if(isDefined(self.tag)) {
    var_0 = self.tag;
  }
  if(!isDefined(var_0)) {
    var_0 = "tag_tail";
  }
  self endon("death");
  self endon("stop_engineeffects");
  maps\_utility::_id_1402("engineeffects");
  maps\_utility::_id_13DC("engineeffects");
  var_1 = common_scripts\utility::getfx("engineeffect");

  for(;;) {
    maps\_utility::_id_1654("engineeffects");
    playFXOnTag(var_1, self, var_0);
    maps\_utility::_id_13DB("engineeffects");
    stopFXOnTag(var_1, self, var_0);
  }
}

_id_4008() {
  self waittill("death");

  if(isDefined(self._id_443B)) {
    self._id_443B delete();
  }
}

_id_443C(var_0) {
  if(isDefined(self.tag)) {
    var_0 = self.tag;
  }
  if(!isDefined(var_0)) {
    var_0 = "tag_tail";
  }
  self._id_443B = _id_443E(var_0);
  var_1 = common_scripts\utility::getfx("contrail");
  self endon("death");
  maps\_utility::_id_1402("contrails");
  maps\_utility::_id_13DC("contrails");

  for(;;) {
    maps\_utility::_id_1654("contrails");
    wait 0.65;
    playFXOnTag(var_1, self._id_443B, "tag_origin");
    maps\_utility::_id_13DB("contrails");
    stopFXOnTag(var_1, self._id_443B, "tag_origin");
  }
}

_id_443D(var_0) {
  if(isDefined(self.tag)) {
    var_0 = self.tag;
  }
  if(!isDefined(var_0)) {
    var_0 = "tag_tail";
  }
  self._id_443B = _id_443E(var_0);
  var_1 = common_scripts\utility::getfx("contrail12");
  self endon("death");
  maps\_utility::_id_1402("contrails");
  maps\_utility::_id_13DC("contrails");

  for(;;) {
    maps\_utility::_id_1654("contrails");
    wait 0.65;
    playFXOnTag(var_1, self._id_443B, "tag_origin");
    maps\_utility::_id_13DB("contrails");
    stopFXOnTag(var_1, self._id_443B, "tag_origin");
  }
}

_id_443E(var_0) {
  var_1 = common_scripts\utility::spawn_tag_origin();
  var_1.origin = self gettagorigin(var_0);
  var_1.angles = self gettagangles(var_0);
  var_2 = spawnStruct();
  var_2.entity = var_1;
  var_2.forward = 0;
  var_2.up = 0;
  var_2.right = 0;
  var_2._id_13FE = 0;
  var_2._id_13FF = 0;
  var_2 maps\_utility::_id_18B9();
  var_1 linkto(self, var_0);
  return var_1;
}

_id_443F(var_0) {
  var_1 = _id_4440(var_0);

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

_id_4440(var_0) {
  var_1 = anglesToForward(common_scripts\utility::flat_angle(var_0.angles));
  var_2 = vectornormalize(common_scripts\utility::flat_origin(level.player.origin) - var_0.origin);
  var_3 = vectordot(var_1, var_2);

  if(var_3 > 0) {
    return 1;
  } else {
    return 0;
  }
}

_id_3E81() {
  self waittill("trigger", var_0);
  var_0 endon("death");
  thread _id_3E81();
  var_0 thread common_scripts\utility::play_loop_sound_on_entity("veh_f15_dist_loop");

  while(_id_4440(var_0)) {
    wait 0.05;
  }
  wait 0.5;
  var_0 thread common_scripts\utility::play_sound_in_space("veh_f15_sonic_boom");
  var_0 waittill("reached_end_node");
  var_0 _id_4441("veh_f15_dist_loop");
  var_0 delete();
}

_id_4441(var_0) {
  self notify("stop sound" + var_0);
}