/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\_b2.gsc
********************************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_vehicle_aianim;
#include maps\_vehicle;
#using_animtree("vehicles");
main(model, type) {
  build_template("b2", model, type);
  build_localinit(::init_local);

  build_deathmodel("vehicle_b2_bomber");

  build_treadfx();

  level._effect["engineeffect"] = loadfx("fire/jet_afterburner");
  level._effect["afterburner"] = loadfx("fire/jet_afterburner_ignite");
  level._effect["contrail"] = loadfx("smoke/jet_contrail");

  build_deathfx("explosions/large_vehicle_explosion", undefined, "explo_metal_rand");
  build_life(999, 500, 1500);
  build_rumble("mig_rumble", .1, .2, 11300, .05, .05);
  build_team("allies");
  build_compassicon("mig29", false);
}

init_local() {
  thread playEngineEffects();
  thread playConTrail();
}

#using_animtree("vehicles");
set_vehicle_anims(positions) {
  return positions;
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
  playFXOnTag(level._effect["afterburner"], self, "tag_engine_right");
  playFXOnTag(level._effect["afterburner"], self, "tag_engine_left");
}

playConTrail() {
  playFXOnTag(level._effect["contrail"], self, "tag_right_wingtip");
  playFXOnTag(level._effect["contrail"], self, "tag_left_wingtip");
}