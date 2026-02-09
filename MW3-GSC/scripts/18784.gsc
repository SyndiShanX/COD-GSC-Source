/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\18784.gsc
**************************************/

main(var_0, var_1, var_2) {
  maps\_vehicle::_id_2AC2("f15", var_0, var_1, var_2);
  maps\_vehicle::_id_2AD2(::_id_2B1D);
  maps\_vehicle::_id_2ABE("vehicle_f15");
  level._effect["engineeffect"] = loadfx("fire/jet_afterburner");
  level._effect["afterburner"] = loadfx("fire/jet_afterburner_ignite");
  level._effect["contrail"] = loadfx("smoke/jet_contrail");
  maps\_vehicle::_id_2A02("explosions/large_vehicle_explosion", undefined, "explo_metal_rand", undefined, undefined, undefined, undefined, undefined, undefined, 0);
  maps\_vehicle::_id_2ACE(999, 500, 1500);
  maps\_vehicle::_id_29F5("mig_rumble", 0.1, 0.2, 11300, 0.05, 0.05);
  maps\_vehicle::_id_2AC6("allies");
  var_3 = randomfloatrange(0, 1);
  var_4 = maps\_vehicle::_id_2B1A(var_0, var_2);
  maps\_vehicle::_id_2AAD(var_4, "wingtip_green", "TAG_LEFT_WINGTIP", "misc/aircraft_light_wingtip_green", "running", var_3);
  maps\_vehicle::_id_2AAD(var_4, "tail_green", "TAG_LEFT_TAIL", "misc/aircraft_light_wingtip_green", "running", var_3);
  maps\_vehicle::_id_2AAD(var_4, "wingtip_red", "TAG_RIGHT_WINGTIP", "misc/aircraft_light_wingtip_red", "running", var_3);
  maps\_vehicle::_id_2AAD(var_4, "tail_red", "TAG_RIGHT_TAIL", "misc/aircraft_light_wingtip_red", "running", var_3);
  maps\_vehicle::_id_2AAD(var_4, "white_blink", "TAG_LIGHT_BELLY", "misc/aircraft_light_white_blink", "running", var_3);
  maps\_vehicle::_id_2AAD(var_4, "landing_light01", "TAG_LIGHT_LANDING01", "misc/light_mig29_landing", "landing", 0.0);
}

_id_2B1D() {
  thread _id_443A();
  thread _id_4008();
  thread _id_443C();
  thread _id_495A();
  maps\_vehicle::_id_2AB3("running");
}

_id_3A9C(var_0) {
  var_1 = "rope_test";
  precachemodel(var_1);
  return var_0;
}

#using_animtree("vehicles");

_id_495A() {
  self useanimtree(#animtree);
  self setanim(%mig_landing_gear_up);
}

_id_3A9D() {
  var_0 = [];

  for(var_1 = 0; var_1 < 1; var_1++) {
    var_0[var_1] = spawnStruct();
  }
  return var_0;
}

_id_443A() {
  self endon("death");
  self endon("stop_engineeffects");
  maps\_utility::_id_1402("engineeffects");
  maps\_utility::_id_13DC("engineeffects");
  var_0 = common_scripts\utility::getfx("engineeffect");

  for(;;) {
    maps\_utility::_id_1654("engineeffects");
    playFXOnTag(var_0, self, "tag_engine_right");
    playFXOnTag(var_0, self, "tag_engine_left");
    maps\_utility::_id_13DB("engineeffects");
    stopFXOnTag(var_0, self, "tag_engine_left");
    stopFXOnTag(var_0, self, "tag_engine_right");
  }
}

_id_495B() {
  self endon("death");
  self endon("stop_afterburners");
  maps\_utility::_id_1402("afterburners");
  maps\_utility::_id_13DC("afterburners");
  var_0 = common_scripts\utility::getfx("afterburner");

  for(;;) {
    maps\_utility::_id_1654("afterburners");
    playFXOnTag(var_0, self, "tag_engine_right");
    playFXOnTag(var_0, self, "tag_engine_left");
    maps\_utility::_id_13DB("afterburners");
    stopFXOnTag(var_0, self, "tag_engine_left");
    stopFXOnTag(var_0, self, "tag_engine_right");
  }
}

_id_4008() {
  self waittill("death");

  if(isDefined(self._id_443B)) {
    self._id_443B delete();
  }
  if(isDefined(self._id_495C)) {
    self._id_495C delete();
  }
}

_id_443C() {
  self._id_443B = _id_443E("tag_engine_right", 1);
  self._id_495C = _id_443E("tag_engine_left", -1);
  var_0 = common_scripts\utility::getfx("contrail");
  self endon("death");
  maps\_utility::_id_1402("contrails");
  maps\_utility::_id_13DC("contrails");

  for(;;) {
    maps\_utility::_id_1654("contrails");
    playFXOnTag(var_0, self._id_443B, "tag_origin");
    playFXOnTag(var_0, self._id_495C, "tag_origin");
    maps\_utility::_id_13DB("contrails");
    stopFXOnTag(var_0, self._id_443B, "tag_origin");
    stopFXOnTag(var_0, self._id_495C, "tag_origin");
  }
}

_id_443E(var_0, var_1) {
  var_2 = common_scripts\utility::spawn_tag_origin();
  var_2.origin = self gettagorigin(var_0);
  var_2.angles = self gettagangles(var_0);
  var_3 = spawnStruct();
  var_3.entity = var_2;
  var_3.forward = -156;
  var_3.up = 0;
  var_3.right = 224 * var_1;
  var_3._id_13FE = 0;
  var_3._id_13FF = 0;
  var_3 maps\_utility::_id_18B9();
  var_2 linkto(self, var_0);
  return var_2;
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
  if(!isDefined(var_0)) {
    return 0;
  }
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

  if(isDefined(var_0)) {
    var_0 thread common_scripts\utility::play_sound_in_space("veh_f15_sonic_boom");
    var_0 waittill("reached_end_node");
    var_0 _id_4441("veh_f15_dist_loop");
    var_0 delete();
  }
}

_id_495D() {
  level._effect["plane_bomb_explosion1"] = loadfx("explosions/bomb_explosion_ac130_small");
  level._effect["plane_bomb_explosion2"] = loadfx("explosions/bomb_explosion_ac130_small");
  self waittill("trigger", var_0);
  var_0 endon("death");
  thread _id_495D();
  var_1 = common_scripts\utility::get_linked_ents();
  var_1 = maps\_utility::_id_0AEC(self.origin, var_1, undefined, var_1.size);
  var_2 = 0;
  wait(randomfloatrange(0.3, 0.8));

  for(var_3 = 0; var_3 < var_1.size; var_3++) {
    var_2++;

    if(var_2 == 3) {
      var_2 = 1;
    }
    var_1[var_3] thread maps\_utility::play_sound_on_entity("airstrike_explosion_close");
    playFX(level._effect["plane_bomb_explosion" + var_2], var_1[var_3].origin);
    level.player playrumblelooponentity("damage_heavy");
    earthquake(0.2, 0.5, level.player.origin, 1000);
    wait 0.2;
    level.player stoprumble("damage_heavy");
    wait 0.1;
  }
}

_id_495E() {
  self waittill("trigger", var_0);
  var_0 endon("death");
  var_1 = var_0;
  var_1 thread _id_495E();
  var_2 = spawn("script_model", var_1.origin - (0, 0, 100));
  var_2.angles = var_1.angles;
  var_2 setModel("projectile_cbu97_clusterbomb");
  var_3 = anglesToForward(var_1.angles) * 2;
  var_4 = anglestoup(var_1.angles) * -0.2;
  var_5 = [];

  for(var_6 = 0; var_6 < 3; var_6++) {
    var_5[var_6] = (var_3[var_6] + var_4[var_6]) / 2;
  }
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
      thread common_scripts\utility::play_sound_in_space("airstrike_explosion_close", var_17);
      playrumbleonposition("artillery_rumble", var_17);
      earthquake(0.7, 0.75, var_17, 1000);
    }

    wait(0.75 / var_10);
  }

  wait 1.0;
  var_2 delete();
}

_id_4441(var_0) {
  self notify("stop sound" + var_0);
}