/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\_f15.gsc
********************************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_vehicle_aianim;
#include maps\_vehicle;
#using_animtree("vehicles");
main(model, type) {
  build_template("f15", model, type);
  build_localinit(::init_local);

  build_deathmodel("vehicle_f15");

  level._effect["engineeffect"] = loadfx("fire/jet_afterburner");
  level._effect["afterburner"] = loadfx("fire/jet_afterburner_ignite");
  level._effect["contrail"] = loadfx("smoke/jet_contrail");

  build_deathfx("explosions/large_vehicle_explosion", undefined, "explo_metal_rand", undefined, undefined, undefined, undefined, undefined, undefined, 0);
  build_life(999, 500, 1500);
  build_rumble("mig_rumble", 0.1, 0.2, 11300, 0.05, 0.05);
  build_team("allies");
  build_compassicon("mig29", false);

  randomStartDelay = randomfloatrange(0, 1);
  build_light(model, "wingtip_green", "TAG_LEFT_WINGTIP", "misc/aircraft_light_wingtip_green", "running", randomStartDelay);
  build_light(model, "tail_green", "TAG_LEFT_TAIL", "misc/aircraft_light_wingtip_green", "running", randomStartDelay);
  build_light(model, "wingtip_red", "TAG_RIGHT_WINGTIP", "misc/aircraft_light_wingtip_red", "running", randomStartDelay);
  build_light(model, "tail_red", "TAG_RIGHT_TAIL", "misc/aircraft_light_wingtip_red", "running", randomStartDelay);
  build_light(model, "white_blink", "TAG_LIGHT_BELLY", "misc/aircraft_light_white_blink", "running", randomStartDelay);
  build_light(model, "landing_light01", "TAG_LIGHT_LANDING01", "misc/light_mig29_landing", "landing", 0.0);
}

init_local() {
  thread playEngineEffects();
  thread playConTrail();
  thread landing_gear_up();
  maps\_vehicle::lights_on("running");
}

#using_animtree("vehicles");
set_vehicle_anims(positions) {
  ropemodel = "rope_test";
  precachemodel(ropemodel);
  return positions;
}

landing_gear_up() {
  self UseAnimTree(#animtree);
  self setanim(%mig_landing_gear_up);
}

#using_animtree("generic_human");

setanims() {
  positions = [];
  for(i = 0; i < 1; i++) {
    positions[i] = spawnStruct();
  }

  return positions;
}

playEngineEffects() {
  self endon("death");
  self endon("stop_engineeffects");

  self ent_flag_init("engineeffects");
  self ent_flag_set("engineeffects");
  engineeffects = getfx("engineeffect");

  for(;;) {
    self ent_flag_wait("engineeffects");
    playFXOnTag(engineeffects, self, "tag_engine_right");
    playFXOnTag(engineeffects, self, "tag_engine_left");
    self ent_flag_waitopen("engineeffects");
    stopFXOnTag(engineeffects, self, "tag_engine_left");
    stopFXOnTag(engineeffects, self, "tag_engine_right");
  }
}

playAfterBurner() {
  self endon("death");
  self endon("stop_afterburners");

  self ent_flag_init("afterburners");
  self ent_flag_set("afterburners");
  afterburners = getfx("afterburner");

  for(;;) {
    self ent_flag_wait("afterburners");
    playFXOnTag(afterburners, self, "tag_engine_right");
    playFXOnTag(afterburners, self, "tag_engine_left");
    self ent_flag_waitopen("afterburners");
    stopFXOnTag(afterburners, self, "tag_engine_left");
    stopFXOnTag(afterburners, self, "tag_engine_right");
  }
}

playConTrail() {
  tag1 = add_contrail("tag_engine_right", 1);
  tag2 = add_contrail("tag_engine_left", -1);
  contrail = getfx("contrail");

  self endon("death");

  ent_flag_init("contrails");
  ent_flag_set("contrails");
  for(;;) {
    ent_flag_wait("contrails");
    playFXOnTag(contrail, tag1, "tag_origin");
    playFXOnTag(contrail, tag2, "tag_origin");
    ent_flag_waitopen("contrails");
    stopFXOnTag(contrail, tag1, "tag_origin");
    stopFXOnTag(contrail, tag2, "tag_origin");
  }
}

add_contrail(fx_tag_name, offset) {
  fx_tag = spawn_tag_origin();
  fx_tag.origin = self getTagOrigin(fx_tag_name);
  fx_tag.angles = self getTagAngles(fx_tag_name);
  ent = spawnStruct();
  ent.entity = fx_tag;
  ent.forward = -156;
  ent.up = 0;
  ent.right = 224 * offset;
  ent.yaw = 0;
  ent.pitch = 0;
  ent translate_local();
  fx_tag LinkTo(self, fx_tag_name);
  return fx_tag;
}

playerisclose(other) {
  infront = playerisinfront(other);
  if(infront) {
    dir = 1;
  } else {
    dir = -1;
  }
  a = flat_origin(other.origin);
  b = a + vector_multiply(anglesToForward(flat_angle(other.angles)), (dir * 100000));
  point = pointOnSegmentNearestToPoint(a, b, level.player.origin);
  dist = distance(a, point);
  if(dist < 3000) {
    return true;
  } else {
    return false;
  }
}

playerisinfront(other) {
  forwardvec = anglesToForward(flat_angle(other.angles));
  normalvec = vectorNormalize(flat_origin(level.player.origin) - other.origin);
  dot = vectordot(forwardvec, normalvec);
  if(dot > 0) {
    return true;
  } else {
    return false;
  }
}

plane_sound_node() {
  self waittill("trigger", other);
  other endon("death");
  self thread plane_sound_node();
  other thread play_loop_sound_on_entity("veh_f15_dist_loop");
  while(playerisinfront(other)) {
    wait .05;
  }
  wait .5;
  other thread play_sound_in_space("veh_f15_sonic_boom");
  other waittill("reached_end_node");
  other stop_sound("veh_f15_dist_loop");
  other delete();
}

plane_bomb_node() {
  level._effect["plane_bomb_explosion1"] = loadfx("explosions/airlift_explosion_large");
  level._effect["plane_bomb_explosion2"] = loadfx("explosions/tanker_explosion");
  self waittill("trigger", other);
  other endon("death");
  self thread plane_bomb_node();

  aBomb_targets = getEntArray(self.script_linkTo, "script_linkname");
  assertEx(isDefined(aBomb_targets), "Plane bomb node at " + self.origin + " needs to script_linkTo at least one script_origin to use as a bomb target");
  assertEx(aBomb_targets.size > 1, "Plane bomb node at " + self.origin + " needs to script_linkTo at least one script_origin to use as a bomb target");

  aBomb_targets = get_array_of_closest(self.origin, aBomb_targets, undefined, aBomb_targets.size);
  iExplosionNumber = 0;

  wait randomfloatrange(.3, .8);
  for(i = 0; i < aBomb_targets.size; i++) {
    iExplosionNumber++;
    if(iExplosionNumber == 3) {
      iExplosionNumber = 1;
    }
    aBomb_targets[i] thread play_sound_on_entity("airstrike_explosion");

    playFX(level._effect["plane_bomb_explosion" + iExplosionNumber], aBomb_targets[i].origin);
    wait randomfloatrange(.3, 1.2);
  }
}

plane_bomb_cluster() {
  self waittill("trigger", other);
  other endon("death");
  plane = other;
  plane thread plane_bomb_cluster();

  bomb = spawn("script_model", plane.origin - (0, 0, 100));
  bomb.angles = plane.angles;
  bomb setModel("projectile_cbu97_clusterbomb");

  vecForward = vector_multiply(anglesToForward(plane.angles), 2);
  vecUp = vector_multiply(anglestoup(plane.angles), -0.2);
  vec = [];
  for(i = 0; i < 3; i++) {
    vec[i] = (vecForward[i] + vecUp[i]) / 2;
  }
  vec = (vec[0], vec[1], vec[2]);
  vec = vector_multiply(vec, 7000);
  bomb moveGravity(vec, 2.0);
  wait(1.2);

  newBomb = spawn("script_model", bomb.origin);
  newBomb setModel("tag_origin");
  newBomb.origin = bomb.origin;
  newBomb.angles = bomb.angles;
  wait(0.05);

  bomb delete();
  bomb = newBomb;

  bombOrigin = bomb.origin;
  bombAngles = bomb.angles;
  playFXOnTag(level.airstrikefx, bomb, "tag_origin");

  wait 1.6;
  repeat = 12;
  minAngles = 5;
  maxAngles = 55;
  angleDiff = (maxAngles - minAngles) / repeat;

  for(i = 0; i < repeat; i++) {
    traceDir = anglesToForward(bombAngles + (maxAngles - (angleDiff * i), randomInt(10) - 5, 0));
    traceEnd = bombOrigin + vector_multiply(traceDir, 10000);
    trace = bulletTrace(bombOrigin, traceEnd, false, undefined);

    traceHit = trace["position"];

    radiusDamage(traceHit + (0, 0, 16), 512, 400, 30);

    if(i % 3 == 0) {
      thread play_sound_in_space("airstrike_explosion", traceHit);
      playRumbleOnPosition("artillery_rumble", traceHit);
      earthquake(0.7, 0.75, traceHit, 1000);
    }

    wait(0.75 / repeat);
  }
  wait(1.0);
  bomb delete();
}

stop_sound(alias) {
  self notify("stop sound" + alias);
}