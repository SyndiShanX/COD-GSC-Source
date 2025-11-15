/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: vehicle_scripts\_b2.gsc
*****************************************************/

main(var_0, var_1, var_2) {
  maps\_vehicle::build_template("b2", var_0, var_1, var_2);
  maps\_vehicle::build_localinit(::init_local);
  maps\_vehicle::build_deathmodel("vehicle_b2_bomber");
  maps\_vehicle::build_treadfx();
  level._effect["engineeffect"] = loadfx("fx/fire/jet_afterburner");
  level._effect["afterburner"] = loadfx("fx/fire/jet_afterburner_ignite");
  level._effect["contrail"] = loadfx("fx/smoke/jet_contrail");
  maps\_vehicle::build_deathfx("fx/explosions/large_vehicle_explosion", undefined, "explo_metal_rand");
  maps\_vehicle::build_life(999, 500, 1500);
  maps\_vehicle::build_rumble("mig_rumble", 0.1, 0.2, 11300, 0.05, 0.05);
  maps\_vehicle::build_team("allies");
  maps\_vehicle::build_is_airplane();
}

init_local() {
  thread playengineeffects();
  thread playcontrail();
}

set_vehicle_anims(var_0) {
  return var_0;
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