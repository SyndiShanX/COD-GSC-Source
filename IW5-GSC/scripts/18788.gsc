/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\18788.gsc
**************************************/

main(var_0, var_1, var_2, var_3) {
  if(var_0 == "vehicle_submarine_sdv") {
    maps\_vehicle::build_template("submarine_sdv", var_0, var_1, var_2);
  } else {
    maps\_vehicle::build_template("blackshadow_730", var_0, var_1, var_2);
  }
  maps\_vehicle::build_localinit(::init_local);
  maps\_vehicle::build_deathmodel(var_0);
  maps\_vehicle::build_life(999, 500, 1500);

  if(!isDefined(var_3) || !var_3) {
    if(var_0 == "vehicle_submarine_sdv") {
      maps\_vehicle::build_rumble("tank_rumble", 0.05, 1.5, 900, 1, 1);
    }
  }

  maps\_vehicle::build_team("allies");
  level._effect["sdv_prop_wash_1"] = loadfx("water/sdv_prop_wash_2");
  level._effect["sdv_headlights"] = loadfx("misc/spotlight_submarine_sdv");
}

init_local() {
  maps\_utility::ent_flag_init("moving");
  maps\_utility::ent_flag_init("lights");
  thread cleanup_sdv();
  thread handle_move();
  thread handle_lights();
}

handle_move() {
  self endon("sdv_done");
  self endon("death");

  for(;;) {
    maps\_utility::ent_flag_wait("moving");
    thread maps\_utility::play_sound_on_tag("sdv_start", "TAG_PROPELLER");
    maps\_utility::delaythread(1, maps\_utility::play_loop_sound_on_tag, "sdv_move_loop", "TAG_PROPELLER", 1);
    playFXOnTag(common_scripts\utility::getfx("sdv_prop_wash_1"), self, "TAG_PROPELLER");
    maps\_utility::ent_flag_waitopen("moving");
    stopFXOnTag(common_scripts\utility::getfx("sdv_prop_wash_1"), self, "TAG_PROPELLER");
    self notify("stop soundsdv_move_loop");
    thread maps\_utility::play_sound_on_tag("sdv_stop", "TAG_PROPELLER");
  }
}

cleanup_sdv() {
  common_scripts\utility::waittill_either("sdv_done", "death");

  if(maps\_utility::ent_flag("lights")) {
    stopFXOnTag(common_scripts\utility::getfx("sdv_headlights"), self, "TAG_LIGHT_L");
    stopFXOnTag(common_scripts\utility::getfx("sdv_headlights"), self, "TAG_LIGHT_R");
  }

  if(maps\_utility::ent_flag("moving")) {
    stopFXOnTag(common_scripts\utility::getfx("sdv_prop_wash_1"), self, "TAG_PROPELLER");
    self notify("stop soundsdv_move_loop");
  }
}

handle_lights() {
  self endon("sdv_done");
  self endon("death");

  for(;;) {
    maps\_utility::ent_flag_wait("lights");
    playFXOnTag(common_scripts\utility::getfx("sdv_headlights"), self, "TAG_LIGHT_L");
    playFXOnTag(common_scripts\utility::getfx("sdv_headlights"), self, "TAG_LIGHT_R");
    maps\_utility::ent_flag_waitopen("lights");
    stopFXOnTag(common_scripts\utility::getfx("sdv_headlights"), self, "TAG_LIGHT_L");
    stopFXOnTag(common_scripts\utility::getfx("sdv_headlights"), self, "TAG_LIGHT_R");
  }
}